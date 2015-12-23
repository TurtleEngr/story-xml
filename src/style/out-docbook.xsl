<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!-- "Print" a story.xml file to a docbook.xml file. -->
  <!-- ******************** -->
  <xsl:output method="xml"
              indent="yes" />
  <xsl:preserve-space elements="pre pre-fmt" />
  <xsl:include href="com-param.xsl" />
  <xsl:include href="com.xsl" />
  <!-- ******************** -->
  <xsl:template match="/content/book">
    <xsl:element name="book">
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates select="title" />
      <xsl:apply-templates select="subtitle" />
      <xsl:apply-templates select="title-abbrev" />
      <xsl:apply-templates select="book-info" />
      <xsl:apply-templates select="preface" />
      <xsl:apply-templates select="chapter" />
      <xsl:apply-templates select="epilog" />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="node() | @* | comment() | processing-instruction()">

    <xsl:copy>
      <xsl:apply-templates select="@* | node()" />
    </xsl:copy>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fReplaceSubstring">
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
        <!--
        <xsl:otherwise>
          <xsl:text></xsl:text>
        </xsl:otherwise>
-->
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="last">
      <xsl:choose>
        <xsl:when test="contains($original, $substring)">
          <xsl:choose>
            <xsl:when test="contains(substring-after($original, $substring), $substring)">

              <xsl:call-template name="fReplaceSubstring">
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
        <!--
        <xsl:otherwise>
          <xsl:text></xsl:text>
        </xsl:otherwise>
-->
      </xsl:choose>
    </xsl:variable>
    <xsl:value-of select="concat($first, $middle, $last)" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="story-dtd"></xsl:template>
  <xsl:template match="style-info"></xsl:template>
  <xsl:template match="story-info"></xsl:template>
  <xsl:template match="outline"></xsl:template>
  <xsl:template match="@ref"></xsl:template>
  <xsl:template match="@who-ref"></xsl:template>
  <xsl:template match="@who-refs"></xsl:template>
  <!-- ******************** -->
  <!--
enum value
  <biblio-id @class=
    library-of-congress
    pub-number
  -->
  <xsl:template match="@other-class">
    <xsl:attribute name="otherclass">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="@revision-flag">
    <xsl:attribute name="revisionflag">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="@other-class">
    <xsl:attribute name="otherclass">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <xsl:template match="author-blurb">
    <xsl:element name="personblurb">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="author-group">
    <xsl:element name="authorgroup">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="biblio-id">
    <xsl:element name="biblioid">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="book-info">
    <xsl:element name="bookinfo">
      <xsl:apply-templates select="author-group" />
      <xsl:apply-templates select="release-info" />
      <xsl:apply-templates select="pub-date" />
      <xsl:apply-templates select="copyright" />
      <xsl:apply-templates select="publisher" />
      <xsl:apply-templates select="edition" />
      <xsl:apply-templates select="biblio-id" />
      <xsl:apply-templates select="keyword-set" />
      <xsl:apply-templates select="abstract" />
      <xsl:apply-templates select="legal-notice" />
    </xsl:element>
  </xsl:template>
  <xsl:template match="chapter-info">
    <xsl:element name="chapterinfo">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="first-name">
    <xsl:element name="firstname">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="keyword-set">
    <xsl:element name="keywordset">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="legal-notice">
    <xsl:element name="legalnotice">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="other-addr">
    <xsl:element name="otheraddr">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="other-name">
    <xsl:element name="othername">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="post-code">
    <xsl:element name="postcode">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="pub-date">
    <xsl:element name="pubdate">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="publisher-name">
    <xsl:element name="publishername">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="release-info">
    <xsl:element name="releaseinfo">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <xsl:template match="title-abbrev">
    <xsl:element name="titleabbrev">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="preface">
    <xsl:element name="preface">
      <xsl:apply-templates select="@*" />
      <xsl:element name="prefaceinfo">
        <xsl:apply-templates select="subtitle" />
        <xsl:apply-templates select="@*" />
        <xsl:apply-templates select="title-abbrev" />
        <xsl:apply-templates select="@*" />
      </xsl:element>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="chapter">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <xsl:element name="chapter">
        <xsl:apply-templates select="@*" />
        <xsl:apply-templates select="title" />
        <xsl:apply-templates select="subtitle" />
        <xsl:apply-templates select="title-abbrev" />
        <xsl:if test="$gContentRef/@preface = '1'">
          <xsl:apply-templates select="prolog" />
        </xsl:if>
        <xsl:apply-templates select="unit" />
        <xsl:if test="$gContentRef/@preface = '1'">
          <xsl:apply-templates select="postlog" />
        </xsl:if>
      </xsl:element>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="epilog">
    <xsl:element name="chapter">
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates select="title" />
      <xsl:apply-templates select="subtitle" />
      <xsl:apply-templates select="title-abbrev" />
      <xsl:apply-templates select="para|pre-fmt" />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="prolog">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <xsl:element name="formalpara">
        <xsl:apply-templates select="title" />
      </xsl:element>
      <xsl:apply-templates select="para|pre-fmt" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="postlog">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <xsl:element name="formalpara">
        <xsl:apply-templates select="title" />
      </xsl:element>
      <xsl:apply-templates select="para|pre-fmt" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="unit">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <xsl:element name="para" />
      <xsl:apply-templates select="thread" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="thread">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <xsl:apply-templates />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="para">
    <xsl:element name="para">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="t">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <xsl:element name="para">
        <xsl:attribute name="indent">5em</xsl:attribute>
        <xsl:apply-templates />
      </xsl:element>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="p|s">
    <xsl:element name="para">
      <xsl:attribute name="indent">5em</xsl:attribute>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
</xsl:stylesheet>
