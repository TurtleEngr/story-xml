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

build : ver.env dist/opt/story-xml/doc/story-xml-dtd/index.html
	-find * -name '*~' -exec rm {} \;
	-find dist -type l -exec rm {} \;
	-rm -rf dist/*
	-mkdir -p dist/opt/story-xml4
	cd dist/opt; ln -s story-xml4 story-xml
	-mkdir -p dist/opt/story-xml/config dist/opt/story-xml/doc/sample
	rsync -r $(mRsyncOpt) src/* dist/opt/story-xml/
	rsync -r $(mRsyncOpt) example/* dist/opt/story-xml/doc/sample/
	rsync -r $(mRsyncOpt) kit/linux/* dist/opt/story-xml/config
	cp src/story/story.dtd dist/opt/story-xml/doc
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

dist/opt/story-xml/doc/story-xml-dtd/index.html doc/livedtd/story/index.html : src/story/story.dtd
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
