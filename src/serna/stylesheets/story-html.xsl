<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">

  <xsl:import href="html/html.xsl"/>
  <xsl:include href="story-common.xsl"/>

<xsl:param name="nbsp">
  <xsl:value-of disable-output-escaping="yes" select="'&amp;'"/>fnbsp;
  <xsl:text disable-output-escaping="yes">&amp;nnbsp;</xsl:text>
  <xsl:text>&amp;nbsp;</xsl:text>
  <xsl:text>&amp;nbsp;</xsl:text>
  <xsl:text>&amp;nbsp;</xsl:text>
</xsl:param>

  <xsl:template match="s|t">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="padding" select="'0pt'"/>
      <xsl:with-param name="start-indent" select="'0pt'"/>
      <xsl:with-param name="end-indent" select="'0pt'"/>
      <xsl:with-param name="content">
	<xsl:value-of select="$nbsp"/><xsl:apply-templates/><br/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  
</xsl:stylesheet>
