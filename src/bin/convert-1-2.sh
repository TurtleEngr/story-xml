#!/bin/bash
# Config
cConvert=/usr/local/serna/xml/stylesheets/story/style/convert-1-2.xsl

if [ $# -ne 2 ]; then
	cat <<EOF
Usage:
	convert-1-2.sh IN.xml OUT.xml
EOF
	exit 1
fi
pIn=$1
pOut=$2

xsltproc.sh $pIn $cConvert /tmp/convert.xml

# Remove %
awk '
/line-height="/ {
	gsub(/\%/, "", $0);
}
{
	print $0
}
' /tmp/convert.xml >$pOut
#rm /tmp/convert.xml
