# Makefile - uinit tests

mBin = ../../bin
mSrc = ../../src/style

mApp = $(mSrc)/com-param.xsl
mTestSuite = test_param.xsl
mFmtReport = xsltunit_report.xsl

# --------------------
test : validate
	$(mBin)/run-test.sh $(mTestSuite) $(mApp) pass

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
