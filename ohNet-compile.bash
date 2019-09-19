#!/usr/local/bin/bash

WORKPATH=/usr/local/share/ohNet-build4FreeBSD
ZIPPATH=$WORKPATH/minim-lib-zip
OHNV=$1

if [[ $OHNV ]]; then

cd $WORKPATH/ohNet-ohNet_$OHNV

echo modification of source code

/usr/bin/sed -i -- 's/-DPLATFORM_LINUX//g' Makefile
/usr/bin/sed -i -- 's/#include <malloc.h>//g' OpenHome/Net/Bindings/Java/*.c
/usr/bin/sed -i -- 's/#include <malloc.h>//g' OpenHome/Net/Bindings/Java/*.h

echo copying jni_md.h

cp -av /usr/local/openjdk8/include/freebsd/jni_md.h /usr/local/openjdk8/include/

echo setting environment variables

export JAVA_HOME=/usr/local/openjdk8
export libjvm_dir=/usr/local/openjdk8/jre/lib/amd64/server

echo start compilation of ohNet version $OHNV 32bit?
read x

export CROSS_COMPILE_CFLAGS=-m32
export CROSS_COMPILE_LINKFLAGS=-m32
/usr/local/bin/gmake tt freebsd=1 uset4=yes
/usr/local/bin/gmake all nocpp11=yes freebsd=1
/usr/local/bin/gmake nocpp11=yes ohNetJni

find $WORKPATH/ohNet-ohNet_$OHNV -name libohNet.so -exec mv {} $ZIPPATH.freebsd.extracted/libohNet.so.32 \;
find $WORKPATH/ohNet-ohNet_$OHNV -name libohNetJni.so -exec mv {} $ZIPPATH.freebsd.extracted/libohNetJni.so.32 \;

echo start compilation of ohNet version $OHNV 64bit?
read x

export CROSS_COMPILE_CFLAGS=-m64
export CROSS_COMPILE_LINKFLAGS=-m64
/usr/local/bin/gmake tt freebsd=1 uset4=yes
/usr/local/bin/gmake all nocpp11=yes freebsd=1
/usr/local/bin/gmake nocpp11=yes ohNetJni

find $WORKPATH/ohNet-ohNet_$OHNV -name libohNet.so -exec mv {} $ZIPPATH.freebsd.extracted/libohNet.so.64 \;
find $WORKPATH/ohNet-ohNet_$OHNV -name libohNetJni.so -exec mv {} $ZIPPATH.freebsd.extracted/libohNetJni.so.64 \;

file $ZIPPATH.freebsd.extracted/libohNet.so.32
file $ZIPPATH.freebsd.extracted/libohNet.so.64
file $ZIPPATH.freebsd.extracted/libohNetJni.so.32
file $ZIPPATH.freebsd.extracted/libohNetJni.so.64

echo
echo compilation finished
read x

else
echo please provide version number to compile
fi
