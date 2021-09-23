<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:date="http://exslt.org/dates-and-times"
                extension-element-prefixes="date">
    <!--
add: @deleted to def-draft
add: @thread-all to def-draft
add: @def-when to def-draft
add: def-when to story-info (default times)
del: @duration from unit (convert to end-date only)
change: start-date and end-date to use attr, not XML date fmt

=================
def-draft
        @deleted='1'
        @thread-all='1'
        @def-when='1'

story-info
        def-when
                @year="1992"
                @month="12"
                @day="27"
                @hour="8"
                @min="0"
                @gmt="-08"

unit
        outline
                when
                        start-date
                                @year="1992"
                                @month="12"
                                @day="27"
                                @hour="8"
                                @min="0"
                                @gmt="-08"
                        end-date        
                                @year="1992"
                                @month="12"
                                @day="27"
                                @hour="8"
                                @min="0"
                                @gmt="-08"
                        descripton
-->
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
    <xsl:template match="content">
        <xsl:if test="number(story-dtd/@version) != 3">
            <xsl:message terminate="yes">
                <xsl:value-of select="'Error: document story-dtd version needs to be 3'" />
            </xsl:message>
        </xsl:if>
        <xsl:element name="content">
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="story-dtd">
        <xsl:element name="story-dtd">
            <xsl:attribute name="version">
                <xsl:value-of select="'4'" />
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="story-info">
        <xsl:element name="story-info">
            <xsl:apply-templates select="@*" />
            <xsl:if test="not(def-when)">
                <def-when year="2000"
                          month="01"
                          day="01"
                          hour="08"
                          min="01"
                          gmt="-08" />
            </xsl:if>
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="start-date">
        <!--
    <xsl:variable name="tDate" select="date:date-time(.)"/>
-->
        <xsl:variable name="tDate"
                      select="." />
        <xsl:message>
            <xsl:value-of select="concat('start-date ', .,'=',$tDate)" />
        </xsl:message>
        <xsl:element name="start-date">
            <xsl:attribute name="year">
                <xsl:value-of select="date:year($tDate)" />
            </xsl:attribute>
            <xsl:attribute name="month">
                <xsl:value-of select="date:month-in-year($tDate)" />
            </xsl:attribute>
            <xsl:attribute name="day">
                <xsl:value-of select="date:day-in-month($tDate)" />
            </xsl:attribute>
            <xsl:attribute name="hour">
                <xsl:value-of select="date:hour-in-day($tDate)" />
            </xsl:attribute>
            <xsl:attribute name="min">
                <xsl:value-of select="date:minute-in-hour($tDate)" />
            </xsl:attribute>
            <xsl:attribute name="gmt">
                <xsl:value-of select="'-08'" />
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="end-date">
        <!--
    <xsl:variable name="tDate" select="date:date-time(.)"/>
-->
        <xsl:variable name="tDate"
                      select="." />
        <xsl:message>
            <xsl:value-of select="concat('end-date ',.,'=',$tDate)" />
        </xsl:message>
        <xsl:element name="end-date">
            <xsl:attribute name="year">
                <xsl:value-of select="date:year($tDate)" />
            </xsl:attribute>
            <xsl:attribute name="month">
                <xsl:value-of select="date:month-in-year($tDate)" />
            </xsl:attribute>
            <xsl:attribute name="day">
                <xsl:value-of select="date:day-in-month($tDate)" />
            </xsl:attribute>
            <xsl:attribute name="hour">
                <xsl:value-of select="date:hour-in-day($tDate)" />
            </xsl:attribute>
            <xsl:attribute name="min">
                <xsl:value-of select="date:minute-in-hour($tDate)" />
            </xsl:attribute>
            <xsl:attribute name="gmt">
                <xsl:value-of select="'-08'" />
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="duration">
        <!--
    <xsl:variable name="tStartDate" select="date:date-time(../start-date)"/>
-->
        <xsl:variable name="tStartDate"
                      select="../start-date" />
        <xsl:variable name="tDate"
                      select="date:add($tStartDate, .)" />
        <xsl:message>
            <xsl:value-of select="concat('duration ',.,'=',$tDate)" />
        </xsl:message>
        <xsl:element name="end-date">
            <xsl:attribute name="year">
                <xsl:value-of select="date:year($tDate)" />
            </xsl:attribute>
            <xsl:attribute name="month">
                <xsl:value-of select="date:month-in-year($tDate)" />
            </xsl:attribute>
            <xsl:attribute name="day">
                <xsl:value-of select="date:day-in-month($tDate)" />
            </xsl:attribute>
            <xsl:attribute name="hour">
                <xsl:value-of select="date:hour-in-day($tDate)" />
            </xsl:attribute>
            <xsl:attribute name="min">
                <xsl:value-of select="date:minute-in-hour($tDate)" />
            </xsl:attribute>
            <xsl:attribute name="gmt">
                <xsl:value-of select="'-08'" />
            </xsl:attribute>
        </xsl:element>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="def-draft">
        <xsl:element name="def-draft">
            <xsl:attribute name="deleted">
                <xsl:value-of select="'1'" />
            </xsl:attribute>
            <xsl:attribute name="thread-all">
                <xsl:value-of select="'1'" />
            </xsl:attribute>
            <xsl:attribute name="def-when">
                <xsl:value-of select="'1'" />
            </xsl:attribute>
            <xsl:apply-templates select="@*" />
            <xsl:apply-templates />
        </xsl:element>
    </xsl:template>
 
    <!-- ******************** -->
</xsl:stylesheet>
