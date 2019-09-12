#!/usr/local/bin/bash

OHNV=$1

cd /usr/local/share/

#/usr/local/bin/git clone git@github.com:openhome/ohNet.git ohnet

cd ohNet-ohNet_$OHNV

/usr/bin/sed -i -- 's/-DPLATFORM_LINUX//g' Makefile

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

scp ohnet.zip e54294@e54294-ssh.services.easyname.eu:html/apps/wordpress-32958/ohnet/
