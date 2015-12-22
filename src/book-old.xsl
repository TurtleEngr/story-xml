<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:date="http://exslt.org/dates-and-times"
xmlns:exsl="http://exslt.org/common"
extension-element-prefixes="date exsl"
>
<!--
$Header: /repo/local.cvs/app/story-xml/old/src/book-old.xsl,v 1.1 2006/02/19 00:18:13 bruce Exp $

Options:

layout, -l
	standalone chapter files (series, repeat ch-preface)
	indexed chapter files (web site, preface)
	all one file (web site, preface)
	manuscript (title, author, just text
thread, -t
	thread id (or next if none)
author toggle, -a
	none
	prolog, postlog
notes filter list, -n
	none
	all
	title
	www: when, where, who
	outline
	show ids
	only show ids
format, -f
	html
	text (still html?, but links are shown)
text, -t
	none
	last
	all
	draft id
-->

  <xsl:output method="html" indent="yes"/>
  <!-- <xsl:strip-space elements="*"/> -->
  <xsl:key name="link-index" match="deflink" use="@id"/>
  <xsl:key name="defwho-index" match="defwho" use="@id"/>
  <xsl:key name="defwhere-index" match="defwhere" use="@id"/>
  <xsl:key name="defdraft-index" match="def" use="@id"/>
  <xsl:key name="defthread-index" match="def" use="@id"/>
  <xsl:key name="ss-index" match="scene|sequel" use="@id"/>
  <xsl:key name="chapter-index" match="chapter" use="@id"/>

  <xsl:param name="gStyle" select="'text'"/>
  <xsl:param name="gThread" select="'main'"/>
  <xsl:param name="gView" select="'outline'"/>

  <xsl:template match="book">
    <exsl:document method="html" href="index.html">
    <html>
      <head>
        <title>
          <xsl:value-of select="title"/>
        </title>
        <!-- <xsl:call-template name="fFmtCss"/> -->
      </head>
      <body bgcolor="#eeeeff" text="#000000"
background="http://www.brian618.dynu.com/icons/paper-b618-b1-ch1-web.gif">
        <h1>
          <xsl:value-of select="title"/>
        </h1>

	<xsl:value-of disable-output-escaping="yes" select="'&lt;p>&amp;copy; Copyright '"/>
	<xsl:value-of select="copyright"/><xsl:value-of select="' - '"/>
	<xsl:value-of select="string(date:year())"/>
	<xsl:call-template name="fLink">
	  <xsl:with-param name="url">
	    mailto:<xsl:value-of select="email"/>
	  </xsl:with-param>
	  <xsl:with-param name="text">
	    <xsl:value-of select="author"/>
	  </xsl:with-param>
	</xsl:call-template>
	<xsl:value-of disable-output-escaping="yes" select="'&lt;/p'"/>

	<p>Edition: <xsl:value-of select="edition"/></p>

	<!-- <xsl:comment> -->
	First version: <xsl:value-of select="first-date"/><br></br>
	<xsl:call-template name="fFmtDate"/><br></br>
	<xsl:call-template name="fFmtRevision"/><br></br>
	<xsl:call-template name="fFmtSource"/><br></br>
	<!-- </xsl:comment> -->

        <xsl:if test="contains($gView, 'outline')">
	  <hr></hr>
          <h2>Show Outline Notes</h2>
          <dl>
          <xsl:apply-templates select="defdraft"/>
          <xsl:apply-templates select="defwhere"/>
          <xsl:apply-templates select="defwho"/>
          <xsl:apply-templates select="defthread"/>
          </dl>
        </xsl:if>
        <xsl:apply-templates select="chapter" mode="index"/>
        <xsl:apply-templates select="chapter" mode="file"/>
      </body>
    </html>
    </exsl:document>
  </xsl:template>

  <xsl:template name="fFmtRevision">
    <xsl:variable name="str" select="revision"/>
    <xsl:value-of select="substring-before(substring-after($str, '$'), ' $')"/>
  </xsl:template>

  <xsl:template name="fFmtDate">
    <xsl:variable name="str" select="revision-date"/>
    Revision <xsl:value-of select="substring(substring-before(substring-after($str, '$'), ' $'), 1, 16)"/>
  </xsl:template>

  <xsl:template name="fFmtSource">
    <xsl:variable name="str" select="source"/>
    <xsl:value-of select="substring-before(substring-after($str, '$'), ' $')"/>
  </xsl:template>

  <xsl:template name="fFmtCss">
    <META http-equiv="Content-Style-Type" content="text/css"></META>
    <style>
      BODY, TABLE {
        font-family: serif color: black;
      }
      P {
        text-indent: 5%; serif color: black;
      }
    </style>
  </xsl:template>

  <xsl:template match="link">
    <xsl:text disable-output-escaping="yes"> &lt;a href="</xsl:text>
    <xsl:value-of select="key('link-index', @ref)/@url"/>
    <xsl:text disable-output-escaping="yes">"</xsl:text>
    <xsl:if test="key('link-index', @ref)/@offsite">
      <xsl:text disable-output-escaping="yes"> target="_blank"</xsl:text>
    </xsl:if>
    <xsl:text disable-output-escaping="yes">></xsl:text>
    <xsl:value-of select="key('link-index', @ref)/."/>
    <xsl:choose>
      <xsl:when test="contains($gStyle, 'text')">
        (<xsl:value-of select="key('link-index', @ref)/@url"/>)
      </xsl:when>
    </xsl:choose>
    <xsl:text disable-output-escaping="yes">&lt;/a> </xsl:text>
  </xsl:template>

  <xsl:template match="p">
    <xsl:value-of disable-output-escaping="yes" select="'&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;'"/>
    <xsl:apply-templates select="*|comment()|text()"/><br></br>
  </xsl:template>

  <xsl:template match="b|i">
    <xsl:choose>
      <xsl:when test="contains($gStyle, 'html')">
        <xsl:copy-of select="."/>
      </xsl:when>
      <xsl:when test="contains($gStyle, 'text')">
        *<xsl:value-of select="."/>*
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="chapter" mode="index">
    <a href="ch{position()}.html">
      <xsl:value-of select="title"/>
    </a><br></br>
  </xsl:template>

  <xsl:template match="chapter" mode="file">
    <exsl:document method="html" href="ch{position()}.html">
      <html>
      <head>
        <title>
          <xsl:value-of select="concat(/book/title, ' - ', title)"/>
        </title>
        <!-- <xsl:call-template name="fFmtCss"/> -->
      </head>
      <body>
      <h1><xsl:value-of select="/book/title"/></h1>
      <h2><xsl:value-of select="title"/></h2>
      First version: <xsl:value-of select="first-pub-date"/><br></br>
      <xsl:call-template name="fFmtDate"/><br></br>
      <xsl:call-template name="fFmtRevision"/><br></br>
      <xsl:call-template name="fFmtSource"/><br></br>
      <xsl:apply-templates select="prolog"/>
      <xsl:apply-templates select="scene|sequel"/>
      <xsl:apply-templates select="postlog"/>
      </body>
      </html>
    </exsl:document>
  </xsl:template>

  <xsl:template match="defwhere|defwho|defthread|defdraft">
    <xsl:value-of disable-output-escaping="yes" select="'&lt;dt>&lt;b>'"/>
    <xsl:value-of select="name()"/>
    <xsl:value-of select="' [id='"/>
    <xsl:value-of disable-output-escaping="yes" select="concat(@id, ']&lt;/b>&lt;/dt>')"/>
    <dd>
    <xsl:apply-templates select="text"/>
    <xsl:apply-templates select="textindent"/>
    <xsl:apply-templates select="textnoindent"/>
    </dd>
  </xsl:template>

  <xsl:template match="preface|prolog|postlog">
    <xsl:apply-templates select="text"/>
  </xsl:template>

  <xsl:template match="text">
    <xsl:if test="position()=last()">
      <xsl:if test="contains($gView, 'outline')">
        <b>[ref=<xsl:value-of select="@ref"/>]</b><br></br>
      </xsl:if>
      <!-- <xsl:value-of select="."/> -->
      <xsl:apply-templates select="p"/>
    </xsl:if>
  </xsl:template>

  <xsl:template match="textindent">
    <xsl:if test="contains($gView, 'outline')">
      <b>[ref=<xsl:value-of select="@ref"/>]</b><br></br>
    </xsl:if>
    <p>
    <xsl:call-template name="replace-substring">
      <xsl:with-param name="original"><xsl:value-of select="."/></xsl:with-param>
      <xsl:with-param name="substring"><xsl:text>

</xsl:text>
</xsl:with-param>
      <xsl:with-param name="replacement">&lt;/p>&lt;p></xsl:with-param>
    </xsl:call-template>
    </p>
  </xsl:template>

  <xsl:template match="scene|sequel">
    <xsl:if test="contains($gView, 'outline')">
      <hr></hr>
      <b>Notes:</b>
      <dl>
      <xsl:value-of disable-output-escaping="yes" select="'&lt;dt>&lt;b>'"/>
      <xsl:value-of select="name()"/>
      <xsl:value-of select="' ['"/>
      <xsl:value-of select="concat(@id, '] - ')"/>
      <xsl:value-of select="title"/>
      <xsl:value-of disable-output-escaping="yes" select="'&lt;/b>&lt;/dt>'"/>
      <xsl:apply-templates select="when"/>
      <xsl:apply-templates select="where"/>
      <xsl:apply-templates select="who"/>
      <xsl:apply-templates select="outline"/>
      </dl>
      <hr></hr>
    </xsl:if>
    <xsl:apply-templates select="text"/>
    <xsl:apply-templates select="thread"/>
  </xsl:template>

  <xsl:template match="when">
    <xsl:value-of disable-output-escaping="yes" select="'&lt;dt>When [type='"/>
    <xsl:value-of disable-output-escaping="yes" select="concat(@type, ']&lt;/dt>')"/>
    <dd>
    <xsl:apply-templates select="p"/>
    </dd>
  </xsl:template>

  <xsl:template match="where">
    <xsl:value-of disable-output-escaping="yes" select="'&lt;dt>Where [ref='"/>
    <xsl:value-of disable-output-escaping="yes" select="concat(@ref, ']&lt;/dt>')"/>
    <dd>
    <xsl:apply-templates select="p"/>
    </dd>
  </xsl:template>

  <xsl:template match="who">
    <xsl:value-of disable-output-escaping="yes" select="'&lt;dt>Who [ref='"/>
    <xsl:value-of disable-output-escaping="yes" select="concat(@ref, ']&lt;/dt>')"/>
    <dd>
    <xsl:apply-templates select="p"/>
    </dd>
  </xsl:template>

  <xsl:template match="outline">
    <xsl:value-of disable-output-escaping="yes" select="'&lt;dt>Outline'"/>
    <xsl:value-of disable-output-escaping="yes" select="'&lt;/dt>'"/>
    <dd>
    <pre>
      <xsl:value-of disable-output-escaping="yes" select="."/>
    </pre>
    </dd>
  </xsl:template>

  <xsl:template match="thread">
    <xsl:apply-templates select="text"/>
    <xsl:text disable-output-escaping="yes">
&lt;p>&amp;nbsp;&lt;/p>
&lt;p>&amp;nbsp;&lt;/p>
    </xsl:text>
  </xsl:template>

  <xsl:template name="fLink">
    <xsl:param name="url" select="'missing-url'"/>
    <xsl:param name="text" select="'missing-text'"/>
    <xsl:choose>
      <xsl:when test="contains($gStyle, 'html')">
        <a href="{$url}">
        <xsl:value-of select="$text"/></a>
      </xsl:when>
      <xsl:when test="contains($gStyle, 'text')">
        <xsl:value-of select="$text"/>
	<xsl:text> (</xsl:text>
        <xsl:value-of select="$url"/>
	<xsl:text>)</xsl:text>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template name="replace-substring">
    <xsl:param name="original"/>
    <xsl:param name="substring"/>
    <xsl:param name="replacement" select="''"/>
    <xsl:variable name="first">
      <xsl:choose>
        <xsl:when test="contains($original, $substring)">
          <xsl:value-of select="substring-before($original, $substring)"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$original"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="middle">
      <xsl:choose>
        <xsl:when test="contains($original, $substring)">
          <xsl:value-of select="$replacement"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text></xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="last">
      <xsl:choose>
        <xsl:when test="contains($original, $substring)">
          <xsl:choose>
            <xsl:when test="contains(substring-after($original, $substring), $substring)">
              <xsl:call-template name="replace-substring">
                <xsl:with-param name="original"><xsl:value-of select="substring-after($original, $substring)"/></xsl:with-param>
                <xsl:with-param name="substring"><xsl:value-of select="$substring"/></xsl:with-param>
                <xsl:with-param name="replacement"><xsl:value-of select="$replacement"/></xsl:with-param>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="substring-after($original, $substring)"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text></xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="concat($first, $middle, $last)"/>
  </xsl:template>

</xsl:stylesheet>
