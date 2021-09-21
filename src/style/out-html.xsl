<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:date="http://exslt.org/dates-and-times"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                exclude-result-prefixes="doc"
                xmlns:exsl="http://exslt.org/common"
                xmlns:str="http://exslt.org/strings"
                extension-element-prefixes="date doc exsl str">
  <!--
        extension-element-prefixes="date doc exsl str"
-->
  <xsl:output method="html"
              indent="yes" />
  <xsl:param name="gDraft"
             select="boolean(number('0'))" />
  <xsl:include href="com-param.xsl" />
  <xsl:include href="com-html.xsl" />
  <xsl:include href="com.xsl" />
  <!-- ************************************************** -->
  <xsl:template match="/content">
    <xsl:apply-templates select="book" />
    <xsl:call-template name="fOutputList" />
  </xsl:template>
  <!-- ************************************************** -->
  <xsl:template name="fOutputList">
    <exsl:document method="text"
                   href="output-list.txt">
      <xsl:apply-templates select="book"
                           mode="output-list" />
    </exsl:document>
  </xsl:template>
  <xsl:template match="book"
                mode="output-list">
    <xsl:value-of select="concat(@id,'.html')" />
    <xsl:value-of select="$gNL" />
  </xsl:template>
  <!-- ************************************************** -->
  <xsl:template match="book">
    <!--
    <xsl:if test="$gDebug">
      <xsl:message>
        <xsl:value-of select="concat('Debug: text=', $gPrintRef/@text)" />
      </xsl:message>
    </xsl:if>
-->
    <!-- ************************ -->
    <exsl:document method="html"
                   href="{concat(@id, '.html')}">
      <html>
        <head>
          <title>
            <xsl:value-of select="title" />
          </title>
          <xsl:call-template name="fMetaHead" />
          <xsl:call-template name="fHtmlStyle" />
        </head>
        <body>
          <xsl:call-template name="fBodyAttr" />
          <xsl:call-template name="fTitlePage" />
          <xsl:call-template name="fCopyrightPage" />
          <xsl:call-template name="fTocPage" />
          <xsl:apply-templates select="story-info/ch-preface" />
          <xsl:apply-templates select="preface" />
          <xsl:apply-templates select="chapter" />
          <xsl:apply-templates select="epilog" />
        </body>
      </html>
    </exsl:document>
  </xsl:template>
  <!-- **************************************************
Book
-->
  <!-- ******************** -->
  <xsl:template match="unit">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <xsl:if test="$gPrintRef/@auto-break = '1' and position() != 1">
        <hr class="break" />
      </xsl:if>
      <xsl:apply-templates select="thread" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="thread">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <xsl:apply-templates select="p|s|t|pre|quote|br|para|pre-fmt" />
    </xsl:if>
  </xsl:template>
  <!-- **************************************************
Block
-->
  <!-- ******************** -->
  <xsl:template match="p">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <p>
      <xsl:call-template name="fRevisionFlag" />&#160;</p>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="para">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <p class="block">
      <xsl:call-template name="fRevisionFlag" />&#160;</p>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="pre|pre-fmt">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <pre>
      
<xsl:call-template name="fRevisionFlag" />
    
</pre>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="quote">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <p class="quote">
      <xsl:call-template name="fRevisionFlag" />&#160;</p>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="s">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <p>
      <xsl:call-template name="fRevisionFlag" />&#160;</p>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="t">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <p>
      <xsl:call-template name="fRevisionFlag" />&#160;</p>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
</xsl:stylesheet>
