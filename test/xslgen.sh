#!/bin/bash
# Patch up the xsl version number, so xsltproc will parse it.  This
# will probably break something.  When it does, look for a newer
# xsltproc version.

pInFile=$1
pOutFile=$2

if [ ! -d /tmp/$LOGNAME ]; then
	mkdir /tmp/$LOGNAME
fi
tFile1=/tmp/$LOGNAME/t1.$$
tFile2=/tmp/$LOGNAME/t2.$$


#	if (/<img ref="([^"]*)"\/>/) {
#		s/<img ref="([^"]*)"\/>/<img class="attr=`src key('img-index', '$1')/@url; alt key('img-index', '$1')/.; target?key('img-index', '$1')[@offsite='yes'] '_blank';` border="0">/;
#	}
#	/<link ref=/ {
#	}
#	/<a ref=/ {
#	}

# Look for an "extra.xsl" file
tExtra=""
for i in extra.xsl ../extra.xsl ../../extra.xsl ../../../extra.xsl; do
	if [ -f $i ]; then
		tExtra=$i
		break
	fi
done

xslgen $pInFile $tFile1
if [ -n "$tExtra" ]; then
	awk -v tExtra=$tExtra '
		$1 == "<xsl:output" {
			print $0
			print "<xsl:include href=\"" tExtra "\"/>"
			next
		}
		{ print $0 }
	' <$tFile1 >$tFile2
	mv -f $tFile2 $tFile1
fi
sed 's/version="1.1.0"/version="1.0"/' <$tFile1 >$pOutFile
rm -f $tFile
