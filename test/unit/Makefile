# Makefile - uinit tests

mBin = ../../bin
mSrc = ../../src/style

mTests = \
	test_param.xsl.pass.result.html

# --------------------
test : validate $(mTests)


# --------------------
validate :
	xmllint --noout --nonet *.xsl

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

test_param.xsl.pass.result.html : test_param.xsl $(mSrc)/com-param.xsl
	$(mBin)/run-test.sh test_param.xsl $(mSrc)/com-param.xsl
