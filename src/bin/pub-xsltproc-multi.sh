#!/bin/bash

cTidyOpt="-modify -q -e --show-warnings no --tidy-mark no --drop-empty-paras no  -indent -wrap 75  --indent-spaces 2 --indent-attributes yes"

if [ $# -lt 3 -a -z "$SERNA_XSL_STYLESHEET" ]; then
	cat <<EOF
Usage:
	$0 IN.xml STYLE.xsl OUT
    or
	Env. Var:
		\$SERNA_XML_SRCFULLPATH
		\$SERNA_XSL_STYLESHEET
		\$SERNA_OUTPUT_FILE
	$0
EOF
	exit 1
fi
if [ $# -eq 3 ]; then
	pIn=$1
	echo "Input=$pIn"
	pStyle=$2
	echo "Style=$pStyle"
	pOut=$3
	echo "Output=$pOut"
else
	pIn=$SERNA_XML_SRCFULLPATH
	echo "Input=$pIn"
	pStyle=$SERNA_XSL_STYLESHEET
	echo "Style=$pStyle"
	pOut=$SERNA_OUTPUT_FILE
	echo "Output=$pOut"
fi
touch $pOut
if [ ! -r $pIn ]; then
	echo "Error: Can not read $pIn"
	exit 1
fi
if [ ! -r $pStyle ]; then
	echo "Error: Can not read $pStyle"
	exit 1
fi
if [ ! -w $pOout ]; then
	echo "Error: Can not write to $pOut"
	exit 1
fi

# ---------------------------------------
if [ -n "$gpStyle" ]; then
	gpStyle="--stringparam style $gpStyle"
fi

echo "/usr/bin/xsltproc $gpStyle -o $pOut $pStyle $pIn"
/usr/bin/xsltproc $gpStyle -o $pOut $pStyle $pIn 2>&1

for i in $(cat output-list.txt); do
	if [ ! -f $i ]; then
		continue
	fi
	case $i in
		*.xml)
			echo "tidy -xml $cTidyOpt $i"
			tidy -xml $cTidyOpt $i
		;;
		*.html)
			echo "tidy -asxhtml $cTidyOpt $i"
			tidy -asxhtml $cTidyOpt $i
		;;
	esac
done

#tTmpDir=/tmp/serna.$$
#mkdir $tTmpDir
#	perl -ne '
#s/xmlns:fo="http:\/\/www.w3.org\/1999\/XSL\/Format" //g;
#s/xmlns:fo=//g;
#s/"http:\/\/www.w3.org\/1999\/XSL\/Format"//g;
#s/ class="[pst]" style="padding: \d+pt; border-width: 0; border-color: black; border-style: solid; start-indent: 0pt; end-indent: 0pt; "//g;
#s/<p>&nbsp;/&nbsp;/g;
#s/<br><\/p>/<br>/g;
#print "$_";
#	' <$i >$tFile
