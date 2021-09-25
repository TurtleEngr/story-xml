<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:exsl="http://exslt.org/common"
                xmlns:xsltu="http://xsltunit.org/0/"
                version="1.0"
                extension-element-prefixes="exsl"
                exclude-result-prefixes="exsl">
    <xsl:import href="../../src/style/com-param.xsl" />
    <xsl:import href="../../src/style/com.xsl" />
    <xsl:import href="../../src/style/com-html.xsl" />
    <xsl:import href="../../src/style/body-html.xsl" />
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
                <xsl:call-template name="xsltu:assertEqual">
                    <xsl:with-param name="id"
                                    select="'Check gStyleName'" />
                    <xsl:with-param name="pActualNodes">
                        <xsl:value-of select="$gStyleName" />
                    </xsl:with-param>
                    <xsl:with-param name="pExpectNodes">
                        <xsl:value-of select="'main'" />
                    </xsl:with-param>
                </xsl:call-template>
                <!-- .......... -->
                <xsl:call-template name="xsltu:assertEqual">
                    <xsl:with-param name="id"
                                    select="'Check gStyleRef'" />
                    <xsl:with-param name="pActualNodes">
                        <xsl:value-of select="$gStyleRef" />
                    </xsl:with-param>
                    <xsl:with-param name="pExpectNodes">
                        <xsl:value-of select="/content/book/style-info/def-style[1]" />
                    </xsl:with-param>
                </xsl:call-template>
                <!-- .......... -->
                <xsl:call-template name="xsltu:assertEqual">
                    <xsl:with-param name="id"
                                    select="'Check gContentRef'" />
                    <xsl:with-param name="pActualNodes">
                        <xsl:value-of select="$gContentRef" />
                    </xsl:with-param>
                    <xsl:with-param name="pExpectNodes">
                        <xsl:value-of select="/content/book/style-info/def-content[1]" />
                    </xsl:with-param>
                </xsl:call-template>
                <!-- .......... -->
                <xsl:call-template name="xsltu:assertEqual">
                    <xsl:with-param name="id"
                                    select="'Check gPrintRef'" />
                    <xsl:with-param name="pActualNodes">
                        <xsl:value-of select="$gPrintRef" />
                    </xsl:with-param>
                    <xsl:with-param name="pExpectNodes">
                        <xsl:value-of select="/content/book/style-info/def-print[1]" />
                    </xsl:with-param>
                </xsl:call-template>
                <!-- .......... -->
                <xsl:call-template name="xsltu:assertEqual">
                    <xsl:with-param name="id"
                                    select="'Check gDraftRef'" />
                    <xsl:with-param name="pActualNodes">
                        <xsl:value-of select="$gDraftRef" />
                    </xsl:with-param>
                    <xsl:with-param name="pExpectNodes">
                        <xsl:value-of select="/content/book/style-info/def-draft[1]" />
                    </xsl:with-param>
                </xsl:call-template>
                <!-- .......... -->
                <xsl:call-template name="xsltu:assertEqual">
                    <xsl:with-param name="id"
                                    select="'Check gDraft'" />
                    <xsl:with-param name="pActualNodes">
                        <xsl:value-of select="$gDraft" />
                    </xsl:with-param>
                    <xsl:with-param name="pExpectNodes">
                        <xsl:value-of select="boolean(0)" />
                    </xsl:with-param>
                </xsl:call-template>
                <!-- .......... -->
                <xsl:call-template name="xsltu:assertEqual">
                    <xsl:with-param name="id"
                                    select="'Check gDebug'" />
                    <xsl:with-param name="pActualNodes">
                        <xsl:value-of select="$gDebug" />
                    </xsl:with-param>
                    <xsl:with-param name="pExpectNodes">
                        <xsl:value-of select="boolean(0)" />
                    </xsl:with-param>
                </xsl:call-template>
                <!-- .......... -->
                <xsl:call-template name="xsltu:assertEqual">
                    <xsl:with-param name="id"
                                    select="'Check gThreads'" />
                    <xsl:with-param name="pActualNodes">
                        <xsl:value-of select="$gThreads" />
                    </xsl:with-param>
                    <xsl:with-param name="pExpectNodes">
                        <xsl:value-of select="' main '" />
                    </xsl:with-param>
                </xsl:call-template>
                <!-- .......... -->
                <xsl:call-template name="xsltu:assertEqual">
                    <xsl:with-param name="id"
                                    select="'Check gChStatus'" />
                    <xsl:with-param name="pActualNodes">
                        <xsl:value-of select="$gChStatus" />
                    </xsl:with-param>
                    <xsl:with-param name="pExpectNodes">
                        <xsl:value-of select="',final,draft,in-progress,'" />
                    </xsl:with-param>
                </xsl:call-template>
                <!-- .......... -->
                <xsl:call-template name="xsltu:assertEqual">
                    <xsl:with-param name="id"
                                    select="'Check gUnitStatus'" />
                    <xsl:with-param name="pActualNodes">
                        <xsl:value-of select="$gUnitStatus" />
                    </xsl:with-param>
                    <xsl:with-param name="pExpectNodes">
                        <xsl:value-of select="',final,draft,in-progress,'" />
                    </xsl:with-param>
                </xsl:call-template>
                <!-- .......... -->
                <xsl:call-template name="xsltu:assertEqual">
                    <xsl:with-param name="id"
                                    select="'Check gContentLink'" />
                    <xsl:with-param name="pActualNodes">
                        <xsl:value-of select="$gContentLink" />
                    </xsl:with-param>
                    <xsl:with-param name="pExpectNodes">
                        <xsl:value-of select="'default'" />
                    </xsl:with-param>
                </xsl:call-template>
            </xsltu:test>
 
        </xsltu:tests>
    </xsl:template>
 
</xsl:stylesheet>
