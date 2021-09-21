<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:fo="http://www.w3.org/1999/XSL/Format">
  <!-- **************************************** -->
  <xsl:import href="/usr/local/serna/xml/stylesheets/xslbricks/fo/fo.xsl" />
  <xsl:param name="body.master">16</xsl:param>
  <xsl:strip-space elements="*" />
  <xsl:preserve-space elements="pre" />
  <!-- ********************************************************************
Block
-->
  <!-- ****************************** -->
  <xsl:template match="book/title">
    <xsl:call-template name="h1" />
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="chapter/title">
    <xsl:call-template name="h2" />
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="ch-preface/title|preface/title|epilog/title|prolog/title|postlog/title|ch-preface/title">

    <xsl:call-template name="h3" />
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="unit/title">
    <xsl:call-template name="h4" />
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="p">
    <xsl:variable name="color">
      <xsl:choose>
        <xsl:when test="name(..) != 'thread'">
          <xsl:text>
black
</xsl:text>
        </xsl:when>
        <xsl:when test="contains(../@refs, /content/book/style-info/@preview-thread)">

          <xsl:text>
black
</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>
red
</xsl:text>
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
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="pre">
    <xsl:call-template name="pre" />
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="s">
    <xsl:variable name="color">
      <xsl:choose>
        <xsl:when test="name(..) != 'thread'">
          <xsl:text>
black
</xsl:text>
        </xsl:when>
        <xsl:when test="contains(../@refs, /content/book/style-info/@preview-thread)">

          <xsl:text>
black
</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>
red
</xsl:text>
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
        <xsl:text>
_____
</xsl:text>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="t">
    <xsl:variable name="color">
      <xsl:choose>
        <xsl:when test="name(..) != 'thread'">
          <xsl:text>
black
</xsl:text>
        </xsl:when>
        <xsl:when test="contains(../@refs, /content/book/style-info/@preview-thread)">

          <xsl:text>
black
</xsl:text>
        </xsl:when>
        <xsl:otherwise>
          <xsl:text>
red
</xsl:text>
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
        <xsl:if test="@ref = ../@viewpoint">
          <xsl:text>
_____
</xsl:text>
          <xsl:apply-templates />
        </xsl:if>
        <xsl:if test="@ref != ../@viewpoint">
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
            <xsl:text>
_____
</xsl:text>
            <xsl:apply-templates />[thought: 
            <xsl:value-of select="@ref" />]</xsl:with-param>
          </xsl:call-template>
        </xsl:if>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="thread">
    <xsl:call-template name="para">
      <xsl:with-param name="content">
        <xsl:call-template name="para">
          <xsl:with-param name="content">
            <xsl:text>
[thread ref: 
</xsl:text>
            <xsl:value-of select="@refs" />
            <xsl:text>
; viewpoint: 
</xsl:text>
            <xsl:value-of select="@viewpoint" />
            <xsl:text>
]
</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
        <xsl:call-template name="div">
          <xsl:with-param name="background-color"
                          select='blue' />
          <xsl:with-param name="content">
            <xsl:apply-templates />
          </xsl:with-param>
        </xsl:call-template>
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
  <xsl:template match="def-who|def-where|def-thread">
    <xsl:call-template name="para">
      <xsl:with-param name="content">
        <xsl:call-template name="h4">
          <xsl:with-param name="content">
            <xsl:value-of select="name()" />
            <xsl:text>
 id=
</xsl:text>
            <xsl:value-of select="@id" />
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="who|where">
    <xsl:call-template name="para">
      <xsl:with-param name="content">
        <xsl:call-template name="h4">
          <xsl:with-param name="content">
            <xsl:value-of select="name()" />
            <xsl:text>
 ref=
</xsl:text>
            <xsl:value-of select="@ref" />
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
    <xsl:text>
 
</xsl:text>
    <xsl:if test="$year != '' and $year != '0'">
      <xsl:value-of select="$year" />
      <xsl:text>
 years 
</xsl:text>
    </xsl:if>
    <xsl:if test="$month != '' and $month != '0'">
      <xsl:value-of select="$month" />
      <xsl:text>
 months 
</xsl:text>
    </xsl:if>
    <xsl:if test="$day != '' and $day != '0'">
      <xsl:value-of select="$day" />
      <xsl:text>
 days 
</xsl:text>
    </xsl:if>
    <xsl:if test="$hour != '' and $hour != '0'">
      <xsl:value-of select="$hour" />
      <xsl:text>
 hours 
</xsl:text>
    </xsl:if>
    <xsl:if test="$min != '' and $min != '0'">
      <xsl:value-of select="$min" />
      <xsl:text>
 minutes 
</xsl:text>
    </xsl:if>
  </xsl:template>
  <!-- ****************************** -->
  <xsl:template match="outline">
    <xsl:call-template name="para">
      <xsl:with-param name="content">
        <xsl:call-template name="h4">
          <xsl:with-param name="content">
            <xsl:text>
Outline
</xsl:text>
          </xsl:with-param>
        </xsl:call-template>
        <xsl:apply-templates />
      </xsl:with-param>
    </xsl:call-template>
  </xsl:template>
</xsl:stylesheet>
