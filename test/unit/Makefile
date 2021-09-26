# Makefile - uinit tests

mBin = ../../bin
mStyle = ../../src/style
mInput = ../../src/doc/template

mTests = \
	test-com.xsl.pass.result.html \
	test-param.xsl.pass.result.html

# --------------------
test : validate $(mTests)


# --------------------
validate :
	xmllint --noout --nonet *.xsl
	xmllint --dtdvalid $(mStyle)/story.dtd --noout book-min.xml
	xmllint --dtdvalid $(mStyle)/story.dtd --noout sample-minimal.xml
	xmllint --dtdvalid $(mStyle)/story.dtd --noout sample-full.xml

# --------------------
reformat : validate
	for i in *.xml *.xsl *.html; do \
		$(mBin)/fmt-xml.sh $$i; \
	done

# --------------------
clean :
	-rm *~ *.result.* &>/dev/null

# --------------------
# Tests

test-param test-param.xsl.pass.result.html : test-param.xsl $(mStyle)/com-param.xsl
	$(mBin)/run-test.sh test-param.xsl $(mStyle)/com-param.xsl

test-com test-com.xsl.pass.result.html : test-com.xsl $(mStyle)/com-param.xsl
	$(mBin)/run-test.sh test-com.xsl sample-full.xml
