#!/usr/local/bin/bash

WORKPATH=/usr/local/share/ohNet-build4FreeBSD
ZIPPATH=$WORKPATH/minim-lib-zip

OHNO="`find $ZIPPATH.orig -name "ohnet*.zip"`"
REGEX=".*\(linux-intel\)-(.*).1.zip"

if [[ $OHNO =~ $REGEX ]]
	then 
		OHNV=${BASH_REMATCH[1]}
		echo Inputfile: $OHNO
		echo Version:   $OHNV 
fi


if [ $OHNV ]; then
	echo compiling ohNet_$OHNV.tar.gz from github as replacement? 
	read x 
	/usr/local/bin/wget -P $WORKPATH https://github.com/openhome/ohNet/archive/ohNet_$OHNV.tar.gz
	echo extract source code?
	read x
	tar -xvzf $WORKPATH/ohNet_$OHNV.tar.gz -C $WORKPATH
	echo extract minimserver-lib?
	read x
	unzip $OHNO -d $ZIPPATH.orig.extracted 

	$WORKPATH/ohNet-compile.bash $OHNV

	echo move new libs to new archive $ZIPPATH.freebsd.extracted?
	read x
	cp -av $ZIPPATH.orig.extracted $ZIPPATH.freebsd.extracted
	find $WORKPATH/ohNet-ohNet_$OHNV -name libohNet.so -exec mv {} $ZIPPATH.freebsd.extracted/ \;
	find $WORKPATH/ohNet-ohNet_$OHNV -name libohNetJni.so -exec mv {} $ZIPPATH.freebsd.extracted/ \;
	echo "Output:\n"
	ls -lsha $ZIPPATH.freebsd.extracted

	echo compress new libs to new archive $ZIPPATH.freebsd
	read x
	mkdir -p $ZIPPATH.freebsd
	/usr/local/bin/zip $ZIPPATH.freebsd/ohnet.zip $ZIPPATH.freebsd.extracted/*

	echo remove temporary working files?
	read x
	rm -rf $WORKPATH/ohNet_$OHNV.tar.gz
	rm -rf $WORKPATH/ohNet-ohNet_$OHNV/
	rm -rf $ZIPPATH.*
else
echo cannot compute - no input version detected 
fi


