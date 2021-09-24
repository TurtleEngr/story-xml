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
            <xsltu:test id="test-content-params">
	        <!-- .......... -->
		<xsl:variable name="test-book" select="document('sample-full.xml')"/>
                <xsl:call-template name="xsltu:assertEqual">
                    <xsl:with-param name="id"
                                    select="'Check gStyleName'" />
                    <xsl:with-param name="pActualNodes">
                        <xsl:value-of select="$gStyleName" />
                    </xsl:with-param>
                    <xsl:with-param name="pExpectNodes">
		    main
		    </xsl:with-param>
                </xsl:call-template>
            </xsltu:test>
	    
        </xsltu:tests>
    </xsl:template>
 
</xsl:stylesheet>
