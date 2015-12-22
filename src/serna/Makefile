mInsDir = /usr/local/serna/xml

build : schemas/story.xsd

install :
	+if [ $$(id -un) != root ]; then exit 1; fi
	-find * -name '*~' -exec rm {} \;
	-mkdir $(mInsDir)/dtds/story
	-cp -f dtds/* $(mInsDir)/dtds/story
	-mkdir $(mInsDir)/schemas/story
	-cp -f schemas/* $(mInsDir)/schemas/story
	-mkdir $(mInsDir)/stylesheets/story
	-cp -fa stylesheets/* $(mInsDir)/stylesheets/story
	-cp -f templates/* $(mInsDir)/templates
	-find $(mInsDir) -type d -exec chmod a+rx {} \;
	-find $(mInsDir) -type f -exec chmod a+r {} \;

schemas/story.xsd : dtds/story.dtd
	/usr/local/bin/dtd2xs $? $@
