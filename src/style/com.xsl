<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:date="http://exslt.org/dates-and-times"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                exclude-result-prefixes="doc"
                xmlns:exsl="http://exslt.org/common"
                xmlns:str="http://exslt.org/strings"
                extension-element-prefixes="date doc exsl str">
    <!-- ************************************************************
Utility Templates
-->
    <!-- ******************** -->
    <xsl:template match="story-dtd">
        <xsl:if test="number(@version) &lt; $gDTDVer">
            <xsl:message>
                <xsl:value-of select="concat('You may upgrade your document to story-dtd version ', $gDTDVer)" />
            </xsl:message>
        </xsl:if>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template name="fShowContent">
        <!--
    Flags related to non-draft elements.
    Return 0 if @revision-flag=deleted
    Return 0 if preface, epilog, chapter, unit, thread, or
    t, should not be shown.
    Else return 1
    -->
        <xsl:choose>
            <xsl:when test="not($gDraft) and @revision-flag='deleted'">
                <xsl:value-of select="'0'" />
            </xsl:when>
 
            <xsl:when test="$gDraft and @revision-flag='deleted' and $gDraftRef/@deleted = '0'">

                <xsl:value-of select="'0'" />
            </xsl:when>
 
            <xsl:when test="name() = 't'">
                <xsl:choose>
                    <xsl:when test="contains(concat(' ', ../@who-refs, ' '), concat(' ', @who-ref, ' '))">

                        <xsl:value-of select="'1'" />
                    </xsl:when>
 
                    <xsl:otherwise>
                        <xsl:value-of select="'0'" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
 
            <xsl:when test="name()= 'thread'">
                <xsl:choose>
                    <xsl:when test="contains($gThreads, concat(' ', @ref, ' '))">

                        <xsl:value-of select="'1'" />
                    </xsl:when>
 
                    <xsl:otherwise>
                        <xsl:value-of select="'0'" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
 
            <xsl:when test="name() = 'unit'">
                <xsl:choose>
                    <xsl:when test="@revision = ''">
                        <xsl:value-of select="'1'" />
                    </xsl:when>
 
                    <xsl:when test="contains($gUnitStatus, @revision)">
                        <xsl:value-of select="'1'" />
                    </xsl:when>
 
                    <xsl:when test="contains(concat(' ', $gContentRef/@unit-refs, ' '), concat(' ', @id, ' '))">

                        <xsl:value-of select="'1'" />
                    </xsl:when>
 
                    <xsl:otherwise>
                        <xsl:value-of select="'0'" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
 
            <xsl:when test="name() = 'prolog' or name() = 'postlog'">
                <xsl:value-of select="$gContentRef/@prolog" />
            </xsl:when>
 
            <xsl:when test="name() = 'chapter'">
                <xsl:choose>
                    <xsl:when test="not(@revision)">
                        <xsl:value-of select="'1'" />
                    </xsl:when>
 
                    <xsl:when test="contains($gChStatus, @revision)">
                        <xsl:value-of select="'1'" />
                    </xsl:when>
 
                    <xsl:when test="contains(concat(' ', $gContentRef/@ch-refs, ' '), concat(' ', @id, ' '))">

                        <xsl:value-of select="'1'" />
                    </xsl:when>
 
                    <xsl:otherwise>
                        <xsl:value-of select="'0'" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
 
            <xsl:when test="name() = 'preface' or name() = 'epilog'">
                <xsl:value-of select="$gContentRef/@preface" />
            </xsl:when>
 
            <xsl:when test="name() = 'ch-preface'">
                <xsl:value-of select="$gContentRef/@ch-preface" />
            </xsl:when>
 
            <xsl:otherwise>
                <xsl:value-of select="'1'" />
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template name="fToXMLTime">
        <xsl:param name="pNode" />
        <xsl:param name="pDefNode1" />
        <xsl:param name="pDefNode2" />
        <xsl:variable name="tY">
            <xsl:choose>
                <xsl:when test="$pNode/@year != ''">
                    <xsl:value-of select="$pNode/@year" />
                </xsl:when>
 
                <xsl:when test="$pDefNode1/@year != ''">
                    <xsl:value-of select="$pDefNode1/@year" />
                </xsl:when>
 
                <xsl:when test="$pDefNode2/@year != ''">
                    <xsl:value-of select="$pDefNode2/@year" />
                </xsl:when>
 
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="tM">
            <xsl:choose>
                <xsl:when test="$pNode/@month != ''">
                    <xsl:value-of select="format-number($pNode/@month,'00')" />
                </xsl:when>
 
                <xsl:when test="$pDefNode1/@month != ''">
                    <xsl:value-of select="format-number($pDefNode1/@month,'00')" />
                </xsl:when>
 
                <xsl:when test="$pDefNode2/@month != ''">
                    <xsl:value-of select="format-number($pDefNode2/@month,'00')" />
                </xsl:when>
 
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="tD">
            <xsl:choose>
                <xsl:when test="$pNode/@day != ''">
                    <xsl:value-of select="format-number($pNode/@day,'00')" />
                </xsl:when>
 
                <xsl:when test="$pDefNode1/@day != ''">
                    <xsl:value-of select="format-number($pDefNode1/@day,'00')" />
                </xsl:when>
 
                <xsl:when test="$pDefNode2/@day != ''">
                    <xsl:value-of select="format-number($pDefNode2/@day,'00')" />
                </xsl:when>
 
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="tH">
            <xsl:choose>
                <xsl:when test="$pNode/@hour != ''">
                    <xsl:value-of select="format-number($pNode/@hour,'00')" />
                </xsl:when>
 
                <xsl:when test="$pDefNode1/@hour != ''">
                    <xsl:value-of select="format-number($pDefNode1/@hour,'00')" />
                </xsl:when>
 
                <xsl:when test="$pDefNode2/@hour != ''">
                    <xsl:value-of select="format-number($pDefNode2/@hour,'00')" />
                </xsl:when>
 
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="tm">
            <xsl:choose>
                <xsl:when test="$pNode/@min != ''">
                    <xsl:value-of select="format-number($pNode/@min,'00')" />
                </xsl:when>
 
                <xsl:when test="$pDefNode1/@min != ''">
                    <xsl:value-of select="format-number($pDefNode1/@min,'00')" />
                </xsl:when>
 
                <xsl:when test="$pDefNode2/@min != ''">
                    <xsl:value-of select="format-number($pDefNode2/@min,'00')" />
                </xsl:when>
 
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="tG">
            <xsl:choose>
                <xsl:when test="$pNode/@gmt != ''">
                    <xsl:value-of select="$pNode/@gmt" />
                </xsl:when>
 
                <xsl:when test="$pDefNode1/@gmt != ''">
                    <xsl:value-of select="$pDefNode1/@gmt" />
                </xsl:when>
 
                <xsl:when test="$pDefNode2/@gmt != ''">
                    <xsl:value-of select="$pDefNode2/@gmt" />
                </xsl:when>
 
            </xsl:choose>
        </xsl:variable>
        <xsl:value-of select="concat($tY, '-', $tM, '-', $tD, 'T', $tH, ':', $tm, ':00', $tG, ':00')" />
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template name="fUnits">
        <xsl:param name="pFrom" />
        <xsl:param name="pTo" />
        <!--
<xsl:message>
  <xsl:value-of select="concat('Debug units: pFrom=', $pFrom, $gNL)"/>
  <xsl:value-of select="concat('Debug units: pTo=', $pTo, $gNL)"/>
</xsl:message>
-->
        <xsl:choose>
            <xsl:when test="$pFrom = 0">
                <xsl:value-of select="0" />
            </xsl:when>
 
            <xsl:when test="$pFrom = '0'">
                <xsl:value-of select="'0'" />
            </xsl:when>
 
            <xsl:otherwise>
                <!-- Get the tFromUnits: last two char. of pFrom -->
                <xsl:variable name="tFromUnits"
                              select="substring($pFrom, string-length($pFrom) - 1, 2)" />
                <xsl:variable name="tFrom"
                              select="number(substring-before($pFrom, $tFromUnits))" />
                <!--
<xsl:message>
  <xsl:value-of select="concat('Debug units: tFromUnits=', $tFromUnits, $gNL)"/>
  <xsl:value-of select="concat('Debug units: tFrom=', $tFrom, $gNL)"/>
</xsl:message>
-->
                <xsl:choose>
                    <xsl:when test="$tFromUnits = $pTo">
                        <xsl:value-of select="$tFrom" />
                    </xsl:when>
 
                    <xsl:otherwise>
                        <xsl:choose>
                            <xsl:when test="$tFromUnits = 'in'">
                                <xsl:choose>
                                    <xsl:when test="$pTo = 'mm'">
                                        <xsl:value-of select="$tFrom * 25.4" />
                                    </xsl:when>
 
                                    <xsl:when test="$pTo = 'cm'">
                                        <xsl:value-of select="$tFrom * 2.54" />
                                    </xsl:when>
 
                                    <xsl:when test="$pTo = 'pc'">
                                        <xsl:value-of select="$tFrom * 6" />
                                    </xsl:when>
 
                                    <xsl:when test="$pTo = 'pt'">
                                        <xsl:value-of select="ceiling($tFrom * 72)" />
                                    </xsl:when>
 
                                </xsl:choose>
                            </xsl:when>
 
                            <xsl:when test="$tFromUnits = 'cm'">
                                <xsl:choose>
                                    <xsl:when test="$pTo = 'mm'">
                                        <xsl:value-of select="$tFrom * 10" />
                                    </xsl:when>
 
                                    <xsl:when test="$pTo = 'in'">
                                        <xsl:value-of select="$tFrom div 2.54" />
                                    </xsl:when>
 
                                    <xsl:when test="$pTo = 'pc'">
                                        <xsl:value-of select="$tFrom div 2.54 * 6" />
                                    </xsl:when>
 
                                    <xsl:when test="$pTo = 'pt'">
                                        <xsl:value-of select="ceiling($tFrom div 2.54 * 72)" />
                                    </xsl:when>
 
                                </xsl:choose>
                            </xsl:when>
 
                            <xsl:when test="$tFromUnits = 'pc'">
                                <xsl:choose>
                                    <xsl:when test="$pTo = 'mm'">
                                        <xsl:value-of select="$tFrom div 12 * 25.4" />
                                    </xsl:when>
 
                                    <xsl:when test="$pTo = 'cm'">
                                        <xsl:value-of select="$tFrom div 12 * 2.54" />
                                    </xsl:when>
 
                                    <xsl:when test="$pTo = 'in'">
                                        <xsl:value-of select="$tFrom div 6" />
                                    </xsl:when>
 
                                    <xsl:when test="$pTo = 'pt'">
                                        <xsl:value-of select="ceiling($tFrom * 6)" />
                                    </xsl:when>
 
                                </xsl:choose>
                            </xsl:when>
 
                            <xsl:when test="$tFromUnits = 'pt'">
                                <xsl:choose>
                                    <xsl:when test="$pTo = 'mm'">
                                        <xsl:value-of select="$tFrom div 72 * 25.4" />
                                    </xsl:when>
 
                                    <xsl:when test="$pTo = 'cm'">
                                        <xsl:value-of select="$tFrom div 72 * 2.54" />
                                    </xsl:when>
 
                                    <xsl:when test="$pTo = 'pc'">
                                        <xsl:value-of select="$tFrom div 6" />
                                    </xsl:when>
 
                                    <xsl:when test="$pTo = 'in'">
                                        <xsl:value-of select="$tFrom div 72" />
                                    </xsl:when>
 
                                </xsl:choose>
                            </xsl:when>
 
                        </xsl:choose>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template name="fDebugBook">
        <xsl:value-of select="concat('gStyleName=', $gStyleName, $gNL)" />
        <xsl:value-of select="concat('gDraft=', $gDraft, $gNL)" />
        <xsl:value-of select="concat('gDebug=', $gDebug, $gNL)" />
        <xsl:value-of select="concat('gThreads=', $gThreads, $gNL)" />
        <xsl:value-of select="concat('gChStatus=', $gChStatus, $gNL)" />
        <xsl:value-of select="concat('gUnitStatus=', $gUnitStatus, $gNL)" />
        <xsl:value-of select="concat('gContentRef/@ch-draft=', $gContentRef/@ch-draft, $gNL)" />
        <xsl:value-of select="concat('gContentRef/@ch-final=', $gContentRef/@ch-final, $gNL)" />
        <xsl:value-of select="concat('gContentRef/@ch-draft=', $gContentRef/@ch-draft, $gNL)" />
        <xsl:value-of select="concat('gContentRef/@ch-draft=', $gContentRef/@ch-draft, $gNL)" />
        <xsl:value-of select="concat('gContentRef/@ch-in-progress=', $gContentRef/@ch-in-progress, $gNL)" />
        <xsl:value-of select="concat('gContentRef/@ch-preface=', $gContentRef/@ch-preface, $gNL)" />
        <xsl:value-of select="concat('gContentRef/@ch-refs=', $gContentRef/@ch-refs, $gNL)" />
        <xsl:value-of select="concat('gContentRef/@link-fmt=', $gContentRef/@link-fmt, $gNL)" />
        <xsl:value-of select="concat('gContentRef/@preface=', $gContentRef/@preface, $gNL)" />
        <xsl:value-of select="concat('gContentRef/@prolog=', $gContentRef/@prolog, $gNL)" />
        <xsl:value-of select="concat('gContentRef/@thread-refs=', $gContentRef/@thread-refs, $gNL)" />
        <xsl:value-of select="concat('gContentRef/@unit-draft=', $gContentRef/@unit-draft, $gNL)" />
        <xsl:value-of select="concat('gContentRef/@unit-final=', $gContentRef/@unit-final, $gNL)" />
        <xsl:value-of select="concat('gContentRef/@unit-in-progress=', $gContentRef/@unit-in-progress, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@def-base=', $gDraftRef/@def-base, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@def-img=', $gDraftRef/@def-img, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@def-link=', $gDraftRef/@def-link, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@def-thread=', $gDraftRef/@def-thread, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@def-where=', $gDraftRef/@def-where, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@def-who=', $gDraftRef/@def-who, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@thread-all-vp=', $gDraftRef/@thread-all-vp, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@thread-content=', $gDraftRef/@thread-content, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@thread-id-vp=', $gDraftRef/@thread-id-vp, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@thread-ref=', $gDraftRef/@thread-ref, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@timeline=', $gDraftRef/@timeline, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@unit-outline=', $gDraftRef/@unit-outline, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@unit-title=', $gDraftRef/@unit-title, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@unit-when=', $gDraftRef/@unit-when, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@unit-where=', $gDraftRef/@unit-where, $gNL)" />
        <xsl:value-of select="concat('gDraftRef/@unit-who=', $gDraftRef/@unit-who, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@alink=', $gPrintRef/@alink, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@bgcolor=', $gPrintRef/@bgcolor, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@bleed-bottom=', $gPrintRef/@bleed-bottom, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@bleed-left=', $gPrintRef/@bleed-left, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@bleed-right=', $gPrintRef/@bleed-right, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@bleed-top=', $gPrintRef/@bleed-top, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@body-family=', $gPrintRef/@body-family, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@body-size=', $gPrintRef/@body-size, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@ch-title-family=', $gPrintRef/@ch-title-family, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@ch-title-size=', $gPrintRef/@ch-title-size, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@copyright-type=', $gPrintRef/@copyright-type, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@draft=', $gPrintRef/@draft, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@duplex=', $gPrintRef/@duplex, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@gutter=', $gPrintRef/@gutter, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@head-align=', $gPrintRef/@head-align, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@head-family=', $gPrintRef/@head-family, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@head-location=', $gPrintRef/@head-location, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@head-size=', $gPrintRef/@head-size, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@head-type=', $gPrintRef/@head-type, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@img-ref=', $gPrintRef/@img-ref, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@line-height=', $gPrintRef/@line-height, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@link=', $gPrintRef/@link, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@margin=', $gPrintRef/@margin, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@multi-file=', $gPrintRef/@multi-file, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@next-prev=', $gPrintRef/@next-prev, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@output-type=', $gPrintRef/@output-type, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@page=', $gPrintRef/@page, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@text=', $gPrintRef/@text, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@title-family=', $gPrintRef/@title-family, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@title-size=', $gPrintRef/@title-size, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@toc=', $gPrintRef/@toc, $gNL)" />
        <xsl:value-of select="concat('gPrintRef/@vlink=', $gPrintRef/@vlink, $gNL)" />
    </xsl:template>
 
</xsl:stylesheet>
