<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
		exclude-result-prefixes="doc"
		xmlns:exsl="http://exslt.org/common"
		extension-element-prefixes="exsl">
  <!--
$Header: /repo/local.cvs/app/story-xml/src/story3/story-ch-html.xsl,v 1.3 2008/02/19 06:44:15 bruce Exp $
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
    <xsl:if test="boolean(number($gContentRef/@preface)) and boolean(book/preface)">

      <xsl:apply-templates select="book/preface"
			   mode="ch" />
    </xsl:if>
    <xsl:apply-templates select="book/chapter" />
    <xsl:if test="boolean(number($gContentRef/@preface)) and boolean(book/epilog)">

      <xsl:apply-templates select="book/epilog"
			   mode="ch" />
    </xsl:if>
    <xsl:call-template name="fOutputList" />
  </xsl:template>
  <!-- ************************************************** -->
  <xsl:template name="fOutputList">
    <exsl:document method="text"
		   href="output-list.txt">
      <xsl:apply-templates select="page"
			   mode="output-list" />
      <xsl:apply-templates select="book"
			   mode="output-list" />
      <xsl:if test="boolean(number($gContentRef/@preface)) and boolean(book/preface)">

	<xsl:apply-templates select="book/preface"
			     mode="output-list" />
      </xsl:if>
      <xsl:apply-templates select="book/chapter"
			   mode="output-list" />
      <xsl:if test="boolean(number($gContentRef/@preface)) and boolean(book/preface)">

	<xsl:apply-templates select="book/epilog"
			     mode="output-list" />
      </xsl:if>
    </exsl:document>
  </xsl:template>
  <xsl:template match="book"
		mode="output-list">
    <xsl:if test="contains($gBookStatus, concat(' book-', @status, ' '))">
      <xsl:value-of select="concat(@id, '-ch.html')" />
      <xsl:value-of select="$gNL" />
    </xsl:if>
  </xsl:template>
  <xsl:template match="preface"
		mode="output-list">
    <xsl:value-of select="concat(../@id, '-ch-pre.html')" />
    <xsl:value-of select="$gNL" />
  </xsl:template>
  <xsl:template match="epilog"
		mode="output-list">
    <xsl:value-of select="concat(../@id, '-ch-epi.html')" />
    <xsl:value-of select="$gNL" />
  </xsl:template>
  <xsl:template match="chapter"
		mode="output-list">
    <xsl:if test="contains($gChStatus, concat(' ch-', @status, ' ')) and (($gContentCh = '') or contains($gContentCh, concat(' ', @id, ' ')))">

      <xsl:value-of select="concat(../@id, '-ch-', ch-no, '.html')" />
      <xsl:value-of select="$gNL" />
    </xsl:if>
  </xsl:template>
  <!-- ************************************************** -->
  <xsl:template match="site"></xsl:template>
  <!-- ************************************************** -->
  <xsl:template match="book">
    <xsl:if test="contains($gBookStatus, concat(' book-', @status, ' '))">
      <exsl:document method="html"
		     href="{concat(@id, '-ch.html')}">
	<html>
	  <head>
	    <title>
	      <xsl:value-of select="title" />
	    </title>
	    <xsl:call-template name="fMetaHead" />
	  </head>
	  <body>
	  <xsl:call-template name="fBodyAttr" />
	  <xsl:if test="$gDebug != 0">
	    <xsl:message>
	      <xsl:value-of select="concat('content-style=', $gContentStyle,' x')" />
	    </xsl:message>
	  </xsl:if>
	  <xsl:call-template name="fBookHeader">
	    <xsl:with-param name="pBook"
			    select="." />
	  </xsl:call-template>
	  <xsl:comment>
	    <xsl:call-template name="fCVSPprint" />
	  </xsl:comment>
	  <xsl:if test="boolean(number($gContentRef/@ch-preface))">
	    <xsl:apply-templates select="ch-preface" />
	  </xsl:if>
	  <xsl:call-template name="fToc" />
	  <hr />Last updated: 
	  <xsl:apply-templates select="cvs/@date" /></body>
	</html>
      </exsl:document>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fBookHeader">
  <xsl:param name="pBook" />
  <h1>
    <xsl:value-of select="$pBook/title" />
  </h1>By: 
  <xsl:value-of select="$pBook/author" />
  <br />
  <xsl:variable name="LastDate">
    <xsl:apply-templates select="$pBook/cvs/@date" />
  </xsl:variable>
  <xsl:if test="substring($pBook/pub-date,1,4) = substring($LastDate,1,4)">
  Copyright 
  <xsl:value-of select="substring($pBook/pub-date,1,4)" />
  <br /></xsl:if>
  <xsl:if test="substring($pBook/pub-date,1,4) != substring($LastDate,1,4)">
  Copyright 
  <xsl:value-of select="substring($pBook/pub-date,1,4)" />- 
  <xsl:value-of select="substring($LastDate,1,4)" />
  <br /></xsl:if>
  <xsl:if test="$pBook/edition != '1'">Edition: 
  <xsl:value-of select="$pBook/edition" />
  <br /></xsl:if>
  <xsl:if test="$pBook/@status = 'in-progress'">In progress 
  <br /></xsl:if>
  <xsl:if test="$pBook/@status = 'draft'">Draft 
  <br /></xsl:if></xsl:template>
  <!-- ******************** -->
  <xsl:template match="preface"
		mode="ch">
    <exsl:document method="html"
		   href="{concat(../@id, '-ch-pre.html')}">
      <html>
	<head>
	  <title>
	  <xsl:value-of select="../title" />- 
	  <xsl:apply-templates select="title"
			       mode="preface" /></title>
	</head>
	<body>
	  <xsl:call-template name="fBodyAttr" />
	  <xsl:call-template name="fBookHeader">
	    <xsl:with-param name="pBook"
			    select=".." />
	  </xsl:call-template>
	  <h2>
	    <xsl:apply-templates select="title"
				 mode="preface" />
	  </h2>
	  <xsl:apply-templates select="p|s|pre" />
	  <xsl:call-template name="fChapterFooter" />
	</body>
      </html>
    </exsl:document>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="epilog"
		mode="ch">
    <exsl:document method="html"
		   href="{concat(../@id, '-ch-epi.html')}">
      <html>
	<head>
	  <title>
	  <xsl:value-of select="../title" />- 
	  <xsl:apply-templates select="title"
			       mode="epilog" /></title>
	</head>
	<body>
	  <xsl:call-template name="fBodyAttr" />
	  <xsl:call-template name="fBookHeader">
	    <xsl:with-param name="pBook"
			    select=".." />
	  </xsl:call-template>
	  <h2>
	    <xsl:apply-templates select="title"
				 mode="epilog" />
	  </h2>
	  <xsl:apply-templates select="p|s|pre" />
	  <xsl:call-template name="fChapterFooter" />
	</body>
      </html>
    </exsl:document>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fToc">
    <hr />
    <h2>Table of Contents</h2>
    <ul>
      <xsl:if test="boolean(number($gContentRef/@preface)) and boolean(preface)">

	<li>
	  <a href="{concat(@id, '-ch-pre.html')}">
	    <xsl:apply-templates select="preface/title"
				 mode="preface" />
	  </a>
	</li>
      </xsl:if>
      <xsl:apply-templates select="chapter"
			   mode="toc" />
      <xsl:if test="boolean(number($gContentRef/@preface)) and boolean(epilog)">

	<li>
	  <a href="{concat(@id, '-ch-epi.html')}">
	    <xsl:apply-templates select="epilog/title"
				 mode="epilog" />
	  </a>
	</li>
      </xsl:if>
    </ul>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="chapter"
		mode="toc">
    <xsl:if test="contains($gChStatus, concat(' ch-', @status, ' ')) and (($gContentCh = '') or contains($gContentCh, concat(' ', @id, ' ')))">

      <li>
      <a>
      <xsl:attribute name="href">
	<xsl:value-of select="concat(../@id, '-ch-', ch-no, '.html')" />
      </xsl:attribute>
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

      <exsl:document method="html"
		     href="{concat(../@id, '-ch-', ch-no, '.html')}">
	<html>
	  <head>
	    <title>
	    <xsl:value-of select="../title" />- 
	    <xsl:value-of select="title" /></title>
	  </head>
	  <body>
	    <xsl:call-template name="fBodyAttr" />
	    <xsl:call-template name="fBookHeader">
	      <xsl:with-param name="pBook"
			      select=".." />
	    </xsl:call-template>
	    <xsl:if test="boolean(number($gContentRef/@ch-preface))">
	      <xsl:apply-templates select="../ch-preface" />
	    </xsl:if>
	    <xsl:call-template name="fChapterBody" />
	    <xsl:call-template name="fChapterFooter" />
	  </body>
	</html>
      </exsl:document>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fChapterFooter">
    <hr />
    <p>
      <a>
      <xsl:attribute name="href">
	<xsl:value-of select="concat(../@id, '-ch.html')" />
      </xsl:attribute>
      <!--  <img src="image/folder.png" alt="Table of Contents" border="0"/> -->
      Table of Contents</a>
    </p>
    <!--
More work needed.  Next and Prev, need to look back and forward for
next "printable" chapter.
-->
    <!--
<hr/>
<table width="100%">
  <tr>
  <td width="33%" alig="left">
<xsl:if test="position() != '1'">
    <a>
    <xsl:attribute name="href">
      <xsl:value-of select="concat(../@id, '-ch-',  preceding-sibling::*[1]/ch-no, '.html')"/>
    </xsl:attribute>
    <img src="image/left.png" alt="Previous" border="0"/>Previous
    </a>
</xsl:if>
  </td>
  <td width="33%" align="center">
    <a>
    <xsl:attribute name="href">
      <xsl:value-of select="concat(../@id, '-ch.html')"/>
    </xsl:attribute>
    <img src="image/folder.png" alt="Table of Contents" border="0"/>
    Table of Contents
    </a>
  </td>
  <td width="33%" align="right">
<xsl:if test="position() != last()">
    <a>
    <xsl:attribute name="href">
      <xsl:value-of select="concat(../@id, '-ch-',  following-sibling::*[1]/ch-no, '.html')"/>
    </xsl:attribute>
    Next<img src="image/right.png" alt="Next" border="0"/>
    </a>
</xsl:if>
  </td>
  </tr>
</table>
-->
    <hr />
    <xsl:if test="boolean(cvs)">
      <p>Last updated: 
      <xsl:apply-templates select="cvs/@date" /></p>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
