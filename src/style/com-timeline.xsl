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
  <!-- ******************** -->
  <xsl:template name="fTimeline">
    <exsl:document method="xml"
                   href="/tmp/timeline.xml">
      <timeline>
        <title>
          <xsl:attribute name="id">
            <xsl:value-of select="@id" />
          </xsl:attribute>
          <xsl:attribute name="revision">
            <xsl:value-of select="@revision" />
          </xsl:attribute>
          <xsl:value-of select="concat(@id, ' Timeline - ', title)" />
        </title>
        <xsl:copy-of select="story-info/def-when" />
        <xsl:copy-of select="story-info/def-who" />
        <xsl:copy-of select="story-info/def-where" />
        <xsl:copy-of select="story-info/def-thread" />
        <xsl:copy-of select="book-info/author-group/author[1]" />
        <xsl:copy-of select="book-info/publisher/publisher-name" />
        <xsl:apply-templates select="chapter"
                             mode="timeline" />
      </timeline>
    </exsl:document>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="chapter"
                mode="timeline">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1' and @revision-flag != 'deleted'">
      <xsl:apply-templates select="unit"
                           mode="timeline" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="unit"
                mode="timeline">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1' and @revision-flag != 'deleted'">
      <xsl:variable name="tStartDate">
        <xsl:call-template name="fToXMLTime">
          <xsl:with-param name="pNode"
                          select="outline/when/start-date" />
          <xsl:with-param name="pDefNode1"
                          select="/content/book/story-info/def-when" />
          <xsl:with-param name="pDefNode2"
                          select="/content/book/story-info/def-when" />
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="tUStartDate">
        <xsl:value-of select="date:add($tStartDate, 'P0DT0H')" />
      </xsl:variable>
      <xsl:variable name="tEndDate">
        <xsl:call-template name="fToXMLTime">
          <xsl:with-param name="pNode"
                          select="outline/when/end-date" />
          <xsl:with-param name="pDefNode1"
                          select="outline/when/start-date" />
          <xsl:with-param name="pDefNode2"
                          select="/content/book/story-info/def-when" />
        </xsl:call-template>
      </xsl:variable>
      <xsl:variable name="tUEndDate">
        <xsl:value-of select="date:add($tEndDate, 'P0DT0H')" />
      </xsl:variable>
      <xsl:variable name="tDuration">
        <xsl:value-of select="date:difference($tStartDate, $tEndDate)" />
      </xsl:variable>
      <xsl:element name="record">
        <xsl:attribute name="u-date">
          <xsl:value-of select="$tUStartDate" />
        </xsl:attribute>
        <xsl:attribute name="date">
          <xsl:value-of select="$tStartDate" />
        </xsl:attribute>
        <xsl:attribute name="u-end-date">
          <xsl:value-of select="$tUEndDate" />
        </xsl:attribute>
        <xsl:attribute name="end-date">
          <xsl:value-of select="$tEndDate" />
        </xsl:attribute>
        <xsl:attribute name="duration">
          <xsl:value-of select="$tDuration" />
        </xsl:attribute>
        <xsl:attribute name="r-type">
          <xsl:value-of select="'start'" />
        </xsl:attribute>
        <xsl:attribute name="ch">
          <xsl:value-of select="../@id" />
        </xsl:attribute>
        <xsl:attribute name="unit">
          <xsl:value-of select="@id" />
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="@type" />
        </xsl:attribute>
        <xsl:attribute name="title">
          <xsl:value-of select="title" />
        </xsl:attribute>
        <when>
          <xsl:value-of select="outline/when/description" />
        </when>
        <xsl:for-each select="outline/where">
          <where ref="{@ref}">
            <xsl:value-of select="outline/where" />
          </where>
        </xsl:for-each>
        <xsl:for-each select="outline/who">
          <who ref="{@ref}">
            <xsl:value-of select="outline/who" />
          </who>
        </xsl:for-each>
        <xsl:for-each select="thread">
          <thread ref="{@ref}" />
        </xsl:for-each>
        <note>
          <xsl:value-of select="outline/description" />
        </note>
      </xsl:element>
      <xsl:element name="record">
        <xsl:attribute name="u-date">
          <xsl:value-of select="$tUEndDate" />
        </xsl:attribute>
        <xsl:attribute name="date">
          <xsl:value-of select="$tEndDate" />
        </xsl:attribute>
        <xsl:attribute name="r-type">
          <xsl:value-of select="'end'" />
        </xsl:attribute>
        <xsl:attribute name="ch">
          <xsl:value-of select="../@id" />
        </xsl:attribute>
        <xsl:attribute name="unit">
          <xsl:value-of select="@id" />
        </xsl:attribute>
        <xsl:attribute name="type">
          <xsl:value-of select="@type" />
        </xsl:attribute>
        <xsl:attribute name="title">
          <xsl:value-of select="title" />
        </xsl:attribute>
        <xsl:attribute name="duration">
          <xsl:value-of select="$tDuration" />
        </xsl:attribute>
      </xsl:element>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fFmtTimeline">
    <exsl:document method="html"
                   href="{concat(@id, '-timeline.html')}">
      <xsl:apply-templates select="document('/tmp/timeline.xml')"
                           mode="html" />
    </exsl:document>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="timeline"
                mode="html">
    <html>
      <head>
        <title>
          <xsl:value-of select="title" />
        </title>
      </head>
      <body>
      <h1>
        <xsl:value-of select="title" />
      </h1>
      <h2>Filters</h2>
      <xsl:if test="$gContentRef/@ch-refs != ''">Chapter List: 
      <xsl:value-of select="$gContentRef/@ch-refs" />
      <br /></xsl:if>Thread: 
      <xsl:value-of select="$gContentRef/@thread-refs" />
      <xsl:if test="$gDraftRef/@thread-all-vp = '1'">
        <xsl:value-of select="' (thread-all-vp)'" />
      </xsl:if>
      <br />
      <xsl:if test="$gContentRef/@ch-final = '1'">ch-final</xsl:if>
      <xsl:if test="$gContentRef/@ch-in-progress = '1'">
      ch-in-progress</xsl:if>
      <xsl:if test="$gContentRef/@ch-draft = '1'">ch-draft</xsl:if>
      <br />
      <xsl:if test="$gContentRef/@unit-final = '1'">unit-final</xsl:if>
      <xsl:if test="$gContentRef/@unit-in-progress = '1'">
      unit-in-progress</xsl:if>
      <xsl:if test="$gContentRef/@unit-draft = '1'">unit-draft</xsl:if>
      <br />
      <h2>Units</h2>
      <table border="1"
             cellpadding="4"
             cellspacing="0">
        <tr align="left">
          <th>Time</th>
          <th>Ch</th>
          <th>Unit</th>
          <th></th>
          <th>Type</th>
          <th wrap="1">Title/Elapsed</th>
          <th>Where</th>
          <th wrap="1">Who</th>
        </tr>
        <xsl:for-each select="record">
          <xsl:sort select="@u-date" />
          <tr>
            <td>
              <xsl:call-template name="fFmtXMLTime">
                <xsl:with-param name="pTime"
                                select="@date" />
                <xsl:with-param name="pTag"
                                select="'&lt;br/&gt;'" />
                <xsl:with-param name="pDay"
                                select="1" />
              </xsl:call-template>
            </td>
            <td>
              <xsl:value-of select="@ch" />
            </td>
            <td>
              <xsl:value-of select="@unit" />
            </td>
            <td>
              <xsl:value-of select="@r-type" />
            </td>
            <td>
              <xsl:value-of select="@type" />
            </td>
            <xsl:if test="@r-type = 'start'">
              <td>
                <xsl:value-of select="@title" />
              </td>
              <td>
                <xsl:value-of select="concat(where/@ref, '; ')" />
              </td>
              <td>
                <xsl:value-of select="concat(who/@ref, '; ')" />
              </td>
            </xsl:if>
            <xsl:if test="@r-type = 'end'">
              <td>
                <xsl:value-of select="@duration" />
              </td>
              <td></td>
              <td></td>
            </xsl:if>
          </tr>
        </xsl:for-each>
      </table></body>
    </html>
  </xsl:template>
  <!-- ******************** -->
</xsl:stylesheet>
