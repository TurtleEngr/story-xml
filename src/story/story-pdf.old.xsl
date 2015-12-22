<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
		exclude-result-prefixes="doc"
		xmlns:exsl="http://exslt.org/common"
		xmlns:str="http://exslt.org/strings"
		xmlns:date="http://exslt.org/dates-and-times"
		extension-element-prefixes="date doc exsl str">
  <!--
$Header: /repo/local.cvs/app/story-xml/src/story4/story-pdf.old.xsl,v 1.1 2008/02/24 21:38:26 bruce Exp $
-->
  <!-- ************************************************** -->
  <xsl:import href="fo/fo.xsl" />
  <xsl:output method="html"
	      indent="yes" />
  <xsl:param name="gDraft"
	     select="'0'" />
  <xsl:param name="gDebug"
	     select="'0'" />
  <xsl:strip-space elements="*" />
  <xsl:preserve-space elements="pre" />
  <!-- ************************************************** -->
  <xsl:key name="content-index"
	   match="def-content"
	   use="@id" />
  <xsl:key name="page-index"
	   match="page"
	   use="@id" />
  <xsl:key name="book-index"
	   match="book"
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
  <!-- ******************** -->
  <xsl:param name="gSpace">
    <xsl:text>
&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;
</xsl:text>
  </xsl:param>
  <!-- ******************** -->
  <xsl:param name="gDraftColor">
    <xsl:value-of select="/content/site/html-style/@draft" />
  </xsl:param>
  <!-- ******************** -->
  <!--
The content style can be selected by defining this external parameter.
If it is not defined, then the story's
/content/site/content-style/@ref will be used.
-->
  <xsl:param name="gSetContentStyle"
	     select="''" />
  <xsl:param name="gContentStyleName">
    <xsl:choose>
      <xsl:when test="$gSetContentStyle = ''">
	<xsl:value-of select="/content/site/content-style/@ref" />
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$gSetContentStyle" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <!-- ******************** -->
  <xsl:param name="gContentStyle">
    <xsl:variable name="fmt"
		  select="key('content-index', $gContentStyleName)" />
    <!--
  <xsl:if test="$gDebug != 0">
    <xsl:message>
    <xsl:value-of select="concat('fmt/@ch-preface=', $fmt/@ch-preface, '; ')"/>
    <xsl:value-of select="concat('ref=', $gContentStyleName)"/>
    </xsl:message>
  </xsl:if>
-->
    <xsl:if test="$fmt/@ch-preface != 'no'">
      <xsl:value-of select="' ch-preface'" />
    </xsl:if>
    <xsl:if test="$fmt/@preface != 'no'">
      <xsl:value-of select="' preface'" />
    </xsl:if>
    <xsl:if test="$fmt/@prolog != 'no'">
      <xsl:value-of select="' prolog'" />
    </xsl:if>
    <xsl:if test="$fmt/@page-done != 'no'">
      <xsl:value-of select="' page-done'" />
    </xsl:if>
    <xsl:if test="$fmt/@page-draft != 'no'">
      <xsl:value-of select="' page-draft'" />
    </xsl:if>
    <xsl:if test="$fmt/@page-in-progress != 'no'">
      <xsl:value-of select="' page-in-progress'" />
    </xsl:if>
    <xsl:if test="$fmt/@book-done != 'no'">
      <xsl:value-of select="' book-done'" />
    </xsl:if>
    <xsl:if test="$fmt/@book-draft != 'no'">
      <xsl:value-of select="' book-draft'" />
    </xsl:if>
    <xsl:if test="$fmt/@book-in-progress != 'no'">
      <xsl:value-of select="' book-in-progress'" />
    </xsl:if>
    <xsl:if test="$fmt/@ch-done != 'no'">
      <xsl:value-of select="' ch-done'" />
    </xsl:if>
    <xsl:if test="$fmt/@ch-draft != 'no'">
      <xsl:value-of select="' ch-draft'" />
    </xsl:if>
    <xsl:if test="$fmt/@ch-in-progress != 'no'">
      <xsl:value-of select="' ch-in-progress'" />
    </xsl:if>
    <xsl:if test="$fmt/@unit-done != 'no'">
      <xsl:value-of select="' unit-done'" />
    </xsl:if>
    <xsl:if test="$fmt/@unit-draft != 'no'">
      <xsl:value-of select="' unit-draft'" />
    </xsl:if>
    <xsl:if test="$fmt/@unit-in-progress != 'no'">
      <xsl:value-of select="' unit-in-progress'" />
    </xsl:if>
    <!-- Draft content flags -->
    <xsl:if test="$fmt/@def-base != 'no'">
      <xsl:value-of select="' def-base'" />
    </xsl:if>
    <xsl:if test="$fmt/@def-img != 'no'">
      <xsl:value-of select="' def-img'" />
    </xsl:if>
    <xsl:if test="$fmt/@def-link != 'no'">
      <xsl:value-of select="' def-link'" />
    </xsl:if>
    <xsl:if test="$fmt/@def-who != 'no'">
      <xsl:value-of select="' def-who'" />
    </xsl:if>
    <xsl:if test="$fmt/@def-where != 'no'">
      <xsl:value-of select="' def-where'" />
    </xsl:if>
    <xsl:if test="$fmt/@def-thread != 'no'">
      <xsl:value-of select="' def-thread'" />
    </xsl:if>
    <xsl:if test="$fmt/@unit-title != 'no'">
      <xsl:value-of select="' unit-title'" />
    </xsl:if>
    <xsl:if test="$fmt/@unit-when != 'no'">
      <xsl:value-of select="' unit-when'" />
    </xsl:if>
    <xsl:if test="$fmt/@unit-where != 'no'">
      <xsl:value-of select="' unit-where'" />
    </xsl:if>
    <xsl:if test="$fmt/@unit-who != 'no'">
      <xsl:value-of select="' unit-who'" />
    </xsl:if>
    <xsl:if test="$fmt/@unit-outline != 'no'">
      <xsl:value-of select="' unit-outline'" />
    </xsl:if>
    <xsl:if test="$fmt/@thread-content != 'no'">
      <xsl:value-of select="' thread-content'" />
    </xsl:if>
    <xsl:if test="$fmt/@thread-ref != 'no'">
      <xsl:value-of select="' thread-ref'" />
    </xsl:if>
    <xsl:if test="$fmt/@thread-id-vp != 'no'">
      <xsl:value-of select="' thread-id-vp'" />
    </xsl:if>
    <xsl:if test="$fmt/@thread-all-vp != 'no'">
      <xsl:value-of select="' thread-all-vp'" />
    </xsl:if>
    <xsl:if test="$fmt/@ttimeline != 'no'">
      <xsl:value-of select="' timeline'" />
    </xsl:if>
    <xsl:value-of select="' '" />
  </xsl:param>
  <xsl:param name="gContentThread">
    <xsl:variable name="fmt"
		  select="key('content-index', $gContentStyleName)" />
    <xsl:text>
 
</xsl:text>
    <xsl:value-of select="$fmt/@thread" />
    <xsl:text>
 
</xsl:text>
  </xsl:param>
  <xsl:param name="gContentLink">
    <xsl:variable name="fmt"
		  select="key('content-index', $gContentStyleName)" />
    <xsl:value-of select="$fmt/@link-fmt" />
  </xsl:param>
  <xsl:param name="gContentCh">
    <xsl:variable name="fmt"
		  select="key('content-index', $gContentStyleName)" />
    <xsl:if test="$fmt/@ch-list != ''">
      <xsl:text>
 
</xsl:text>
      <xsl:value-of select="$fmt/@ch-list" />
      <xsl:text>
 
</xsl:text>
    </xsl:if>
  </xsl:param>
  <xsl:param name="gContentUnit">
    <xsl:variable name="fmt"
		  select="key('content-index', $gContentStyleName)" />
    <xsl:if test="$fmt/@unit-list != ''">
      <xsl:text>
 
</xsl:text>
      <xsl:value-of select="$fmt/@unit-list" />
      <xsl:text>
 
</xsl:text>
    </xsl:if>
  </xsl:param>
  <!-- ************************************************** -->
  <xsl:template match="/content">
    <xsl:apply-templates select="site" />
    <xsl:apply-templates select="page" />
    <!--
  <xsl:apply-templates select="book"/>
-->
  </xsl:template>
  <!-- ************************************************** -->
  <xsl:template match="site"></xsl:template>
  <!-- ************************************************** -->
  <xsl:template match="page">
    <xsl:if test="contains($gContentStyle, concat(' page-', @status, ' '))">

      <!--
  <exsl:document method="xml" href="{concat(@id,'.pdf.xml')}">
-->
      <xsl:choose>
	<xsl:when test="$gDraft = '1'">
	  <xsl:call-template name="h1">
	    <xsl:with-param name="content">Draft - 
	    <xsl:value-of select="title" /></xsl:with-param>
	  </xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
	  <xsl:call-template name="h1">
	    <xsl:with-param name="content">
	      <xsl:value-of select="title" />
	    </xsl:with-param>
	  </xsl:call-template>
	</xsl:otherwise>
      </xsl:choose>
      <xsl:if test="@staus != done">
	<xsl:call-template name="para">
	  <xsl:with-param name="content">
	    <xsl:value-of select="@status" />
	  </xsl:with-param>
	</xsl:call-template>
      </xsl:if>
      <!--
    <xsl:comment>
      <xsl:call-template name="fCVSPprint"/>
    </xsl:comment>
-->
      <xsl:apply-templates select="p|s|pre"
			   mode="pdf" />
      <xsl:apply-templates select="sect1" />
      <xsl:call-template name="para">
	<xsl:with-param name="content">
	  <xsl:text>
_________________________________________________
</xsl:text>
	</xsl:with-param>
      </xsl:call-template>
      <xsl:call-template name="para">
	<xsl:with-param name="content">Last updated: 
	<xsl:apply-templates select="cvs/@date" /></xsl:with-param>
      </xsl:call-template>
      <!--
  </exsl:document>
-->
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="sect1">
    <xsl:call-template name="h2">
      <xsl:with-param name="content">
	<xsl:value-of select="title" />
      </xsl:with-param>
    </xsl:call-template>
    <xsl:text>
in sect1, before items
</xsl:text>
    <!--
  <xsl:call-template name="ul"/>
-->
    <xsl:apply-templates select="item/title" />
    <xsl:text>
in sect1, after items
</xsl:text>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="item/title">
    <xsl:call-template name="ul-li" />
    <!--
    <xsl:with-param name="content">
      <xsl:call-template name="br"/>
      <xsl:apply-templates select="p|s|pre" mode="pdf"/>
    </xsl:with-param>
  </xsl:call-template>
-->
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="title"></xsl:template>
  <!-- ******************** -->
  <xsl:template match="p"
		mode="pdf">
    <xsl:call-template name="para" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="pre"
		mode="pdf">
    <xsl:call-template name="pre" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="s|t"
		mode="pdf">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="padding"
		      select="'0pt'" />
      <xsl:with-param name="start-indent"
		      select="'0pt'" />
      <xsl:with-param name="end-indent"
		      select="'0pt'" />
      <xsl:with-param name="content">
	<xsl:text>
_____
</xsl:text>
	<xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ********************************************************************
Inline
 -->
  <!-- ****************************** -->
  <xsl:template match="b">
    <xsl:call-template name="bold.inline" />
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="i">
    <xsl:call-template name="italic.inline" />
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="tt">
    <xsl:call-template name="monospace.inline" />
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="link">
    <xsl:call-template name="italic.inline">
      <xsl:with-param name="content">
	<xsl:text>
[link ref: 
</xsl:text>
	<xsl:value-of select="@ref" />
	<xsl:if test="@img = 'yes'">
	  <xsl:text>
; img
</xsl:text>
	</xsl:if>
	<xsl:if test="@title = 'yes' or (. = '' and @img != 'yes' and @url != 'yes')">

	  <xsl:text>
; title
</xsl:text>
	</xsl:if>
	<xsl:if test="@url = 'yes'">
	  <xsl:text>
; url
</xsl:text>
	</xsl:if>
	<xsl:text>
] 
</xsl:text>
	<xsl:if test=". != ''">
	  <xsl:value-of select="." />
	</xsl:if>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
