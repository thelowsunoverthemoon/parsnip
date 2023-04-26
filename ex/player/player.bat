<!-- : Begin batch script

@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
(CHCP 65001)>NUL

CALL :PARSNIP_INIT
SET "music[num]=0"
FOR %%T in (.\tracks\*) DO (
    SET /A "music[num]+=1"
    SET "music[!music[num]!]=%%T"
    
)

IF %music[num]% EQU 0 (
    ECHO No tracks found
    PAUSE
    EXIT /B
)

SET "music[cur]="
SET "music[name]="
SET "music[state]="
FOR /L %%$ in () DO (
    CLS
    ECHO ╔═════════════════════════════╗
    ECHO ║ Music Player                ║
    ECHO ╚═════════════════════════════╝
    ECHO   Enter Index to play track
    ECHO   [S] stop [U] pause [P] play [K] skip 1s [R] rewind 1s
    ECHO   Track : !music[name]! !music[state]!
    ECHO   Song List :
    FOR /L %%T in (1, 1, %music[num]%) DO (
        FOR %%L in ("!music[%%T]!") DO (
            ECHO   [%%T] %%~nxL
        )
    )
    SET /P "input="
    IF defined music[cur] (
        IF /I "!input!" == "S" (
            %PARSNIP_STOP: # = music[cur]%
            SET "music[cur]=" & SET "music[state]=" & SET "music[name]="
        ) else IF /I "!input!" == "U" (
            %PARSNIP_PAUSE: # = music[cur]%
            SET "music[state]=(Paused)"
        ) else IF /I "!input!" == "P" (
            %PARSNIP_PLAY: # = music[cur]%
            SET "music[state]=(Playing)"
        ) else IF /I "!input!" == "K" (
            %PARSNIP_SKIP: # = music[cur], @ = 1%
        ) else IF /I "!input!" == "R" (
            %PARSNIP_REWIND: # = music[cur], @ = 1%
        )
    )
    SET "input[num]="
    FOR /F "delims=0123456789" %%I in ("!input!") DO (
        SET "input[num]=%%I"
    )
    IF not defined input[num] (
        IF !input! GEQ 1 ( IF !input! LEQ %music[num]% (
            IF defined music[cur] (
                %PARSNIP_STOP: # = music[cur]%
            )
            FOR %%N in (!input!) DO (
                %PARSNIP_MAKE% music[cur] "!music[%%N]!" loop 100
                FOR %%L in ("!music[%%N]!") DO (
                    SET "music[name]=%%~nxL"
                )
            )
            SET "music[state]=(Playing)"
            %PARSNIP_PLAY: # = music[cur]%
        ))
    )
    
)

EXIT /B

:PARSNIP_INIT
SET "PARSNIP_M_NUM=0"&FOR /F "tokens=1,*" %%A in ('DIR "%~n0.bat*" /R ^| FIND "$DATA"') DO FOR /F "tokens=2 delims=:" %%D in ("%%B") DO ECHO R,> "%~n0.bat:%%D"
SET "PARSNIP_PAUSE=SET /A "PARSNIP[DUM]= # "^&ECHO A,^>^> "%~n0.bat:Mode^^!PARSNIP[DUM]^^!""&SET "PARSNIP_PLAY_NUM=SET /A "PARSNIP[DUM]= # "^&ECHO T ^^^!@^^^!,^>^> "%~n0.bat:Mode^^!PARSNIP[DUM]^^!""&SET "PARSNIP_PLAY=SET /A "PARSNIP[DUM]= # "^&ECHO P,^>^> "%~n0.bat:Mode^^!PARSNIP[DUM]^^!""
SET "PARSNIP_STOP=SET /A "PARSNIP[DUM]= # "^&ECHO S,^>^> "%~n0.bat:Mode^^!PARSNIP[DUM]^^!""&SET "PARSNIP_VOLUME=SET /A "PARSNIP[DUM]= # "^&ECHO V ^^^!@^^^!,^>^> "%~n0.bat:Mode^^!PARSNIP[DUM]^^!""&SET "PARSNIP_CRESCENDO=SET /A "PARSNIP[DUM]= # "^&ECHO C ^^^!@^^^! ^^^!?^^^!,^>^> "%~n0.bat:Mode^^!PARSNIP[DUM]^^!""
SET "PARSNIP_DECRESCENDO=SET /A "PARSNIP[DUM]= # "^&ECHO D ^^^!@^^^! ^^^!?^^^!,^>^> "%~n0.bat:Mode^^!PARSNIP[DUM]^^!""&SET "PARSNIP_SKIP=SET /A "PARSNIP[DUM]= # "^&ECHO K ^^^!@^^^!,^>^> "%~n0.bat:Mode^^!PARSNIP[DUM]^^!""&SET "PARSNIP_REWIND=SET /A "PARSNIP[DUM]= # "^&ECHO W ^^^!@^^^!,^>^> "%~n0.bat:Mode^^!PARSNIP[DUM]^^!""
SET PARSNIP_MAKE=FOR %%# in (1, 1, 2) DO IF %%#==2 ( FOR /F "tokens=1,*" %%A in ("^!args^!") DO START /B CSCRIPT //NOLOGO "%~f0?.wsf" %%B "%~n0.bat:Mode^!PARSNIP_M_NUM^!"^&ECHO R,^^^> "%~n0.bat:Mode^!PARSNIP_M_NUM^!"^&SET /A "%%A=PARSNIP_M_NUM", "PARSNIP_M_NUM+=1") else SET args=
GOTO :EOF
----- Begin wsf script --->
<job><script language="VBScript">
    Set Sound = CreateObject("WMPlayer.OCX.7"):Set Fso = CreateObject("Scripting.FileSystemObject"):stream = WScript.Arguments.Item(3):loopSound = False:Sound.URL = WScript.Arguments.Item(0):Sound.settings.volume = WScript.Arguments.Item(2):If WScript.Arguments.Item(1) = "loop" Then loopSound = True:Sound.settings.setMode "loop", True Else Sound.settings.playCount = WScript.Arguments.Item(1)
    Sound.controls.stop:do while NOT Fso.FileExists(stream):Wscript.sleep 500:loop:adjStr = 0:adjLen = 0:secElapse = 0:numPlay = 0:do while Sound.playState = 3 OR Sound.playState = 2 OR Sound.playState = 10 OR numPlay = -1
    If Sound.playState = 1 AND numPlay = -1 Then Sound.settings.setMode "loop", True:numPlay = 0:Sound.controls.play:Sound.controls.pause
    Set data = Fso.OpenTextFile(stream, 1):line = Split(data.ReadAll, ","):data.Close:Set data = Fso.OpenTextFile(stream, 2):data.Write "R,":data.Close:for each x in line:x = Replace(x, vbCrLf, ""):check = Split(x, " "):If UBound(check) <> -1 Then
    If check(0) <> "R" Then
    If check(0) = "P" Then
        Sound.controls.play
    ElseIf check(0) = "A" Then:Sound.controls.pause
    ElseIf check(0) = "S" Then:Sound.controls.stop
    ElseIf check(0) = "C" Then:adjStr = check(1):adjLen = check(2)
    ElseIf check(0) = "D" Then:adjStr = -check(1):adjLen = check(2)
    ElseIf check(0) = "T" Then:Sound.controls.play:numPlay = -1:Sound.settings.setMode "loop", False:Sound.settings.playCount = check(1)
    ElseIf check(0) = "K" Then:If Sound.currentMedia.duration >= Sound.controls.currentPosition + check(1) Then Sound.controls.currentPosition = Sound.controls.currentPosition + check(1) Else Sound.controls.currentPosition = 0
    ElseIf check(0) = "W" Then:If 0 < Sound.controls.currentPosition - check(1) Then Sound.controls.currentPosition = Sound.controls.currentPosition - check(1) Else Sound.controls.currentPosition = 0
    ElseIf check(0) = "V" Then:Sound.settings.volume = check(1)
    End If
    End If
    End If
    next:Wscript.sleep 200:If adjLen <> 0 Then
    If secElapse = 0 Then
        vol = Sound.settings.volume + adjStr:If vol > 100 Then
            vol = 100
        ElseIf vol < 0 Then:vol = 0
        End If:Sound.settings.volume = vol:adjLen = adjLen - 1
        If adjLen = 0 Then secElapse = 0
    End If:secElapse = (secElapse + 1) Mod 5
    End If:loop
</script></job>