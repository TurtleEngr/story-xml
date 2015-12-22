<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ****************************************** -->
<xsl:template match="text[@active='no']">
</xsl:template>

<xsl:template match="text[@type='pre']">
  <xsl:apply-templates select="p" mode="pre"/>
</xsl:template>

<xsl:template match="text[@type='block']">
  <xsl:apply-templates select="p" mode="block"/>
</xsl:template>

<xsl:template match="text[@type='indent']">
  <xsl:apply-templates select="p" mode="indent"/>
</xsl:template>

<xsl:template match="text">
  <xsl:apply-templates select="p" mode="block"/>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="p" mode="block">
  <p>
    <xsl:apply-templates select="i|em|emp|emph|b|strong|tt|code|link|comment()|text()"/>
  </p>
</xsl:template>

<xsl:template match="p" mode="indent">
  <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; </xsl:text>
  <xsl:apply-templates select="i|em|emp|emph|b|strong|tt|code|link|comment()|text()"/><br/>
<xsl:text>

</xsl:text>
</xsl:template>

<xsl:template match="p" mode="pre">
  <pre>
  <xsl:apply-templates select="i|em|emp|emph|b|strong|tt|code|link|comment()|text()"/>
  </pre>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="i|em|emp|emph">
   <i><xsl:apply-templates select="b|strong|tt|code|link|comment()|text()"/><xsl:text> </xsl:text></i>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="b|strong">
   <b><xsl:apply-templates select="i|em|emp|emph|tt|code|link|comment()|text()"/><xsl:text> </xsl:text></b>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="tt|code">
   <tt><xsl:apply-templates select="i|em|emp|emph|b|strong|link|comment()|text()"/><xsl:text> </xsl:text></tt>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="link">
  <xsl:element name="a">
  <xsl:attribute name="href">
  <xsl:value-of select="key('def-link-index', @ref)/@url"/>
  </xsl:attribute>
  <xsl:if test="key('def-link-index', @ref)/@offsite">
    <xsl:attribute name="target">
      <xsl:text>_blank</xsl:text>
    </xsl:attribute>
  </xsl:if>
  <xsl:if test="contains(@icon,'yes')">
        <xsl:value-of select="/content/site/link-image/@off-site"/>
  </xsl:if>
  <xsl:choose>
    <xsl:when test="contains(@type,'label')">
      <xsl:value-of select="key('def-link-index', @ref)/."/>
    </xsl:when>
    <xsl:when test="contains(@type,'url')">
      <xsl:value-of select="key('def-link-index', @ref)/@url"/>
    </xsl:when>
    <xsl:when test="contains(@type,'all')">
      <xsl:value-of select="key('def-link-index', @ref)/."/>
      (<xsl:value-of select="key('def-link-index', @ref)/@url"/>)
    </xsl:when>
  </xsl:choose>
  </xsl:element>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="cvs-date">
  <xsl:value-of select="substring(substring-before(substring-after(., '$'), ' $'), 1, 16)"/>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="cvs-rev">
  why is it not finding this!
<xsl:value-of select="substring-before(substring-after(., '$'), ' $')"/>
bar
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="cvs-source">
  <xsl:value-of select="substring-before(substring-after(., '$'), ' $')"/>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="pub-date">
  <xsl:value-of select="."/>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="email">
  <xsl:value-of select="."/>
</xsl:template>

</xsl:stylesheet>
