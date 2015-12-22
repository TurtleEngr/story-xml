  <xsl:key name="link-index" match="deflink" use="@id"/>
  <xsl:key name="img-index" match="defimg" use="@id"/>
  <xsl:key name="defwho-index" match="defwho" use="@id"/>
  <xsl:key name="defwhere-index" match="defwhere" use="@id"/>
  <xsl:key name="defdraft-index" match="def" use="@id"/>
  <xsl:key name="defthread-index" match="def" use="@id"/>
  <xsl:key name="chapter-index" match="chapter" use="@id"/>
  <xsl:key name="unit-index" match="unit" use="@id"/>
