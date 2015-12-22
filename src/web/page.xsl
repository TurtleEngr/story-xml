<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times" xmlns:exsl="http://exslt.org/common" extension-element-prefixes="date exsl">

<!-- ****************************************** -->
<xsl:output method="html" indent="yes"/>
<!-- <xsl:strip-space elements="*"/> -->

<xsl:include href="inc-key.xsl"/>
<xsl:include href="inc-util.xsl"/>
<xsl:include href="inc-text.xsl"/>

<!-- ****************************************** -->
<xsl:template match="/content">
  <xsl:for-each select="page-file">
    <xsl:apply-templates select="document(@name)/page"/>
  </xsl:for-each>
  <xsl:apply-templates select="page"/>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="page">
  <xsl:message>Creating: <xsl:value-of select="concat(@id,'.html')"/></xsl:message>
  <exsl:document method="html" href="{concat(@id,'.html')}">
  <html>
    <head>
      <title><xsl:value-of select="title"/></title>
      <xsl:apply-templates select="meta-description"/>
      <xsl:apply-templates select="meta-keywords"/>
    </head>
    <body link="#0000ff" vlink="#9900ff" alink="#000000">
      <xsl:attribute name="bgcolor">
        <xsl:value-of select="/content/site/style/@bgcolor"/>
      </xsl:attribute>
      <xsl:attribute name="text">
        <xsl:value-of select="/content/site/style/@text"/>
      </xsl:attribute>

      <h1><xsl:value-of select="title"/></h1>
      <xsl:apply-templates select="text"/>
      <xsl:apply-templates select="sect1"/>
      <hr/>
      Last updated: <xsl:apply-templates select="cvs-date"/><br/>
      First published: <xsl:apply-templates select="pub-date"/><br/>
      Revision: <xsl:apply-templates select="cvs-revision"/><br/>
      Source: <xsl:apply-templates select="cvs-source"/><br/>
    </body>
  </html>
  </exsl:document>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="meta-description">
  <meta name="description">
    <xsl:attribute name="content">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </meta>
</xsl:template>

<xsl:template match="meta-keywords">
  <meta name="keywords">
    <xsl:attribute name="content">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </meta>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="sect1">
  <h2><xsl:value-of select="title"/></h2>
  <dl>
    <xsl:apply-templates select="item"/>
  </dl>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="item">
  <dt><xsl:value-of select="title"/></dt>
  <dd><xsl:apply-templates select="text"/></dd>
</xsl:template>

</xsl:stylesheet>
