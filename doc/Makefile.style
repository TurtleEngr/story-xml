# Makefile

build : schema-gen.xsd template2.sdt

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
