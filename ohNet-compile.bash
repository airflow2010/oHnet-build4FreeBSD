#!/usr/local/bin/bash

WORKPATH=/usr/local/share/ohNet-build4FreeBSD
OHNV=$1

cd $WORKPATH/ohNet-ohNet_$OHNV

read x

/usr/bin/sed -i -- 's/-DPLATFORM_LINUX//g' Makefile

read x

/usr/local/bin/gmake tt freebsd=1 uset4=yes

read x

export JAVA_HOME=/usr/local/openjdk8/
export libjvm_dir=/usr/local/openjdk8/jre/lib/amd64/server/

read x

/usr/local/bin/gmake all nocpp11=yes freebsd=1

read x

/usr/bin/sed -i -- 's/#include <malloc.h>//g' OpenHome/Net/Bindings/Java/*.c
/usr/bin/sed -i -- 's/#include <malloc.h>//g' OpenHome/Net/Bindings/Java/*.h

read x

/usr/local/bin/gmake nocpp11=yes ohNetJni

echo Fertig kompiliert, zip-File erstellen?
read x

cd ..

mv ohnet-zip/libohNet.so ohnet-zip/libohNet.so.bak
find ohNet-ohNet_$OHNV -name libohNet.so -exec mv {} ohnet-zip/ \;
mv ohnet-zip/libohNetJni.so ohnet-zip/libohNetJni.so.bak
find ohNet-ohNet_$OHNV -name libohNetJni.so -exec mv {} ohnet-zip/ \;

echo "Output:\n"
ls -lsha ohnet-zip

read x

cd ohnet-zip
/usr/local/bin/zip ../ohnet.zip ./*
cd ..

