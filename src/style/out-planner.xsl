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
$Header: /repo/local.cvs/app/story-xml/src/story5/out-planner.xsl,v 1.4 2009/04/03 06:00:13 bruce Exp $
-->
  <xsl:param name="gDraft"
             select="boolean(number('1'))" />
  <xsl:include href="com-param.xsl" />
  <xsl:include href="com-html.xsl" />
  <xsl:include href="com.xsl" />
  <xsl:include href="com-timeline.xsl" />
  <!-- ************************************************** -->
  <xsl:template match="/content">
    <xsl:apply-templates select="book" />
  </xsl:template>
  <!-- ************************************************** -->
  <xsl:template match="book">
    <xsl:call-template name="fTimeline" />
    <xsl:call-template name="fFmtPlanner" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fFmtPlanner">
    <!--
Output the timeline as a MrProject file (now called Planner).
Units -> tasks
def-who -> resources
def-where -> resources
def-thread -> resources
-->
    <exsl:document method="xml"
                   href="{concat(@id, '-timeline.planner')}">
      <xsl:apply-templates select="document('/tmp/timeline.xml')"
                           mode="planner" />
    </exsl:document>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="timeline"
                mode="planner">
    <xsl:element name="project">
      <xsl:attribute name="name">
        <xsl:value-of select="title/@id" />
      </xsl:attribute>
      <xsl:attribute name="company">
        <xsl:value-of select="publisher-name" />
      </xsl:attribute>
      <xsl:attribute name="manager">
        <xsl:value-of select="concat(author/first-name, ' ', author/surname)" />
      </xsl:attribute>
      <xsl:attribute name="phase">
        <xsl:value-of select="title/@revision" />
      </xsl:attribute>
      <xsl:attribute name="project-start">
        <xsl:value-of select="concat(def-when/@year, format-number(def-when/@month, '00'), format-number(def-when/@day, '00'), 'T', format-number(def-when/@hour, '00'), format-number(def-when/@min, '00'), '00Z')" />
      </xsl:attribute>
      <xsl:attribute name="mrproject-version">
        <xsl:value-of select="'2'" />
      </xsl:attribute>
      <xsl:attribute name="calendar">
        <xsl:value-of select="'1'" />
      </xsl:attribute>
      <properties>
        <property name="cost"
                  type="cost"
                  owner="resource"
                  label="Cost"
                  description="standard cost for a resource" />
      </properties>
      <phases>
        <phase name="in-progress" />
        <phase name="draft" />
        <phase name="final" />
      </phases>
      <calendars>
        <day-types>
          <day-type id="0"
                    name="Working"
                    description="A default working day" />
          <day-type id="1"
                    name="Nonworking"
                    description="A default non working day" />
          <day-type id="2"
                    name="Use base"
                    description="Use day from base calendar" />
        </day-types>
        <calendar id="1"
                  name="Default">
          <default-week mon="0"
                        tue="0"
                        wed="0"
                        thu="0"
                        fri="0"
                        sat="0"
                        sun="0" />
          <overridden-day-types>
            <overridden-day-type id="0">
              <interval start="0000"
                        end="2359" />
            </overridden-day-type>
          </overridden-day-types>
          <days />
        </calendar>
      </calendars>
      <tasks>
        <xsl:for-each select="record[@r-type='start']">
          <xsl:element name="task">
            <xsl:attribute name="id">
              <xsl:value-of select="position()" />
            </xsl:attribute>
            <xsl:attribute name="name">
              <xsl:value-of select="substring(concat(@unit, ': ', @title), 1, 30)" />
            </xsl:attribute>
            <xsl:attribute name="note">
              <xsl:value-of select="concat(@type, '; when: ', when, '; ', who/@ref, ':who: ', who, '; ', where/@ref, ':where: ', where, '; ', note)" />
            </xsl:attribute>
            <xsl:attribute name="work">
              <xsl:value-of select="date:seconds(@duration)" />
            </xsl:attribute>
            <xsl:attribute name="start">
              <xsl:value-of select="translate(@u-date, '-:', '')" />
            </xsl:attribute>
            <xsl:attribute name="end">
              <xsl:value-of select="translate(@u-end-date, '-:', '')" />
            </xsl:attribute>
            <xsl:attribute name="percent-complete">
              <xsl:if test="@type = 'sequel'">
                <xsl:value-of select="'0'" />
              </xsl:if>
              <xsl:if test="@type = 'scene'">
                <xsl:value-of select="'100'" />
              </xsl:if>
            </xsl:attribute>
            <xsl:attribute name="type">
              <xsl:value-of select="'normal'" />
            </xsl:attribute>
            <!--
            <xsl:attribute name="scheduling">
              <xsl:value-of select="'fixed-duration'" />
            </xsl:attribute>
-->
            <xsl:element name="constraint">
              <xsl:attribute name="type">
                <xsl:value-of select="'start-no-earlier-than'" />
              </xsl:attribute>
              <xsl:attribute name="time">
                <xsl:value-of select="translate(@u-date, '-:', '')" />
              </xsl:attribute>
            </xsl:element>
            <xsl:if test="position() != 1">
              <predecessors>
                <predecessor id="1"
                             type="FS"
                             predecessor-id="{position() - 1}" />
              </predecessors>
            </xsl:if>
          </xsl:element>
        </xsl:for-each>
      </tasks>
      <resource-groups />
      <resources>
        <xsl:for-each select="def-who|def-where|def-thread">
          <resource id="{position()}">
            <xsl:attribute name="name">
              <xsl:value-of select="@id" />
              <xsl:choose>
                <xsl:when test="name() = 'def-who'">
                  <xsl:value-of select="':who'" />
                </xsl:when>
                <xsl:when test="name() = 'def-where'">
                  <xsl:value-of select="':where'" />
                </xsl:when>
                <xsl:when test="name() = 'def-thread'">
                  <xsl:value-of select="':thread'" />
                </xsl:when>
              </xsl:choose>
            </xsl:attribute>
            <xsl:attribute name="type">
              <xsl:value-of select="1" />
            </xsl:attribute>
            <xsl:attribute name="units">
              <xsl:value-of select="0" />
            </xsl:attribute>
            <xsl:attribute name="email">
              <xsl:value-of select="''" />
            </xsl:attribute>
            <xsl:attribute name="note">
              <xsl:value-of select="." />
            </xsl:attribute>
            <xsl:attribute name="std-rate">
              <xsl:value-of select="0" />
            </xsl:attribute>
            <xsl:attribute name="calendar">
              <xsl:value-of select="1" />
            </xsl:attribute>
            <properties>
              <property name="cost"
                        value="" />
            </properties>
          </resource>
        </xsl:for-each>
      </resources>
      <allocations />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
</xsl:stylesheet>
