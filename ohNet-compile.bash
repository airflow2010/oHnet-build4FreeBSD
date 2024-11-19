#!/usr/local/bin/bash

WORKPATH=/usr/local/share/ohNet-build4FreeBSD
ZIPPATH=$WORKPATH/minim-lib-zip
OHNV=$1

if [[ $OHNV ]]; then

cd $WORKPATH/ohNet-ohNet_$OHNV

echo modification of source code

#/usr/bin/sed -i -- 's/-Werror//g' Makefile
/usr/bin/sed -i -- '1838s/$/ \&\& \!defined(PLATFORM_FREEBSD)/' Os/Posix/Os.c
/usr/bin/sed -i -- 's/IPV6_ADD_MEMBERSHIP/IP_ADD_MEMBERSHIP/g' Os/Posix/Os.c
/usr/bin/sed -i -- 's/IPV6_DROP_MEMBERSHIP/IP_DROP_MEMBERSHIP/g' Os/Posix/Os.c

echo copying jni_md.h

cp -av /usr/local/openjdk17/include/freebsd/jni_md.h /usr/local/openjdk17/include/

echo setting environment variables

export JAVA_HOME=/usr/local/openjdk17
export libjvm_dir=/usr/local/openjdk17/lib/server

echo start compilation of ohNet version $OHNV 32bit?
read x

export CROSS_COMPILE_CFLAGS=-m32
export CROSS_COMPILE_LINKFLAGS=-m32
echo 1: /usr/local/bin/gmake ohNetJni nocpp11=yes freebsd=1 
read x
/usr/local/bin/gmake ohNetJni nocpp11=yes freebsd=1
echo 2: /usr/local/bin/gmake ohNetJava nocpp11=yes freebsd=1
read x
/usr/local/bin/gmake ohNetJava nocpp11=yes freebsd=1

# old stuff
#/usr/local/bin/gmake tt freebsd=1 uset4=yes
#/usr/local/bin/gmake all nocpp11=yes freebsd=1
#/usr/local/bin/gmake ohNetJni nocpp11=yes freebsd=1

find $WORKPATH/ohNet-ohNet_$OHNV -name libohNet.so -exec mv {} $ZIPPATH.freebsd.extracted/libohNet.so.32 \;
find $WORKPATH/ohNet-ohNet_$OHNV -name libohNetJni.so -exec mv {} $ZIPPATH.freebsd.extracted/libohNetJni.so.32 \;

echo start compilation of ohNet version $OHNV 64bit?
read x

export CROSS_COMPILE_CFLAGS=-m64
export CROSS_COMPILE_LINKFLAGS=-m64
echo 1: /usr/local/bin/gmake ohNetJni nocpp11=yes freebsd=1
read x
/usr/local/bin/gmake ohNetJni nocpp11=yes freebsd=1
echo 2: /usr/local/bin/gmake ohNetJava nocpp11=yes freebsd=1
read x
/usr/local/bin/gmake ohNetJava nocpp11=yes freebsd=1

# old stuff
#/usr/local/bin/gmake tt freebsd=1 uset4=yes
#/usr/local/bin/gmake all nocpp11=yes freebsd=1
#/usr/local/bin/gmake ohNetJni nocpp11=yes freebsd=1

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
