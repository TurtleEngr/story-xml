<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:xsltu="http://xsltunit.org/0/"
                version="1.0"
                extension-element-prefixes="exsl"
                exclude-result-prefixes="exsl">
    <xsl:import href="../../src/style/com-param.xsl" />
    <xsl:import href="xsltunit.xsl" />
    <xsl:output method="xml"
                version="1.0"
                encoding="UTF-8"
                indent="yes" />
    <xsl:template match="/">
        <xsltu:tests>
            <!-- ******************** -->
            <xsltu:test id="test-defaults">
	        <!-- .......... -->
                <xsl:call-template name="xsltu:assertEqual">
                    <xsl:with-param name="id"
                                    select="'gDTDVer'" />
                    <xsl:with-param name="pActualNodes">
                        <xsl:value-of select="$gDTDVer" />
                    </xsl:with-param>
                    <xsl:with-param name="pExpectNodes">4</xsl:with-param>
                </xsl:call-template>
	        <!-- .......... -->
                <xsl:call-template name="xsltu:assertEqual">
                    <xsl:with-param name="id"
                                    select="'gDTDVer'" />
                    <xsl:with-param name="pActualNodes">
                        <xsl:value-of select="$gDTDVer" />
                    </xsl:with-param>
                    <xsl:with-param name="pExpectNodes">4</xsl:with-param>
                </xsl:call-template>
            </xsltu:test>
 
        </xsltu:tests>
    </xsl:template>
 
</xsl:stylesheet>
