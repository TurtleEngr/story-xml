<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="pre"/>

  <xsl:template match="page/title|book/title|chapter/title">
    <xsl:call-template name="h1"/>
  </xsl:template>

  <xsl:template match="page/sect1/title|chapter/title">
    <xsl:call-template name="h2"/>
  </xsl:template>

  <xsl:template match="page/sect1/item/title">
    <xsl:call-template name="h3"/>
  </xsl:template>

  <xsl:template match="p">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="padding" select="'30pt'"/>
      <xsl:with-param name="start-indent" select="'0pt'"/>
      <xsl:with-param name="end-indent" select="'0pt'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="pre">
    <xsl:call-template name="pre"/>
  </xsl:template>

  <xsl:template match="b">
    <xsl:call-template name="bold.inline"/>
  </xsl:template>

  <xsl:template match="i">
    <xsl:call-template name="italic.inline"/>
  </xsl:template>

  <xsl:template match="tt">
    <xsl:call-template name="monospace.inline"/>
  </xsl:template>

<!--
  <xsl:template match="*">
    <xsl:call-template name="para"/>
  </xsl:template>

  <xsl:template match="note">
    <xsl:call-template name="div.decoration">
      <xsl:with-param name="background-color" select="'#CDFDFF'"/>

      <xsl:with-param name="content">n
        <xsl:call-template name="div.decoration">
          <xsl:with-param name="font-size" select="'17pt'"/>
          <xsl:with-param name="content">
            <xsl:text>Note: </xsl:text>
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="em">
    <xsl:choose>
      <xsl:when test="@weight='bold' and @style='normal'">
        <xsl:call-template name="bold.inline"/>
      </xsl:when>
      <xsl:when test="@weight='bold' and @style='italic'">
        <xsl:call-template name="bold-italic.inline"/>
      </xsl:when>
      <xsl:when test="@weight='normal' and @style='italic'">
        <xsl:call-template name="italic.inline"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="inline"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="ul">
    <xsl:call-template name="ul"/>
  </xsl:template>

  <xsl:template match="ol">
    <xsl:call-template name="ol"/>
  </xsl:template>

  <xsl:template match="ul/li">
    <xsl:call-template name="ul-li"/>
  </xsl:template>

  <xsl:template match="ol/li">
    <xsl:call-template name="ol-li"/>
  </xsl:template>

  <xsl:template match="figure">
    <xsl:call-template name="div.decoration">
      <xsl:with-param name="background-color" select="'#96cbf2'"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="figure/title">
    <xsl:call-template name="h5"/>
  </xsl:template>

  <xsl:template match="baseline">
    <xsl:call-template name="inline.decoration">
      <xsl:with-param name="vertical" select="@shift"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="image">
    <xsl:call-template name="image.block">
      <xsl:with-param name="url" select="@filename"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="table">
    <xsl:call-template name="simple-table">
      <xsl:with-param name="rows" select="row"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="row">
    <xsl:call-template name="simple-row">
      <xsl:with-param name="cells" select="cell"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template match="cell">
    <xsl:call-template name="simple-cell">
      <xsl:with-param name="span" select="@span"/>
    </xsl:call-template>
  </xsl:template>
-->

</xsl:stylesheet>
