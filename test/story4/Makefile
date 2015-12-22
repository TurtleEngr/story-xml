# Makefile

mTest=book1
mBin=../../src/publishing
mSrc=/home/brucer/home/ver/local/app/story-xml/src/story4
mTidy=tidy -q -xml -indent -wrap 75 --tidy-mark no --indent-attributes yes -modify --new-pre-tags pre-fmt 

html :
	-$(mBin)/pub-xsltproc.sh $(mTest).xml $(mSrc)/story-html.xsl $(mTest).html 2>&1

draft :
	-$(mBin)/pub-xsltproc.sh $(mTest).xml $(mSrc)/story-draft.xsl $(mTest)-draft.html 2>&1

planner :
	-$(mBin)/pub-xsltproc.sh $(mTest).xml $(mSrc)/story-planner.xsl $(mTest)-timeline.planner
	-$(mTidy) /tmp/timeline.xml

proj :
	-$(mBin)/pub-xsltproc.sh $(mTest).xml $(mSrc)/story-project.xsl $(mTest)-timeline.proj.xml
	-$(mTidy) /tmp/timeline.xml
	-$(mTidy) --indent-spaces 4 $(mTest)-timeline.proj.xml

pdf :
	-$(mBin)/pub-fop-pdf.sh $(mTest).xml $(mSrc)/story-pdf.xsl $(mTest).pdf 2>&1

ps :
	-$(mBin)/pub-fop-ps.sh $(mTest).xml $(mSrc)/story-pdf.xsl $(mTest).ps 2>&1

docbook :
	-$(mBin)/pub-xsltproc.sh $(mTest).xml $(mSrc)/story-docbook.xsl $(mTest)-docbook.xml 2>&1

convert-3to4 :
	-$(mBin)/pub-xsltproc.sh ../story3/$(mTest).xml $(mSrc)/convert-3to4.xsl $(mTest)-ver4.xml 2>&1

set-env :
	echo "export b=$$PWD/$(mBin)/pub-xsltproc.sh"
	echo "export s=$$PWD/$(mSrc)"
	echo echo "$$b IN.xml $$s/convert-3to4.xsl IN-ver4.xml"

clean :
	-rm *~
	-rm *.fo
	-rm *.tmp
	-rm output-list.txt
	-rm *.ps *.pdf
	-rm *.html
	-rm *.planner
	-rm *.mrproject
	-rm *-docbook.xml


