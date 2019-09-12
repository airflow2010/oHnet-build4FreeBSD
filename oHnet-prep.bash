#!/bin/bash

INPUTPATH=/usr/local/share/ohNet-build4FreeBSD/minim-lib-zip/

OHNV=$1
#OHNO="`find /mnt/SSD/jails/services_2/usr/local/share/minimserver/libext/ -name "ohnet*.zip"`"

if [ $OHNV ]; then
	echo orig lib: $OHNO
	echo compiling ohNet_$OHNV.tar.gz from github as replacement? 
	read x 
	/usr/local/bin/wget https://github.com/openhome/ohNet/archive/ohNet_$OHNV.tar.gz
	tar -xvzf ohNet_$OHNV.tar.gz -C /mnt/SSD/jails/build_1/usr/local/share/
#	rm -rf ./ohNet_$OHNV.tar.gz
	unzip $OHNO -d /mnt/SSD/jails/build_1/usr/local/share/ohnet-zip/

	jexec build_1 /usr/local/share/ohnet-compile.sh $OHNV

	echo move libs to archive?
	read x
	cp -av $OHNO /mnt/SSD/jails/build_1/usr/local/share/ /mnt/SSD/jails/build_1/usr/local/share/ohnet-$OHNV-orig.zip
	cp -av /mnt/SSD/jails/build_1/usr/local/share/ohnet.zip /mnt/SSD/jails/build_1/usr/local/share/ohnet-$OHNV-freebsd.zip

	echo replace $OHNO with newly compiled lib?
	read x
	cp -av /mnt/SSD/jails/build_1/usr/local/share/ohnet-$OHNV-freebsd.zip $OHNO 

	echo remove working-dirs?
	read x
	rm -rf /mnt/SSD/jails/build_1/usr/local/share/ohNet-ohNet_$OHNV/
	rm -rf /mnt/SSD/jails/build_1/usr/local/share/ohnet-zip/
	rm -rf /mnt/SSD/jails/build_1/usr/local/share/ohnet.zip
else
echo Bitte Versionsnummer von ohnet angeben, zB $OHNO 
fi


