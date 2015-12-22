<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<!-- ******************************* -->
<xsl:template match="book" mode="toc">
  <exsl:document method="html" href="{concat('web/',file-prefix,'-toc.html')}">
<html>
<head>
<title>
    <xsl:value-of select="title"/>
</title>
</head>
<body>
<h1>
    <xsl:value-of select="title"/>
</h1>
<p>by <xsl:value-of select="author"/></p>

<h2>Preface</h2>
<xsl:apply-templates select="preface/text"/>

<h2>TOC</h2>
<xsl:apply-templates select="chapter" mode="toc"/>

</body>
</html>
  </exsl:document>
</xsl:template>

<!-- ******************************* -->
<xsl:template match="chapter" mode="toc">
<xsl:element name="a">
<xsl:attribute name="href">
<xsl:value-of select="concat(../file-prefix,'-',@id,'.html')"/>
</xsl:attribute>
Chapter <xsl:value-of select="position()"/>.
<xsl:value-of select="title"/>
</xsl:element>
<br/>
</xsl:template>

</xsl:stylesheet>
