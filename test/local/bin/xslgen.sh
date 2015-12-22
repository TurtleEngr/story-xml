#!/bin/bash
# Patch up the xsl version number, so xsltproc will parse it.  This
# will probably break something.  When it does, look for a newer
# xsltproc version.

tFile=/tmp/t.$$
xslgen $1 $tFile
sed 's/version="1.1.0"/version="1.0"/' <$tFile >$2
rm -f $tFile
