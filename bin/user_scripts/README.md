# User Scripts
This folder cotains my 'user scripts' configurations, that is split, according to the following sekelton:

- /bin: The 'bin' directory contains executable scripts, or in other words, scripts that specify a shebang definition at the top of the file and can be executed like a regular binary executable.
- /scripts: The 'scripts' directory is home to scripts that, for some reason, shouldn't populate the systems PATH environement. For example, scripts that are integrated with the window manager, to handle opening a tmux session or launch an Xorg locker, are not supposed to be executed by the user/through a tty. Therefore, there is no apparent reason to add them to the systems PATH.
- /lib: The 'lib' directory contains files, that can be sourced by various scripts in the 'bin' and 'scripts' directorys, to provide helpful definitions or in other words, library functionality.


