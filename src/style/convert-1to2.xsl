<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- ******************** -->
  <xsl:output method="xml" />
  <xsl:preserve-space elements="pre pre-fmt" />
  <!-- ******************** -->
  <xsl:template match="node() | @* | comment() | processing-instruction()">

    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="replace-substring">
    <xsl:param name="original" />
    <xsl:param name="substring" />
    <xsl:param name="replacement" />
    <xsl:variable name="first">
      <xsl:choose>
        <xsl:when test="contains($original, $substring)">
          <xsl:value-of select="substring-before($original, $substring)" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$original" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="middle">
      <xsl:choose>
        <xsl:when test="contains($original, $substring)">
          <xsl:value-of select="$replacement" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:text></xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="last">
      <xsl:choose>
        <xsl:when test="contains($original, $substring)">
          <xsl:choose>
            <xsl:when test="contains(substring-after($original, $substring), $substring)">

              <xsl:call-template name="replace-substring">
                <xsl:with-param name="original">
                  <xsl:value-of select="substring-after($original, $substring)" />
                </xsl:with-param>
                <xsl:with-param name="substring">
                  <xsl:value-of select="$substring" />
                </xsl:with-param>
                <xsl:with-param name="replacement">
                  <xsl:value-of select="$replacement" />
                </xsl:with-param>
              </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="substring-after($original, $substring)" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text></xsl:text>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="concat($first, $middle, $last)" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="site"></xsl:template>
  <xsl:template match="page"></xsl:template>
  <xsl:template match="ch-no"></xsl:template>
  <xsl:template match="def-book"></xsl:template>
  <xsl:template match="@page-in-progress"></xsl:template>
  <xsl:template match="@page-done"></xsl:template>
  <xsl:template match="@page-draft"></xsl:template>
  <xsl:template match="@book-in-progress"></xsl:template>
  <xsl:template match="@book-done"></xsl:template>
  <xsl:template match="@book-draft"></xsl:template>
  <xsl:template match="@font-size"></xsl:template>
  <!-- ******************** -->
  <xsl:template match="/content/book">
    <xsl:element name="book">
      <xsl:apply-templates select="@*"
                           mode="base" />
      <xsl:apply-templates select="title" />
      <xsl:element name="book-info">
        <xsl:element name="author-group">
          <xsl:apply-templates select="author" />
        </xsl:element>
        <xsl:apply-templates select="cvs" />
        <xsl:apply-templates select="pub-date" />
        <xsl:element name="copyright">
          <xsl:element name="year">2007</xsl:element>
          <xsl:element name="holder">
            <xsl:value-of select="author" />
          </xsl:element>
        </xsl:element>
        <xsl:apply-templates select="edition" />
        <xsl:apply-templates select="isbn" />
        <xsl:apply-templates select="meta-keywords" />
      </xsl:element>
      <xsl:element name="style-info">
        <xsl:apply-templates select="/content/site/style/@*" />
        <xsl:apply-templates select="/content/site/def-style" />
        <xsl:apply-templates select="/content/site/def-content" />
        <xsl:apply-templates select="/content/site/def-draft" />
        <xsl:apply-templates select="/content/site/def-print" />
        <xsl:apply-templates select="/content/site/def-base" />
        <xsl:apply-templates select="/content/site/def-img" />
        <xsl:apply-templates select="/content/site/def-link" />
        <xsl:apply-templates select="meta-description" />
        <xsl:apply-templates select="file-prefix" />
      </xsl:element>
      <xsl:element name="story-info">
        <xsl:apply-templates select="def-book/def-who" />
        <xsl:apply-templates select="def-book/def-where" />
        <xsl:apply-templates select="def-book/def-thread" />
        <xsl:apply-templates select="ch-preface" />
      </xsl:element>
      <xsl:apply-templates select="preface" />
      <xsl:apply-templates select="chapter" />
      <xsl:apply-templates select="epilog" />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="chapter">
    <xsl:element name="chapter">
      <xsl:apply-templates select="@*"
                           mode="base" />
      <xsl:apply-templates select="title" />
      <xsl:element name="chapter-info">
        <xsl:apply-templates select="cvs" />
        <xsl:apply-templates select="pub-date" />
      </xsl:element>
      <xsl:apply-templates select="prolog" />
      <xsl:apply-templates select="unit" />
      <xsl:apply-templates select="postlog" />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="unit">
    <xsl:element name="unit">
      <xsl:apply-templates select="@*"
                           mode="base" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-img">
    <xsl:element name="def-img">
      <xsl:apply-templates select="@*"
                           mode="base" />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-link">
    <xsl:element name="def-link">
      <xsl:apply-templates select="@*"
                           mode="base" />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@base"
                mode="base">
    <xsl:attribute name="base-ref">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@ref"
                mode="base">
    <xsl:attribute name="img-ref">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@*"
                mode="base">
    <xsl:copy>
      <xsl:apply-templates select="@*" />
    </xsl:copy>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@status"
                mode="base">
    <xsl:attribute name="revision">
      <xsl:choose>
        <xsl:when test=". = 'done'">
          <xsl:value-of select="'final'" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="." />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:attribute>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-print/@ref">
    <xsl:attribute name="img-ref">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <!-- ******************** -->
  <!--
  <xsl:template match="@line-height">
    <xsl:attribute name="line-height">
      <xsl:call-template name="replace-substring">
        <xsl:with-param name="."/>
        <xsl:with-param name="'%'"/>
        <xsl:with-param name="replacement" select="''"/>
      </xsl:call-template>
    </xsl:attribute>
  </xsl:template>
  -->
  <!-- ******************** -->
  <xsl:template match="@unit-list">
    <xsl:attribute name="unit-refs">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@ch-list">
    <xsl:attribute name="ch-refs">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@ch-done">
    <xsl:attribute name="ch-final">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@unit-done">
    <xsl:attribute name="unit-final">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-print">
    <xsl:element name="{name()}">
      <xsl:attribute name="multi-file">
        <xsl:value-of select="0" />
      </xsl:attribute>
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates select="*|text()" />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="thread">
    <xsl:element name="{name()}">
      <xsl:attribute name="refs">
        <xsl:value-of select="@ref" />
      </xsl:attribute>
      <xsl:attribute name="who-refs">
        <xsl:value-of select="@viewpoint" />
      </xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="t|s">
    <xsl:element name="{name()}">
      <xsl:if test="@ref">
        <xsl:attribute name="who-ref">
          <xsl:value-of select="@ref" />
        </xsl:attribute>
      </xsl:if>
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="ins">
    <xsl:element name="rev">
      <xsl:attribute name="revision-flag">
        <xsl:value-of select="'added'" />
      </xsl:attribute>
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="del">
    <xsl:element name="rev">
      <xsl:attribute name="revision-flag">
        <xsl:value-of select="'deleted'" />
      </xsl:attribute>
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="author">
    <xsl:element name="author">
      <xsl:element name="first-name">
        <xsl:value-of select="substring-before(.,' ')" />
      </xsl:element>
      <xsl:element name="surname">
        <xsl:value-of select="substring-after(.,' ')" />
      </xsl:element>
      <xsl:apply-templates select="../email" />
      <xsl:element name="author-blurb"></xsl:element>
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="meta-keywords">
    <xsl:element name="keyword-set">
      <xsl:value-of select="." />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="cvs">
    <xsl:element name="release-info">
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates select="*|text()" />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
</xsl:stylesheet>
