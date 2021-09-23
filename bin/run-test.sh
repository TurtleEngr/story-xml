#!/bin/bash

# --------------------
# Usage
if [ $# -ne 3 ]; then
	cat <<EOF
Usage:
	run-test.sh Test.xsl App.xsl {pass|fail}
EOF
	exit 1
fi

# --------------------
# Get Args
gpTest=$1
gpApp=$2
gpPassFail=$3

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

xsltproc \
	--stringparam gpApp $gpApp \
	--stringparam gpTestSuite $gpTest \
	--stringparam gpPassFail $gpPassFail \
	$cReport \
	$gpTest.result.xml \
		>$gpTest.$gpPassFail.result.html
$cBin/fmt-xml.sh $gpTest.$gpPassFail.result.html

exit 0
