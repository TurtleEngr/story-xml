# Makefile

build : schema.xsd

schema.xsd : story.dtd
	/usr/local/bin/dtd2xs $? $@
	tidy -q -xml -indent -wrap 80 --tidy-mark no --indent-attributes yes -modify $@
	unexpand --first-only <$@ >t.tmp
	mv -f t.tmp $@
	# Manually add restricitons: story-schema.xsd
