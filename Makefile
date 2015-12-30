# story-xml Makefile

# Build Dependencies (in addition to other story-xml deps.)
# 	Linux: Red Hat, CentOS
#		Serna
#		epm-4.4-2 - with mkver.pl
#		livedtd
#	Linux: Debian
#		epm-4.4-2 - with mkver.pl
#		livedtd
# 	Windows:
#		cygwin
#		Advanced Installer

mRsyncOpt = -Clptz

build : ver.env livedtd
	-find * -name '*~' -exec rm {} \;
	-find dist -type l -exec rm {} \;
	-rm -rf dist/*
	-mkdir -p dist/opt/story-xml4
	cd dist/opt; ln -s story-xml4 story-xml
	-mkdir -p dist/opt/story-xml/config dist/opt/story-xml/doc/example
	rsync -r $(mRsyncOpt) src/* dist/opt/story-xml/
	rsync -r $(mRsyncOpt) example/* dist/opt/story-xml/doc/example/
	rsync -r $(mRsyncOpt) doc/livedtd dist/opt/story-xml/doc/
	rsync -r $(mRsyncOpt) kit/linux/* dist/opt/story-xml/config/
	chmod a+rx,go-w dist/opt/story-xml/bin/*
	find dist/opt -type d -exec chmod a+rx {} \;
	find dist/opt -type f -exec chmod a+r {} \;
	mkepmlist  -u root -g root --prefix / dist | patch-epm-list -f epm.list.patch >epm.list

package : ver.env ver.epm
	-mkdir -p pkg
	#if [ "$$(whoami)" != 'root' ]; then exit 1; fi
	-rm -f pkg/*
	mkepmlist  -u root -g root --prefix / dist | patch-epm-list -f epm.list.patch >epm.list
	epm -v -f native  -a amd64 --output-dir pkg story-xml ver.epm
	chown -R $$LOGNAME:users *

release : ver.env
	+. ./ver.env; echo ssh $$ProdRelServer mkdir -p $$ProdRelDir/$$ProdOS
	. ./ver.env; rsync -P $(mRsyncOpt) pkg/* $$ProdRelServer:$$ProdRelDir/$$ProdOS
	. ./ver.env; rsync -rP $(mRsyncOpt) dist/opt/story-xml/doc $$ProdRelServer:$$ProdRelDir

clean :
	find * -type l -exec rm {} \;
	-rm ver.env ver.epm epm.list
	-rm -rf dist pkg

# -------------

ver.env : ver.sh
	export RELEASE=1; mkver.pl -e env

ver.epm : ver.sh
	export RELEASE=1; mkver.pl -e epm

# -------------
# doc/livedtd/docbook45/index.html

livedtd : doc/livedtd/story/index.html  doc/livedtd/html3.2/index.html doc/livedtd/html40loose/index.html doc/livedtd/xhtml1-transitional/index.html doc/livedtd/xslfo/index.html doc/livedtd/xslt10/index.html

doc/livedtd/story/index.html : src/style/story.dtd
	-rm -rf doc/livedtd/story/*
	livedtd.pl --outdir doc/livedtd/story --title story.dtd $?
	uniq doc/livedtd/story/ElemUsage.html >t.tmp
	mv t.tmp doc/livedtd/story/ElemUsage.html
	uniq doc/livedtd/story/EntityUsage.html >t.tmp
	mv t.tmp doc/livedtd/story/EntityUsage.html

doc/livedtd/docbook45/index.html : doc/dtd/docbook45.dtd
	livedtd.pl --outdir doc/livedtd/docbook45 --title docbook45.dtd $?
	uniq doc/livedtd/docbook45/ElemUsage.html >t.tmp
	mv t.tmp doc/livedtd/docbook45/ElemUsage.html
	uniq doc/livedtd/docbook45/EntityUsage.html >t.tmp
	mv t.tmp doc/livedtd/docbook45/EntityUsage.html

doc/livedtd/html3.2/index.html : doc/dtd/html3.2.dtd
	livedtd.pl --outdir doc/livedtd/html3.2 --title html3.2.dtd $?
	uniq doc/livedtd/html3.2/ElemUsage.html >t.tmp
	mv t.tmp doc/livedtd/html3.2/ElemUsage.html
	uniq doc/livedtd/html3.2/EntityUsage.html >t.tmp
	mv t.tmp doc/livedtd/html3.2/EntityUsage.html

doc/livedtd/html40loose/index.html : doc/dtd/html40loose.dtd
	livedtd.pl --outdir doc/livedtd/html40loose --title html40loose.dtd $?
	uniq doc/livedtd/html40loose/ElemUsage.html >t.tmp
	mv t.tmp doc/livedtd/html40loose/ElemUsage.html
	uniq doc/livedtd/html40loose/EntityUsage.html >t.tmp
	mv t.tmp doc/livedtd/html40loose/EntityUsage.html

doc/livedtd/xhtml1-transitional/index.html : doc/dtd/xhtml1-transitional.dtd
	livedtd.pl --outdir doc/livedtd/xhtml1-transitional --title xhtml1-transitional.dtd $?
	uniq doc/livedtd/xhtml1-transitional/ElemUsage.html >t.tmp
	mv t.tmp doc/livedtd/xhtml1-transitional/ElemUsage.html
	uniq doc/livedtd/xhtml1-transitional/EntityUsage.html >t.tmp
	mv t.tmp doc/livedtd/xhtml1-transitional/EntityUsage.html

doc/livedtd/xslfo/index.html : doc/dtd/xslfo.dtd
	livedtd.pl --outdir doc/livedtd/xslfo --title xslfo.dtd $?
	uniq doc/livedtd/xslfo/ElemUsage.html >t.tmp
	mv t.tmp doc/livedtd/xslfo/ElemUsage.html
	uniq doc/livedtd/xslfo/EntityUsage.html >t.tmp
	mv t.tmp doc/livedtd/xslfo/EntityUsage.html

doc/livedtd/xslt10/index.html : doc/dtd/xslt10.dtd
	livedtd.pl --outdir doc/livedtd/xslt10 --title xslt10.dtd $?
	uniq doc/livedtd/xslt10/ElemUsage.html >t.tmp
	mv t.tmp doc/livedtd/xslt10/ElemUsage.html
	uniq doc/livedtd/xslt10/EntityUsage.html >t.tmp
	mv t.tmp doc/livedtd/xslt10/EntityUsage.html

# -------------

build-schema : schema-gen.xsd template2.sdt

schema-gen.xsd : story.dtd
	/usr/local/bin/dtd2xs $? $@
	tidy -q -xml -indent -wrap 80 --tidy-mark no --indent-attributes yes -modify $@
	# Manually add restricitons and save as: schema.xsd

template2.sdt : template2.xml sample-full.xml  sample-minimal.xml
	m4 -P template2.xml >$@

template-index.html :
	echo '<html><head><title>Template Index</title></head><body><h1>Template Index<h1>' >$@
	for i in com*.xsl out*.xsl; do \
		echo '<h2>' $$i '</h2><pre>' >>$@; \
		grep '<xsl:template ' $$i | perl -ne 's/\s*<xsl:template\s+//; print' | sort -f >>$@; \
		echo '</pre>' >>$@; \
	done
	echo '</body></html>' >>$@

# -------------
mSerna1 = /usr/local/serna
mSerna3 = /usr/local/serna-3.4
mStory = story4
mTidyOpt = -q -indent -wrap 75 --tidy-mark no --indent-attributes yes --new-pre-tags pre-fmt 

serna1-publish :
	# Make symlinks in serna dirs to these devel files
	if [ $$(id -un) != root ]; then exit 1; fi
	if [ ! -d $(mSerna1) ]; then exit 1; fi
	ln -sf $$PWD/publishing/pub-fop-*.sh $(mSerna1)/utils/publishing
	ln -sf $$PWD/publishing/convert-*.sh $(mSerna1)/utils/publishing
	ln -sf $$PWD/publishing/pub-fop-pdf.sh $(mSerna1)/utils/publishing
	ln -sf $$PWD/publishing/pub-fop-ps.sh $(mSerna1)/utils/publishing
	ln -sf $$PWD/publishing/pub-xsltproc.sh $(mSerna1)/utils/publishing
	ln -sf $$PWD/publishing/pub-xsltproc-multi.sh $(mSerna1)/utils/publishing

serna1-story2 :
	# Make symlinks in serna dirs to these devel files
	if [ $$(id -un) != root ]; then exit 1; fi
	if [ ! -d $(mSerna) ]; then exit 1; fi
	-cd $(mSerna1)/xml; mkdir dtds/story2 schemas/story2 stylesheets/story2
	cp -sf $$PWD/story2/*.xsl $(mSerna1)/xml/stylesheets/story2
	ln -sf $$PWD/story2/story.dtd $(mSerna1)/xml/dtds/story2
	ln -sf $$PWD/story2/story-schema.xsd $(mSerna1)/xml/schemas/story2
	ln -sf $$PWD/story2/story-template1.xml $(mSerna1)/xml/templates/story2-template.xml

serna2-story2 :
	# Make symlinks in serna2 dirs to these devel files
	if [ $$(id -un) != root ]; then exit 1; fi
	if [ ! -d $(mSerna3) ]; then exit 1; fi
	-mkdir $(mSerna3)/plugins/story
	ln -sf $$PWD/story.dtd $(mSerna3)/plugins/story
	ln -sf $$PWD/story-schema.xsd $(mSerna3)/plugins/story
	ln -sf $$PWD/story-common.xsl $(mSerna3)/plugins/story
	ln -sf $$PWD/story2 $(mSerna3)/plugins/story
	ln -sf $$PWD/story-template2.sdt $(mSerna3)/plugins/story
	ln -sf $$PWD/publishing/run*.sh $(mSerna3)/utils/publishing

serna1-story3 :
	# Make symlinks in serna dirs to these devel files
	if [ $$(id -un) != root ]; then exit 1; fi
	if [ ! -d $(mSerna1) ]; then exit 1; fi
	-cd $(mSerna1)/xml; mkdir dtds/story3 schemas/story3 stylesheets/story3
	cp -sf $$PWD/story3/*.xsl $(mSerna1)/xml/stylesheets/story3
	ln -sf $$PWD/story3/story.dtd $(mSerna1)/xml/dtds/story3
	ln -sf $$PWD/story3/story-schema.xsd $(mSerna1)/xml/schemas/story3
	ln -sf $$PWD/story3/story-template1.xml $(mSerna1)/xml/templates/story3-template.xml

serna1-story4 :
	# Make symlinks in serna dirs to these devel files
	if [ $$(id -un) != root ]; then exit 1; fi
	if [ ! -d $(mSerna1) ]; then exit 1; fi
	-cd $(mSerna1)/xml; mkdir dtds/story4 schemas/story4 stylesheets/story4
	cp -sf $$PWD/story4/*.xsl $(mSerna1)/xml/stylesheets/story4
	ln -sf $$PWD/story4/story.dtd $(mSerna1)/xml/dtds/story4
	ln -sf $$PWD/story4/story-schema.xsd $(mSerna1)/xml/schemas/story4
	ln -sf $$PWD/story4/story-template1.xml $(mSerna1)/xml/templates/story4-template.xml

serna3-story4 :
	# Make symlinks in serna3 dirs to these devel files
	if [ $$(id -un) != root ]; then exit 1; fi
	if [ ! -d $(mSerna3) ]; then exit 1; fi
	ln -sf $$PWD/story4 $(mSerna3)/plugins
	ln -sf $$PWD/publishing/pub-*.sh $(mSerna3)/utils/publishing
	ln -sf $$PWD/publishing/convert-*.sh $(mSerna3)/utils/publishing

tidy-serna :
	find story2/* story3/* story4/* -name '*~' -exec rm -f {} \;
	for i in $$(ls *.x[ms]l story[1234]/*.x[ms]l | grep -v template); do \
		echo "Process: $$i"; \
		tidy -xml -modify $(mTidyOpt) $$i; \
	done
