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

mSerna4 = /opt/serna/serna-4.2
mRsyncOpt = -Clptz

mTidyOpt = -modify -q --show-warnings no --tidy-mark no --drop-empty-paras no -indent -wrap 75 --indent-spaces 2 --indent-attributes yes --new-pre-tags pre-fmt

mTidyTemplate = -modify -q --show-warnings no --tidy-mark no --drop-empty-paras no -indent -wrap 2000 --indent-spaces 2 --indent-attributes no --quote-nbsp no --quote-ampersand no

# --------------------
build : ver.env livedtd
	-find * -name '*~' -exec rm {} \;
	-find dist -type l -exec rm {} \;
	-rm -rf dist/*
	-mkdir -p dist/opt/story-xml4
	cd dist/opt; ln -s story-xml4 story-xml
	rsync -r $(mRsyncOpt) src/* dist/opt/story-xml/
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
# src/doc/livedtd/docbook45/index.html

livedtd : src/doc/livedtd/story/index.html src/doc/livedtd/html3.2/index.html src/doc/livedtd/html40loose/index.html src/doc/livedtd/xhtml1-transitional/index.html src/doc/livedtd/xslfo/index.html src/doc/livedtd/xslt10/index.html
	for i in $$(find src/doc/livedtd -name '*.html'); do \
		echo "Process: $$i"; \
		tidy -asxhtml $(mTidyOpt) $$i; \
	done

src/doc/livedtd/story/index.html : src/style/story.dtd
	-rm -rf src/doc/livedtd/story/*
	livedtd.pl --outdir src/doc/livedtd/story --title story.dtd $?
	uniq src/doc/livedtd/story/ElemUsage.html >t.tmp
	mv t.tmp src/doc/livedtd/story/ElemUsage.html
	uniq src/doc/livedtd/story/EntityUsage.html >t.tmp
	mv t.tmp src/doc/livedtd/story/EntityUsage.html

src/doc/livedtd/docbook45/index.html : src/doc/dtd/docbook45.dtd
	livedtd.pl --outdir src/doc/livedtd/docbook45 --title docbook45.dtd $?
	uniq src/doc/livedtd/docbook45/ElemUsage.html >t.tmp
	mv t.tmp src/doc/livedtd/docbook45/ElemUsage.html
	uniq src/doc/livedtd/docbook45/EntityUsage.html >t.tmp
	mv t.tmp src/doc/livedtd/docbook45/EntityUsage.html

src/doc/livedtd/html3.2/index.html : src/doc/dtd/html3.2.dtd
	livedtd.pl --outdir src/doc/livedtd/html3.2 --title html3.2.dtd $?
	uniq src/doc/livedtd/html3.2/ElemUsage.html >t.tmp
	mv t.tmp src/doc/livedtd/html3.2/ElemUsage.html
	uniq src/doc/livedtd/html3.2/EntityUsage.html >t.tmp
	mv t.tmp src/doc/livedtd/html3.2/EntityUsage.html

src/doc/livedtd/html40loose/index.html : src/doc/dtd/html40loose.dtd
	livedtd.pl --outdir src/doc/livedtd/html40loose --title html40loose.dtd $?
	uniq src/doc/livedtd/html40loose/ElemUsage.html >t.tmp
	mv t.tmp src/doc/livedtd/html40loose/ElemUsage.html
	uniq src/doc/livedtd/html40loose/EntityUsage.html >t.tmp
	mv t.tmp src/doc/livedtd/html40loose/EntityUsage.html

src/doc/livedtd/xhtml1-transitional/index.html : src/doc/dtd/xhtml1-transitional.dtd
	livedtd.pl --outdir src/doc/livedtd/xhtml1-transitional --title xhtml1-transitional.dtd $?
	uniq src/doc/livedtd/xhtml1-transitional/ElemUsage.html >t.tmp
	mv t.tmp src/doc/livedtd/xhtml1-transitional/ElemUsage.html
	uniq src/doc/livedtd/xhtml1-transitional/EntityUsage.html >t.tmp
	mv t.tmp src/doc/livedtd/xhtml1-transitional/EntityUsage.html

src/doc/livedtd/xslfo/index.html : src/doc/dtd/xslfo.dtd
	livedtd.pl --outdir src/doc/livedtd/xslfo --title xslfo.dtd $?
	uniq src/doc/livedtd/xslfo/ElemUsage.html >t.tmp
	mv t.tmp src/doc/livedtd/xslfo/ElemUsage.html
	uniq src/doc/livedtd/xslfo/EntityUsage.html >t.tmp
	mv t.tmp src/doc/livedtd/xslfo/EntityUsage.html

src/doc/livedtd/xslt10/index.html : src/doc/dtd/xslt10.dtd
	livedtd.pl --outdir src/doc/livedtd/xslt10 --title xslt10.dtd $?
	uniq src/doc/livedtd/xslt10/ElemUsage.html >t.tmp
	mv t.tmp src/doc/livedtd/xslt10/ElemUsage.html
	uniq src/doc/livedtd/xslt10/EntityUsage.html >t.tmp
	mv t.tmp src/doc/livedtd/xslt10/EntityUsage.html

# -------------
build-schema : src/style/schema-gen.xsd src/style/template2.sdt

# dtd2xs fix:
# ln -s /usr/lib/i386-linux-gnu/libXft.so.2 /usr/lib/i386-linux-gnu/libXft.so.1

src/style/schema-gen.xsd : src/style/story.dtd
	/usr/local/bin/dtd2xs $? $@
	tidy -xml $(mTidyOpt) $@
	cp src/style/schema.xsd src/style/schema.xsd.sav
	cp $@ src/style/schema.xsd
	# Manually add restrictions to: schema.xsd

src/style/template2.sdt : src/style/template2.xml src/doc/template/sample-full.xml src/doc/template/sample-minimal.xml
	grep -v 'xml version=' src/doc/template/sample-full.xml src/style/sample-full.xml
	grep -v 'xml version=' src/doc/template/sample-minimal.xml src/style/sample-minimal.xml
	cd src/style; m4 -P template2.xml >template2.sdt
	tidy -xml $(mTidyTemplate) $@
	rm src/style/sample-full.xml src/style/sample-minimal.xml

src/style/template-index.html :
	echo '<html><head><title>Template Index</title></head><body><h1>Template Index<h1>' >$@
	for i in src/style/com*.xsl src/style/out*.xsl; do \
		echo '<h2>' $${i##*/} '</h2><pre>' >>$@; \
		grep '<xsl:template ' $$i | perl -ne 's/\s*<xsl:template\s+//; print' | sort -f >>$@; \
		echo '</pre>' >>$@; \
	done
	echo '</body></html>' >>$@

# -------------

serna4-story :
	# Make symlinks in serna4 dirs to these devel files
	if [ $$(id -un) != root ]; then exit 1; fi
	if [ ! -d $(mSerna4) ]; then exit 1; fi
	ln -sf $$PWD/src/style $(mSerna4)/plugins/story
	ln -sf $$PWD/src/bin/pub-*.sh $(mSerna4)/utils/publishing
	ln -sf $$PWD/src/bin/convert-*.sh $(mSerna4)/utils/publishing

tidy-story :
	-for i in $$(ls src/doc/example/*.xml src/style/*.xml src/style/*.xsl src/style/*.xsd | grep -v template); do \
		echo "Process: $$i"; \
		tidy -xml $(mTidyOpt) $$i; \
	done
	-for i in $$(find doc src/doc -name '*.html'); do \
		echo "Process: $$i"; \
		tidy -asxhtml $(mTidyOpt) $$i; \
	done
	-for i in src/style/template2.sdt src/style/template2.xml src/doc/template/*.xml; do \
		echo "Process: $$i"; \
		tidy -xml $(mTidyTemplate) $$i; \
	done
