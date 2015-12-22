<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

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

<xsl:template match="text">
  <xsl:choose>
    <xsl:when test="contains(@type,'pre')">
<pre>
      <xsl:apply-templates select="*|comment()|text()"/>
</pre>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates select="p"/>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="p">
  <xsl:choose>
    <xsl:when test="contains(../@type,'indent')">
      <xsl:text disable-output-escaping="yes">&amp;nbsp;&amp;nbsp;&amp;nbsp;&amp;nbsp; </xsl:text>
      <xsl:apply-templates select="*|comment()|text()"/><br/>
      <xsl:text>

</xsl:text>
    </xsl:when>
    <xsl:when test="contains(../@type,'block')">
<p>
      <xsl:apply-templates select="*|comment()|text()"/>
</p>
      <xsl:text>

</xsl:text>
    </xsl:when>
    <xsl:when test="contains(../@type,'pre')">
      <xsl:apply-templates select="*|comment()|text()"/>
    </xsl:when>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
