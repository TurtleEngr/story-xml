# Makefile - uinit tests

mBin = ../../bin
mSrc = ../../src/style

mTests = \
	test-com.xsl.pass.result.html \
	test-param.xsl.pass.result.html

# --------------------
test : validate $(mTests)


# --------------------
validate :
	xmllint --noout --nonet *.xsl
	xmllint --dtdvalid $(mSrc)/story.dtd --noout book-min.xml
	xmllint --dtdvalid $(mSrc)/story.dtd --noout sample-minimal.xml
	xmllint --dtdvalid $(mSrc)/story.dtd --noout sample-full.xml

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

test-param test-param.xsl.pass.result.html : test-param.xsl $(mSrc)/com-param.xsl
	$(mBin)/run-test.sh test-param.xsl $(mSrc)/com-param.xsl

test-com test-com.xsl.pass.result.html : test-com.xsl $(mSrc)/com-param.xsl
	$(mBin)/run-test.sh test-com.xsl sample-full.xml
