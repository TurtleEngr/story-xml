<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:date="http://exslt.org/dates-and-times"
		xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
		exclude-result-prefixes="doc"
		xmlns:exsl="http://exslt.org/common"
		xmlns:str="http://exslt.org/strings"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		extension-element-prefixes="date doc exsl str">
  <!--
	extension-element-prefixes="date doc exsl fo str"
$Header: /repo/local.cvs/app/story-xml/src/story2/story-pdf.xsl,v 1.17 2008/01/07 02:35:52 bruce Exp $
-->
  <xsl:output method="xml"
	      indent="yes" />
  <xsl:include href="story-com.xsl" />
  <!-- ************************************* -->
  <!-- Set page size variables -->
  <xsl:param name="gWidth">
    <xsl:choose>
      <xsl:when test="$gPrintRef/@page = '4.25x5.5in'">
	<xsl:text>
4.25
</xsl:text>
      </xsl:when>
      <xsl:when test="$gPrintRef/@page = '6x9in'">
	<xsl:text>
6
</xsl:text>
      </xsl:when>
      <xsl:when test="$gPrintRef/@page = '8.5x11in'">
	<xsl:text>
8.5
</xsl:text>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>
6
</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="gHeight">
    <xsl:choose>
      <xsl:when test="$gPrintRef/@page = '4.25x5.5in'">
	<xsl:text>
5.5
</xsl:text>
      </xsl:when>
      <xsl:when test="$gPrintRef/@page = '6x9in'">
	<xsl:text>
9
</xsl:text>
      </xsl:when>
      <xsl:when test="$gPrintRef/@page = '8.5x11in'">
	<xsl:text>
11
</xsl:text>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>
9
</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="gMargin">
    <xsl:call-template name="units">
      <xsl:with-param name="pFrom"
		      select="$gPrintRef/@margin" />
      <xsl:with-param name="pTo"
		      select="'in'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gGutter">
    <xsl:call-template name="units">
      <xsl:with-param name="pFrom"
		      select="$gPrintRef/@gutter" />
      <xsl:with-param name="pTo"
		      select="'in'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gBleedLeft">
    <xsl:call-template name="units">
      <xsl:with-param name="pFrom"
		      select="$gPrintRef/@bleed-left" />
      <xsl:with-param name="pTo"
		      select="'in'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gBleedRight">
    <xsl:call-template name="units">
      <xsl:with-param name="pFrom"
		      select="$gPrintRef/@bleed-right" />
      <xsl:with-param name="pTo"
		      select="'in'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gBleedTop">
    <xsl:call-template name="units">
      <xsl:with-param name="pFrom"
		      select="$gPrintRef/@bleed-top" />
      <xsl:with-param name="pTo"
		      select="'in'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gBleedBottom">
    <xsl:call-template name="units">
      <xsl:with-param name="pFrom"
		      select="$gPrintRef/@bleed-bottom" />
      <xsl:with-param name="pTo"
		      select="'in'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gDuplex"
	     select="boolean(number($gPrintRef/@duplex))" />
  <!-- Calculate dimensions -->
  <xsl:param name="gPageHeight"
	     select="$gHeight + $gBleedTop + $gBleedBottom" />
  <xsl:param name="gPageWidth"
	     select="$gWidth + $gBleedLeft + $gBleedRight" />
  <xsl:param name="gMarginTop"
	     select="$gMargin + $gBleedTop" />
  <xsl:param name="gMarginBottom"
	     select="$gMargin + $gBleedBottom" />
  <xsl:param name="gMarginOddLeft"
	     select="$gMargin + $gGutter + $gBleedLeft" />
  <xsl:param name="gMarginOddRight"
	     select="$gMargin + $gBleedRight" />
  <xsl:param name="gMarginEvenLeft">
    <xsl:if test="boolean(number($gDuplex))">
      <xsl:value-of select="$gMargin + $gBleedLeft" />
    </xsl:if>
    <xsl:if test="not(number($gDuplex))">
      <xsl:value-of select="$gMarginOddLeft" />
    </xsl:if>
  </xsl:param>
  <xsl:param name="gMarginEvenRight">
    <xsl:if test="boolean(number($gDuplex))">
      <xsl:value-of select="$gMargin + $gGutter + $gBleedRight" />
    </xsl:if>
    <xsl:if test="not(number($gDuplex))">
      <xsl:value-of select="$gMarginOddRight" />
    </xsl:if>
  </xsl:param>
  <xsl:param name="gBodySize">
    <xsl:call-template name="units">
      <xsl:with-param name="pFrom"
		      select="$gPrintRef/@body-size" />
      <xsl:with-param name="pTo"
		      select="'pt'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gBodyWidth">
    <xsl:value-of select="$gWidth - $gMarginOddRight - $gMarginOddLeft" />
  </xsl:param>
  <xsl:param name="gHalfBodyWidth">
    <xsl:value-of select="$gBodyWidth div 2" />
  </xsl:param>
  <xsl:param name="gLineHeight">
    <xsl:value-of select="number(substring-before($gPrintRef/@line-height,'%'))" />
  </xsl:param>
  <xsl:param name="gHeaderHeight">
    <xsl:value-of select="$gBodySize * $gLineHeight div 100 * 2" />
  </xsl:param>
  <!-- =================================================================== -->
  <xsl:template match="/content">
    <xsl:apply-templates select="book" />
  </xsl:template>
  <!-- ************************************************** -->
  <xsl:template match="book">
    <xsl:if test="contains($gBookStatus, concat(' book-', @status, ' '))">
      <xsl:message>
	<xsl:value-of select="concat('Debug: gWidth=',$gWidth)" />
	<xsl:value-of select="$gNL" />
	<xsl:value-of select="concat('Debug: bleed-left=', $gPrintRef/@bleed-left)" />
	<xsl:value-of select="$gNL" />
	<xsl:value-of select="concat('Debug: gBleedLeft=',$gBleedLeft)" />
	<xsl:value-of select="$gNL" />
	<xsl:value-of select="concat('Debug: gPageWidth=',$gPageWidth)" />
	<xsl:value-of select="$gNL" />
	<xsl:value-of select="concat('Debug: gBodyWidth=',$gBodyWidth)" />
	<xsl:value-of select="$gNL" />
	<xsl:value-of select="concat('Debug: gHalfBodyWidth=',$gHalfBodyWidth)" />
	<xsl:value-of select="$gNL" />
	<xsl:value-of select="concat('Debug: gHeaderHeight=',$gHeaderHeight)" />
	<xsl:value-of select="$gNL" />
      </xsl:message>
      <!-- ************************************* -->
      <exsl:document method="xml"
		     href="{concat(@id,'.fo')}">
	<fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"
		 text-align="start">
	  <xsl:attribute name="font-family">
	    <xsl:call-template name="select-font">
	      <xsl:with-param name="pFont"
			      select="$gPrintRef/@body-family" />
	    </xsl:call-template>
	  </xsl:attribute>
	  <xsl:attribute name="font-size">
	    <xsl:value-of select="concat($gBodySize,'pt')" />
	  </xsl:attribute>
	  <xsl:attribute name="line-height">
	    <xsl:value-of select="concat($gLineHeight,'%')" />
	  </xsl:attribute>
	  <fo:layout-master-set>
	    <fo:simple-page-master master-name="Title"
				   page-width="{$gPageWidth}in"
				   page-height="{$gPageHeight}in"
				   margin-top="{$gMarginTop}in"
				   margin-bottom="{$gMarginBottom}in"
				   margin-left="{$gMarginOddLeft}in"
				   margin-right="{$gMarginOddRight}in">
	      <fo:region-body margin-top="1in"
			      margin-bottom="0pt" />
	    </fo:simple-page-master>
	    <fo:simple-page-master master-name="Copyright"
				   page-width="{$gPageWidth}in"
				   page-height="{$gPageHeight}in"
				   margin-top="{$gMarginTop}in"
				   margin-bottom="{$gMarginBottom}in"
				   margin-left="{$gMarginEvenLeft}in"
				   margin-right="{$gMarginEvenRight}in">
	      <fo:region-body margin-top="2in"
			      margin-bottom="40pt" />
	    </fo:simple-page-master>
	    <fo:simple-page-master master-name="TOC"
				   page-width="{$gPageWidth}in"
				   page-height="{$gPageHeight}in"
				   margin-top="{$gMarginTop}in"
				   margin-bottom="{$gMarginBottom}in"
				   margin-left="{$gMarginOddLeft}in"
				   margin-right="{$gMarginOddRight}in">
	      <fo:region-body margin-top="{$gHeaderHeight}pt"
			      margin-bottom="0pt"
			      margin-left="0.5in"
			      margin-right="0in" />
	    </fo:simple-page-master>
	    <fo:simple-page-master master-name="ChOdd"
				   page-width="{$gPageWidth}in"
				   page-height="{$gPageHeight}in"
				   margin-top="{$gMarginTop}in"
				   margin-bottom="{$gMarginBottom}in"
				   margin-left="{$gMarginOddLeft}in"
				   margin-right="{$gMarginOddRight}in">
	      <fo:region-body margin-top="{$gHeaderHeight}pt"
			      margin-bottom="0pt" />
	      <fo:region-before extent="{$gHeaderHeight}pt"
				region-name="ChOddBefore" />
	    </fo:simple-page-master>
	    <fo:simple-page-master master-name="ChEven"
				   page-width="{$gPageWidth}in"
				   page-height="{$gPageHeight}in"
				   margin-top="{$gMarginTop}in"
				   margin-bottom="{$gMarginBottom}in"
				   margin-left="{$gMarginEvenLeft}in"
				   margin-right="{$gMarginEvenRight}in">
	      <fo:region-body margin-top="{$gHeaderHeight}pt"
			      margin-bottom="0pt" />
	      <fo:region-before extent="{$gHeaderHeight}pt"
				region-name="ChEvenBefore" />
	    </fo:simple-page-master>
	    <fo:page-sequence-master master-name="Book">
	      <fo:single-page-master-reference master-reference="Title" />
	      <fo:single-page-master-reference master-reference="Copyright" />
	      <fo:single-page-master-reference master-reference="TOC" />
	      <fo:repeatable-page-master-alternatives>
		<fo:conditional-page-master-reference master-reference="ChOdd"
						      page-position="any"
						      odd-or-even="odd" />
		<fo:conditional-page-master-reference master-reference="ChEven"
						      page-position="any"
						      odd-or-even="even" />
	      </fo:repeatable-page-master-alternatives>
	    </fo:page-sequence-master>
	  </fo:layout-master-set>
	  <fo:page-sequence master-reference="Book">
	    <xsl:call-template name="page-header" />
	    <fo:flow flow-name="xsl-region-body">
	      <xsl:call-template name="title-page" />
	      <xsl:call-template name="copyright-page" />
	      <xsl:if test="boolean(number($gPrintRef/@toc))">
		<xsl:call-template name="toc-page" />
	      </xsl:if>
	      <xsl:if test="boolean(number($gContentRef/@preface))">
		<xsl:apply-templates select="preface" />
	      </xsl:if>
	      <xsl:apply-templates select="chapter" />
	      <xsl:if test="boolean(number($gContentRef/@preface))">
		<xsl:apply-templates select="epilog" />
	      </xsl:if>
	    </fo:flow>
	  </fo:page-sequence>
	</fo:root>
      </exsl:document>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="page-header">
    <!-- Page Numbering -->
    <fo:static-content flow-name="ChOddBefore">
      <fo:table table-layout="fixed"
		width="{$gBodyWidth}in"
		border-collapse="collapse">
	<fo:table-column column-width="{$gHalfBodyWidth}in" />
	<fo:table-column column-width="{$gHalfBodyWidth}in" />
	<fo:table-body>
	  <fo:table-row>
	    <fo:table-cell>
	      <fo:block text-align="left"
			line-height="60%">
		<xsl:value-of select="title" />
	      </fo:block>
	    </fo:table-cell>
	    <fo:table-cell>
	      <fo:block text-align="right"
			line-height="60%">
		<fo:page-number />
	      </fo:block>
	    </fo:table-cell>
	  </fo:table-row>
	</fo:table-body>
      </fo:table>
      <fo:block text-align="left"
		line-height="60%">
	<fo:leader leader-pattern="rule"
		   leader-length="{$gBodyWidth}in" />
      </fo:block>
    </fo:static-content>
    <fo:static-content flow-name="ChEvenBefore">
      <fo:table table-layout="fixed"
		width="{$gBodyWidth}in"
		border-collapse="collapse">
	<fo:table-column column-width="{$gHalfBodyWidth}in" />
	<fo:table-column column-width="{$gHalfBodyWidth}in" />
	<fo:table-body>
	  <fo:table-row>
	    <fo:table-cell>
	      <fo:block text-align="left"
			line-height="60%">
		<fo:page-number />
	      </fo:block>
	    </fo:table-cell>
	    <fo:table-cell>
	      <fo:block text-align="right"
			line-height="60%">
		<xsl:value-of select="title" />
	      </fo:block>
	    </fo:table-cell>
	  </fo:table-row>
	</fo:table-body>
      </fo:table>
      <fo:block text-align="left"
		line-height="60%">
	<fo:leader leader-pattern="rule"
		   leader-length="{$gBodyWidth}in" />
      </fo:block>
    </fo:static-content>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="title-page">
    <fo:block text-align="center"
	      font-weight="bold">
      <xsl:attribute name="font-family">
	<xsl:call-template name="select-font">
	  <xsl:with-param name="pFont"
			  select="$gPrintRef/@title-family" />
	</xsl:call-template>
      </xsl:attribute>
      <xsl:attribute name="font-size">
	<xsl:value-of select="$gPrintRef/@title-size" />
      </xsl:attribute>
      <xsl:value-of select="title" />
    </fo:block>
    <fo:block text-align="center"
	      font-weight="bold"
	      break-after="page">
    <xsl:attribute name="font-family">
      <xsl:call-template name="select-font">
	<xsl:with-param name="pFont"
			select="$gPrintRef/@title-family" />
      </xsl:call-template>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$gPrintRef/@ch-title-size" />
    </xsl:attribute>by 
    <xsl:value-of select="author" /></fo:block>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="copyright-page">
    <!-- "$gPrintRef/@copyright-type" -->
    <xsl:variable name="LastDate">
      <xsl:apply-templates select="cvs/@date" />
    </xsl:variable>
    <xsl:if test="boolean(number($gContentRef/@ch-preface))">
      <fo:block>
	<xsl:apply-templates select="ch-preface" />
      </fo:block>
    </xsl:if>
    <fo:block font-weight="bold">
      <xsl:value-of select="title" />
    </fo:block>
    <fo:block padding-top=".5em"
	      font-weight="bold">
    <xsl:if test="substring(pub-date,1,4) = substring($LastDate,1,4)">
    Copyright 
    <xsl:value-of select="substring(pub-date,1,4)" /></xsl:if>
    <xsl:if test="substring(pub-date,1,4) != substring($LastDate,1,4)">
    Copyright 
    <xsl:value-of select="substring(pub-date,1,4)" />- 
    <xsl:value-of select="substring($LastDate,1,4)" /></xsl:if>by 
    <xsl:value-of select="author" /></fo:block>
    <fo:block text-align="justify">All rights reserved, including the
    right to reproduce this book, or portions thereof, in any
    form.</fo:block>
    <fo:block padding-top=".5em">Edition: 
    <xsl:value-of select="edition" /></fo:block>
    <xsl:if test="@status = 'in-progress'">
      <fo:block>In progress</fo:block>
    </xsl:if>
    <xsl:if test="@status = 'draft'">
      <fo:block>Draft</fo:block>
    </xsl:if>
    <xsl:call-template name="cvs-print" />
    <fo:block padding-top=".5em"
	      font-weight="bold">Printed in the United States of
	      America</fo:block>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="toc-page">
    <fo:block break-before="page"
	      text-align="center"
	      font-weight="bold"
	      space-after="0.5in">
    <xsl:attribute name="font-family">
      <xsl:call-template name="select-font">
	<xsl:with-param name="pFont"
			select="$gPrintRef/@ch-title-family" />
      </xsl:call-template>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$gPrintRef/@ch-title-size" />
    </xsl:attribute>Contents</fo:block>
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
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="preface"
		mode="toc">
    <fo:block text-indent="-0.5in"
	      text-align-last="justify">
      <xsl:apply-templates select="title"
			   mode="preface" />
      <fo:leader leader-length.minimum="12pt"
		 leader-length.optimum="40pt"
		 leader-length.maximum="100%"
		 leader-pattern="dots" />
      <fo:page-number-citation ref-id="preface" />
    </fo:block>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="epilog"
		mode="toc">
    <fo:block text-indent="-0.5in"
	      text-align-last="justify">
      <xsl:apply-templates select="title"
			   mode="epilog" />
      <fo:leader leader-length.minimum="12pt"
		 leader-length.optimum="40pt"
		 leader-length.maximum="100%"
		 leader-pattern="dots" />
      <fo:page-number-citation ref-id="epilog" />
    </fo:block>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="chapter"
		mode="toc">
    <xsl:if test="contains($gChStatus, concat(' ch-', @status, ' ')) and (($gContentCh = '') or contains($gContentCh, concat(' ', @id, ' ')))">

      <fo:block text-indent="-0.5in"
		text-align-last="justify">
      <xsl:value-of select="ch-no" />. 
      <xsl:value-of select="title" />
      <xsl:if test="../@status != 'done'">
      <xsl:if test="@status = 'draft'">- draft</xsl:if>
      <xsl:if test="@status = 'in-progress'">- in progress</xsl:if>
      <xsl:if test="@status = 'done'">- done</xsl:if>(first post: 
      <xsl:value-of select="pub-date" />; last update: 
      <xsl:apply-templates select="cvs/@date" />)</xsl:if>
      <fo:leader leader-length.minimum="12pt"
		 leader-length.optimum="40pt"
		 leader-length.maximum="100%"
		 leader-pattern="dots" />
      <fo:page-number-citation>
	<xsl:attribute name="ref-id">
	  <xsl:value-of select="concat('ch-', @id)" />
	</xsl:attribute>
      </fo:page-number-citation></fo:block>
    </xsl:if>
  </xsl:template>
  <!-- **************************************************
Book
-->
  <!-- ******************** -->
  <xsl:template match="preface">
    <fo:block id="preface"
	      break-before="odd-page"
	      text-align="left"
	      font-size="20pt"
	      font-weight="bold">
      <xsl:attribute name="font-family">
	<xsl:call-template name="select-font">
	  <xsl:with-param name="pFont"
			  select="$gPrintRef/@ch-title-family" />
	</xsl:call-template>
      </xsl:attribute>
      <xsl:attribute name="font-size">
	<xsl:value-of select="$gPrintRef/@ch-title-size" />
      </xsl:attribute>
      <xsl:apply-templates select="title"
			   mode="preface" />
    </fo:block>
    <xsl:apply-templates select="p|s|pre" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="title"
		mode="preface">
    <xsl:if test=". = ''">
      <xsl:text>
Preface
</xsl:text>
    </xsl:if>
    <xsl:value-of select="." />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="epilog">
    <fo:block id="epilog"
	      break-before="odd-page"
	      text-align="left"
	      font-weight="bold">
      <xsl:attribute name="font-family">
	<xsl:call-template name="select-font">
	  <xsl:with-param name="pFont"
			  select="$gPrintRef/@ch-title-family" />
	</xsl:call-template>
      </xsl:attribute>
      <xsl:attribute name="font-size">
	<xsl:value-of select="$gPrintRef/@ch-title-size" />
      </xsl:attribute>
      <xsl:apply-templates select="title"
			   mode="epilog" />
    </fo:block>
    <xsl:apply-templates select="p|s|pre" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="title"
		mode="epilog">
    <xsl:if test=". = ''">
      <xsl:text>
Epilog
</xsl:text>
    </xsl:if>
    <xsl:value-of select="." />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="chapter">
    <xsl:if test="contains($gChStatus, concat(' ch-', @status, ' ')) and (($gContentCh = '') or contains($gContentCh, concat(' ', @id, ' ')))">

      <xsl:call-template name="chapter-body" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="ch-preface">
    <xsl:apply-templates select="p|s|pre" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="prolog">
    <fo:block padding-top=".5em"
	      text-align="left"
	      font-weight="bold">
      <xsl:attribute name="font-family">
	<xsl:call-template name="select-font">
	  <xsl:with-param name="pFont"
			  select="$gPrintRef/@ch-title-family" />
	</xsl:call-template>
      </xsl:attribute>
      <xsl:attribute name="font-size">
	<xsl:value-of select="$gPrintRef/@ch-title-size" />
      </xsl:attribute>
      <xsl:value-of select="title" />
    </fo:block>
    <xsl:apply-templates select="p|s|pre" />
    <fo:block text-align="left"
	      line-height="60%">
      <fo:leader leader-pattern="rule"
		 leader-length="3in" />
    </fo:block>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="postlog">
    <fo:block padding-top=".5em"
	      text-align="left"
	      line-height="60%">
      <fo:leader leader-pattern="rule"
		 leader-length="3in" />
    </fo:block>
    <fo:block padding-top=".5em"
	      text-align="left"
	      font-weight="bold">
      <xsl:attribute name="font-family">
	<xsl:call-template name="select-font">
	  <xsl:with-param name="pFont"
			  select="$gPrintRef/@ch-title-family" />
	</xsl:call-template>
      </xsl:attribute>
      <xsl:attribute name="font-size">
	<xsl:value-of select="$gPrintRef/@ch-title-size" />
      </xsl:attribute>
      <xsl:value-of select="title" />
    </fo:block>
    <xsl:apply-templates select="p|s|pre" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="chapter-body">
    <fo:block break-before="page"
	      text-align="left"
	      font-weight="bold">
    <xsl:attribute name="id">
      <xsl:value-of select="concat('ch-', @id)" />
    </xsl:attribute>
    <xsl:attribute name="font-family">
      <xsl:call-template name="select-font">
	<xsl:with-param name="pFont"
			select="$gPrintRef/@ch-title-family" />
      </xsl:call-template>
    </xsl:attribute>
    <xsl:attribute name="font-size">
      <xsl:value-of select="$gPrintRef/@ch-title-size" />
    </xsl:attribute>
    <xsl:value-of select="ch-no" />. 
    <xsl:value-of select="title" /></fo:block>
    <xsl:if test="@staus != done">
      <fo:block line-height="120%">
	<xsl:value-of select="@status" />
      </fo:block>
      <xsl:call-template name="cvs-print" />
    </xsl:if>
    <xsl:if test="boolean(number($gContentRef/@prolog))">
      <xsl:apply-templates select="prolog" />
    </xsl:if>
    <xsl:apply-templates select="unit" />
    <xsl:if test="boolean(number($gContentRef/@prolog))">
      <xsl:apply-templates select="postlog" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="unit">
    <xsl:if test="contains($gUnitStatus, concat(' unit-', @status, ' ')) and (($gContentUnit = '') or contains($gContentUnit, concat(' ', @id, ' ')))">

      <fo:block padding-top="1.5em"
		line-height="120%" />
      <xsl:apply-templates select="thread" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="thread">
    <xsl:if test="not(number($gDraft)) or boolean(number($gContentRef/@thread-content))">

      <xsl:if test="contains(concat(' ', @ref, ' '), $gContentThread)">
	<xsl:apply-templates select="p|s|t|pre" />
      </xsl:if>
    </xsl:if>
  </xsl:template>
  <!-- ************************************************************
Utility
-->
  <!-- ******************** -->
  <xsl:template name="select-font">
    <xsl:param name="pFont" />
    <xsl:choose>
      <xsl:when test="$pFont = 'century'">
	<xsl:text>
Century, serif
</xsl:text>
      </xsl:when>
      <xsl:when test="$pFont = 'times'">
	<xsl:text>
Times, serif
</xsl:text>
      </xsl:when>
      <xsl:when test="$pFont = 'helvetica'">
	<xsl:text>
Helvetica, Arial, sans
</xsl:text>
      </xsl:when>
      <xsl:otherwise>
	<xsl:text>
Times, serif
</xsl:text>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- **************************************************
Block
-->
  <!-- ******************** -->
  <xsl:template name="cvs-print">
    <xsl:if test="pub-date">
      <fo:block>First Published: 
      <xsl:value-of select="pub-date" /></fo:block>
    </xsl:if>
    <xsl:if test="cvs/@date">
      <fo:block>Revision Date: 
      <xsl:apply-templates select="cvs/@date" /></fo:block>
    </xsl:if>
    <xsl:if test="cvs/@rev">
      <fo:block>Revision: 
      <xsl:apply-templates select="cvs/@rev" /></fo:block>
    </xsl:if>
    <xsl:if test="cvs/@source">
      <fo:block>Source: 
      <xsl:apply-templates select="cvs/@source" /></fo:block>
    </xsl:if>
    <xsl:if test="cvs/@root">
      <fo:block>Root: 
      <xsl:apply-templates select="cvs/@root" /></fo:block>
    </xsl:if>
    <xsl:if test="cvs/@repository">
      <fo:block>Repository: 
      <xsl:apply-templates select="cvs/@repository" /></fo:block>
    </xsl:if>
    <xsl:if test="cvs/@file">
      <fo:block>File: 
      <xsl:apply-templates select="cvs/@file" /></fo:block>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="cvs/@date">
    <xsl:value-of select="substring(substring-before(substring-after(., '$'), ' $'), 7, 10)" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="cvs/@rev">
    <xsl:value-of select="substring(substring-before(substring-after(., '$'), ' $'), 11, 256)" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="cvs/@source">
    <xsl:value-of select="substring(substring-before(substring-after(., '$'), ' $'), 9, 256)" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="cvs/@root">
    <xsl:value-of select="." />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="cvs/@repository">
    <xsl:value-of select="." />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="cvs/@file">
    <xsl:value-of select="." />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="p">
    <fo:block text-indent="0pt"
	      padding-top=".5em"
	      text-align="justify"
	      line-height="120%"
	      orphans="2"
	      widows="2">
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="pre">
    <fo:block>
      <xsl:attribute name="font-size">
	<xsl:value-of select="$gPrintRef/@body-size * 0.83" />
	<xsl:text>
pt
</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="font-family">
	<xsl:value-of select="'Courier, monospace'" />
      </xsl:attribute>
      <xsl:attribute name="white-space">pre</xsl:attribute>
      <xsl:attribute name="padding-top">.5em</xsl:attribute>
      <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
      <xsl:attribute name="white-space-collapse">false</xsl:attribute>
      <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="s">
    <fo:block text-align="justify"
	      orphans="2"
	      widows="2">
      <xsl:attribute name="text-indent">
	<xsl:value-of select="concat(number($gBodySize) * 2, 'pt')" />
      </xsl:attribute>
      <xsl:apply-templates />
    </fo:block>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="t">
    <xsl:if test="@ref = ../@viewpoint">
      <fo:block text-align="justify"
		orphans="2"
		widows="2">
	<xsl:attribute name="text-indent">
	  <xsl:value-of select="concat(number($gBodySize) * 2, 'pt')" />
	</xsl:attribute>
	<xsl:apply-templates />
      </fo:block>
    </xsl:if>
  </xsl:template>
  <!-- **************************************************
Inline
-->
  <!-- ******************** -->
  <xsl:template name="img-url">
    <xsl:param name="pKey" />
    <xsl:variable name="image"
		  select="key('def-img-index', $pKey)" />
    <xsl:variable name="image-url">
      <xsl:value-of select="$image/@url" />
    </xsl:variable>
    <xsl:variable name="image-base">
      <xsl:value-of select="key('def-base-index', $image/@base)/." />
    </xsl:variable>
    <xsl:value-of select="concat($image-base, $image-url)" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="img-tag">
    <xsl:param name="pKey" />
    <xsl:variable name="image-path">
      <xsl:call-template name="img-url">
	<xsl:with-param name="pKey"
			select="$pKey" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:if test="boolean(number($gDebug))">
      <xsl:message>
	<xsl:value-of select="concat('graphic src=', $image-path)" />
      </xsl:message>
    </xsl:if>
    <fo:external-graphic>
      <xsl:attribute name="src">
	<xsl:value-of select="$image-path" />
      </xsl:attribute>
    </fo:external-graphic>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="img">
    <xsl:call-template name="img-tag">
      <xsl:with-param name="pKey"
		      select="@ref" />
    </xsl:call-template>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="link">
    <xsl:choose>
      <xsl:when test="$gContentLink = 'full'">
	<xsl:call-template name="link-full" />
      </xsl:when>
      <xsl:when test="$gContentLink = 'long'">
	<xsl:call-template name="link-long" />
      </xsl:when>
      <xsl:when test="$gContentLink = 'short'">
	<xsl:call-template name="link-short" />
      </xsl:when>
      <xsl:when test="$gContentLink = 'text'">
	<xsl:call-template name="link-text" />
      </xsl:when>
      <xsl:when test="$gContentLink = 'plain'">
	<xsl:call-template name="link-plain" />
      </xsl:when>
      <xsl:when test="$gContentLink = 'default'">
	<xsl:call-template name="link-default" />
      </xsl:when>
      <xsl:otherwise>
	<xsl:call-template name="link-default" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="link-default">
    <xsl:variable name="link"
		  select="key('def-link-index', @ref)" />
    <xsl:variable name="link-url">
      <xsl:value-of select="$link/@url" />
    </xsl:variable>
    <xsl:variable name="link-base">
      <xsl:value-of select="key('def-base-index', $link/@base)/." />
    </xsl:variable>
    <fo:inline text-decoration="underline">
      <xsl:if test="@img = 'yes' and $link/@ref != ''">
	<xsl:call-template name="img-tag">
	  <xsl:with-param name="pKey"
			  select="$link/@ref" />
	</xsl:call-template>
	<xsl:text>
 
</xsl:text>
      </xsl:if>
      <xsl:if test=". != ''">
	<xsl:value-of select="." />
	<xsl:text>
 
</xsl:text>
      </xsl:if>
      <xsl:if test="@title = 'yes' or (. = '' and @img != 'yes' and @url != 'yes')">

	<xsl:value-of select="key('def-link-index', @ref)" />
	<xsl:text>
 
</xsl:text>
      </xsl:if>
      <xsl:if test="@url = 'yes'">( 
      <xsl:value-of select="concat(key('def-base-index', @base), key('def-link-index', @ref)/@url)" />)</xsl:if>
    </fo:inline>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="link-full">
    <xsl:variable name="link"
		  select="key('def-link-index', @ref)" />
    <xsl:variable name="link-url">
      <xsl:value-of select="$link/@url" />
    </xsl:variable>
    <xsl:variable name="link-base">
      <xsl:value-of select="key('def-base-index', $link/@base)/." />
    </xsl:variable>
    <fo:inline text-decoration="underline">
    <xsl:if test="$link/@ref != ''">
      <xsl:call-template name="img-tag">
	<xsl:with-param name="pKey"
			select="$link/@ref" />
      </xsl:call-template>
      <xsl:text>
 
</xsl:text>
    </xsl:if>
    <xsl:if test=". != ''">
      <xsl:value-of select="." />
      <xsl:text>
 
</xsl:text>
    </xsl:if>
    <xsl:value-of select="key('def-link-index', @ref)" />
    <xsl:text>
 
</xsl:text>( 
    <xsl:value-of select="concat(key('def-base-index', @base), key('def-link-index', @ref)/@url)" />)</fo:inline>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="link-long">
    <xsl:variable name="link"
		  select="key('def-link-index', @ref)" />
    <xsl:variable name="link-url">
      <xsl:value-of select="$link/@url" />
    </xsl:variable>
    <xsl:variable name="link-base">
      <xsl:value-of select="key('def-base-index', $link/@base)/." />
    </xsl:variable>
    <fo:inline text-decoration="underline">
    <xsl:if test=". != ''">
      <xsl:value-of select="." />
      <xsl:text>
 
</xsl:text>
    </xsl:if>
    <xsl:value-of select="key('def-link-index', @ref)" />
    <xsl:text>
 
</xsl:text>( 
    <xsl:value-of select="concat(key('def-base-index', @base), key('def-link-index', @ref)/@url)" />)</fo:inline>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="link-short">
    <xsl:variable name="link"
		  select="key('def-link-index', @ref)" />
    <xsl:variable name="link-url">
      <xsl:value-of select="$link/@url" />
    </xsl:variable>
    <xsl:variable name="link-base">
      <xsl:value-of select="key('def-base-index', $link/@base)/." />
    </xsl:variable>
    <fo:inline text-decoration="underline">
    <xsl:attribute name="href">
      <xsl:value-of select="concat($link-base, $link-url)" />
    </xsl:attribute>
    <xsl:value-of select="key('def-link-index', @ref)" />
    <xsl:text>
 
</xsl:text>( 
    <xsl:value-of select="concat(key('def-base-index', @base), key('def-link-index', @ref)/@url)" />)</fo:inline>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="link-text">
    <xsl:variable name="link"
		  select="key('def-link-index', @ref)" />
    <xsl:variable name="link-url">
      <xsl:value-of select="$link/@url" />
    </xsl:variable>
    <xsl:variable name="link-base">
      <xsl:value-of select="key('def-base-index', $link/@base)/." />
    </xsl:variable>
    <fo:inline text-decoration="underline">
    <xsl:value-of select="key('def-link-index', @ref)" />
    <xsl:text>
 
</xsl:text>( 
    <xsl:value-of select="concat(key('def-base-index', @base), key('def-link-index', @ref)/@url)" />)</fo:inline>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="link-plain">
    <fo:inline text-decoration="underline">
      <xsl:value-of select="key('def-link-index', @ref)" />
    </fo:inline>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="b">
    <fo:inline font-weight="bold">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="i">
    <fo:inline font-style="italic">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="tt">
    <fo:inline font-family="'Courier, monospace'">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="ins">
    <!-- if draft: underine, green, else just text. FIX -->
    <fo:inline text-decoration="underline"
	       color="green">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="del">
    <!-- if draft: strike, red, else no output FIX -->
    <fo:inline text-decoration="line-through"
	       color="red">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="text()">
    <xsl:value-of select="." />
  </xsl:template>
</xsl:stylesheet>
