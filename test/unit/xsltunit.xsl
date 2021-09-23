<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:exsl="http://exslt.org/common" xmlns:xsltu="http://xsltunit.org/0/" version="1.0" extension-element-prefixes="exsl" exclude-result-prefixes="exsl">
  
  <xsl:template name="xsltu:assertEqual">
    <xsl:param name="id"/>
    <xsl:param name="pActualNodes"/>
    <xsl:param name="pExpectNodes"/>
    <xsl:variable name="result">
      <xsl:call-template name="xsltu:diff">
        <xsl:with-param name="pActualNodes" select="exsl:node-set($pActualNodes)"/>
        <xsl:with-param name="pExpectNodes" select="exsl:node-set($pExpectNodes)"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="xsltu:assert">
      <xsl:with-param name="id" select="$id"/>
      <xsl:with-param name="test" select="not(exsl:node-set($result)//xsltu:no-match)"/>
      <xsl:with-param name="message" select="exsl:node-set($result)"/>
    </xsl:call-template>
  </xsl:template>
 
  <xsl:template name="xsltu:assertNotEqual">
    <xsl:param name="id"/>
    <xsl:param name="pActualNodes"/>
    <xsl:param name="pExpectNodes"/>
    <xsl:variable name="result">
      <xsl:call-template name="xsltu:diff">
        <xsl:with-param name="pActualNodes" select="exsl:node-set($pActualNodes)"/>
        <xsl:with-param name="pExpectNodes" select="exsl:node-set($pExpectNodes)"/>
      </xsl:call-template>
    </xsl:variable>
    <xsl:call-template name="xsltu:assert">
      <xsl:with-param name="id" select="$id"/>
      <xsl:with-param name="test" select="exsl:node-set($result)//xsltu:no-match"/>
      <xsl:with-param name="message">Should have been different!</xsl:with-param>
    </xsl:call-template>
  </xsl:template>
 
  <xsl:template name="xsltu:assert">
    <xsl:param name="id"/>
    <xsl:param name="test"/>
    <xsl:param name="message"/>
    <xsltu:assert id="{$id}">
      <xsl:choose>
        <xsl:when test="$test">
          <xsl:attribute name="outcome">passed</xsl:attribute>
        </xsl:when>
 
        <xsl:otherwise>
          <xsl:attribute name="outcome">failed</xsl:attribute>
          <xsltu:message>
            <xsl:copy-of select="$message"/>
          </xsltu:message>
        </xsl:otherwise>
      </xsl:choose>
    </xsltu:assert>
  </xsl:template>
 
  <xsl:template name="xsltu:diff">
    <xsl:param name="pActualNodes"/>
    <xsl:param name="pExpectNodes"/>
    <xsltu:diff name="{name($pActualNodes)}">
      <xsl:choose>
        <xsl:when test="self::* and (local-name($pActualNodes) != local-name($pExpectNodes) or namespace-uri($pActualNodes) != namespace-uri($pExpectNodes))">
          <xsltu:no-match diff="names">
            <xsltu:node>
              <xsl:copy-of select="$pActualNodes"/>
            </xsltu:node>
            <xsltu:node>
              <xsl:copy-of select="$pExpectNodes"/>
            </xsltu:node>
          </xsltu:no-match>
        </xsl:when>
 
        <xsl:when test="count($pActualNodes/@*) != count($pExpectNodes/@*)">
          <xsltu:no-match diff="number of children attributes ({count($pActualNodes/@*)} versus {count($pExpectNodes/@*)} )">
            <xsltu:node>
              <xsl:copy-of select="$pActualNodes"/>
            </xsltu:node>
            <xsltu:node>
              <xsl:copy-of select="$pExpectNodes"/>
            </xsltu:node>
          </xsltu:no-match>
        </xsl:when>
 
        <xsl:when test="count($pActualNodes/*) != count($pExpectNodes/*)">
          <xsltu:no-match diff="number of children elements ({count($pActualNodes/*)} versus {count($pExpectNodes/*)} )">
            <xsltu:node>
              <xsl:copy-of select="$pActualNodes"/>
            </xsltu:node>
            <xsltu:node>
              <xsl:copy-of select="$pExpectNodes"/>
            </xsltu:node>
          </xsltu:no-match>
        </xsl:when>
 
        <xsl:when test="count($pActualNodes/text()) != count($pExpectNodes/text())">
          <xsltu:no-match diff="number of children text nodes ({count($pActualNodes/text())} versus {count($pExpectNodes/text())} )">
            <xsltu:node>
              <xsl:copy-of select="$pActualNodes"/>
            </xsltu:node>
            <xsltu:node>
              <xsl:copy-of select="$pExpectNodes"/>
            </xsltu:node>
          </xsltu:no-match>
        </xsl:when>
 
        <xsl:otherwise>
          <xsl:apply-templates select="$pActualNodes/@*" mode="xsltu:diff">
            <xsl:with-param name="pExpectNodes" select="$pExpectNodes"/>
          </xsl:apply-templates>
          <xsl:apply-templates select="$pActualNodes/*" mode="xsltu:diff">
            <xsl:with-param name="pExpectNodes" select="$pExpectNodes"/>
          </xsl:apply-templates>
          <xsl:apply-templates select="$pActualNodes/text()" mode="xsltu:diff">
            <xsl:with-param name="pExpectNodes" select="$pExpectNodes"/>
          </xsl:apply-templates>
        </xsl:otherwise>
      </xsl:choose>
    </xsltu:diff>
  </xsl:template>
 
  <xsl:template match="*" mode="xsltu:diff">
    <xsl:param name="pos" select="position()"/>
    <xsl:param name="pExpectNodes"/>
    <xsl:param name="pExpect" select="$pExpectNodes/*[position()=$pos]"/>
    <xsl:call-template name="xsltu:diff">
      <xsl:with-param name="pActualNodes" select="."/>
      <xsl:with-param name="pExpectNodes" select="$pExpect"/>
    </xsl:call-template>
  </xsl:template>
 
  <xsl:template match="text()" mode="xsltu:diff">
    <xsl:param name="current" select="."/>
    <xsl:param name="pos" select="position()"/>
    <xsl:param name="pExpectNodes"/>
    <xsl:param name="pExpect" select="$pExpectNodes/text()[position()=$pos]"/>
    <xsl:if test="not(. = $pExpect)">
      <xsltu:no-match>
        <xsltu:node>
          <xsl:copy-of select="."/>
        </xsltu:node>
        <xsltu:node>
          <xsl:copy-of select="$pExpect"/>
        </xsltu:node>
      </xsltu:no-match>
    </xsl:if>
  </xsl:template>
 
  <xsl:template match="@*" mode="xsltu:diff">
    <xsl:param name="current" select="."/>
    <xsl:param name="pExpectNodes"/>
    <xsl:param name="pExpect" select="$pExpectNodes/@*[local-name() = local-name(current()) and namespace-uri() = namespace-uri(current())]"/>
    <xsl:if test="not(. = $pExpect)">
      <xsltu:no-match>
        <xsltu:node>
          <xsl:copy-of select="."/>
        </xsltu:node>
        <xsltu:node>
          <xsl:copy-of select="$pExpect"/>
        </xsltu:node>
      </xsltu:no-match>
    </xsl:if>
  </xsl:template>
 
</xsl:stylesheet>
