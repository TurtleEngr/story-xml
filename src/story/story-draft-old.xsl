<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
		exclude-result-prefixes="doc">
  <!--
$Header: /repo/local.cvs/app/story-xml/src/story3/story-draft-old.xsl,v 1.3 2008/02/19 06:44:15 bruce Exp $
-->
  <xsl:output method="html"
	      indent="yes" />
  <xsl:include href="story-com.xsl" />
  <xsl:include href="html/parameters.xsl" />
  <xsl:include href="html/blocks.xsl" />
  <xsl:include href="html/inlines.xsl" />
  <xsl:include href="html/lists.xsl" />
  <xsl:include href="html/simple-tables.xsl" />
  <xsl:include href="html/default-elements.xsl" />
  <xsl:template match="/content">
    <xsl:variable name="doc"
		  select="self::*" />
    <html>
      <head>
	<title>Site Draft</title>
      </head>
      <body>
	<xsl:attribute name="bgcolor">
	  <xsl:value-of select="site/style/@bgcolor" />
	</xsl:attribute>
	<xsl:attribute name="text">
	  <xsl:value-of select="site/style/@text" />
	</xsl:attribute>
	<xsl:attribute name="link">#0000FF</xsl:attribute>
	<xsl:attribute name="vlink">#840084</xsl:attribute>
	<xsl:attribute name="alink">#0000FF</xsl:attribute>
	<xsl:apply-templates select="site"
			     mode="draft" />
	<xsl:apply-templates select="page"
			     mode="draft" />
	<xsl:apply-templates select="book"
			     mode="draft" />
      </body>
    </html>
  </xsl:template>
  <xsl:template match="site"
		mode="draft">
    <h1>Site Draft</h1>
    <table border="3">
      <tr>
	<td wrap="1">
	  <xsl:call-template name="fCVSPprint"
			     mode="draft" />
	  <xsl:call-template name="fMetaPrint"
			     mode="draft" />
	</td>
      </tr>
    </table>
    <h2>def-img</h2>
    <table border="3">
      <tr>
	<th>id</th>
	<th>url</th>
	<th>alt</th>
      </tr>
      <xsl:apply-templates select="def-img"
			   mode="draft" />
    </table>
    <h2>def-link</h2>
    <table border="3">
      <tr>
	<th>id</th>
	<th>url</th>
	<th>ref</th>
	<th>title</th>
      </tr>
      <xsl:apply-templates select="def-link"
			   mode="draft" />
    </table>
  </xsl:template>
  <xsl:template match="def-img"
		mode="draft">
    <tr>
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td>
	<xsl:value-of select="@url" />
      </td>
      <td>
	<xsl:value-of select="." />
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="def-link"
		mode="draft">
    <tr>
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td>
	<xsl:value-of select="@url" />
      </td>
      <td>
	<xsl:value-of select="@ref" />
      </td>
      <td>
	<xsl:value-of select="." />
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="page"
		mode="draft">
  <hr />
  <h1>Pages</h1>
  <h2>
    <xsl:value-of select="title" />
  </h2>
  <table border="3">
    <tr>
      <td wrap="1">
	<xsl:call-template name="fCVSPprint"
			   mode="draft" />
	<xsl:call-template name="fMetaPrint"
			   mode="draft" />
      </td>
    </tr>
  </table>
  <xsl:apply-templates select="p|s|t|pre" />
  <xsl:apply-templates select="sect1" />
  <hr />Last updated: 
  <xsl:apply-templates select="cvs/@date" /></xsl:template>
  <xsl:template match="sect1">
    <h3>
      <xsl:value-of select="title" />
    </h3>
    <dl>
      <xsl:apply-templates select="item" />
    </dl>
  </xsl:template>
  <xsl:template match="item">
    <dt>* 
    <xsl:value-of select="title" /></dt>
    <dd>
      <xsl:apply-templates select="p|s|t|pre" />
    </dd>
  </xsl:template>
  <xsl:template match="book"
		mode="draft">
  <hr />
  <h1>Books</h1>
  <h2>
    <xsl:value-of select="title" />
  </h2>By: 
  <xsl:value-of select="author" />
  <br />
  <xsl:variable name="LastDate">
    <xsl:apply-templates select="cvs/@date" />
  </xsl:variable>
  <xsl:if test="substring(pub-date,1,4) = substring(cvs/@date,1,4)">
  Copyright 
  <xsl:value-of select="substring(pub-date,1,4)" />
  <br /></xsl:if>
  <xsl:if test="substring(pub-date,1,4) != substring(cvs/@date,1,4)">
  Copyright 
  <xsl:value-of select="substring(pub-date,1,4)" />- 
  <xsl:value-of select="substring($LastDate,1,4)" />
  <br /></xsl:if>
  <xsl:if test="edition != '1'">Edition: 
  <xsl:value-of select="edition" />
  <br /></xsl:if>
  <table border="3">
    <tr>
      <td wrap="1">
	<xsl:call-template name="fCVSPprint"
			   mode="draft" />
	<xsl:call-template name="fMetaPrint"
			   mode="draft" />
	<b>Edition:</b>
	<xsl:value-of select="edition" />
	<br />
	<b>EMail:</b>
	<xsl:value-of select="email" />
	<br />
	<b>Dir:</b>
	<xsl:value-of select="dir" />
	<br />
	<b>File Prefix:</b>
	<xsl:value-of select="file-prefix" />
	<br />
      </td>
    </tr>
  </table>
  <h2>def-who</h2>
  <table border="3">
    <tr>
      <th>id</th>
      <th>description</th>
    </tr>
    <xsl:apply-templates select="def-who"
			 mode="draft" />
  </table>
  <h2>def-where</h2>
  <table border="3">
    <tr>
      <th>id</th>
      <th>description</th>
    </tr>
    <xsl:apply-templates select="def-where"
			 mode="draft" />
  </table>
  <h2>def-tread</h2>
  <table border="3">
    <tr>
      <th>id</th>
      <th>default</th>
      <th>start-unit</th>
      <th>description</th>
    </tr>
    <xsl:apply-templates select="def-thread"
			 mode="draft" />
  </table>
  <xsl:apply-templates select="preface" />
  <hr />
  <xsl:apply-templates select="chapter" />
  <hr />
  <xsl:apply-templates select="epilog" />
  <hr />URL: 
  <xsl:value-of select="url" />
  <br />Last updated: 
  <xsl:apply-templates select="cvs/@date" /></xsl:template>
  <xsl:template match="def-who|def-where"
		mode="draft">
    <tr>
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td wrap="1">
	<xsl:apply-templates select="p|s|t|pre" />
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="def-thread"
		mode="draft">
    <tr>
      <td>
	<xsl:value-of select="@id" />
      </td>
      <td>
	<xsl:value-of select="@default" />
      </td>
      <td>
	<xsl:value-of select="@start-unit" />
      </td>
      <td wrap="1">
	<xsl:apply-templates select="p|s|t|pre" />
      </td>
    </tr>
  </xsl:template>
  <xsl:template match="preface|epilog|ch-preface|prolog|postlog">
    <xsl:choose>
      <xsl:when test="name() = 'preface'">
	<h3>Preface</h3>
      </xsl:when>
      <xsl:when test="name() = 'epilog'">
	<h3>Epilog</h3>
      </xsl:when>
      <xsl:when test="name() = 'ch-preface'">
	<h3>Preface</h3>
      </xsl:when>
      <xsl:when test="name() = 'prolog'">
	<h3>Prolog</h3>
      </xsl:when>
      <xsl:when test="name() = 'postlog'">
	<h3>Postlog</h3>
      </xsl:when>
    </xsl:choose>
    <xsl:apply-templates select="p|s|t|pre" />
  </xsl:template>
  <xsl:template match="chapter">
  <h3>
  <xsl:value-of select="ch-no" />. 
  <xsl:value-of select="title" /></h3>
  <table border="3">
    <tr>
      <td wrap="1">
	<xsl:call-template name="fCVSPprint"
			   mode="draft" />
      </td>
    </tr>
  </table>
  <xsl:apply-templates select="prolog" />
  <hr />
  <xsl:apply-templates select="unit" />
  <hr />
  <xsl:apply-templates select="postlog" />
  <hr />Last updated: 
  <xsl:apply-templates select="cvs/@date" /></xsl:template>
  <xsl:template match="unit">
    <table border="3">
      <tr>
	<td wrap="1">
	  <b>Unit: 
	  <xsl:value-of select="@id" />; 
	  <xsl:value-of select="@type" />; 
	  <xsl:value-of select="title" />( 
	  <xsl:value-of select="@status" />)</b>
	</td>
      </tr>
    </table>
    <xsl:apply-templates select="thread" />
  </xsl:template>
  <xsl:template match="thread">
    <table border="3">
      <tr>
	<td wrap="1">Tread ref: 
	<xsl:value-of select="@ref" />; viewpoint: 
	<xsl:value-of select="@viewpoint" /></td>
      </tr>
    </table>
    <xsl:apply-templates select="p|s|t|pre" />
  </xsl:template>
  <xsl:template name="fCVSPprint"
		mode="draft">
    <b>Date:</b>
    <xsl:apply-templates select="cvs/@date" />
    <br />
    <b>Pub-Date:</b>
    <xsl:value-of select="pub-date" />
    <br />
    <b>Revision:</b>
    <xsl:apply-templates select="cvs/@rev" />
    <br />
    <b>Source:</b>
    <xsl:apply-templates select="cvs/@source" />
    <br />
    <b>Root:</b>
    <xsl:apply-templates select="cvs/@root" />
    <br />
    <b>Repository:</b>
    <xsl:apply-templates select="cvs/@repository" />
    <br />
    <b>File:</b>
    <xsl:apply-templates select="cvs/@file" />
    <br />
  </xsl:template>
  <xsl:template match="cvs/@date">
    <xsl:value-of select="substring(substring-before(substring-after(., '$'), ' $'), 7, 10)" />
  </xsl:template>
  <xsl:template match="cvs/@rev">
    <xsl:value-of select="substring(substring-before(substring-after(., '$'), ' $'), 11, 256)" />
  </xsl:template>
  <xsl:template match="cvs/@source">
    <xsl:value-of select="substring(substring-before(substring-after(., '$'), ' $'), 9, 256)" />
  </xsl:template>
  <xsl:template match="cvs/@root">
    <xsl:value-of select="." />
  </xsl:template>
  <xsl:template match="cvs/@repository">
    <xsl:value-of select="." />
  </xsl:template>
  <xsl:template match="cvs/@file">
    <xsl:value-of select="." />
  </xsl:template>
  <xsl:template name="fMetaPrint"
		mode="draft">
    <b>meta-description:</b>
    <xsl:apply-templates select="meta-description"
			 mode="draft" />
    <br />
    <b>meta-keywords:</b>
    <xsl:apply-templates select="meta-keywords"
			 mode="draft" />
    <br />
  </xsl:template>
  <xsl:template match="*"
		mode="draft">
    <xsl:value-of select="." />
  </xsl:template>
  <xsl:template match="text()">
    <xsl:value-of select="." />
  </xsl:template>
  <xsl:param name="nbsp">
    <xsl:text>
&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
</xsl:text>
  </xsl:param>
  <xsl:template match="s|t">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="padding"
		      select="'0pt'" />
      <xsl:with-param name="start-indent"
		      select="'0pt'" />
      <xsl:with-param name="end-indent"
		      select="'0pt'" />
      <xsl:with-param name="content">
	<xsl:value-of select="$nbsp" />
	<xsl:apply-templates />
	<br />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
