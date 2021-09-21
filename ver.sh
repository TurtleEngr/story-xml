#!/bin/bash

# Input file for: mkver.pl.  All variables must have
# "export " at the beginning.  No spaces around the
# "=".  And all values enclosed with double quotes.
# Variables may include other variables in their
# values.

export ProdName="story-xml"
# One word [-_.a-zA-Z0-9]

export ProdAlias="story-xml"
# One word [-_.a-zA-Z0-9]

export ProdVer="0.5.1"
# [0-9]*.[0-9]*{.[0-9]*}{.[0-9]*}

export ProdBuild="1"
# [0-9]*

export ProdSummary="Story XML - Authoring tool that supports Scene/Sequel Structured story development."
# All on one line (< 80 char)

export ProdDesc="Authoring tool that supports Scene/Sequel Structured story development. GNU License: http://www.gnu.org/licenses/gpl.html"
# All on one line

export ProdVendor="$LOGNAME"

export ProdPackager="$LOGNAME"
export ProdSupport="http://moria.whyayh.com/rel/released/software/own/story-xml/"
export ProdCopyright="2009 - 2015 Bruce Rafnel"

export ProdDate="2015-12-23"
# 20[012][0-9]-[01][0-9]-[0123][0-9]

export ProdLicense="src/doc/LICENSE"
# Required: http://www.gnu.org/licenses/gpl.html

export ProdReadMe="src/doc/README.html"
# Required

# Third Party (if any)
export ProdTPVendor=""
export ProdTPVer=""
export ProdTPCopyright=""

# Set this to latest version of mkver.pl
export MkVer="2.0"

export ProdRelServer="moria.whyayh.com"
export ProdRelRoot="/rel"
export ProdRelCategory="software/own/$ProdName"
# Generated: ProdRelDir=ProdRelRoot . /released|development/ . ProdRelCategory
# (if RELEASE=1, then use "released", else use "development")
# Generated: ProdDevDir=ProdRelRoot/development/ProdRelCategory

# Generated: ProdTag=ProdVer-ProdBuild
# (All "." converted to "-")

# Generated: ProdOS (DistVer)
#	Dist
#		Ver
# linux
# 	deb
# 	rhes
# 	cent
# 	fc
# cygwin
#	cygwin
# mswin32
#	win
#		xp
# solaris
#	sun
# darwin
#	mac

# Generated: ProdArch
# i386
# x86_64

# Output file control variables.
# The *File vars can include dir. names
# The *Header and *Footer defaults are more complete
# than what is shown here.

export envFile="ver.env"
export envHeader=""
export envFooter="export RELEASE=1\nexport CurLogName=$LOGNAME\n"

export epmFile="ver.epm"
export epmHeader=""
export epmFooter="%include ver.require\n%include epm.list"

export hFile="ver.h"
export hHeader=""
export hFooter=""

export javaFile="ver.java"
export javaPackage="DIR.DIR.DIR"
export javaInterface="ver"
export javaHeader=""
export javaFooter=""

export csFile="ver.cs"
export csNamespace="Supernode"
export csClass="ver"
export csHeader=""
export csFooter=""

export makFile="ver.mak"
export makHeader=""
export makFooter=""

export plFile="ver.pl"
export plHeader=""
export plFooter=""

export xmlFile="ver.xml"
export xmlHeader=""
export xmlFooter=""
