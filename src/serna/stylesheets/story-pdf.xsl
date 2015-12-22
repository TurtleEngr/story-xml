<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
>

  <xsl:import href="fo/fo.xsl"/>
  <xsl:param name="body.master">16</xsl:param>

  <xsl:include href="story-common.xsl"/>

  <xsl:template match="s|t">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="padding" select="'0pt'"/>
      <xsl:with-param name="start-indent" select="'0pt'"/>
      <xsl:with-param name="end-indent" select="'0pt'"/>
      <xsl:with-param name="content">
        <xsl:text>_____</xsl:text>
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
</xsl:stylesheet>
