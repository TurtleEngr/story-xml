# Input files: *.fmt
# Output files: *.html

mFileList = test.html

mTidyPath=/usr/local/etc/tidy-xslgen.conf
mTidyConfig=/usr/local/etc/tidy-html.conf

all : tidy.conf $(mFileList)

tidy.conf :
	ln  -s $(mTidyPath) $@

%.html : %.xsl
	xsltproc $? ../testbook.xml >t.tmp
	-tidy -config $(mTidyConfig) t.tmp >$@
	rm t.tmp

%.xsl  : %.fmt
	../xslgen.sh $? $@

Content: site
index.html : site-index.xsl
site-index.xsl : site-index.fmt

Content: site, each story
story-index.html : story-index.xsl
story-index.xsl : story-index.fmt

Content: site, story, each chapter
STORYn/index.html : ch-index.xsl
ch-index.xsl : ch-index.fmt

Content: site, story, chapter
STORYn/ch1.html ch.xsl
ch.xsl : ch.fmt

Content: site, story, chapter
STORYn/ch2.html : ch.xsl
ch.xsl : ch.fmt

Content: site, story, all chapters
STORYn/STORYn.html : 

Content: site, story, all chapters
STORYn/STORYn-ann.html


site/
	index.html
	image/
	mirror/
		index.html
	reference/
		index.html
	story/
		index.html
		BOOKn/
			index.html
		BOOKn/
			index.html
