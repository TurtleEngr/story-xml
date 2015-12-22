# $Header: /repo/local.cvs/app/story-xml/old/src/Makefile,v 1.3 2004/12/05 18:26:47 bruce Exp $

test : book.xsl inc-key.xsl inc-text.xsl inc-util.xsl ../test/common-sense.xml
	-rm -rf web/* draft/* 2>/dev/null
	-mkdir web draft 2>/dev/null
	xsltproc book.xsl ../test/common-sense.xml 2>&1 | more

book.html : book.xsl
	xsltproc ~/xpath-tree-diagram.xsl $? >$@
