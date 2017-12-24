POMODORO (Bad Things in Perugia)
-------------------------
This is a very silly pixel-art adventure game written and developed by me and Luna Paciucci, in two years, from scratch during our spare time. The game follows the adventures of a younger version of myself during a very bizzarre day of June 2012 in the beautiful city of Perugia.

![alt text](demo_intro.gif)

Originally, the game has been developed as a PoC (Proof Of Concept) of some components in Miranda-media but, after few months, we decided to give to the game a real story and to complete it.

Please keep in mind the following two points:
 * This game is a just-for-fun and could be potentially full of bug
 * The english version of the game has **never** been tested and, due to the high amount of dialogs, conversations and cut-scenes, we **never** reviewed it.

# Dependencies
The game requires the following dependencies:
 * libmiranda (https://github.com/nardinan/miranda)
 * libSDL2
 * libSDL2_ttf
 * libSDL2_mixer
 * libSDL2_image

### Compilation on Ubuntu (potentially any Linux distribution)

Please, on Ubuntu (or any other Debian based version of Linux with apt-get support), open a terminal and install the SDL2 libraries via your Advanced Packages Tool:
```bash
$ sudo apt-get install libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev libsdl2-ttf-dev
```
Now, that all SDL2 packages are installed, it's time for Miranda:
```bash
$ git clone https://github.com/nardinan/miranda
$ cd miranda
$ make
$ sudo make install
```
Great! Miranda is now installed in your /usr/local/lib directory so, please, be sure that the environment variable LD_LIBRARY_PATH points there. Again, from your terminal, please follow the following steps to prepare Pomodoro:
```
$ git clone https://github.com/nardinan/pomodoro
$ cd pomdoro
$ make
```

### Compilation on Mac OS X

On MacOS X, the installation procedure has been tested and completed using MacPort (https://www.macports.org). To install the SDL2 libraries via *port* command please, follow the following steps:
```bash
$ sudo port install libsdl2 libsdl2_image libsdl2_mixer libsdl2_ttf
```
Once the libraries are correctly installed on your system, please, follow the installation of Miranda and Pomodoro on the 'Installation on Ubuntu' paragraph.

If you experience any problem during this procedure please, let us know.

## Compilation on Windows

Well, it is feasible (we compiled the binary on Windows as well) but is really complex: don't do it.

# The game

The game has been designed and developed by me and Luna Paciucci (https://www.linkedin.com/in/paciucciluna/), musics are an original composition of Saverio Federici (http://www.saveriofederici.it), pixel-art by me and 2D illustrations are an original work of Leonardo Carboni (https://www.facebook.com/leonardocarboniart/).
### Controls
The game can be controlled with the following keys:
* **arrow right** (keep pressed) - move the character on the right
* **arrow right** (press twice and keep pressed the second time) - run on the right
* **arrow left** (keep pressed) - move the character on the left
* **arrow left** (press twice and keep pressed the second time) - run on the left
* **left shift** (keep pressed) - highlight all the interactable objects visible
* **space** - action
* **esc** - quit the game

# Please help us

The game has not been beta-tested for real and it would be great if you could help us letting us know about problems, bugs, crashes, typos, errors in the game or any other kind of feedback using the project's **issues** tab.
Thank you for your cooperation.


