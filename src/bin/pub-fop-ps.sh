#!/bin/sh
# $Header: /repo/local.cvs/app/story-xml/src/publishing/pub-fop-ps.sh,v 1.8 2008/06/23 21:42:05 bruce Exp $

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

tBase=${pOut%.*}
tBase=/tmp/${tBase##*/}
tBin=${0%/*}

# ---------------------------------
echo "$tBin/pub-fop-pdf.sh $pIn $pStyle $tBase.pdf"
$tBin/pub-fop-pdf.sh $pIn $pStyle $tBase.pdf

echo "pdf2ps -dLanguageLevel=1 -r600 $tBase.pdf $pOut"
pdf2ps -dLanguageLevel=1 -r600 $tBase.pdf $pOut
