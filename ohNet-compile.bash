#!/usr/local/bin/bash

WORKPATH=/usr/local/share/ohNet-build4FreeBSD
ZIPPATH=$WORKPATH/minim-lib-zip
OHNV=$1

if [[ $OHNV ]]; then

cd $WORKPATH/ohNet-ohNet_$OHNV

echo modify source code?
read x

/usr/bin/sed -i -- 's/-DPLATFORM_LINUX//g' Makefile

echo start compilation of ohNet version $OHNV tt?
read x

/usr/local/bin/gmake tt freebsd=1 uset4=yes

echo modify ENV-VAR and copy jni_md.h?
read x

export JAVA_HOME=/usr/local/openjdk8
export libjvm_dir=/usr/local/openjdk8/jre/lib/amd64/server
cp -av /usr/local/openjdk8/include/freebsd/jni_md.h /usr/local/openjdk8/include/

echo start compilation of ohNet version $OHNV all?
read x

/usr/local/bin/gmake all nocpp11=yes freebsd=1

echo modify source code?
read x

/usr/bin/sed -i -- 's/#include <malloc.h>//g' OpenHome/Net/Bindings/Java/*.c
/usr/bin/sed -i -- 's/#include <malloc.h>//g' OpenHome/Net/Bindings/Java/*.h

echo start compilation of ohNet version $OHNV ohNetJni?
read x

/usr/local/bin/gmake nocpp11=yes ohNetJni

echo
echo compilation finished
read x

else
echo please provide version number to compile
fi
