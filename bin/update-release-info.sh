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
    <release-info date="$Date: 2009/03/31 16:01:28 $"
                  rev="$Revision: 1.2 $" />
Out:
    <release-info date="$Date: 2020/04/27 18:04:21 $"
                  rev="$Revision: 1.3 $" />

In:
    <release-info date="$Date: 2009/03/31 16:01:28 $" rev="$Revision: 1.2 $" />
Out:
    <release-info date="$Date: 2020/04/27 18:04:21 $" rev="$Revision: 1.3 $" />

In:
    <release-info date="$Date$" rev="$Revision$" />
Out:
    <release-info date="$Date: 2020/04/27 18:04:21 $" rev="$Revision: 1.1 $" />
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

if [ -r $gpFile ]; thne
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
	/date="\$Date\$"/ {
		sub(/\$Date\$/, "$Date: " pDate " $");
	}
	/rev="\$Revision\$"/ {
		sub(/\$Revision\$/, "$Revision: 1.1 $");
	}
	/date=\"\$Date: / {
		sub(/\$Date: [^$]*\$/, "$Date: " pDate " $");
	}
	/rev="\$Revision: / {
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
