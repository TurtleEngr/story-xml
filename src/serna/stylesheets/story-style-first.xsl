<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                version='1.0'>

  <xsl:import href="../xslbricks/fo/common.xsl"/>
  <xsl:import href="../xslbricks/fo/layoutsetup.xsl"/>
  <xsl:import href="../xslbricks/fo/default-elements.xsl"/>
  <xsl:import href="../xslbricks/fo/page-sizes.xsl"/>

  <xsl:strip-space elements="*"/>
  <xsl:preserve-space elements="pre"/>

  <!-- Page parameters -->
  <xsl:param name="paper.type" select="'USLetter'"/>
  <xsl:param name="page.orientation" select="'portrait'"/>
  <xsl:param name="page.margin.bottom" select="'0.5in'"/>
  <xsl:param name="page.margin.inner">1in</xsl:param>
  <xsl:param name="page.margin.outer">1in</xsl:param>
  <xsl:param name="page.margin.top" select="'0.5in'"/>
  <xsl:param name="body.margin.bottom" select="'0.5in'"/>
  <xsl:param name="body.margin.top" select="'0.5in'"/>
  <xsl:param name="page.margin.left">1in</xsl:param>
  <xsl:param name="page.margin.right">1in</xsl:param>

  <!-- Font parameters -->
  <xsl:variable name="body.font.size" select="'14pt'"/>
  <xsl:variable name="body.font.family" select="'serif'"/>
  <xsl:variable name="attribute.font.size" select="'14pt'"/>

  <!-- Other parameters -->

  <xsl:variable name="default.indent.shift" select="'20'"/>

  <xsl:attribute-set name="root">
    <xsl:attribute name="font-family">
      <xsl:value-of select="$body.font.family"/>
    </xsl:attribute>
    <xsl:attribute name="font-size"><xsl:value-of select="$body.font.size"/></xsl:attribute>
  </xsl:attribute-set>

  <!-- -->

  <xsl:template match="s|t">
    <fo:block
      font-size="{$body.font.size}"
      start-indent="10"
    >
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

<!--
  <xsl:attribute-set name="p">
    <xsl:attribute name="padding-top">0.2em</xsl:attribute>
  </xsl:attribute-set>

 <xsl:template match="p|P">
    <fo:block xsl:use-attribute-sets="p">
      <xsl:call-template name="process-common-attributes-and-children"/>
    </fo:block>
  </xsl:template>

  <xsl:attribute-set name="pre">
    <xsl:attribute name="font-size">14pt</xsl:attribute>
    <xsl:attribute name="font-family">monospace</xsl:attribute>
    <xsl:attribute name="white-space">pre</xsl:attribute>
    <xsl:attribute name="padding-top">.5em</xsl:attribute>
    <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
    <xsl:attribute name="white-space-collapse">false</xsl:attribute>
    <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
  </xsl:attribute-set>

  <xsl:template match="pre">
    <fo:block xsl:use-attribute-sets="pre">
      <xsl:call-template name="process-pre"/>
    </fo:block>
  </xsl:template>
-->

  <xsl:template match="*">
    <xsl:param name="indent">0</xsl:param>
    <fo:block 
      font-size="{$body.font.size}" 
      font-family="{$body.font.family}"
      start-indent="{concat($indent, 'pt')}">
      <xsl:if test="attribute::*">
        <fo:block color="#f00000" font-size="{$attribute.font.size}">
          <xsl:call-template name="attrs"/>
        </fo:block>
      </xsl:if>
      <xsl:choose>
        <xsl:when test="text()">
          <xsl:apply-templates mode="inline"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates>
            <xsl:with-param name="indent">
              <xsl:value-of select="$indent + $default.indent.shift"/>
            </xsl:with-param>
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
    </fo:block>
  </xsl:template>

  <xsl:template match="*" mode="inline">
qq    <fo:inline font-style="italic" background-color="#f0f0f0">
      <xsl:if test="attribute::*">
        <fo:inline color="#f00000" font-size="{$attribute.font.size}">
          <xsl:call-template name="attrs"/>
        </fo:inline>
      </xsl:if>
      <xsl:apply-templates mode="inline"/>
    </fo:inline>
  </xsl:template>

  <xsl:template name="attrs">
    <xsl:variable name="att-len" select="count(@*)"/>
    <fo:inline font-style="italic"
      padding-right="3pt">
      <xsl:text>Attrs: </xsl:text>
    </fo:inline>
    <xsl:for-each select="@*">
      <xsl:value-of select="local-name(.)"/>
      <xsl:text> = </xsl:text>
      <xsl:value-of select="."/>
      <xsl:if test="position() &lt; $att-len">
        <xsl:text>; </xsl:text>
      </xsl:if>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
