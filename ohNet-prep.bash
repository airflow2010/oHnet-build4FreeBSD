#!/usr/local/bin/bash

WORKPATH=/usr/local/share/ohNet-build4FreeBSD
ZIPPATH=$WORKPATH/minim-lib-zip

OHNO="`find $ZIPPATH.orig -name "ohnet*.zip"`"
REGEX=".*\(linux-intel\)-(.*).zip"

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
	rm -rf $ZIPPATH.orig.extracted
	unzip $OHNO -d $ZIPPATH.orig.extracted 
	cp -av $ZIPPATH.orig.extracted/ $ZIPPATH.freebsd.extracted

	$WORKPATH/ohNet-compile.bash $OHNV

	echo "Output:\n"
	ls -lsha $ZIPPATH.freebsd.extracted

	echo compress new libs to new archive $ZIPPATH.freebsd
	read x
	mkdir -p $ZIPPATH.freebsd
	/usr/local/bin/zip -FSj $ZIPPATH.freebsd/ohnet.zip $ZIPPATH.freebsd.extracted/*

	echo remove temporary working files?
	read x
	rm -rf $WORKPATH/ohNet_$OHNV.tar.gz
	rm -rf $WORKPATH/ohNet-ohNet_$OHNV/

	echo if everything worked fine, copy result to public repository
	echo \<assisted mechanism needed\>
	echo scp minim-lib-zip.freebsd/ohnet\(linux-intel\)-1.33.4785.zip e54294@e54294-ssh.services.easyname.eu:html/apps/wordpress-168816/ohnet/ 
else
echo cannot compute - no input version detected 
fi
