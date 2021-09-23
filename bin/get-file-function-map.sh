#!/bin/bash

if [ "${PWD##*/}" != "bin" ]; then
   echo "Error: run this from the top 'bin' dir"
   exit 1
fi
if [ ! -d ../src/style ]; then
   echo "Error: Could not find ../src/style"
   exit 1
fi
cd ../src/style

cat <<EOF >file-function-map.html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>File Function Map</title>
  <style type="text/css">
  <!--
/*<![CDATA[*/
  body {
        margin-left: 2%;
        margin-right: 2%;
        font-family: Times, serif;
        font-size: 110%;
  }
  pre {
        font-size: 100%;
        line-height: 100%;
        font-family: Courier New, monospace;
  }
  /*]]>*/
  // -->
  </style>
</head>
<body>
<h1>File Function Map</h1>
EOF

for i in \
    com-param.xsl \
    com.xsl \
    com-timeline.xsl \
    com-html.xsl \
    out-html.xsl \
    out-ch-html.xsl \
    out-draft.xsl \
    out-pdf.xsl \
    out-docbook.xsl \
    out-planner.xsl \
    out-project.xsl \
    test-parm.xsl \
    serna.xsl \
    serna-new.xsl \
    serna-toc.xsl \
    serna-1.xsl \
    ; do
	echo "<hr/>"
	echo "<h2>$i</h2>"
	if grep -q ":include " $i &>/dev/null; then
		echo '<h3>Includes:</h3>'
		echo '<pre>'
		grep ':include ' $i | awk '{
			sub(/ *<xsl:include href="/,"")
			sub(/" \/>/,"")
			print $0
		}'
		echo '----------'
		echo '</pre>'
	fi
	if grep -q ':param name="g' $i &>/dev/null; then
		echo '<h3>Global Params:</h3>'
		echo '<pre>'
		grep ':param name="g' $i | awk '{
			sub(/ *<xsl:param name="/,"")
			sub(/">/,"")
			sub(/"/,"")
			print $0
		}'
		echo '----------'
		echo '</pre>'
	fi
	awk '
		BEGIN {
			gInPre=0
		}
		/:template name=/ {
			if (gInPre) {
				print "</pre>"
			}
			gInPre=0
			sub(/ *<xsl:/,"")
			sub(/>/,"")
			print "<h3>" $0 "</h3>"
			next
		}
		/call-template name=/ {
			if (! gInPre) {
				print "<pre>"
			}
			gInPre=1
			sub(/<xsl:/,"")
			sub(/>/,"")
			sub(/ *\//,"")
			sub(/&#160;<\/p>/,"")
			print "    " $0
			next
		}
		/template match=/ {
			if (! gInPre) {
				print "<pre>"
			}
			gInPre=1
			sub(/>/,"")
			sub(/<xsl:/,"<b>")
			sub(/<\/xsl:template>/,"")
			print "    " $0 "</b>"
			next
		}
		/apply-templates select/ {
			if (! gInPre) {
				print "<pre>"
			}
			gInPre=1
			sub(/<xsl:/,"")
			sub(/ *\/>/,"")
			sub(/<\/fo:block>/,"")
			print "    " $0
			next
		}
		{ next }
		END {
			if (gInPre) {
				print "</pre>"
			}
		}
	' <$i
done >>file-function-map.html

cat <<EOF >>file-function-map.html
</body>
</html>
EOF

tidy -m -q -i -w 78 -asxhtml --break-before-br yes \
     --indent-attributes yes --indent-spaces 2 --tidy-mark no \
     --vertical-space no \
     file-function-map.html

mv file-function-map.html ../../doc
