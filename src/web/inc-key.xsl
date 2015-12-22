<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:key name="def-link-index" match="deflink" use="@id"/>
<xsl:key name="def-img-index" match="defimg" use="@id"/>
<xsl:key name="page-index" match="page" use="@id"/>

<xsl:key name="book-index" match="book" use="@id"/>
<xsl:key name="chapter-index" match="chapter" use="concat(../@id,'-',@id)"/>
<xsl:key name="unit-index" match="unit" use="concat(../../@id,'-',@id)"/>
<xsl:key name="def-who-index" match="defwho" use="concat(../@id,'-',@id)"/>
<xsl:key name="def-where-index" match="defwhere" use="concat(../@id,'-',@id)"/>
<xsl:key name="def-thread-index" match="def-thread" use="concat(../@id,'-',@id)"/>

</xsl:stylesheet>
