<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xsltu="http://xsltunit.org/0/" version="1.0">
  <xsl:param name="gpApp"/>
  <xsl:param name="gpTestSuite"/>
  <xsl:param name="gpPassFail"/>
  <xsl:template match="xsltu:tests">
    <html>
      <head>
        <title>Test Stylesheet: <xsl:value-of select="$gpApp"/></title>
      </head>
      <body>
        <h1>Test Stylesheet: <xsl:value-of select="$gpApp"/></h1>
        <h2>Test Suite: <xsl:value-of select="$gpTestSuite"/></h2>
        <xsl:apply-templates/>
      </body>
    </html>
  </xsl:template>
 
  <xsl:template match="xsltu:test">
    <h3>Test: <xsl:value-of select="@id"/></h3>
    <ul>
      <xsl:apply-templates/>
    </ul>
  </xsl:template>
 
  <xsl:template match="xsltu:assert">
    <xsl:choose>
      <xsl:when test="(@outcome = 'passed')">
        <xsl:if test="($gpPassFail = 'pass')">
          <li><xsl:value-of select="@id"/> - 
	    <span style="color:green">Passed</span>
            </li>
        </xsl:if>
      </xsl:when>
 
      <xsl:when test="(@outcome = 'failed')">
        <li>
          <xsl:value-of select="@id"/>
          <xsl:text> - </xsl:text>
          <span style="color:red">Failed</span>
          <xsl:apply-templates/>
        </li>
      </xsl:when>
 
      <xsl:otherwise>
        <li>
          <xsl:value-of select="@id"/>
          <xsl:text> - </xsl:text>
          <span style="color:red">Failed</span>
          <xsl:apply-templates/>
        </li>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
 
  <xsl:template match="text()">
    <xsl:value-of select="normalize-space(translate(., '&#9;&#10;&#13;', ''))"/>
  </xsl:template>
 
  <xsl:template match="xsltu:no-match">
    <table>
      <tr>
        <td>Expected:</td>
        <td>
          <xsl:value-of select="xsltu:node[2]"/>
        </td>
      </tr>
      <tr>
        <td>Actual:</td>
        <td>
          <xsl:value-of select="xsltu:node[1]"/>
        </td>
      </tr>
    </table>
  </xsl:template>
 
</xsl:stylesheet>
