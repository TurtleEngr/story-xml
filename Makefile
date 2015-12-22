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

build : ver.env dist/opt/story-xml/doc/story-xml-dtd/index.html
	-find * -name '*~' -exec rm {} \;
	-find dist -type l -exec rm {} \;
	-rm -rf dist/*
	-mkdir -p dist/opt/story-xml4
	cd dist/opt; ln -s story-xml4 story-xml
	-cd dist/opt/story-xml; mkdir -p bin doc/sample config style
	rsync --exclude=CVS kit/linux/* dist/opt/story-xml/config
	rsync --exclude=CVS src/publishing/* dist/opt/story-xml/bin
	chmod a+rx,go-w dist/opt/story-xml/bin/*
	rsync -r --exclude=CVS src/story5/* dist/opt/story-xml/style
	-cd dist/opt/story-xml/style; rm -rf Makefile README *old* tmp* bin
	cp src/story5/story.dtd dist/opt/story-xml/doc
	cp kit/LICENSE kit/README.html dist/opt/story-xml/doc
	cp doc/story-xml-manual.html dist/opt/story-xml/doc
	cp doc/story-xml-reference.html dist/opt/story-xml/doc
	cp doc/gplv3-127x51.png dist/opt/story-xml/doc
	cp example/ebook-20869-h.xml dist/opt/story-xml/doc/sample
	cp example/entity-example.xml dist/opt/story-xml/doc/sample
	echo '<?xml version="1.0"?>' >dist/opt/story-xml/doc/sample/sample-minimal.xml
	cat src/story5/sample-minimal.xml >>dist/opt/story-xml/doc/sample/sample-minimal.xml
	echo '<?xml version="1.0"?>' >dist/opt/story-xml/doc/sample/sample-full.xml
	cat src/story5/sample-minimal.xml >>dist/opt/story-xml/doc/sample/sample-full.xml
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
	. ./ver.env; rsync -P pkg/* $$ProdRelServer:$$ProdRelDir/$$ProdOS
	. ./ver.env; rsync -rP dist/opt/story-xml/doc $$ProdRelServer:$$ProdRelDir

clean :
	find * -type l -exec rm {} \;
	-rm ver.env ver.epm epm.list
	-rm -rf dist pkg

# -------------

dist/opt/story-xml/doc/story-xml-dtd/index.html doc/livedtd/story/index.html : src/story5/story.dtd
	-mkdir -p dist/opt/story-xml/doc/story-xml-dtd
	livedtd.pl --outdir dist/opt/story-xml/doc/story-xml-dtd --title story-xml $?
	uniq dist/opt/story-xml/doc/story-xml-dtd/ElemUsage.html >t.tmp
	mv t.tmp dist/opt/story-xml/doc/story-xml-dtd/ElemUsage.html
	uniq dist/opt/story-xml/doc/story-xml-dtd/EntityUsage.html >t.tmp
	mv t.tmp dist/opt/story-xml/doc/story-xml-dtd/EntityUsage.html
	-mkdir doc/livedtd/story
	cp dist/opt/story-xml/doc/story-xml-dtd/* doc/livedtd/story

ver.env : ver.sh
	export RELEASE=1; mkver.pl -e env

ver.epm : ver.sh
	export RELEASE=1; mkver.pl -e epm
