## How to Use

1. Copy the header [here](../src/header.bat) to the top of your batch file and the library [here](../src/library.bat) to the bottom of your batch file
2. Before using **parsnip**, ```CALL :PARSNIP_INIT```
3. Visit the documentation [here](doc/README.md) and look at the examples [here](ex)!

## Macros

```Batch
%PARSNIP_MAKE% var name num vol
```

Creates a music object that will be used to manipulate audio

* **var** variable name that will "store" the object
* **name** path to audio file
* **num** number of times to play audio, or "loop" to loop
* **vol** volume from 0-100

---

```Batch
%PARSNIP_PLAY: # = var%
```
Plays audio

* **var** variable name that will "store" the object

---

```Batch
%PARSNIP_PLAY_NUM: # = var, @ = num%
```
Plays audio specified times. Only for looping audio. Good for sounds in game loops (create one object and play num each time needed)

* **var** variable name stores the object
* **num** number of times to play

---

```Batch
%PARSNIP_PAUSE: # = var%
```
Pauses audio

* **var** variable name that stores the object

---

```Batch
%PARSNIP_STOP: # = var%
```

Stops audio, meaning audio process is stopped. Do this when you no longer need music and if you want to exit the batch file.
* **var** variable name stores the object

---

```Batch
%PARSNIP_VOLUME: # = var, @ = vol%
```

Sets volume.

* **var** variable name stores the object
* **vol** volume
* 
---

```Batch
%PARSNIP_CRESCENDO: # = var, @ = str, ? = len%
```

Crescendos the volume

* **var** variable name stores the object
* **str** how much to increase each second
* **len** for how long in second

---

```Batch
%PARSNIP_DECRESCENDO: # = var, @ = str, ? = len%
```
Decrescendos the volume.

* **var** variable name stores the object
* **str** how much to decrease each second
* **len** for how long in second

---

```Batch
%PARSNIP_SKIP: # = var, @ = num%
```
Skips audio.

* **var** variable name stores the object
* **num** how many seconds to skip

---

```Batch
%PARSNIP_REWIND: # = var, @ = num%
```
Rewinds audio.

* **var** variable name stores the object
* **num** how many seconds to rewind
