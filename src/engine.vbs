Set Sound = CreateObject("WMPlayer.OCX.7")
Set Fso = CreateObject("Scripting.FileSystemObject")
stream = WScript.Arguments.Item(3)
loopSound = False

Sound.URL = WScript.Arguments.Item(0)
Sound.settings.volume = WScript.Arguments.Item(2)
If WScript.Arguments.Item(1) = "loop" Then
    loopSound = True
    Sound.settings.setMode "loop", True
Else
    Sound.settings.playCount = WScript.Arguments.Item(1)
End If

Sound.controls.Stop

Do whileNOT Fso.FileExists(stream)
    WScript.sleep 500
Loop

adjStr = 0
adjLen = 0
secElapse = 0
numPlay = 0
Do whileSound.playState = 3 Or Sound.playState = 2 Or Sound.playState = 10 Or numPlay = -1
    If Sound.playState = 1 And numPlay = -1 Then
        Sound.settings.setMode "loop", True
        numPlay = 0
        Sound.controls.play
        Sound.controls.pause
    End If
    
    
    Set data = Fso.OpenTextFile(stream, 1)
    line = Split(data.ReadAll, ",")
    data.Close
    
    Set data = Fso.OpenTextFile(stream, 2)
    data.Write "R,"
    data.Close
  
    For Each x In line
        x = Replace(x, vbCrLf, "")
        
        check = Split(x, " ")
        If UBound(check) <> -1 Then
            If check(0) <> "R" Then
                If check(0) = "P" Then
                    Sound.controls.play
                ElseIf check(0) = "A" Then
                    Sound.controls.pause
                ElseIf check(0) = "S" Then
                    Sound.controls.Stop
                ElseIf check(0) = "C" Then
                    adjStr = check(1)
                    adjLen = check(2)
                ElseIf check(0) = "D" Then
                    adjStr =  - check(1)
                    adjLen = check(2)
                ElseIf check(0) = "T" Then
                    Sound.controls.play
                    numPlay = -1
                    Sound.settings.setMode "loop", False
                    Sound.settings.playCount = check(1)
                ElseIf check(0) = "K" Then
                    If Sound.currentMedia.duration >= Sound.controls.currentPosition + check(1) Then
                        Sound.controls.currentPosition = Sound.controls.currentPosition + check(1)
                    Else
                        Sound.controls.currentPosition = 0
                    End If
                ElseIf check(0) = "W" Then
                    If 0 < Sound.controls.currentPosition - check(1) Then
                        Sound.controls.currentPosition = Sound.controls.currentPosition - check(1)
                    Else
                        Sound.controls.currentPosition = 0
                    End If
                ElseIf check(0) = "V" Then
                    Sound.settings.volume = check(1)
                End If
            End If
        End If
    Next
  
    WScript.sleep 200
    
    If adjLen <> 0 Then
        If secElapse = 0 Then
            WScript.Echo "Elapsed!"
            vol = Sound.settings.volume + adjStr
            If vol > 100 Then
                vol = 100
            ElseIf vol < 0 Then
                vol = 0
            End If
            Sound.settings.volume = vol
            
            adjLen = adjLen - 1
            If adjLen = 0 Then
                secElapse = 0
            End If
        End If
        secElapse = (secElapse + 1) Mod 5
    End If
Loop
