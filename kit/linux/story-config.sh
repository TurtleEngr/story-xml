#!/bin/bash

# --------------------
function fReadConfig {
	gConf="$gConfDef"
	if [[ -f $gConfCur ]]; then
		gConf=$gConfCur
	fi
}

# --------------------
function fWriteConfig {
	Xdialog \
		--backtitle "Save" \
		--title "Story Config" \
		--yesno "Save this configiguration?" \
		0 0
	if [ $? = 0 ]; then
		cat <<EOF >$gConfCur
# story-xml Config
# Only one cfgXSLT type variable should be 'on'.
# Only one cfgFmt type variable should be 'on'.

EOF
		set | perl -ne  'if (/^cfg/) { print "$_" }' | sort -i >>$gConfCur
		chmod a+rx $gConfCur
	fi
}

# --------------------
function fLookForApps {
	Xdialog \
		--title "Story Config" \
	        --infobox "Looking for XML tools (applications) on your system." \
		0 0 5000

	# Serna
	for i in \
		$('ls' -d /usr/local/serna* /opt/serna* 2>/dev/null | sort -r) \
		nonE \
	    ; do
		if [[ -d $i ]]; then
			cfgAuthorSerna="on"
			cfgAuthorSernaPath=${i%/}
			break
		fi
	done

	# EditiX
	for i in \
		/usr/bin/editix \
		/usr/local/bin/editix \
		/opt/editix/bin/editix \
	    ; do
		if [[ -x $i ]]; then
			cfgAuthorEditix="on"
			cfgAuthorEditixPath=$i
			break
		fi
	done

	# Emacs
	for i in \
		/usr/bin/emacs \
		/usr/bin/xemacs \
	    ; do
		if [[ -x $i ]]; then
			cfgAuthorEmacs="on"
			cfgAuthorEmacsPath=$i
			break
		fi
	done

	# Vi
	for i in \
		/usr/bin/vim \
		/usr/bin/vi \
	    ; do
		if [[ -x $i ]]; then
			cfgAuthorVi="on"
			cfgAuthorViPath=$i
			break
		fi
	done

	# ----------------

	# RenderX
	for i in \
		/opt/RenderX/XEP/xep \
		/opt/renderx/xep/xep \
		/opt/xep/xep \
		/usr/local/RenderX/XEP/xep \
		/usr/local/renderx/xep/xep \
		/usr/local/xep/xep \
	    ; do
		if [[ -x $i ]]; then
			cfgFmtRenderx="on"
			cfgFmtRenderxPath=$i
			cfgXSLTRenderx="on"
			cfgXSLTRenderxPath=$i
			break
		fi
	done

	# AntennaHouse
	for i in \
		/opt/Antenna/ah \
	    ; do
		if [[ -x $i ]]; then
			cfgFmtAnt="on"
			cfgFmtAntPaht=$i
			cfgXSLTAnt="on"
			cfgXSLTAntPath=$i
			break
		fi
	done

	# FOP
	for i in \
		/opt/fop/fop \
		/usr/local/fop/fop \
		/opt/fop-0.94/fop \
		/usr/local/fop-0.94/fop \
		/opt/fop-0.20.5/fop \
		/usr/local/fop-0.20.5/fop \
	    ; do
		if [[ -x $i ]]; then
			cfgFmtFOP="on"
			cfgFmtFOPPath=$i
			break
		fi
	done

	# ----------------

	# xsltproc
	for i in \
		/usr/bin/xsltproc \
		/usr/local/bin/xsltproc \
	    ; do
		if [[ -x $i ]]; then
			cfgXSLTProc="on"
			cfgXSLTProcPath=$i
			break
		fi
	done

	# Saxon
	for i in \
		/usr/local/bin/Saxon \
	    ; do
		if [[ -x $i ]]; then
			cfgXSLTSaxon="on"
			cfgXSLTSaxonPath=$i
			break
		fi
	done

	# ----------------

	# OpenProj
	for i in \
		/usr/bin/openproj \
	    ; do
		if [[ -r $i ]]; then
			cfgProjectOpenProj="on"
			cfgProjectOpenProjPath=$i
			break
		fi
	done

	# Planner
	for i in \
		/usr/bin/planner \
	    ; do
		if [[ -r $i ]]; then
			cfgProjectPlanner="on"
			cfgProjectPlannerPath=$i
			break
		fi
	done

	# CSV
	for i in \
		/usr/bin/oocalc \
	    ; do
		if [[ -r $i ]]; then
			cfgProjectCSV="on"
			break
		fi
	done

	# ----------------

	cfgOutputPDF="on"
	cfgOutputHTML="on"
	cfgOutputPS="off"
	cfgOutputDocBook="on"
	gOutput="PDF/HTML/DocBook"

	fSetCat
} # fLookForApps

# --------------------
function fSetApp {
	# Given the $g category variables, set the $cfg variables

	if [[ ${gAuthor#*Serna} != $gAuthor ]]; then
		cfgAuthorSerna='on'
	else
		cfgAuthorSerna='off'
	fi
	if [[ ${gAuthor#*EditiX} != $gAuthor ]]; then
		cfgAuthorEditix='on'
	else
		cfgAuthorEditix='off'
	fi
	if [[ ${gAuthor#*emacs} != $gAuthor ]]; then
		cfgAuthorEmacs='on'
	else
		cfgAuthorEmacs='off'
	fi
	if [[ ${gAuthor#*vi} != $gAuthor ]]; then
		cfgAuthorVi='on'
	else
		cfgAuthorVi='off'
	fi

	if [[ ${gXSLT#*xsltproc} != $gXSLT ]]; then
		cfgXSLTProc='on'
	else
		cfgXSLTProc='off'
	fi
	if [[ ${gXSLT#*Saxon} != $gXSLT ]]; then
		cfgXSLTSaxon='on'
	else
		cfgXSLTSaxon='off'
	fi
	if [[ ${gXSLT#*RenderX} != $gXSLT ]]; then
		cfgXSLTRenderx='on'
		cfgFmtRenderx='on'
	else
		cfgXSLTRenderx='off'
		cfgFmtRenderx='off'
	fi
	if [[ ${gXSLT#*AntennaHouse} != $gXSLT ]]; then
		cfgXSLTAnt='on'
		cfgFmtAnt='on'
	else
		cfgXSLTAnt='off'
		cfgFmtAnt='off'
	fi

	if [[ ${gFmt#*FOP} != $gFmt ]]; then
		cfgFmtFOP='on'
	else
		cfgFmtFOP='off'
	fi
	if [[ ${gFmt#*RenderX} != $gFmt ]]; then
		cfgFmtRenderx='on'
	else
		cfgFmtRenderx='off'
	fi
	if [[ ${gFmt#*AntennaHouse} != $gFmt ]]; then
		cfgFmtAnt='on'
	else
		cfgFmtAnt='off'
	fi

	if [[ ${gProject#*OpenProj} != $gProject ]]; then
		cfgProjectOpenProj='on'
	else
		cfgProjectOpenProj='off'
	fi
	if [[ ${gProject#*Planner} != $gProject ]]; then
		cfgProjectPlanner='on'
	else
		cfgProjectPlanner='off'
	fi
	if [[ ${gProject#*MS-Project} != $gProject ]]; then
		cfgProjectMS='on'
	else
		cfgProjectMS='off'
	fi
	if [[ ${gProject#*CSV} != $gProject ]]; then
		cfgProjectCSV='on'
	else
		cfgProjectCSV='off'
	fi
	if [[ ${gProject#*HTML} != $gProject ]]; then
		cfgProjectHTML='on'
	else
		cfgProjectHTML='off'
	fi

	if [[ ${gOutput#*PDF} != $gOutput ]]; then
		cfgOutputPDF='on'
	else
		cfgOutputPDF='off'
	fi
	if [[ ${gOutput#*HTML} != $gOutput ]]; then
		cfgOutputHTML='on'
	else
		cfgOutputHTML='off'
	fi
	if [[ ${gOutput#*PS} != $gOutput ]]; then
		cfgOutputPS='on'
	else
		cfgOutputPS='off'
	fi
	if [[ ${gOutput#*DocBook} != $gOutput ]]; then
		cfgOutputDocBook='on'
	else
		cfgOutputDocBook='off'
	fi

	gAuthor=$(echo $gAuthor | sed 's;/;, ;g')
	gXSLT=$(echo $gXSLT | sed 's;/;, ;g')
	gFmt=$(echo $gFmt | sed 's;/;, ;g')
	gProject=$(echo $gProject | sed 's;/;, ;g')
	gOutput=$(echo $gOutput | sed 's;/;, ;g')
}

# --------------------
function fSetCat {
	# Given the $cfg variables, set the $g category variables
	gAuthor=""

	# Only one
	gXSLT=""

	# Only one
	gFmt=""

	gProject=""
	gOutput=""

	if [[ "$cfgAuthorSerna" == 'on' ]]; then
		gAuthor="$gAuthor/Serna"
	fi
	if [[ "$cfgAuthorEditix" == 'on' ]]; then
		gAuthor="$gAuthor/EditiX"
	fi
	if [[ "$cfgAuthorEmacs" == 'on' ]]; then
		gAuthor="$gAuthor/emacs"
	fi
	if [[ "$cfgAuthorVi" == 'on' ]]; then
		gAuthor="$gAuthor/vi"
	fi

	if [[ "$cfgXSLTProc" == 'on' ]]; then
		gXSLT="$gXSLT/xsltproc"
		cfgXSLTSaxon='off'
		cfgXSLTRenderx='off'
		cfgXSLTAnt='off'
	fi
	if [[ "$cfgXSLTRenderx" == 'on' ]]; then
		gXSLT="$gXSLT/RenderX"
		cfgXSLTProc='off'
		cfgXSLTSaxon='off'
		cfgXSLTAnt='off'
	fi
	if [[ "$cfgXSLTAnt" == 'on' ]]; then
		gXSLT="$gXSLT/AntennaHouse"
		cfgXSLTProc='off'
		cfgXSLTSaxon='off'
		cfgXSLTRenderx='off'
	fi
	if [[ "$cfgXSLTSaxon" == 'on' ]]; then
		gXSLT="$gXSLT/Saxon"
		cfgXSLTProc='off'
		cfgXSLTRenderx='off'
		cfgXSLTAnt='off'
	fi

	if [[ "$cfgFmtRenderx" == 'on' ]]; then
		gFmt="$gFmt/RenderX"
		cfgFmtFOP='off'
		cfgFmtAnt='off'
	fi
	if [[ "$cfgFmtAnt" == 'on' ]]; then
		gFmt="$gFmt/AntennaHouse"
		cfgFmtFOP='off'
		cfgFmtRenderx='off'
	fi
	if [[ "$cfgFmtFOP" == 'on' ]]; then
		gFmt="$gFmt/FOP"
		cfgFmtRenderx='off'
		cfgFmtAnt='off'
	fi

	if [[ "$cfgProjectOpenProj" == 'on' ]]; then
		gProject="$gProject/OpenProj"
	fi
	if [[ "$cfgProjectPlanner" == 'on' ]]; then
		gProject="$gProject/Planner"
	fi
	if [[ "$cfgProjectMS" == 'on' ]]; then
		gProject="$gProject/MS-Project"
	fi
	if [[ "$cfgProjectCSV" == 'on' ]]; then
		gProject="$gProject/CSV"
	fi
	if [[ "$cfgProjectHTML" == 'on' ]]; then
		gProject="$gProject/HTML"
	fi

	if [[ "$cfgOutputPDF" == 'on' ]]; then
		gOutput="$gOutput/PDF"
	fi
	if [[ "$cfgOutputHTML" == 'on' ]]; then
		gOutput="$gOutput/HTML"
	fi
	if [[ "$cfgOutputPS" == 'on' ]]; then
		gOutput="$gOutput/PS"
	fi
	if [[ "$cfgOutputDocBook" == 'on' ]]; then
		gOutput="$gOutput/DocBook"
	fi

	gAuthor=${gAuthor#/}
	gAuthor=${gAuthor%/}

	gFmt=${gFmt#/}
	gFmt=${gFmt%/}

	gXSLT=${gXSLT#/}
	gXSLT=${gXSLT%/}

	gProject=${gProject#/}
	gProject=${gProject%/}

	gOutput=${gOutput#/}
	gOutput=${gOutput%/}

	gAuthor=$(echo $gAuthor | sed 's;/;, ;g')
	gXSLT=$(echo $gXSLT | sed 's;/;, ;g')
	gFmt=$(echo $gFmt | sed 's;/;, ;g')
	gProject=$(echo $gProject | sed 's;/;, ;g')
	gOutput=$(echo $gOutput | sed 's;/;, ;g')
}

# --------------------
function fPickApp {
	tAllSet=0
	while [[ "$gAppl" != "next" || $tAllSet -eq 0 ]]; do
		fPickCat
		case $gAppl in
			Author)		fAuthor;;
			XSLT)		fXSLT;;
			Formatter)	fFmt;;
			Project)	fProject;;
			Output)		fOutput;;
			last)		. $gConfCur
					fSetCat
			;;
			default)	. $gConfDef
					fLookForApps
			;;
		esac
		fSetApp
		tAllSet=1
		if [[ -z "$gAuthor" ]]; then
			tAllSet=0
		fi
		if [[ -z "$gFmt" ]]; then
			tAllSet=0
		fi
		if [[ -z "$gXSLT" ]]; then
			tAllSet=0
		fi
		if [[ -z "$gProject" ]]; then
			tAllSet=0
		fi
		if [[ -z "$gOutput" ]]; then
			tAllSet=0
		fi
		if [[ "$gAppl" = "next" && $tAllSet -eq 0 ]]; then
			Xdialog \
				--title "Story Config" \
				--infobox "You need to define at last one Author tool,\n one XSLT tool, one Formatter tool,\n one Project tool, and one Output format." \
				0 0 5000
		fi
	done
}

# --------------------
function fPickCat {
	gAuthor=$(echo $gAuthor | sed 's;/;, ;g')
	gXSLT=$(echo $gXSLT | sed 's;/;, ;g')
	gFmt=$(echo $gFmt | sed 's;/;, ;g')
	gProject=$(echo $gProject | sed 's;/;, ;g')
	gOutput=$(echo $gOutput | sed 's;/;, ;g')

	if [[ -x $gConfCur ]]; then
		tLast1='last'
		tLast2='Reset back to your last saved values'
		tLast3='off'
	fi

	tChoice=""
	while [[ -z "$tChoice" ]]; do
		Xdialog \
			--backtitle "Define Tools" \
			--title "Story Config" \
			--help "TBD" \
			--radiolist "Select a tool category.\n Select 'next' when you have defined at least one item in each category." \
			512x390 0  \
			"Author" "Currently set to: $gAuthor" on \
			"XSLT" "Currently set to: $gXSLT" off \
			"Formatter" "Currently set to: $gFmt" off \
			"Project" "Currently set to: $gProject" off \
			"Output" "Currently set to: $gOutput" off \
			$tLast1 "$tLast2" $tLast3 \
			"default" "Reset back to initial defaults" off \
			"next" "Go to the next step" on \
			> /tmp/list.tmp 2>&1
		tRet=$?
		tChoice=$(cat /tmp/list.tmp)
		echo "Debug: Return=$tRet"
		echo "Debug: Choice=$tChoice"
		if [[ $tRet -ne 0 ]]; then
			exit
		fi
		if [[ -z "$tChoice" ]]; then
			fRequire
		fi
	done
	gAppl=$tChoice
}

# --------------------
function fRequire {
	Xdialog \
		--title "Story Config" \
		--infobox "You need to check at least one item." \
		0 0 5000
} # fRequire

# --------------------
function fAuthor {
	tChoice=""
	while [[ -z "$tChoice" ]]; do
		Xdialog \
			--backtitle "Authoring Tools" \
			--title "Story Config" \
			--cancel-label "Back" \
			--help "TBD" \
			--checklist "Check the tools installed on your system." \
			0 0 5  \
			"Serna" "XML Authoring Tool" $cfgAuthorSerna \
			"EditiX" "XML Editor" $cfgAuthorEditix \
			"emacs" "ascii editor" $cfgAuthorEmacs \
			"vi" "ascii editor" $cfgAuthorVi \
			> /tmp/list.tmp 2>&1
		tRet=$?
		tChoice=$(cat /tmp/list.tmp)
		echo "Debug: Return=$tRet"
		echo "Debug: Choice=$tChoice"
		if [[ $tRet -eq 255 ]]; then
			exit
		fi
		if [[ $tRet -ne 0 ]]; then
			return
		fi
		if [[ -z "$tChoice" ]]; then
			fRequire
		fi
	done
	gAuthor=$tChoice
}

# --------------------
function fXSLT {
	tChoice=""
	while [[ -z "$tChoice" ]]; do
		Xdialog \
			--backtitle "XSLT Tool" \
			--title "Story Config" \
			--cancel-label "Back" \
			--help "TBD" \
			--radiolist "Check one of the tools installed on your system." \
			0 0 5  \
			"xsltproc" "xslt processor" $cfgXSLTProc \
			"RenderX" "xslt processing mode" $cfgXSLTRenderx \
			"AntennaHouse" "xslt processing mode" $cfgXSLTAnt \
			"Saxon" "xslt processor" $cfgXSLTSaxon \
			> /tmp/list.tmp 2>&1
		tRet=$?
		tChoice=$(cat /tmp/list.tmp)
		echo "Debug: Return=$tRet"
		echo "Debug: Choice=$tChoice"
		if [[ $tRet -eq 255 ]]; then
			exit
		fi
		if [[ $tRet -ne 0 ]]; then
			return
		fi
		if [[ -z "$tChoice" ]]; then
			fRequire
		fi
	done
	gXSLT=$tChoice
}

# --------------------
function fFmt {
	tChoice=""
	while [[ -z "$tChoice" ]]; do
		Xdialog \
			--backtitle "Formatting Tool" \
			--title "Story Config" \
			--cancel-label "Back" \
			--help "TBD" \
			--radiolist "Check one of the tools installed on your system." \
			0 0 4  \
			"RenderX" "xep formatter" $cfgFmtRenderx \
			"AntennaHouse" "fo formatter" $cfgFmtAnt \
			"FOP" "Apache FOP formatter" $cfgFmtFOP \
			> /tmp/list.tmp 2>&1
		tRet=$?
		tChoice=$(cat /tmp/list.tmp)
		echo "Debug: Return=$tRet"
		echo "Debug: Choice=$tChoice"
		if [[ $tRet -eq 255 ]]; then
			exit
		fi
		if [[ $tRet -ne 0 ]]; then
			return
		fi
		if [[ -z "$tChoice" ]]; then
			fRequire
		fi
	done
	gFmt=$tChoice
}

# --------------------
function fProject {
	tChoice=""
	while [[ -z "$tChoice" ]]; do
		Xdialog \
			--backtitle "Project Tool" \
			--title "Story Config" \
			--cancel-label "Back" \
			--help "TBD" \
			--checklist "Select one or more project tools" \
			0 0 6  \
			"OpenProj" "A muti-platform project tool" $cfgProjectOpenProj \
			"Planner" "A project planning tool for Linux" $cfgProjectPlanner \
			"MS-Project" "Microsoft Project" $cfgProjectMS \
			"CSV" "Comma Separated Values, import to spreadsheet" $cfgProjectCSV \
			"HTML" "HTML table" $cfgProjectHTML \
			> /tmp/list.tmp 2>&1
		tRet=$?
		tChoice=$(cat /tmp/list.tmp)
		echo "Debug: Return=$tRet"
		echo "Debug: Choice=$tChoice"
		if [[ $tRet -eq 255 ]]; then
			exit
		fi
		if [[ $tRet -ne 0 ]]; then
			return
		fi
		if [[ -z "$tChoice" ]]; then
			fRequire
		fi
	done
	gProject=$tChoice
}

# --------------------
function fOutput {
	tChoice=""
	while [[ -z "$tChoice" ]]; do
		Xdialog \
			--backtitle "Output Formats" \
			--title "Story Config" \
			--cancel-label "Back" \
			--help "TBD" \
			--checklist "Select one or more output formats" \
			0 0 5  \
			"DocBook" "" $cfgOutputDocBook \
			"HTML" "" $cfgOutputHTML \
			"PDF" "" $cfgOutputPDF \
			"PS" "" $cfgOutputPS \
			> /tmp/list.tmp 2>&1
		tRet=$?
		tChoice=$(cat /tmp/list.tmp)
		echo "Debug: Return=$tRet"
		echo "Debug: Choice=$tChoice"
		if [[ $tRet -eq 255 ]]; then
			exit
		fi
		if [[ $tRet -ne 0 ]]; then
			return
		fi
		if [[ -z "$tChoice" ]]; then
			fRequire
		fi
	done
	gOutput=$tChoice
}

# --------------------
function fSetPaths {
	cfgXSLTProcPath=$(Xdialog --title "Select xsltproc location" --no-buttons --fselect /usr/bin 28 48 2>&1)
	echo "Debug: $cfgXSLTProcPath"
} # fSetPaths

# ---------------------------------------------------------
# Main
export gAuthor=""
export gXSLT=""
export gFmt=""
export gProject=""
export gOutput=""
export gAppl=""
export gConf=""
export gConfDef=/opt/story-xml/config/default.conf
export gConfCur=/opt/story-xml/config/cur.conf

fReadConfig
. $gConf
fSetCat

if [[ "$gConf" == "$gConfDef" ]]; then
	fLookForApps
fi

fPickApp
fSetPaths
fWriteConfig
