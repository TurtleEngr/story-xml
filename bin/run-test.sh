#!/bin/bash

# --------------------
# Usage
if [ $# -ne 2 ]; then
	cat <<EOF
Usage:
	run-test.sh Test.xsl App.xsl
EOF
	exit 1
fi

# --------------------
# Get Args
gpTest=$1
gpApp=$2

# --------------------
# Config
cCurDir=$PWD
cBin=${0%/*}
cReport=$cCurDir/xsltunit_report.xsl
cUnitTestLib=$cCurDir/xsltunit.xsl

# --------------------
# Validate

for i in $gpTest $gpApp $cReport $cUnitTestLib; do
	if [ ! -r $i ]; then
		echo "Error: Cannot find file: $i"
		exit 1
	fi
done

# --------------------
# Run test
set -x
xsltproc $gpTest $gpApp >$gpTest.result.xml
set +x

if [ ! -s test_param.xsl.result.xml ]; then
	echo "Error: Cannot run the tests"
	exit 1
fi

for tPassFail in pass fail; do
xsltproc \
	--stringparam gpApp $gpApp \
	--stringparam gpTestSuite $gpTest \
	--stringparam gpPassFail $tPassFail \
	$cReport \
	$gpTest.result.xml \
		>$gpTest.$tPassFail.result.html
$cBin/fmt-xml.sh $gpTest.$tPassFail.result.html
done

if grep Failed $gpTest.fail.result.html; then
	exit 1
fi
exit 0
