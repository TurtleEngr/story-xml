#!/bin/bash

# --------------------
# Usage
if [ $# -ne 1 ]; then
	cat <<EOF
Usage:
	update-release-info.sh FILE.xml >t.tmp
	mv t.tmp FILE.xml

CVS style keywords are used for Date and Revision formats. The updated
file is output to stdout.

Patterns matched and changed:
In:
    <release-info>
      <para>$Date: 2009/03/31 16:01:28 $</para>
      <para>$Revision: 1.2 $</para>
    </release-info>
Out:
    <release-info>
      <para>$Date: 2020/04/27 18:04:21 $</para>
      <para>$Revision: 1.3 $</para>
    </release-info>

In:
    <release-info>
      <para>$Date$</para>
      <para>$Revision$</para>
    </release-info>
Out:
    <release-info>
      <para>$Date: 2020/04/27 18:04:21 $</para>
      <para>$Revision: 1.1 $</para>
    </release-info>

EOF
	exit 1
fi

# --------------------
# Get Args
gpFile=$1

# --------------------
# Config

# Current Date/Time
tDate=$(date -u +'%F %T' | tr '-' '/')

# --------------------
# Validate

if [ ! -r $gpFile ]; then
	echo "Error: Could not read file: $gpFile" 1>&2
	exit 1
fi
if ! grep -q "<release-info" $gpFile &>/dev/null; then
	echo "Error: File does not contain 'release-info' tag." 1>&2
	exit 1
fi

# --------------------
# Process

awk -v pDate="$tDate" '
	/\$Date\$/ {
		sub(/\$Date\$/, "$Date: " pDate " $");
	}
	/\$Revision\$/ {
		sub(/\$Revision\$/, "$Revision: 1.1 $");
	}
	/\$Date: / {
		sub(/\$Date: [^$]*\$/, "$Date: " pDate " $");
	}
	/\$Revision: / {
    		tOldVer = $0
		sub(/.*\$Revision: /, "", tOldVer);
		sub(/ \$.*/, "", tOldVer);
		tVerMajor = tOldVer;
		tVerMinor = tOldVer;
		sub(/\.[0-9]*/,"",tVerMajor);
		sub(/[0-9]*\./,"",tVerMinor);
		tNewVer = tVerMajor "." ++tVerMinor
		sub(tOldVer, tNewVer);
	}
	{ print $0 }
' <$gpFile
