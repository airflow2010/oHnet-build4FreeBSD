# oHnet-build4FreeBSD
buildscripts to make oHnet libraries available on FreeBSD

## oHnet-prep.bash

wrapper script, prepares for compilation of libraries

* takes the zip-file from minim-server installation as input
* determines the exact oHnet version to compile
* downloads the sourcecode
* calls the compilation script
* packs the output of the compilation into the new zip-file needed for FreeBSD installation of MinimServer

## oHnet-compile.bash

* makes necessary changes to the sourcecode of oHnet-lib to make it compilable on FreeBSD
* compiles the code
