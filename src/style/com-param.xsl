<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:date="http://exslt.org/dates-and-times"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                exclude-result-prefixes="doc"
                xmlns:exsl="http://exslt.org/common"
                xmlns:str="http://exslt.org/strings"
                extension-element-prefixes="date doc exsl str">
  <!-- ************************************************** -->
  <!-- External parameters -->
  <xsl:param name="style"
             select="''" />
  <xsl:strip-space elements="*" />
  <xsl:preserve-space elements="pre pre-fmt" />
  <!-- ************************************************** -->
  <xsl:key name="style-index"
           match="def-style"
           use="@id" />
  <xsl:key name="content-index"
           match="def-content"
           use="@id" />
  <xsl:key name="draft-index"
           match="def-draft"
           use="@id" />
  <xsl:key name="print-index"
           match="def-print"
           use="@id" />
  <xsl:key name="chapter-index"
           match="chapter"
           use="@id" />
  <xsl:key name="unit-index"
           match="unit"
           use="@id" />
  <xsl:key name="def-base-index"
           match="def-base"
           use="@id" />
  <xsl:key name="def-img-index"
           match="def-img"
           use="@id" />
  <xsl:key name="def-link-index"
           match="def-link"
           use="@id" />
  <xsl:key name="def-thread-index"
           match="def-thread"
           use="@id" />
  <xsl:key name="def-where-index"
           match="def-where"
           use="@id" />
  <xsl:key name="def-who-index"
           match="def-who"
           use="@id" />
  <!-- ************************************************** -->
  <!-- Global Parameters -->
  <xsl:param name="gDTDVer"
             select="'4'" />
  <xsl:param name="gNL">
    <xsl:value-of disable-output-escaping="yes"
                  select="' '" />
  </xsl:param>
  <!--
  The content style can be selected by defining the 'style'
  external parameter.  If it is not defined, then the
  story's /content/site/style/@style-ref will be used.
  -->
  <xsl:param name="gStyleName">
    <xsl:choose>
      <xsl:when test="$style = ''">
        <xsl:value-of select="/content/book/style-info/@style-ref" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$style" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <!-- ******************** -->
  <xsl:param name="gStyleRef"
             select="key('style-index', $gStyleName)" />
  <!-- ******************** -->
  <xsl:param name="gContentRef"
             select="key('content-index', $gStyleRef/@content-ref)" />
  <!--
  Use: test="$gContentRef/@preface = '1'"
  -->
  <!-- ******************** -->
  <xsl:param name="gPrintRef"
             select="key('print-index', $gStyleRef/@print-ref)" />
  <!-- ******************** -->
  <xsl:param name="gDraftRef"
             select="key('draft-index', $gStyleRef/@draft-ref)" />
  <!-- ******************** -->
  <xsl:param name="gDraft"
             select="boolean(number($gStyleRef/@draft))" />
  <!--
  Use: test="$gDraft"
  -->
  <!-- ******************** -->
  <xsl:param name="gDebug"
             select="boolean(number($gStyleRef/@debug))" />
  <!-- ******************** -->
  <xsl:param name="gThreads"
             select="concat(' ', $gContentRef/@thread-refs, ' ')" />
  <!--
  Use: test="contains($gThreads, concat(' ', ../@ref, ' '))"
  -->
  <!-- ******************** -->
  <xsl:param name="gChStatus">
    <xsl:if test="$gContentRef/@ch-final = '1'">
      <xsl:value-of select="' final'" />
    </xsl:if>
    <xsl:if test="$gContentRef/@ch-draft = '1'">
      <xsl:value-of select="' draft'" />
    </xsl:if>
    <xsl:if test="$gContentRef/@ch-in-progress = '1'">
      <xsl:value-of select="' in-progress'" />
    </xsl:if>
    <xsl:value-of select="' '" />
  </xsl:param>
  <!--
  Use: test="contains($gChStatus, @revision)"
  -->
  <!-- ******************** -->
  <xsl:param name="gUnitStatus">
    <xsl:if test="$gContentRef/@unit-final = '1'">
      <xsl:value-of select="' final '" />
    </xsl:if>
    <xsl:if test="$gContentRef/@unit-draft = '1'">
      <xsl:value-of select="' draft '" />
    </xsl:if>
    <xsl:if test="$gContentRef/@unit-in-progress = '1'">
      <xsl:value-of select="' in-progress '" />
    </xsl:if>
    <xsl:value-of select="' '" />
  </xsl:param>
  <!-- ******************** -->
  <xsl:param name="gContentLink">
    <xsl:value-of select="$gContentRef/@link-fmt" />
  </xsl:param>
</xsl:stylesheet>
