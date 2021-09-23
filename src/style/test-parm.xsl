<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:date="http://exslt.org/dates-and-times"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                exclude-result-prefixes="doc"
                xmlns:exsl="http://exslt.org/common"
                xmlns:str="http://exslt.org/strings"
                extension-element-prefixes="date doc exsl str">
    <xsl:include href="com-param.xsl" />
    <xsl:include href="com.xsl" />
    <xsl:output method="text" />
    <!-- ************************************************** -->
    <xsl:template match="/content/book">
        <xsl:apply-templates select="style-info" />
        <xsl:apply-templates select="preface" />
        <xsl:apply-templates select="chapter" />
        <xsl:apply-templates select="epilog" />
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="style-info">
        <xsl:call-template name="fDebugBook" />
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="preface">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:value-of select="concat('--------------- ', $tShow, $gNL)" />
        <xsl:if test="$tShow = '1'">
            <xsl:value-of select="concat('Show preface ',@id, ' ', title, $gNL)" />
        </xsl:if>
        <xsl:if test="$tShow = '0'">
            <xsl:value-of select="concat('Do not show preface ',@id, ' ', title, $gNL)" />
        </xsl:if>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="epilog">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:value-of select="concat('--------------- ', $tShow, $gNL)" />
        <xsl:if test="$tShow = '1'">
            <xsl:value-of select="concat('Show epilog ',@id, ' ', title, $gNL)" />
        </xsl:if>
        <xsl:if test="$tShow = '0'">
            <xsl:value-of select="concat('Do not show epilog ',@id, ' ', title, $gNL)" />
        </xsl:if>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="ch-preface">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:value-of select="concat('--------------- ', $tShow, $gNL)" />
        <xsl:if test="$tShow = '1'">
            <xsl:value-of select="concat('Show ch-preface ',@id, ' ', title, $gNL)" />
        </xsl:if>
        <xsl:if test="$tShow = '0'">
            <xsl:value-of select="concat('Do not show ch-preface ',@id, ' ', title, $gNL)" />
        </xsl:if>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="chapter">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:value-of select="concat('--------------- ', $tShow, $gNL)" />
        <xsl:if test="$tShow = '1'">
            <xsl:value-of select="concat('Show chapter ',@id, ' ', title, $gNL)" />
        </xsl:if>
        <xsl:if test="$tShow = '0'">
            <xsl:value-of select="concat('Do not show chapter ',@id, ' ', title, $gNL)" />
        </xsl:if>
        <xsl:apply-templates select="prolog" />
        <xsl:apply-templates select="unit" />
        <xsl:apply-templates select="postlog" />
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="prolog">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:value-of select="concat('--------------- ', $tShow, $gNL)" />
        <xsl:if test="$tShow = '1'">
            <xsl:value-of select="concat('Show prolog ',@id, ' ', title, $gNL)" />
        </xsl:if>
        <xsl:if test="$tShow = '0'">
            <xsl:value-of select="concat('Do not show prolog ',@id, ' ', title, $gNL)" />
        </xsl:if>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="postlog">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:value-of select="concat('--------------- ', $tShow, $gNL)" />
        <xsl:if test="$tShow = '1'">
            <xsl:value-of select="concat('Show postlog ',@id, ' ', title, $gNL)" />
        </xsl:if>
        <xsl:if test="$tShow = '0'">
            <xsl:value-of select="concat('Do not show postlog ',@id, ' ', title, $gNL)" />
        </xsl:if>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="unit">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:value-of select="concat('--------------- ', $tShow, $gNL)" />
        <xsl:if test="$tShow = '1'">
            <xsl:value-of select="concat('Show unit ',@id, ' ', title, $gNL)" />
        </xsl:if>
        <xsl:if test="$tShow = '0'">
            <xsl:value-of select="concat('Do not show unit ',@id, ' ', title, $gNL)" />
        </xsl:if>
        <xsl:apply-templates select="thread" />
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="thread">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:value-of select="concat('---------------', $gNL, 'gThreads=', $gThreads, $gNL)" />
        <xsl:value-of select="concat('thread/@ref=', @ref, $gNL)" />
        <xsl:value-of select="concat('thread/@who-refs=', @who-refs, $gNL)" />
        <xsl:if test="$tShow = '1'">
            <xsl:value-of select="concat('Active thread', $gNL)" />
        </xsl:if>
        <xsl:if test="$tShow = '0'">
            <xsl:value-of select="concat('Inactive thread', $gNL)" />
        </xsl:if>
        <xsl:apply-templates select="t" />
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="t">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:value-of select="concat(name(), '/@who-ref=', @who-ref, $gNL)" />
        <xsl:if test="$tShow = '1'">
            <xsl:value-of select="concat('Found who', $gNL)" />
        </xsl:if>
        <xsl:if test="$tShow = '0'">
            <xsl:value-of select="concat('Who not found', $gNL)" />
        </xsl:if>
    </xsl:template>
 
</xsl:stylesheet>
