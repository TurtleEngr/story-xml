#!/bin/bash

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

# ---------------------------------
tTmp=/tmp/serna.$$.tmp

echo "/usr/bin/xsltproc -o $tTmp $pStyle $pIn"
/usr/bin/xsltproc -o $tTmp $pStyle $pIn 2>&1

echo "sed 's/"NaN"/"0"/g' <$tTmp >$pOut"
sed 's/"NaN"/"0"/g' <$tTmp >$pOut
rm $tTmp

echo "tidy -xml -q -i --indent-spaces 4 --wrap 75 --indent-attributes yes -m $pOut"
tidy -xml -q -i --indent-spaces 4 --wrap 75 --indent-attributes y -m $pOut
