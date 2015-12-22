#!/bin/bash
# $Header: /repo/local.cvs/app/story-xml/src/publishing/pub-xsltproc.sh,v 1.14 2009/04/28 07:23:43 bruce Exp $

cTidyOpt="-modify -q -e --show-warnings no --tidy-mark no --drop-empty-paras no  -indent -wrap 75  --indent-spaces 2 --indent-attributes yes"

echo cmd: $0 $*
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
if [ -n "$gpStyle" ]; then
	gpStyle="--stringparam style $gpStyle"
fi

echo "/usr/bin/xsltproc $gpStyle -o $pOut $pStyle $pIn"
/usr/bin/xsltproc $gpStyle -o $pOut $pStyle $pIn 2>&1

case $pOut in
	*.xml)
		echo "tidy -xml $cTidyOpt $pOut"
		tidy -xml $cTidyOpt $pOut
	;;
	*.html)
		echo "tidy -asxhtml $cTidyOpt $pOut"
		tidy -asxhtml $cTidyOpt $pOut
	;;
	*) exit 0
	;;
esac
