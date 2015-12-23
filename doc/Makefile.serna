# $Header: /repo/local.cvs/app/story-xml/src/Makefile,v 1.14 2008/06/22 03:25:06 bruce Exp $

mSerna1 = /usr/local/serna
mSerna3 = /usr/local/serna-3.4
mStory = story4
mTidyOpt = -q -indent -wrap 75 --tidy-mark no --indent-attributes yes --new-pre-tags pre-fmt 

build :
	cd $(mStory); make build

package :
	# Make the dist/ areas

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

tidy :
	find story2/* story3/* story4/* -name '*~' -exec rm -f {} \;
	for i in $$(ls *.x[ms]l story[1234]/*.x[ms]l | grep -v template); do \
		echo "Process: $$i"; \
		tidy -xml -modify $(mTidyOpt) $$i; \
	done

commit : tidy
	cvs commit -m Updated
