## How to Use

1. Copy the header [here](../src/header.bat) to the top of your batch file and the library [here](../src/library.bat) to the bottom of your batch file
2. Before using **parsnip**, ```CALL :PARSNIP_INIT```
3. Visit the documentation [here](doc/README.md) and look at the examples [here](ex)!

## Macros

Note : all macros accept variables. For example, 

```
%PARSNIP_PLAY_NUM: # = var, @ = 2%
```

works, as well as 

```
%PARSNIP_PLAY_NUM: # = var, @ = num%
```

and even math statements (it's a SET /A behind the scenes)

```
%PARSNIP_PLAY_NUM: # = var, @ = num + 2%
```

---

```Batch
%PARSNIP_MAKE% var name num vol
```

Creates a music object that will be used to manipulate audio. Do **NOT** use this inside a game loop. Create the object before hand and play as needed inside the loop.

* **var** variable name that will "store" the object
* **name** path to audio file
* **num** number of times to play audio, or "loop" to loop
* **vol** volume from 0-100

---

```Batch
%PARSNIP_PLAY: # = var%
```
Plays audio

* **var** variable name

---

```Batch
%PARSNIP_PLAY_NUM: # = var, @ = num%
```
Plays audio specified times. ONLY for **looping** audio (```num``` parameter in ```%PARSNIP_MAKE%```). Good for sounds in game loops (create one object with loop and play num each time needed)

* **var** variable name
* **num** number of times to play

---

```Batch
%PARSNIP_PAUSE: # = var%
```
Pauses audio

* **var** variable name

---

```Batch
%PARSNIP_STOP: # = var%
```

Stops audio, meaning audio process is stopped. Do this when you no longer need that specific audio. You MUST stop all audio when you want to programmatically exit the batch file (since they're all separate threads).

* **var** variable name

---

```Batch
%PARSNIP_VOLUME: # = var, @ = vol%
```

Sets volume.

* **var** variable name
* **vol** volume

---

```Batch
%PARSNIP_CRESCENDO: # = var, @ = str, ? = len%
```

Crescendos the volume

* **var** variable name
* **str** how much to increase each second
* **len** for how long in second

---

```Batch
%PARSNIP_DECRESCENDO: # = var, @ = str, ? = len%
```
Decrescendos the volume.

* **var** variable name
* **str** how much to decrease each second
* **len** for how long in second

---

```Batch
%PARSNIP_SKIP: # = var, @ = num%
```
Skips audio.

* **var** variable name
* **num** how many seconds to skip

---

```Batch
%PARSNIP_REWIND: # = var, @ = num%
```
Rewinds audio.

* **var** variable name stores the object
* **num** how many seconds to rewind
