<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:date="http://exslt.org/dates-and-times"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                exclude-result-prefixes="doc"
                xmlns:exsl="http://exslt.org/common"
                xmlns:str="http://exslt.org/strings"
                extension-element-prefixes="date doc exsl str">
    <!--
        extension-element-prefixes="date doc exsl str"
-->
    <xsl:output method="html"
                indent="yes" />
    <xsl:param name="gDraft"
               select="boolean(number('0'))" />
    <xsl:include href="com-param.xsl" />
    <xsl:include href="com-html.xsl" />
    <xsl:include href="com.xsl" />
    <xsl:include href="body-html.xsl" />
    <!-- ************************************************** -->
    <xsl:template match="/content">
        <xsl:apply-templates select="book" />
        <xsl:call-template name="fOutputList" />
    </xsl:template>
 
</xsl:stylesheet>
