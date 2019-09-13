# ohNet-build4FreeBSD
buildscripts to make ohNet libraries available on FreeBSD

some discussion about this to be found here: http://forum.openhome.org/showthread.php?tid=1320

## ohNet-prep.bash

wrapper script, prepares for compilation of libraries

* takes the zip-file from minim-server installation as input
* determines the exact ohNet version to compile
* downloads the sourcecode
* calls the compilation script
* packs the output of the compilation into the new zip-file needed for FreeBSD installation of MinimServer

## ohNet-compile.bash

* makes necessary changes to the sourcecode of ohNet-lib to make it compilable on FreeBSD
* compiles the code
