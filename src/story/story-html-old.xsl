<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
		exclude-result-prefixes="doc"
		xmlns:exsl="http://exslt.org/common"
		extension-element-prefixes="exsl">
  <!--
$Header: /repo/local.cvs/app/story-xml/src/story4/story-html-old.xsl,v 1.1 2008/02/24 21:38:26 bruce Exp $
-->
  <xsl:output method="html"
	      indent="yes" />
  <xsl:include href="story-com.xsl" />
  <xsl:include href="story-com-html.xsl" />
  <!-- ************************************************** -->
  <xsl:template match="/content">
    <xsl:apply-templates select="site" />
    <xsl:apply-templates select="page" />
    <xsl:apply-templates select="book" />
    <xsl:call-template name="fOutputList" />
  </xsl:template>
  <!-- ************************************************** -->
  <xsl:template match="site"></xsl:template>
  <!-- ************************************************** -->
  <xsl:template name="fOutputList">
    <exsl:document method="text"
		   href="output-list.txt">
      <xsl:apply-templates select="page"
			   mode="output-list" />
      <xsl:apply-templates select="book"
			   mode="output-list" />
    </exsl:document>
  </xsl:template>
  <xsl:template match="book"
		mode="output-list">
    <xsl:if test="contains($gBookStatus, concat(' book-', @status, ' '))">
      <xsl:value-of select="concat(@id,'.html')" />
      <xsl:value-of select="$gNL" />
    </xsl:if>
  </xsl:template>
  <!-- ************************************************** -->
  <xsl:template match="book">
    <xsl:if test="contains($gBookStatus, concat(' book-', @status, ' '))">
      <exsl:document method="html"
		     href="{concat(@id,'.html')}">
	<html>
	  <head>
	    <title>
	      <xsl:value-of select="title" />
	    </title>
	    <xsl:call-template name="fMetaHead" />
	  </head>
	  <body>
	  <xsl:call-template name="fBodyAttr" />
	  <xsl:call-template name="fDebugBook" />
	  <h1>
	    <xsl:value-of select="title" />
	  </h1>By: 
	  <xsl:value-of select="author" />
	  <br />
	  <xsl:variable name="LastDate">
	    <xsl:apply-templates select="cvs/@date" />
	  </xsl:variable>
	  <xsl:if test="substring(pub-date,1,4) = substring($LastDate,1,4)">
	  Copyright 
	  <xsl:value-of select="substring(pub-date,1,4)" />
	  <br /></xsl:if>
	  <xsl:if test="substring(pub-date,1,4) != substring($LastDate,1,4)">
	  Copyright 
	  <xsl:value-of select="substring(pub-date,1,4)" />- 
	  <xsl:value-of select="substring($LastDate,1,4)" />
	  <br /></xsl:if>
	  <xsl:if test="edition != '1'">Edition: 
	  <xsl:value-of select="edition" />
	  <br /></xsl:if>
	  <xsl:if test="@status = 'in-progress'">In progress 
	  <br /></xsl:if>
	  <xsl:if test="@status = 'draft'">Draft 
	  <br /></xsl:if>
	  <xsl:comment>
	    <xsl:call-template name="fCVSPprint" />
	  </xsl:comment>
	  <xsl:call-template name="fToc" />
	  <xsl:if test="boolean(number($gContentRef/@ch-preface))">
	    <xsl:apply-templates select="ch-preface" />
	  </xsl:if>
	  <xsl:if test="boolean(number($gContentRef/@preface))">
	    <xsl:apply-templates select="preface" />
	  </xsl:if>
	  <xsl:apply-templates select="chapter" />
	  <xsl:if test="boolean(number($gContentRef/@preface))">
	    <xsl:apply-templates select="epilog" />
	  </xsl:if>
	  <hr />Last updated: 
	  <xsl:apply-templates select="cvs/@date" /></body>
	</html>
      </exsl:document>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fToc">
    <hr />
    <h2>Contents</h2>
    <ul>
      <xsl:if test="boolean(number($gContentRef/@preface))">
	<xsl:apply-templates select="preface"
			     mode="toc" />
      </xsl:if>
      <xsl:apply-templates select="chapter"
			   mode="toc" />
      <xsl:if test="boolean(number($gContentRef/@preface))">
	<xsl:apply-templates select="epilog"
			     mode="toc" />
      </xsl:if>
    </ul>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="preface"
		mode="toc">
    <li>
      <a>
	<xsl:attribute name="href">#preface</xsl:attribute>
	<xsl:apply-templates select="title"
			     mode="preface" />
      </a>
    </li>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="epilog"
		mode="toc">
    <li>
      <a>
	<xsl:attribute name="href">#epilog</xsl:attribute>
	<xsl:apply-templates select="title"
			     mode="epilog" />
      </a>
    </li>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="chapter"
		mode="toc">
    <xsl:if test="contains($gChStatus, concat(' ch-', @status, ' ')) and (($gContentCh = '') or contains($gContentCh, concat(' ', @id, ' ')))">

      <li>
      <a>
      <xsl:attribute name="href">#ch- 
      <xsl:value-of select="@id" /></xsl:attribute>
      <xsl:value-of select="ch-no" />. 
      <xsl:value-of select="title" /></a>
      <xsl:if test="../@status != 'done'">
	<xsl:if test="@status = 'draft'">- draft</xsl:if>
	<xsl:if test="@status = 'in-progress'">- in progress</xsl:if>
	<xsl:if test="@status = 'done'">- done</xsl:if>
      </xsl:if>(first post: 
      <xsl:value-of select="pub-date" />; last update: 
      <xsl:apply-templates select="cvs/@date" />)</li>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="chapter">
    <xsl:if test="contains($gChStatus, concat(' ch-', @status, ' ')) and (($gContentCh = '') or contains($gContentCh, concat(' ', @id, ' ')))">

      <xsl:call-template name="fChapterBody" />
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
