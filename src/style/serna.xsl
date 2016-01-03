<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <!--
$Header: /repo/local.cvs/app/story-xml/src/story5/serna.xsl,v 1.2 2009/03/29 05:11:49 bruce Exp $
-->
  <!-- **************************************** -->
  <xsl:import href="/usr/local/serna/xml/stylesheets/xslbricks/fo/fo.xsl" />
  <xsl:param name="body.master">16</xsl:param>
  <xsl:strip-space elements="*" />
  <xsl:preserve-space elements="pre pre.decoration pre-fmt" />
  <!-- ****************************** -->
  <xsl:param name="gThreads">
    <xsl:value-of select="concat(' ', /content/book/style-info/@thread-refs, ' ')" />
  </xsl:param>
  <!-- ********************************************************************
Block
-->
  <!-- ****************************** -->
  <xsl:template match="story-dtd">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="color"
                      select="'red'" />
      <xsl:with-param name="content">
        <xsl:call-template name="h4">
          <xsl:with-param name="content">
            <xsl:value-of select="concat(name(), 'version=', @version)" />
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="book/title">
    <xsl:call-template name="h1">
      <xsl:with-param name="content">
        <xsl:call-template name="inline.decoration">
          <xsl:with-param name="color"
                          select="'black'" />
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="chapter/title">
    <xsl:call-template name="h2">
      <xsl:with-param name="content">
        <xsl:call-template name="inline.decoration">
          <xsl:with-param name="color"
                          select="'black'" />
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="subtitle|ch-preface/title|preface/title|epilog/title|prolog/title|postlog/title|ch-preface/title">

    <xsl:call-template name="h3">
      <xsl:with-param name="content">
        <xsl:call-template name="inline.decoration">
          <xsl:with-param name="color"
                          select="'black'" />
        </xsl:call-template>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="unit/title">
    <xsl:call-template name="h4" />
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="p">
    <xsl:variable name="color">
      <xsl:choose>
        <xsl:when test="contains($gThreads, concat(' ', ../@ref, ' '))">
          <xsl:value-of select="'black'" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'red'" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="padding"
                      select="'30pt'" />
      <xsl:with-param name="start-indent"
                      select="'0pt'" />
      <xsl:with-param name="end-indent"
                      select="'0pt'" />
      <xsl:with-param name="color"
                      select="$color" />
      <xsl:with-param name="content">
        <xsl:value-of select="' '" />
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="ch-preface/para|preface/para|epilog/para|prolog/para|postlog/para">

    <xsl:call-template name="para.decoration">
      <xsl:with-param name="padding"
                      select="'30pt'" />
      <xsl:with-param name="start-indent"
                      select="'0pt'" />
      <xsl:with-param name="end-indent"
                      select="'0pt'" />
      <xsl:with-param name="color"
                      select="'black'" />
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="para">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="padding"
                      select="'30pt'" />
      <xsl:with-param name="start-indent"
                      select="'0pt'" />
      <xsl:with-param name="end-indent"
                      select="'0pt'" />
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="ch-preface/pre-fmt|preface/pre-fmt|epilog/pre-fmt|prolog/pre-fmt|postlog/pre-fmt">

    <xsl:call-template name="pre.decoration">
      <xsl:with-param name="color"
                      select="'black'" />
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="pre-fmt">
    <xsl:call-template name="pre.decoration">
      <xsl:with-param name="color"
                      select="'red'" />
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="pre">
    <xsl:variable name="color">
      <xsl:choose>
        <xsl:when test="contains($gThreads, concat(' ', ../@ref, ' '))">
          <xsl:value-of select="'black'" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'red'" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:call-template name="pre.decoration">
      <xsl:with-param name="color"
                      select="$color" />
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="s">
    <xsl:variable name="color">
      <xsl:choose>
        <xsl:when test="contains($gThreads, concat(' ', ../@ref, ' '))">
          <xsl:value-of select="'black'" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'red'" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="padding"
                      select="'0pt'" />
      <xsl:with-param name="start-indent"
                      select="'0pt'" />
      <xsl:with-param name="end-indent"
                      select="'0pt'" />
      <xsl:with-param name="color"
                      select="$color" />
      <xsl:with-param name="content">
        <xsl:value-of select="' '" />
        <xsl:apply-templates />
        <xsl:if test="@who-ref">
          <xsl:call-template name="para.decoration">
            <xsl:with-param name="color"
                            select="'red'" />
            <xsl:with-param name="content">
              <xsl:value-of select="' [who-ref='" />
              <xsl:value-of select="@who-ref" />
              <xsl:value-of select="']'" />
            </xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="t">
    <xsl:variable name="color">
      <xsl:choose>
        <xsl:when test="contains($gThreads, concat(' ', ../@ref, ' '))">
          <xsl:value-of select="'black'" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="'red'" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="padding"
                      select="'0pt'" />
      <xsl:with-param name="start-indent"
                      select="'0pt'" />
      <xsl:with-param name="end-indent"
                      select="'0pt'" />
      <xsl:with-param name="color"
                      select="$color" />
      <xsl:with-param name="content">
        <xsl:choose>
          <xsl:when test="contains(concat(' ', ../@who-refs, ' '), concat(' ', @who-ref, ' '))">

            <xsl:value-of select="' '" />
            <xsl:apply-templates />
          </xsl:when>
          <xsl:otherwise>
            <xsl:call-template name="para.decoration">
              <xsl:with-param name="padding"
                              select="'0pt'" />
              <xsl:with-param name="start-indent"
                              select="'0pt'" />
              <xsl:with-param name="end-indent"
                              select="'0pt'" />
              <xsl:with-param name="font-style"
                              select="'italic'" />
              <xsl:with-param name="color"
                              select="'red'" />
              <xsl:with-param name="content">
                <xsl:value-of select="' '" />
                <xsl:apply-templates />
                <xsl:value-of select="concat(' [who-ref= ',@who-ref,']')" />
              </xsl:with-param>
            </xsl:call-template>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="rev">
    <xsl:choose>
      <xsl:when test="@revision-flag='changed'">
        <xsl:call-template name="inline.decoration">
          <xsl:with-param name="color"
                          select="'blue'" />
          <xsl:with-param name="text-decoration"
                          select="'underline'" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="@revision-flag='added'">
        <xsl:call-template name="inline.decoration">
          <xsl:with-param name="color"
                          select="'green'" />
          <xsl:with-param name="text-decoration"
                          select="'underline'" />
        </xsl:call-template>
      </xsl:when>
      <xsl:when test="@revision-flag='deleted'">
        <xsl:call-template name="inline.decoration">
          <xsl:with-param name="color"
                          select="'red'" />
          <xsl:with-param name="text-decoration"
                          select="'strike'" />
        </xsl:call-template>
      </xsl:when>
    </xsl:choose>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="style-info">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="color"
                      select="'red'" />
      <xsl:with-param name="content">
        <xsl:call-template name="h4">
          <xsl:with-param name="content">
            <xsl:value-of select="'style-info'" />
            <xsl:value-of select="concat('; style-ref=', @style-ref)" />
            <xsl:value-of select="concat('; thread-refs=',@thread-refs)" />
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="def-style">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="color"
                      select="'red'" />
      <xsl:with-param name="content">
        <xsl:call-template name="h4">
          <xsl:with-param name="content">
            <xsl:value-of select="'def-style'" />
            <xsl:value-of select="concat('; id=',@id)" />
            <xsl:value-of select="concat('; content-ref=',@content-ref)" />
            <xsl:value-of select="concat('; print-ref=',@print-ref)" />
            <xsl:value-of select="concat('; draft-ref=',@draft-ref)" />
            <xsl:value-of select="concat('; draft=',@draft)" />
            <xsl:value-of select="concat('; debug=',@debug)" />
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="chapter|book">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="color"
                      select="'black'" />
      <xsl:with-param name="content">
        <xsl:call-template name="para.decoration">
          <xsl:with-param name="color"
                          select="'red'" />
          <xsl:with-param name="content">
            <xsl:value-of select="'['" />
            <xsl:value-of select="name()" />
            <xsl:value-of select="' id='" />
            <xsl:value-of select="@id" />
            <xsl:value-of select="'; revision='" />
            <xsl:value-of select="@revision" />
            <xsl:value-of select="']'" />
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="unit">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="color"
                      select="'black'" />
      <xsl:with-param name="content">
        <xsl:call-template name="para.decoration">
          <xsl:with-param name="color"
                          select="'red'" />
          <xsl:with-param name="content">
            <xsl:value-of select="'[unit type='" />
            <xsl:value-of select="@type" />
            <xsl:value-of select="'; id='" />
            <xsl:value-of select="@id" />
            <xsl:value-of select="'; revision='" />
            <xsl:value-of select="@revision" />
            <xsl:value-of select="']'" />
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="thread">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="color"
                      select="'black'" />
      <xsl:with-param name="content">
        <xsl:call-template name="para.decoration">
          <xsl:with-param name="color"
                          select="'red'" />
          <xsl:with-param name="content">
            <xsl:value-of select="'[thread ref='" />
            <xsl:value-of select="@ref" />
            <xsl:value-of select="'; who-refs='" />
            <xsl:value-of select="@who-refs" />
            <xsl:value-of select="']'" />
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ********************************************************************
Inline
 -->
  <!-- ****************************** -->
  <xsl:template match="b">
    <xsl:call-template name="bold.inline" />
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="i">
    <xsl:call-template name="italic.inline" />
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="tt">
    <xsl:call-template name="monospace.inline" />
  </xsl:template>
  <!-- ********************************************************************
Draft only
-->
  <!-- ****************************** -->
  <xsl:template match="def-img">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="color"
                      select="'red'" />
      <xsl:with-param name="content">
        <xsl:call-template name="h4">
          <xsl:with-param name="content">
            <xsl:value-of select="'def-img'" />
            <xsl:value-of select="concat('; id=',@id)" />
            <xsl:value-of select="concat('; base-ref=',@base-ref)" />
            <xsl:value-of select="concat('; url=',@url)" />
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="def-link">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="color"
                      select="'red'" />
      <xsl:with-param name="content">
        <xsl:call-template name="h4">
          <xsl:with-param name="content">
            <xsl:value-of select="'def-link'" />
            <xsl:value-of select="concat('; id=',@id)" />
            <xsl:value-of select="concat('; base-ref=',@base-ref)" />
            <xsl:value-of select="concat('; url=',@url)" />
            <xsl:value-of select="concat('; img-ref=',@img-ref)" />
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="link">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="color"
                      select="'black'" />
      <xsl:with-param name="content">
        <xsl:call-template name="para.decoration">
          <xsl:with-param name="color"
                          select="'red'" />
          <xsl:with-param name="content">
            <xsl:value-of select="'link;'" />
            <xsl:value-of select="concat(' ref=',@ref)" />
            <xsl:if test="@img=1">
              <xsl:value-of select="concat('; img=',@img)" />
            </xsl:if>
            <xsl:if test="@title=1">
              <xsl:value-of select="concat('; title=',@title)" />
            </xsl:if>
            <xsl:if test="@url=1">
              <xsl:value-of select="concat('; url=',@url)" />
            </xsl:if>
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="img">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="color"
                      select="'black'" />
      <xsl:with-param name="content">
        <xsl:call-template name="para.decoration">
          <xsl:with-param name="color"
                          select="'red'" />
          <xsl:with-param name="content">
            <xsl:value-of select="'[img'" />
            <xsl:value-of select="concat('; ref=',@ref)" />
            <xsl:value-of select="']'" />
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="def-draft|def-print|def-content|def-who|def-where|def-thread|def-base">

    <xsl:call-template name="para.decoration">
      <xsl:with-param name="color"
                      select="'red'" />
      <xsl:with-param name="content">
        <xsl:call-template name="h4">
          <xsl:with-param name="content">
            <xsl:value-of select="name()" />
            <xsl:value-of select="concat('; id=',@id)" />
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="who|where">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="color"
                      select="'red'" />
      <xsl:with-param name="content">
        <xsl:call-template name="h4">
          <xsl:with-param name="content">
            <xsl:value-of select="name()" />
            <xsl:value-of select="' ref='" />
            <xsl:value-of select="@ref" />
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="outline">
    <xsl:call-template name="para.decoration">
      <xsl:with-param name="color"
                      select="'red'" />
      <xsl:with-param name="content">
        <xsl:call-template name="h4">
          <xsl:with-param name="content">
            <xsl:value-of select="'Outline'" />
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template name="fSayDuration">
    <xsl:variable name="year"
                  select="substring-before(substring-after(.,'P'),'Y')" />
    <xsl:variable name="month"
                  select="substring-before(substring-after(.,'Y'),'M')" />
    <xsl:variable name="day"
                  select="substring-before(substring-after(.,'M'),'D')" />
    <xsl:variable name="hour"
                  select="substring-before(substring-after(.,'DT'),'H')" />
    <xsl:variable name="min"
                  select="substring-before(substring-after(.,'H'),'M')" />
    <xsl:value-of select="' '" />
    <xsl:if test="$year != '' and $year != '0'">
      <xsl:value-of select="$year" />
      <xsl:value-of select="' years '" />
    </xsl:if>
    <xsl:if test="$month != '' and $month != '0'">
      <xsl:value-of select="$month" />
      <xsl:value-of select="' months '" />
    </xsl:if>
    <xsl:if test="$day != '' and $day != '0'">
      <xsl:value-of select="$day" />
      <xsl:value-of select="' days '" />
    </xsl:if>
    <xsl:if test="$hour != '' and $hour != '0'">
      <xsl:value-of select="$hour" />
      <xsl:value-of select="' hours '" />
    </xsl:if>
    <xsl:if test="$min != '' and $min != '0'">
      <xsl:value-of select="$min" />
      <xsl:value-of select="' minutes '" />
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
