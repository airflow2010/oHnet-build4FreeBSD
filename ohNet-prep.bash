#!/usr/local/bin/bash

WORKPATH=/usr/local/share/ohNet-build4FreeBSD
INPUTPATH=/usr/local/share/ohNet-build4FreeBSD/minim-lib-zip

OHNO="`find $INPUTPATH -name "ohnet*.zip"`"
REGEX=".*\(linux-intel\)-(.*).1.zip"

if [[ $OHNO =~ $REGEX ]]
	then 
		echo Inputfile: $OHNO
		echo Version: ${BASH_REMATCH[1]} 
		OHNV=${BASH_REMATCH[1]}
fi


if [ $OHNV ]; then
	echo orig lib: $OHNO
	echo compiling ohNet_$OHNV.tar.gz from github as replacement? 
	read x 
	/usr/local/bin/wget -P $WORKPATH https://github.com/openhome/ohNet/archive/ohNet_$OHNV.tar.gz
	tar -xvzf $WORKPATH/ohNet_$OHNV.tar.gz -C $WORKPATH
	read x
	unzip $OHNO -d $WORKPATH/minim-lib-zip-extracted/

	exit

	$WORKPATH/ohNet-compile.sh $OHNV

	echo move libs to archive?
	read x
	cp -av $OHNO /mnt/SSD/jails/build_1/usr/local/share/ /mnt/SSD/jails/build_1/usr/local/share/ohnet-$OHNV-orig.zip
	cp -av /mnt/SSD/jails/build_1/usr/local/share/ohnet.zip /mnt/SSD/jails/build_1/usr/local/share/ohnet-$OHNV-freebsd.zip

	echo remove working-dirs?
	read x
	rm -rf /mnt/SSD/jails/build_1/usr/local/share/ohNet-ohNet_$OHNV/
	rm -rf /mnt/SSD/jails/build_1/usr/local/share/ohnet-zip/
	rm -rf /mnt/SSD/jails/build_1/usr/local/share/ohnet.zip
	rm -rf $WORKPATH/*.zip
else
echo cannot compute - no input version detected 
fi


