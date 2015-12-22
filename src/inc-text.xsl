<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>

<!-- test
<xsl:output method="html"/>

<xsl:template match="/">
<html>
<head>
<title>test</title>
</head>
<body>
  <xsl:apply-templates select="*"/>
</body>
</html>
</xsl:template>
-->

<!-- ****************************************** -->
<xsl:template match="text">
  <xsl:if test="$gdb:debugOn"><xsl:comment>In: text</xsl:comment></xsl:if>
  <xsl:choose>
    <xsl:when test="contains(@type,'pre')">
<pre>
      <xsl:apply-templates select="i|em|emp|emph|b|strong|tt|code|link|comment()|text()"/>
</pre>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="p"/>
    </xsl:otherwise>
  </xsl:choose>
  <xsl:if test="$gdb:debugOn"><xsl:comment>Out: text</xsl:comment></xsl:if>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="p">
  <xsl:if test="$gdb:debugOn"><xsl:comment>In: p</xsl:comment></xsl:if>
  <xsl:choose>
    <xsl:when test="contains(../@type,'indent')">
      <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; </xsl:text>
      <xsl:apply-templates select="i|em|emp|emph|b|strong|tt|code|link|comment()|text()"/><br/>
      <xsl:text>

</xsl:text>
    </xsl:when>
    <xsl:when test="contains(../@type,'block')">
<p>
      <xsl:apply-templates select="i|em|emp|emph|b|strong|tt|code|link|comment()|text()"/>
</p>
      <xsl:text>

</xsl:text>
    </xsl:when>
    <xsl:when test="contains(../@type,'pre')">
      <xsl:apply-templates select="i|em|emp|emph|b|strong|tt|code|link|comment()|text()"/>
    </xsl:when>
  </xsl:choose>
  <xsl:if test="$gdb:debugOn"><xsl:comment>Out: p</xsl:comment></xsl:if>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="i|em|emp|emph">
   <i><xsl:apply-templates select="b|strong|tt|code|link|comment()|text()"/></i>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="b|strong">
   <b><xsl:apply-templates select="i|em|emp|emph|tt|code|link|comment()|text()"/></b>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="tt|code">
   <tt><xsl:apply-templates select="i|em|emp|emph|b|strong|link|comment()|text()"/></tt>
</xsl:template>

<!-- ****************************************** -->
<xsl:template match="link">
  <xsl:if test="$gdb:debugOn"><xsl:comment>In: link</xsl:comment></xsl:if>
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
  <xsl:if test="$gdb:debugOn"><xsl:comment>In: link</xsl:comment></xsl:if>
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
