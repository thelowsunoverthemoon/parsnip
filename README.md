<p align="center">
  <img src="https://i.imgur.com/nsDyBdf.png">
</p>
<p align="center">
  <b>Lightweight Audio Library for Batch Script</b>
</p>

## Features

* Simple to include, just copy & paste!
* Relatively fast, with a simple macro interface
* Supports many audio file types : mp3, wma, wav (see [here](https://support.microsoft.com/en-us/topic/file-types-supported-by-windows-media-player-32d9998e-dc8f-af54-7ba1-e996f74375d9) for full)
* Supports stop, play, play num, pause, volume, skip, rewind, crescendo, decrescrendo
* Audio is contained within the Batch file (closing it stops the audio)
* Does not get slower with more tracks
* No external exes, contained within a single batch file
* Works out-of-the-box with Windows 2000 (on NTFS file system) and up

## Usage

**parsnip** is fit for audio manipulation for various Batch scripts (like music players), especially games such as text adventures or turn based games. Look at the examples to see optimal ways to use it. The simple macro interface is made to be intuitive and simple to use. For example, to play a piece of music looping at full volume

```Batch
%PARSNIP_MAKE% music "OrationOfRuin.mp3" loop 100
%PARSNIP_PLAY: # = music%
```

## Documentation
Visit the documentation [here](doc/README.md)!

## Examples
Look at the examples [here](ex)!

## How does it work?
**parsnip** uses the Windows Media Player object to manipulate audio from embedded VBScript. Embedding VBScript in Batch script is detailed [here](https://www.dostips.com/forum/viewtopic.php?p=33963#p33963) - the gist is that we can call CSCRIPT on the batch file itself (interpreting as a WSF file) to run scripts, which, in our case, is a single audio script. Embedding this way brings lots of benefits, such as working out-of-the-box and also having the audio contained in the Batch file process. Once we create a process, then we communicate using alternate data streams (ADS, only on NTFS file systems).This way, we can start a new VBScript process for each audio, and associate it with a particular data stream, meaning it's all asynchronous, so performance does not slow down with more tracks.
