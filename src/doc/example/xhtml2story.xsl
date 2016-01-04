<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- ******************** -->
  <xsl:output method="xml" />
  <xsl:preserve-space elements="pre" />
  <!-- ******************** -->
  <xsl:template match="/html/body">
    <content>
      <story-dtd version="4"/>
      <title>
      <xsl:value-of disable-output-escaping="yes" select="substring-after(p[starts-with(.,'Title: ')],'Title: ')" />
      </title>
      <author>
      <xsl:value-of disable-output-escaping="yes" select="substring-after(p[starts-with(.,'Author: ')],'Author: ')" />
      </author>
      <xsl:apply-templates />
    </content>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="h2/a[contains(@id,'CHAPTER')]">
<chapter id="{@id}"></chapter>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="h3">
<title><xsl:value-of select="."/></title>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="p">
<xsl:choose>
<xsl:when test="contains(.,'qT')">
<s>
<xsl:apply-templates />
</s>
</xsl:when>
<xsl:otherwise>
<p>
<xsl:apply-templates />
</p>
</xsl:otherwise>
</xsl:choose>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="span[class='pagenum']">
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="a">
  </xsl:template>
  <!-- ******************** -->
</xsl:stylesheet>
