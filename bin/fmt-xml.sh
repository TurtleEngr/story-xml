#!/bin/bash

# --------------------
if [ $# -eq 0 ]; then
	cat <<EOF
Usage:
	fmt-xml.sh FILE...

Format xml, xsl, html, and other files. The files are changed
in-place, so version or backup the files.

Indent is set to 4 spaces for html and xml files. You can overide this
by setting this env. var.: export XMLLINT_INDENT=' '

Blank lines are put after important code blocks: template, when, test,
etc.

EOF
	exit 1
fi

# --------------------
# Config

# Set to 4 spaces
export XMLLINT_INDENT
XMLLINT_INDENT=${XMLLINT_INDENT:-'    '}

cWidth=${#XMLLINT_INDENT}

cTidyCom="-m -q -i --indent-spaces $cWidth -w 78 --indent-attributes yes --drop-empty-elements no --preserve-entities yes --wrap-attributes yes --literal-attributes yes --vertical-space yes --tidy-mark no --show-warnings no "

cTidyHtml="tidy -asxhtml $cTidyCom --break-before-br yes --drop-empty-paras yes"

cTidyWrap="tidy -xml $cTidyCom --drop-empty-paras no --quote-nbsp no --quote-ampersand no --new-pre-tags pre-fmt"

cTidyNoWrap="tidy -xml $cTidyCom -w 2000 --drop-empty-paras no --quote-nbsp no --quote-ampersand no --wrap-attributes no --indent-attributes no"

# --------------------
# Validate
gpFiles=''
for i in $*; do
	tExt=${i##*.}
	if [ "$tExt" != "html" ] && \
	   [ "$tExt" != "htm" ] && \
	   [ "$tExt" != "xml" ] && \
	   [ "$tExt" != "xsl" ] && \
	   [ "$tExt" != "xsd" ] && \
	   [ "$tExt" != "sdt" ]; then
		echo "Skipping: $i. $tExt extension is not supported. [$LINENO]"
		continue
	fi
	if [ ! -r $i ]; then
		echo "Skipping $i. Could not read. [$LINENO]"
		continue
	fi
	if [ "$tExt" != "html" ] && [ "$tExt" != "htm" ]; then
		if ! xmllint --noout --nonet $i; then
			echo "Skipping $i. Invalid xml. [$LINENO]"
			continue
		fi
	fi
	gpFiles="$gpFiles $i"
done
if [ -z "$gpFiles" ]; then
	exit 1
fi

# --------------------
# Format
for i in $gpFiles; do
	echo $i
	tExt=${i##*.}
	case $tExt in
		htm|html)    $cTidyHtml    $i;;
		xsl|xml|xsd) $cTidyWrap    $i;;
		sdt) 	     $cTidyNoWrap  $i;;
	esac
	cat $i | awk '
		/xsl:template>/ {print $0; print " "; next}
		/xsl:when>/ {print $0; print " "; next}
		/xsltu:test>/ {print $0; print " "; next}
		/xs:element>/ {print $0; print " "; next}
		/xs:attribute>/ {print $0; print " "; next}
		{print $0}
	' >t.tmp
	mv t.tmp $i
done
