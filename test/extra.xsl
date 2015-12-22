<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
  <xsl:key name="link-index" match="deflink" use="@id"/>
  <xsl:key name="img-index" match="defimg" use="@id"/>
  <xsl:key name="defwho-index" match="defwho" use="@id"/>
  <xsl:key name="defwhere-index" match="defwhere" use="@id"/>
  <xsl:key name="defdraft-index" match="def" use="@id"/>
  <xsl:key name="defthread-index" match="def" use="@id"/>
  <xsl:key name="chapter-index" match="chapter" use="@id"/>
  <xsl:key name="unit-index" match="unit" use="@id"/>

  <xsl:template match="p">
    <xsl:value-of disable-output-escaping="yes" select="'&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp;'"/>
    <xsl:apply-templates select="*|comment()|text()"/><br></br>
  </xsl:template>

  <xsl:template match="link">
    <xsl:text disable-output-escaping="yes"> &lt;a href="</xsl:text>
    <xsl:value-of select="key('link-index', @ref)/@url"/>
    <xsl:text disable-output-escaping="yes">"</xsl:text>
    <xsl:if test="key('link-index', @ref)/@offsite">
      <xsl:text disable-output-escaping="yes"> target="_blank"</xsl:text>
    </xsl:if>
    <xsl:text disable-output-escaping="yes">></xsl:text>
    <xsl:if test="contains(@icon,'yes')">
      <xsl:call-template name="fIcon">
        <xsl:with-param name="url">
<xsl:call key('link-index', @ref)/@offsite />
        </xsl:with-param>
    </xsl:if>
    <xsl:choose>
      <xsl:when test="contains(@type,'title')">
        <xsl:value-of select="key('link-index', @ref)/."/>
      </xsl:when>
      <xsl:when test="contains(@type,'url')">
        <xsl:value-of select="key('link-index', @ref)/@url"/>
      </xsl:when>
      <xsl:when test="contains(@type,'both')">
        <xsl:value-of select="key('link-index', @ref)/."/>
        (<xsl:value-of select="key('link-index', @ref)/@url"/>)
      </xsl:when>
    </xsl:choose>
    <xsl:text disable-output-escaping="yes">&lt;/a> </xsl:text>
  </xsl:template>

  <xsl:template match="revision">
    <xsl:value-of select="substring-before(substring-after(., '$'), ' $')"/>
  </xsl:template>

  <xsl:template match="revision-date">
    Revision <xsl:value-of select="substring(substring-before(substring-after(., '$'), ' $'), 1, 16)"/>
  </xsl:template>

  <xsl:template match="source">
    <xsl:value-of select="substring-before(substring-after(., '$'), ' $')"/>
  </xsl:template>

</xsl:stylesheet>

<!--
<source>$Source: /repo/local.cvs/app/story-xml/old/test/extra.xsl,v $</source>
<revision>$Revision: 1.1 $</revision>
<revision-date>$Date: 2006/02/19 01:41:45 $</revision-date>
<first-pub-date>1999/12/03</first-pub-date>

# on site
<link ref="id" type="title" icon="no"/>
	<a href="url">title</a>
<link ref="id" type="url" icon="no"/>
	<a href="url">url</a>
<link ref="id" type="all" icon="no"/>
	<a href="url">title (url)</a>

# off site
<link ref="id" type="title" loc="yes"/>
	<a href="url" target="_blank"><img src="folder.jpg" align="left" border="0" alt="folder"/>title</a>
	<a href="url" target="_blank">url</a>
	<a href="url" target="_blank">title (url)</a>

<icon ref="id" align="left"/>
	<img src="url" alt="title" align="left" border="0"/>

<deflink id="id" url="http://.../" offsite="yes" icon="folder">title</a>
<deflink id="id" url="http://.../file.html" offsite="no" icon="file">title</a>
-->
