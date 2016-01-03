<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <!--
add: ch-page-break=
Change: isbn - biblio-id class=isbn
bug: head-type conversion doesn't work well

=================
style-info
        change: @preview-thread to @thread-refs

def-print
        change: @header-type to @head-type
        change: @head-type value of 0 or none, change to page-no
        add: @head-align="right"
        add: @head-location="top"

def-content
        change: @thread to @thread-refs

thread
        change: @refs to @ref

change @revison-flag to @revision-flag

Change: s and p elements to para in non-thread sections.

Change: pre elements to pre-fmt in non-thread sections.
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
    <xsl:element name="content">
      <xsl:element name="story-dtd">
        <xsl:attribute name="version">3</xsl:attribute>
      </xsl:element>
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="style-info">
    <xsl:element name="style-info">
      <xsl:apply-templates select="@*" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@preview-thread">
    <xsl:attribute name="thread-refs">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@header-type">
    <xsl:attribute name="@head-type">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-content">
    <xsl:element name="def-content">
      <xsl:apply-templates select="@*"
                           mode="thread" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@thread"
                mode="thread">
    <xsl:attribute name="thread-refs">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="thread">
    <xsl:element name="thread">
      <xsl:apply-templates select="@*"
                           mode="thread" />
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@refs"
                mode="thread">
    <xsl:attribute name="ref">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@*"
                mode="thread">
    <xsl:apply-templates select="." />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@revison-flag">
    <xsl:attribute name="@revision-flag">
      <xsl:value-of select="." />
    </xsl:attribute>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-who/s|def-where/s|def-thread/s|preface/s|epilog/s|ch-preface/s|prolog/s|postlog/s|where/s|who/s|description/s">

    <xsl:element name="para">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-who/p|def-where/p|def-thread/p|preface/p|epilog/p|ch-preface/p|prolog/p|postlog/p|where/p|who/p|description/p">

    <xsl:element name="para">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="def-who/pre|def-where/pre|def-thread/pre|preface/pre|epilog/pre|ch-preface/pre|prolog/pre|postlog/pre|where/pre|who/pre|description/pre">

    <xsl:element name="pre-fmt">
      <xsl:apply-templates />
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
</xsl:stylesheet>
