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
$Header: /repo/local.cvs/app/story-xml/src/story2/story-draft.xsl,v 1.14 2008/01/07 02:35:52 bruce Exp $
-->
  <xsl:output method="html"
	      indent="yes" />
  <!-- ************************************************** -->
  <xsl:param name="gDraft"
	     select="'1'" />
  <xsl:param name="gDebug"
	     select="'0'" />
  <xsl:include href="story-com.xsl" />
  <xsl:include href="story-com-html.xsl" />
  <!-- ************************************************** -->
  <xsl:template match="/content">
    <xsl:apply-templates select="site"
			 mode="draft" />
    <!--  <xsl:apply-templates select="page"/> -->
    <xsl:apply-templates select="book"
			 mode="draft" />
    <xsl:call-template name="output-list" />
  </xsl:template>
  <!-- ************************************************** -->
  <xsl:template name="output-list">
    <exsl:document method="text"
		   href="output-list.txt">
      <xsl:apply-templates select="site"
			   mode="output-list" />
      <xsl:apply-templates select="page"
			   mode="output-list" />
      <xsl:apply-templates select="book"
			   mode="output-list" />
      <xsl:call-template name="timeline-output-list" />
    </exsl:document>
  </xsl:template>
  <xsl:template match="site"
		mode="output-list">
    <xsl:value-of select="'site.html'" />
    <xsl:value-of select="$gNL" />
  </xsl:template>
  <xsl:template match="book"
		mode="output-list">
    <xsl:if test="contains($gBookStatus, concat(' book-', @status, ' '))">
      <xsl:value-of select="concat(@id, '-draft.html')" />
      <xsl:value-of select="$gNL" />
    </xsl:if>
  </xsl:template>
  <xsl:template name="timeline-output-list">
    <xsl:if test="boolean(number($gDraftRef/@timeline))">
      <xsl:value-of select="'timeline.html'" />
      <xsl:value-of select="$gNL" />
    </xsl:if>
  </xsl:template>
  <!-- ************************************************** -->
  <xsl:template match="site"
		mode="draft">
    <exsl:document method="html"
		   href="site.html">
      <html>
	<head>
	  <title>Site - Draft</title>
	</head>
	<xsl:copy-of select="$gHtmlStyle" />
	<body>
	  <h1>Site - Draft</h1>
	  <h2>style</h2>
	  <table border="1"
		 cellpadding="4"
		 cellspacing="0">
	    <tr align="left"
		valign="top">
	      <th>Name</th>
	      <th>Value</th>
	    </tr>
	    <tr>
	      <td>preview-thread</td>
	      <td>
		<xsl:value-of select="style/@preview-thread" />
	      </td>
	    </tr>
	    <tr>
	      <td>style-ref</td>
	      <td>
		<xsl:value-of select="style/@style-ref" />
	      </td>
	    </tr>
	  </table>
	  <h2>def-style</h2>
	  <table border="1"
		 cellpadding="4"
		 cellspacing="0">
	    <tr align="left"
		valign="top">
	      <th>id</th>
	      <th>print-ref</th>
	      <th>content-ref</th>
	      <th>draft-ref</th>
	      <th>draft</th>
	      <th>debug</th>
	    </tr>
	    <xsl:apply-templates select="def-style" />
	  </table>
	  <h2>def-print - common</h2>
	  <table border="1"
		 cellpadding="4"
		 cellspacing="0">
	    <tr align="left"
		valign="top">
	      <th>id</th>
	      <th>output- 
	      <br />type</th>
	      <th>copyright- 
	      <br />type</th>
	      <th>toc</th>
	      <th>body- 
	      <br />size</th>
	      <th>body- 
	      <br />family</th>
	      <th>head- 
	      <br />size</th>
	      <th>head- 
	      <br />family</th>
	      <th>title- 
	      <br />size</th>
	      <th>title- 
	      <br />family</th>
	      <th>ch- 
	      <br />title- 
	      <br />size</th>
	      <th>ch- 
	      <br />title- 
	      <br />family</th>
	      <th>line- 
	      <br />height</th>
	    </tr>
	    <xsl:apply-templates select="def-print"
				 mode="common" />
	  </table>
	  <h2>def-print - paper</h2>
	  <table border="1"
		 cellpadding="4"
		 cellspacing="0">
	    <tr align="left"
		valign="top">
	      <th>id</th>
	      <th>page</th>
	      <th>margin</th>
	      <th>gutter</th>
	      <th>bleed-left</th>
	      <th>bleed-right</th>
	      <th>bleed-top</th>
	      <th>bleed-bottom</th>
	      <th>duplex</th>
	      <th>header-type</th>
	    </tr>
	    <xsl:apply-templates select="def-print"
				 mode="paper" />
	  </table>
	  <h2>def-print - html</h2>
	  <table border="1"
		 cellpadding="4"
		 cellspacing="0">
	    <tr align="left"
		valign="top">
	      <th>id</th>
	      <th>ref</th>
	      <th>bgcolor</th>
	      <th>text</th>
	      <th>draft</th>
	      <th>link</th>
	      <th>vlink</th>
	      <th>alink</th>
	      <th>next-prev</th>
	    </tr>
	    <xsl:apply-templates select="def-print"
				 mode="html" />
	  </table>
	  <h2>def-content</h2>
	  <table border="1"
		 cellpadding="4"
		 cellspacing="0">
	    <tr align="left"
		valign="top">
	      <th></th>
	      <th colspan="3">page</th>
	      <th colspan="3">book</th>
	      <th colspan="3">chapter</th>
	      <th colspan="3">unit</th>
	      <th colspan="3">headings</th>
	      <th colspan="4">filter</th>
	    </tr>
	    <tr align="left"
		valign="top">
	      <th>id</th>
	      <th>dr</th>
	      <th>in</th>
	      <th>dn</th>
	      <th>dr</th>
	      <th>in</th>
	      <th>dn</th>
	      <th>dr</th>
	      <th>in</th>
	      <th>dn</th>
	      <th>dr</th>
	      <th>in</th>
	      <th>dn</th>
	      <th>ch-preface</th>
	      <th>preface</th>
	      <th>prolog</th>
	      <th>thread</th>
	      <th wrap="1">ch-list</th>
	      <th wrap="1">unit-list</th>
	      <th>link-fmt</th>
	    </tr>
	    <xsl:apply-templates select="def-content" />
	  </table>
	  <h2>def-draft</h2>
	  <table border="1"
		 cellpadding="4"
		 cellspacing="0">
	    <tr align="left"
		valign="top">
	      <th></th>
	      <th></th>
	      <th colspan="6">def-</th>
	      <th colspan="5">unit-</th>
	      <th colspan="5">thread-</th>
	    </tr>
	    <tr align="left"
		valign="top">
	      <th>id</th>
	      <th>timeline</th>
	      <th>base</th>
	      <th>img</th>
	      <th>link</th>
	      <th>who</th>
	      <th>where</th>
	      <th>thread</th>
	      <th>title</th>
	      <th>when</th>
	      <th>where</th>
	      <th>who</th>
	      <th>outline</th>
	      <th>content</th>
	      <th>all</th>
	      <th>ref</th>
	      <th>id-vp</th>
	      <th>all-vp</th>
	    </tr>
	    <xsl:apply-templates select="def-draft" />
	  </table>
	  <xsl:if test="boolean(number($gDraftRef/@def-base))">
	    <h2>def-base</h2>
	    <table border="1"
		   cellpadding="4"
		   cellspacing="0">
	      <tr align="left"
		  valign="top">
		<th>@id</th>
		<th>URL</th>
	      </tr>
	      <xsl:apply-templates select="def-base"
				   mode="draft" />
	    </table>
	  </xsl:if>
	  <xsl:if test="boolean(number($gDraftRef/@def-img))">
	    <h2>def-img</h2>
	    <table border="1"
		   cellpadding="4"
		   cellspacing="0">
	      <tr align="left"
		  valign="top">
		<th>@id</th>
		<th>@base</th>
		<th wrap="1">@url</th>
		<th wrap="1">alt</th>
	      </tr>
	      <xsl:apply-templates select="def-img"
				   mode="draft" />
	    </table>
	  </xsl:if>
	  <xsl:if test="boolean(number($gDraftRef/@def-link))">
	    <h2>def-link</h2>
	    <table border="1"
		   cellpadding="4"
		   cellspacing="0">
	      <tr align="left"
		  valign="top">
		<th>@id</th>
		<th>@base</th>
		<th wrap="1">@url</th>
		<th>@ref</th>
		<th wrap="1">title</th>
	      </tr>
	      <xsl:apply-templates select="def-link"
				   mode="draft" />
	    </table>
	  </xsl:if>
	</body>
      </html>
    </exsl:document>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-style">
    <tr align="left">
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td>
	<xsl:value-of select="@print-ref" />
      </td>
      <td>
	<xsl:value-of select="@content-ref" />
      </td>
      <td>
	<xsl:value-of select="@draft-ref" />
      </td>
      <td>
	<xsl:value-of select="@draft" />
      </td>
      <td>
	<xsl:value-of select="@debug" />
      </td>
    </tr>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-print"
		mode="common">
    <tr align="left">
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td>
	<xsl:value-of select="@output-type" />
      </td>
      <td>
	<xsl:value-of select="@copyright-type" />
      </td>
      <td>
	<xsl:value-of select="@toc" />
      </td>
      <td>
	<xsl:value-of select="@body-size" />
      </td>
      <td>
	<xsl:value-of select="@body-family" />
      </td>
      <td>
	<xsl:value-of select="@head-size" />
      </td>
      <td>
	<xsl:value-of select="@head-family" />
      </td>
      <td>
	<xsl:value-of select="@title-size" />
      </td>
      <td>
	<xsl:value-of select="@title-family" />
      </td>
      <td>
	<xsl:value-of select="@ch-title-size" />
      </td>
      <td>
	<xsl:value-of select="@ch-title-family" />
      </td>
      <td>
	<xsl:value-of select="@line-height" />
      </td>
    </tr>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-print"
		mode="paper">
    <tr align="left">
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td>
	<xsl:value-of select="@page" />
      </td>
      <td>
	<xsl:value-of select="@margin" />
      </td>
      <td>
	<xsl:value-of select="@gutter" />
      </td>
      <td>
	<xsl:value-of select="@bleed-left" />
      </td>
      <td>
	<xsl:value-of select="@bleed-right" />
      </td>
      <td>
	<xsl:value-of select="@bleed-top" />
      </td>
      <td>
	<xsl:value-of select="@bleed-bottom" />
      </td>
      <td>
	<xsl:value-of select="@duplex" />
      </td>
      <td>
	<xsl:value-of select="@header-type" />
      </td>
    </tr>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-print"
		mode="html">
    <tr align="left">
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td>
	<xsl:value-of select="@ref" />
      </td>
      <td>
	<xsl:value-of select="@bgcolor" />
      </td>
      <td>
	<xsl:value-of select="@text" />
      </td>
      <td>
	<xsl:value-of select="@draft" />
      </td>
      <td>
	<xsl:value-of select="@link" />
      </td>
      <td>
	<xsl:value-of select="@vlink" />
      </td>
      <td>
	<xsl:value-of select="@alink" />
      </td>
      <td>
	<xsl:value-of select="@next-prev" />
      </td>
    </tr>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-content">
    <tr align="center">
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td>
	<xsl:if test="@page-draft != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@page-in-progress != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@page-done != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@book-draft != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@book-in-progress != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@book-done != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@ch-draft != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@ch-in-progress != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@ch-done != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@unit-draft != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@unit-in-progress != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@unit-done != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@ch-preface != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@preface != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@prolog != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:value-of select="@thread" />
      </td>
      <td wrap="1">
	<xsl:value-of select="@ch-list" />
      </td>
      <td wrap="1">
	<xsl:value-of select="@unit-list" />
      </td>
      <td>
	<xsl:value-of select="@link-fmt" />
      </td>
    </tr>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-draft">
    <tr align="center">
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td>
	<xsl:if test="@def-base != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@def-img != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@def-link != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@def-who != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@def-where != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@def-thread != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@unit-title != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@unit-when != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@unit-where != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@unit-who != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@unit-outline != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@thread-content != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@thread-all != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@thread-ref != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@thread-id-vp != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@thread-all-vp != '0'">*</xsl:if>
      </td>
      <td>
	<xsl:if test="@timeline != '0'">*</xsl:if>
      </td>
    </tr>
  </xsl:template>
  <!-- ************************************************** -->
  <xsl:template match="book"
		mode="draft">
    <xsl:if test="contains($gBookStatus, concat(' book-', @status, ' '))">
      <exsl:document method="html"
		     href="{concat(@id,'-draft.html')}">
	<html>
	  <head>
	    <title>Draft - 
	    <xsl:value-of select="title" /></title>
	    <xsl:call-template name="meta-head" />
	    <xsl:copy-of select="$gHtmlStyle" />
	  </head>
	  <body>
	  <xsl:call-template name="body-attr" />
	  <h1>Draft - 
	  <xsl:value-of select="title" /></h1>By: 
	  <xsl:value-of select="author" />
	  <br />
	  <xsl:call-template name="show-draft">
	    <xsl:with-param name="pContent">email: 
	    <xsl:value-of select="email" />
	    <br />file-prefix: 
	    <xsl:value-of select="file-prefix" />
	    <br /></xsl:with-param>
	  </xsl:call-template>
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
	  <xsl:call-template name="show-draft">
	    <xsl:with-param name="pContent">
	      <table border="1"
		     cellpadding="4"
		     cellspacing="0">
		<tr>
		  <td>
		    <pre>
<xsl:call-template name="cvs-print" />
      
</pre>
		  </td>
		</tr>
	      </table>
	    </xsl:with-param>
	  </xsl:call-template>
	  <xsl:call-template name="toc" />
	  <xsl:if test="boolean(number($gContentRef/@ch-preface))">
	    <xsl:apply-templates select="ch-preface" />
	  </xsl:if>
	  <xsl:if test="boolean(number($gContentRef/@preface))">
	    <xsl:apply-templates select="preface" />
	  </xsl:if>
	  <xsl:if test="boolean(number($gDraftRef/@def-who))">
	    <xsl:call-template name="show-draft">
	      <xsl:with-param name="pContent">
		<h2>def-who</h2>
		<table border="1"
		       cellpadding="4"
		       cellspacing="0">
		  <tr align="left"
		      valign="top">
		    <th>@id</th>
		    <th wrap="1">Description</th>
		  </tr>
		  <xsl:apply-templates select="def-book/def-who"
				       mode="draft" />
		</table>
	      </xsl:with-param>
	    </xsl:call-template>
	  </xsl:if>
	  <xsl:if test="boolean(number($gDraftRef/@def-where))">
	    <xsl:call-template name="show-draft">
	      <xsl:with-param name="pContent">
		<h2>def-where</h2>
		<table border="1"
		       cellpadding="4"
		       cellspacing="0">
		  <tr align="left"
		      valign="top">
		    <th>@id</th>
		    <th wrap="1">Description</th>
		  </tr>
		  <xsl:apply-templates select="def-book/def-where"
				       mode="draft" />
		</table>
	      </xsl:with-param>
	    </xsl:call-template>
	  </xsl:if>
	  <xsl:if test="boolean(number($gDraftRef/@def-thread))">
	    <xsl:call-template name="show-draft">
	      <xsl:with-param name="pContent">
		<h2>def-thread</h2>
		<table border="1"
		       cellpadding="4"
		       cellspacing="0">
		  <tr align="left"
		      valign="top">
		    <th>@id</th>
		    <th wrap="1">Description</th>
		  </tr>
		  <xsl:apply-templates select="def-book/def-thread"
				       mode="draft" />
		</table>
	      </xsl:with-param>
	    </xsl:call-template>
	  </xsl:if>
	  <xsl:if test="boolean(number($gDraftRef/@timeline))">
	    <xsl:call-template name="timeline" />
	    <h2>
	      <a href="timeline.html">Timeline</a>
	    </h2>
	  </xsl:if>
	  <xsl:apply-templates select="chapter"
			       mode="draft" />
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
  <xsl:template name="toc">
    <hr />
    <h2>Contents</h2>
    <ul>
      <xsl:if test="boolean(number($gContentRef/@preface))">
	<xsl:apply-templates select="preface"
			     mode="toc" />
      </xsl:if>
      <xsl:if test="boolean(number($gDraftRef/@timeline))">
	<li>
	  <a href="timeline.html">Timeline</a>
	</li>
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
  <xsl:template match="def-base"
		mode="draft">
    <tr align="left"
	valign="top">
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td>
	<xsl:value-of select="." />
      </td>
    </tr>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-img"
		mode="draft">
    <tr align="left"
	valign="top">
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td>
	<xsl:value-of select="@base" />
      </td>
      <td wrap="1">
	<xsl:value-of select="@url" />
      </td>
      <td wrap="1">
	<xsl:value-of select="." />
      </td>
    </tr>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-link"
		mode="draft">
    <tr align="left"
	valign="top">
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td>
	<xsl:value-of select="@base" />
      </td>
      <td wrap="1">
	<xsl:value-of select="@url" />
      </td>
      <td>
	<xsl:value-of select="@ref" />
      </td>
      <td wrap="1">
	<xsl:value-of select="." />
      </td>
    </tr>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-who"
		mode="draft">
    <tr>
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td wrap="1">
	<xsl:apply-templates select="p|s|pre" />
      </td>
    </tr>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-where"
		mode="draft">
    <tr>
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td wrap="1">
	<xsl:apply-templates select="p|s|pre" />
      </td>
    </tr>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-thread"
		mode="draft">
    <tr>
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td wrap="1">
	<xsl:apply-templates select="p|s|pre" />
      </td>
    </tr>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="when"
		mode="draft">
    <tr>
      <td>
	<xsl:value-of select="start-date" />
      </td>
      <td>
	<xsl:if test="duration">
	  <xsl:value-of select="duration" />
	</xsl:if>
	<xsl:if test="enddate">
	  <xsl:value-of select="end-date" />
	</xsl:if>
      </td>
      <td wrap="1">
	<xsl:apply-templates select="description"
			     mode="draft" />
      </td>
    </tr>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="description"
		mode="draft">
    <xsl:apply-templates select="p|s|pre" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="where"
		mode="draft">
    <tr>
      <td>
	<xsl:value-of select="@ref" />
      </td>
      <td wrap="1">
	<xsl:apply-templates select="p|s|pre" />
      </td>
    </tr>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="who"
		mode="draft">
    <tr>
      <td>
	<xsl:value-of select="@ref" />
      </td>
      <td wrap="1">
	<xsl:apply-templates select="p|s|pre" />
      </td>
    </tr>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="outline"
		mode="draft">
    <xsl:if test="boolean(number($gDraftRef/@unit-when))">
      <xsl:call-template name="show-draft">
	<xsl:with-param name="pContent">
	  <h3>when</h3>
	  <table border="1"
		 cellpadding="4"
		 cellspacing="0">
	    <tr align="left"
		valign="top">
	      <th>start-date</th>
	      <th>end-date or 
	      <br />duration</th>
	      <th wrap="1">Description</th>
	    </tr>
	    <xsl:apply-templates select="outline/when"
				 mode="draft" />
	  </table>
	</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="boolean(number($gDraftRef/@unit-where))">
      <xsl:call-template name="show-draft">
	<xsl:with-param name="pContent">
	  <h3>where</h3>
	  <table border="1"
		 cellpadding="4"
		 cellspacing="0">
	    <tr align="left"
		valign="top">
	      <th>@ref</th>
	      <th wrap="1">Description</th>
	    </tr>
	    <xsl:apply-templates select="outline/where"
				 mode="draft" />
	  </table>
	</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:if test="boolean(number($gDraftRef/@unit-who))">
      <xsl:call-template name="show-draft">
	<xsl:with-param name="pContent">
	  <h3>who</h3>
	  <table border="1"
		 cellpadding="4"
		 cellspacing="0">
	    <tr align="left"
		valign="top">
	      <th>@ref</th>
	      <th wrap="1">Description</th>
	    </tr>
	    <xsl:apply-templates select="outline/who"
				 mode="draft" />
	  </table>
	</xsl:with-param>
      </xsl:call-template>
    </xsl:if>
    <xsl:call-template name="show-draft">
      <xsl:with-param name="pContent">
	<h3>outline</h3>
	<table border="1"
	       cellpadding="4"
	       cellspacing="0">
	  <tr>
	    <td wrap="1">
	      <xsl:apply-templates select="outline/description"
				   mode="draft" />
	    </td>
	  </tr>
	</table>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="chapter"
		mode="draft">
    <xsl:if test="contains($gChStatus, concat(' ch-', @status, ' ')) and (($gContentCh = '') or contains($gContentCh, concat(' ', @id, ' ')))">

      <xsl:call-template name="chapter-body-draft" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="chapter-body-draft">
    <hr />
    <a>
      <xsl:attribute name="name">ch- 
      <xsl:value-of select="@id" /></xsl:attribute>
    </a>
    <h2>
    <xsl:value-of select="ch-no" />. 
    <xsl:value-of select="title" /></h2>
    <xsl:if test="@staus != done">
      <p>
	<xsl:value-of select="@status" />
      </p>
    </xsl:if>
    <xsl:call-template name="show-draft">
      <xsl:with-param name="pContent">
	<table border="1"
	       cellpadding="4"
	       cellspacing="0">
	  <tr>
	    <td>
	      <pre>
<xsl:call-template name="cvs-print" />
      
</pre>
	    </td>
	  </tr>
	</table>
      </xsl:with-param>
    </xsl:call-template>
    <xsl:if test="boolean(number($gContentRef/@prolog))">
      <xsl:apply-templates select="prolog" />
    </xsl:if>
    <hr />
    <xsl:apply-templates select="unit"
			 mode="draft" />
    <xsl:if test="boolean(number($gContentRef/@prolog))">
      <xsl:apply-templates select="postlog" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="unit"
		mode="draft">
    <xsl:if test="contains($gUnitStatus, concat(' unit-', @status, ' ')) and (($gContentUnit = '') or contains($gContentUnit, concat(' ', @id, ' ')))">

      <xsl:if test="boolean(number($gDraftRef/@unit-title))">
	<xsl:call-template name="show-draft">
	  <xsl:with-param name="pContent">
	  <hr width="50%"
	      align="left" />
	  <h3>Unit: 
	  <xsl:value-of select="concat(' (', @id, ') ')" />
	  <xsl:value-of select="title" />
	  <xsl:text>
 - 
</xsl:text>n 
	  <xsl:value-of select="@type" /></h3>status= 
	  <xsl:value-of select="@status" />
	  <br /></xsl:with-param>
	</xsl:call-template>
      </xsl:if>
      <xsl:if test="boolean(number($gDraftRef/@unit-outline))">
	<xsl:call-template name="outline"
			   mode="draft" />
      </xsl:if>
      <p />
      <xsl:apply-templates select="thread"
			   mode="draft" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="thread"
		mode="draft">
    <xsl:if test="contains(concat(' ', @ref, ' '), $gContentThread)">
      <xsl:if test="boolean(number($gDraftRef/@thread-id-vp))">
	<xsl:call-template name="show-draft">
	  <xsl:with-param name="pContent">
	    <xsl:value-of select="concat('thread @ref=',@ref)" />
	    <xsl:text>
; 
</xsl:text>
	    <xsl:value-of select="concat('@vp=',@viewpoint)" />
	    <br />
	  </xsl:with-param>
	</xsl:call-template>
      </xsl:if>
      <xsl:if test="boolean(number($gDraftRef/@thread-content))">
	<xsl:apply-templates select="p|s|t|pre"
			     mode="draft" />
      </xsl:if>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="timeline">
    <exsl:document method="xml"
		   href="/tmp/timeline.xml">
      <timeline>
	<xsl:text></xsl:text>
	<xsl:apply-templates select="chapter"
			     mode="timeline" />
      </timeline>
    </exsl:document>
    <xsl:call-template name="fmt-timeline" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fmt-timeline">
    <exsl:document method="html"
		   href="timeline.html">
      <xsl:apply-templates select="document('/tmp/timeline.xml')" />
    </exsl:document>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="timeline">
    <html>
      <head>
	<title>Timeline</title>
      </head>
      <body>
      <h1>Timeline</h1>
      <h2>Filters</h2>
      <xsl:if test="$gContentCh != ''">Chapter List: 
      <xsl:value-of select="$gContentCh" />
      <br /></xsl:if>
      <xsl:if test="$gContentUnit != ''">Unit List: 
      <xsl:value-of select="$gContentUnit" />
      <br /></xsl:if>Thread: 
      <xsl:value-of select="$gContentThread" />
      <xsl:if test="boolean(number($gDraftRef/@thread-all-vp))">
	<xsl:text>
 (thread-all-vp)
</xsl:text>
      </xsl:if>
      <br />
      <xsl:if test="boolean(number($gContentRef/@ch-done))">
      ch-done</xsl:if>
      <xsl:if test="boolean(number($gContentRef/@ch-in-progress))">
      ch-in-progress</xsl:if>
      <xsl:if test="boolean(number($gContentRef/@ch-draft))">
      ch-draft</xsl:if>
      <br />
      <xsl:if test="boolean(number($gContentRef/@unit-done))">
      unit-done</xsl:if>
      <xsl:if test="boolean(number($gContentRef/@unit-in-progress))">
      unit-in-progress</xsl:if>
      <xsl:if test="boolean(number($gContentRef/@unit-draft))">
      unit-draft</xsl:if>
      <br />
      <h2>Units</h2>
      <table border="1"
	     cellpadding="4"
	     cellspacing="0">
	<tr align="left">
	  <th>Time</th>
	  <th>Ch</th>
	  <th>Unit</th>
	  <th></th>
	  <th>Type</th>
	  <th wrap="1">Title/Elapsed</th>
	  <th>Where</th>
	  <th wrap="1">Who</th>
	</tr>
	<xsl:for-each select="record">
	  <xsl:sort select="@date" />
	  <!-- <record date="" type=start|end>value</record> -->
	  <tr>
	    <td>
	      <xsl:value-of select="translate(@date, 'TZ', ' ')" />
	    </td>
	    <xsl:copy-of select="./*" />
	  </tr>
	</xsl:for-each>
      </table></body>
    </html>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="chapter"
		mode="timeline">
    <xsl:if test="contains($gChStatus, concat(' ch-', @status, ' ')) and (($gContentCh = '') or contains($gContentCh, concat(' ', @id, ' ')))">

      <xsl:apply-templates select="unit"
			   mode="timeline" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="unit"
		mode="timeline">
    <xsl:if test="contains($gUnitStatus, concat(' unit-', @status, ' ')) and (($gContentUnit = '') or contains($gContentUnit, concat(' ', @id, ' ')))">

      <!-- <record date="" type=start|end>value</record> -->
      <xsl:element name="record">
	<xsl:attribute name="date">
	  <xsl:value-of select="outline/when/start-date" />
	</xsl:attribute>
	<xsl:attribute name="type">
	  <xsl:text>
start
</xsl:text>
	</xsl:attribute>
	<td>
	  <xsl:value-of select="concat('C-', ../@id, ' ')" />
	</td>
	<td>
	  <xsl:value-of select="concat('U-', @id, ' ')" />
	</td>
	<td>
	  <xsl:value-of select="'begin'" />
	</td>
	<td>
	  <xsl:value-of select="@type" />
	</td>
	<td wrap="1">
	  <xsl:value-of select="title" />
	</td>
	<td>
	  <xsl:value-of select="outline/where/@ref" />
	</td>
	<td wrap="1">
	  <xsl:for-each select="outline/who">
	    <xsl:value-of select="concat(' ', @ref)" />
	  </xsl:for-each>
	</td>
      </xsl:element>
      <xsl:text></xsl:text>
      <xsl:element name="record">
	<xsl:attribute name="date">
	  <xsl:if test="outline/when/end-date">
	    <xsl:value-of select="outline/when/end-date" />
	  </xsl:if>
	  <xsl:if test="outline/when/duration">
	    <xsl:value-of select="date:add(outline/when/start-date, outline/when/duration)" />
	  </xsl:if>
	</xsl:attribute>
	<xsl:attribute name="type">
	  <xsl:text>
end
</xsl:text>
	</xsl:attribute>
	<td>
	  <xsl:value-of select="concat('C-', ../@id, ' ')" />
	</td>
	<td>
	  <xsl:value-of select="concat('U-', @id)" />
	</td>
	<td>
	  <xsl:value-of select="'end'" />
	</td>
	<td>
	  <xsl:value-of select="@type" />
	</td>
	<td>
	  <xsl:value-of select="'Elapsed: '" />
	  <xsl:if test="outline/when/duration">
	    <xsl:value-of select="translate(outline/when/duration, 'PTHYMDS', ' hymds')" />
	  </xsl:if>
	  <xsl:if test="outline/when/end-date">
	    <xsl:value-of select="translate(date:difference(outline/when/end-date, outline/when/start-date), 'PTHYMDS', ' hymds')" />
	  </xsl:if>
	  <xsl:text>
 
</xsl:text>
	</td>
      </xsl:element>
      <xsl:text></xsl:text>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="*"
		mode="draft">
    <xsl:call-template name="show-draft">
      <xsl:with-param name="pContent">
	<xsl:value-of select="." />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
