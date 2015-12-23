#!/bin/sh
# $Header: /repo/local.cvs/app/story-xml/src/publishing/pub-fop-pdf.sh,v 1.16 2009/05/26 17:36:51 bruce Exp $

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
tBase=${pOut%.*}
tBase=${tBase##*/}
tBin=${0%/*}

# ---------------------------------
#if [ -n "$gpStyle" ]; then
#	gpStyle="--stringparam style $gpStyle"
#fi

echo "$tBin/pub-xsltproc.sh $pIn $pStyle $tBase.fo"
$tBin/pub-xsltproc.sh $pIn $pStyle $tBase.fo
#echo "tidy -xml $cTidyOpt $tBase.fo"
#tidy -xml $cTidyOpt $tBase.fo

gpStyle=''

echo "/opt/fop/fop.sh -dpi 300 -fo $tBase.fo -pdf $pOut"
/opt/fop/fop.sh -dpi 300 -fo $tBase.fo -pdf $pOut
#/opt/fop/fop.sh -c /home/brucer/tmp/fop.xconf -fo $tBase.fo -pdf $pOut
