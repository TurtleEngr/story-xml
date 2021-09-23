# Makefile

#xsltproc -o t.txt ../src/style/story-pdf.xsl test2.xml 2>&1 | more

#xsltproc ../src/style/story-html.xsl test2.xml 2>&1 | more

#xsltproc ../src/style/story-ch-html.xsl test2.xml 2>&1 | more

page : test-page.fo
	/opt/fop/fop.sh -fo $? -pdf test-page.pdf

even-odd : test-even-odd.fo
	/opt/fop/fop.sh -fo $? -pdf test-even-odd.pdf

test-man : test-man.fo
	/opt/fop/fop.sh -fo $? -pdf test-man.pdf

book1 : book1.pdf

book1.pdf : book1.fo /opt/fop/fop.sh
	/opt/fop/fop.sh -fo book1.fo -pdf $@

book1.fo : book1.xml ../src/style/story-pdf.xsl
	xsltproc ../src/style/story-pdf.xsl book1.xml

clean :
	rm -f *.html* t.txt*
