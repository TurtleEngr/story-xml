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
$Header: /repo/local.cvs/app/story-xml/src/story5/com-html.xsl,v 1.6 2009/05/01 20:52:53 bruce Exp $
-->
  <!-- ******************** -->
  <xsl:param name="gIndent">
    <xsl:value-of select="'&#161;&#161;&#161;'" />
  </xsl:param>
  <!-- ******************** -->
  <xsl:param name="gDraftColor">
    <xsl:value-of select="$gPrintRef/@draft" />
  </xsl:param>
  <!-- ************************************************************
Utility
-->
  <!-- ******************** -->
  <xsl:template name="fFmtXMLTime">
    <xsl:param name="pTime" />
    <xsl:param name="pTag" />
    <!-- pTag is a space or a br tag -->
    <xsl:param name="pDay" />
    <!-- 123456789012345678901234567 -->
    <!-- yyyy-mm-ddThh:mm:ss-hh:mm 25 -->
    <!-- yyyy-mm-ddThh:mm-hh 19 -->
    <!-- yyyy-mm-ddThh:mm:ssZ 20 -->
    <!-- yyyy-mm-ddThh:mmZ 17 -->
    <!-- yyyy-mm-ddThh:mm ? -->
    <xsl:choose>
      <xsl:when test="string-length($pTime) = 25 and contains('+-', substring($pTime,20,1))">

        <xsl:value-of disable-output-escaping="yes"
                      select="concat( substring($pTime, 1, 10), $pTag, substring($pTime, 12, 5), ' UTC', substring($pTime, 20, 3) )" />
      </xsl:when>
      <xsl:when test="string-length($pTime) = 19 and contains('+-', substring($pTime,17,1))">

        <xsl:value-of disable-output-escaping="yes"
                      select="concat( substring($pTime, 1, 10), $pTag, substring($pTime, 12, 5), ' UTC', substring($pTime, 17, 3) )" />
      </xsl:when>
      <xsl:when test="string-length($pTime) = 20 and substring($pTime,20,1) = 'Z'">

        <xsl:value-of disable-output-escaping="yes"
                      select="concat( substring($pTime, 1, 10), $pTag, substring($pTime, 12, 5), ' UTC' )" />
      </xsl:when>
      <xsl:when test="string-length($pTime) = 17 and substring($pTime,20,1) = 'Z'">

        <xsl:value-of disable-output-escaping="yes"
                      select="concat( substring($pTime, 1, 10), $pTag, substring($pTime, 12, 5), ' UTC' )" />
      </xsl:when>
      <xsl:otherwise>
        <!-- yyyy-mm-ddThh:mm ? -->
        <xsl:value-of disable-output-escaping="yes"
                      select="concat( substring($pTime, 1, 10), $pTag, substring($pTime, 12, 5) )" />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:if test="$pDay = '1'">
      <xsl:value-of disable-output-escaping="yes"
                    select="concat($pTag, date:day-name($pTime))" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fRevisionFlag">
    <xsl:if test="not($gDraft) and not(@revision-flag='deleted')">
      <xsl:apply-templates />
    </xsl:if>
    <xsl:if test="$gDraft">
      <xsl:choose>
        <xsl:when test="@revision-flag='changed'">
          <font class="change">
            <xsl:apply-templates />
          </font>
        </xsl:when>
        <xsl:when test="@revision-flag='added'">
          <font class="ins">
            <xsl:apply-templates />
          </font>
        </xsl:when>
        <xsl:when test="@revision-flag='deleted'">
          <xsl:if test="$gDraftRef/@deleted = '1'">
            <font class="del">
              <xsl:apply-templates />
            </font>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fRevFlag">
    <xsl:param name="pContent" />
    <xsl:if test="not($gDraft) and not(@revision-flag='deleted')">
      <xsl:copy-of select="$pContent" />
    </xsl:if>
    <xsl:if test="$gDraft">
      <xsl:choose>
        <xsl:when test="@revision-flag='changed'">
          <div class="change">
            <xsl:copy-of select="$pContent" />
          </div>
        </xsl:when>
        <xsl:when test="@revision-flag='added'">
          <div class="ins">
            <xsl:copy-of select="$pContent" />
          </div>
        </xsl:when>
        <xsl:when test="@revision-flag='deleted'">
          <xsl:if test="$gDraftRef/@deleted = '1'">
            <div class="del">
              <xsl:copy-of select="$pContent" />
            </div>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:copy-of select="$pContent" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:if>
  </xsl:template>
  <!-- ************************************************************
Meta
-->
  <!-- ******************** -->
  <xsl:template name="fHtmlStyle">
    <style type="text/css">
      <xsl:comment>body { text-align: justify; margin: 5%; font-family:
      Times, serif; } h1,h2,h3,h4,h5,h6 { text-align: left; font-family:
      Times, serif; } h1.book-title { text-align: center; font-family:
      Times, serif; } h2.subtitle { text-align: center; font-family:
      Times, serif; } h2.ch-title { text-align: left; font-family: Times,
      serif; } h3.prolog-title { text-align: left; font-family: Times,
      serif; } hr { width: 100%; margin: 2em auto 2em auto; height: 2px;
      border-style: solid; border-color: #000000; clear: both; } hr.prolog
      { width: 33%; margin: 2em auto 2em 0; align: left; height: 2px;
      border-style: solid; border-color: #000000; clear: both; } hr.break
      { width: 33%; margin: .7em auto .7em auto; align: center; height:
      0px; border-style: solid; border-color: #ffffff; clear: both; } pre
      { font-size: 90%; font-family: Courier, monospace; } p {
      text-indent: 2em; margin-top: .1em; margin-bottom: .1em;
      font-family: Times, serif; } p.author { text-indent: 0; text-align:
      center; margin-top: .2em; margin-bottom: .2em; font-family: Times,
      serif; } p.block { text-indent: 0; margin-top: .5em; margin-bottom:
      .5em; font-family: Times, serif; } p.quote { text-indent: 0;
      margin-top: 1em; margin-bottom: 1em; margin-left: 10%; margin-right:
      10%; font-family: Times, serif; } font.draft { color: red;
      font-style: italic; } font.change { color: blue; text-decoration:
      underline } font.ins { color: green; text-decoration: underline }
      font.del { color: red; text-decoration: line-through } div.change {
      color: blue; text-decoration: underline } div.ins { color: green;
      text-decoration: underline } div.del { color: red; text-decoration:
      line-through }</xsl:comment>
    </style>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fMetaHead">
    <xsl:element name="meta">
      <xsl:attribute name="name">description</xsl:attribute>
      <xsl:attribute name="content">
        <xsl:value-of select="meta-description" />
      </xsl:attribute>
    </xsl:element>
    <xsl:element name="meta">
      <xsl:attribute name="name">keywords</xsl:attribute>
      <xsl:attribute name="content">
        <xsl:value-of select="meta-keywords" />
      </xsl:attribute>
    </xsl:element>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fBodyAttr">
    <xsl:attribute name="text">
      <xsl:value-of select="$gPrintRef/@text" />
    </xsl:attribute>
    <xsl:attribute name="bgcolor">
      <xsl:value-of select="$gPrintRef/@bgcolor" />
    </xsl:attribute>
    <xsl:attribute name="link">
      <xsl:if test="not(boolean(number($gPrintRef/@link)))">
        <xsl:value-of select="$gPrintRef/@link" />
      </xsl:if>
      <xsl:if test="boolean(number($gPrintRef/@link))">
        <xsl:value-of select="'#0000FF'" />
      </xsl:if>
    </xsl:attribute>
    <xsl:attribute name="vlink">
      <xsl:if test="not(boolean(number($gPrintRef/@vlink)))">
        <xsl:value-of select="$gPrintRef/@vlink" />
      </xsl:if>
      <xsl:if test="boolean(number($gPrintRef/@vlink))">
        <xsl:value-of select="'#840084'" />
      </xsl:if>
    </xsl:attribute>
    <xsl:attribute name="alink">
      <xsl:if test="not(boolean(number($gPrintRef/@alink)))">
        <xsl:value-of select="$gPrintRef/@alink" />
      </xsl:if>
      <xsl:if test="boolean(number($gPrintRef/@alink))">
        <xsl:value-of select="'#0000FF'" />
      </xsl:if>
    </xsl:attribute>
    <xsl:if test="boolean(number($gPrintRef/@ref))">
      <xsl:attribute name="background">
        <xsl:call-template name="fImgUrl">
          <xsl:with-param name="pKey"
                          select="$gPrintRef/@ref" />
        </xsl:call-template>
      </xsl:attribute>
    </xsl:if>
  </xsl:template>
  <!-- **************************************************
Page
-->
  <!-- ******************** -->
  <xsl:template name="fTitlePage">
    <br />
    <h1 class="book-title">
      <xsl:value-of select="title" />
    </h1>
    <xsl:if test="subtitle">
      <h2 class="subtitle">
        <xsl:apply-templates select="subtitle" />
      </h2>
    </xsl:if>
    <br />
    <p class="author">
      <xsl:value-of select="'by '" />
      <xsl:apply-templates select="book-info/author-group/author" />
    </p>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fCopyrightPage">
    <hr />
    <!-- "$gPrintRef/@copyright-type" -->
    <br />
    <xsl:call-template name="fFmtCopyright" />
    <xsl:apply-templates select="book-info/edition" />
    <xsl:apply-templates select="book-info/publisher" />
    <xsl:apply-templates select="book-info/biblio-id" />
    <xsl:call-template name="fFmtReleaseInfo" />
    <br />
    <xsl:apply-templates select="book-info/legal-notice" />
    <!--
    <br/>
    <p class="block"><xsl:value-of select="'Printed in the United States of America'" /></p>
-->
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fFmtCopyright">
    <p class="block">
      <xsl:if test="count(book-info/copyright/year) = 0">
        <xsl:value-of select="concat('Copyright ', book-info/pub-date)" />
      </xsl:if>
      <xsl:if test="count(book-info/copyright/year) = 1">
        <xsl:value-of select="concat('Copyright ', book-info/copyright/year)" />
      </xsl:if>
      <xsl:if test="count(book-info/copyright/year) &gt; 1">
        <xsl:value-of select="'Copyright '" />
        <xsl:apply-templates select="book-info/copyright/year[1]" />
        <xsl:value-of select="' - '" />
        <xsl:apply-templates select="book-info/copyright/year[last()]" />
      </xsl:if>
      <xsl:if test="count(book-info/copyright/holder) &gt; 0">
        <xsl:value-of select="' by '" />
        <xsl:apply-templates select="book-info/copyright/holder[1]" />
      </xsl:if>
      <xsl:if test="count(book-info/copyright/holder) = 0">
        <xsl:value-of select="' by '" />
        <xsl:apply-templates select="book-info/author-group/author[1]" />
      </xsl:if>
    </p>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fTocPage">
    <xsl:if test="$gPrintRef/@toc = '1'">
      <hr />
      <h2 class="ch-title">
        <xsl:value-of select="'Contents'" />
      </h2>
      <ul>
        <xsl:apply-templates select="story-info/ch-preface"
                             mode="toc" />
        <xsl:apply-templates select="preface"
                             mode="toc" />
        <xsl:apply-templates select="chapter"
                             mode="toc" />
        <xsl:apply-templates select="epilog"
                             mode="toc" />
      </ul>
    </xsl:if>
  </xsl:template>
  <!-- **************************************************
Block
-->
  <!-- ******************** -->
  <xsl:template match="legal-notice">
    <xsl:apply-templates select="p|para|pre|pre-fmt|quote" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="ch-preface|preface|epilog"
                mode="toc">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <li>
        <p class="block">
          <xsl:element name="a">
            <xsl:attribute name="href">
              <xsl:value-of select="concat('#', @id)" />
            </xsl:attribute>
            <xsl:value-of select="title" />
          </xsl:element>
        </p>
      </li>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="ch-preface|preface|epilog">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <hr />
      <h2 class="ch-title">
        <xsl:element name="a">
          <xsl:attribute name="name">
            <xsl:value-of select="@id" />
          </xsl:attribute>
          <xsl:apply-templates select="title" />
        </xsl:element>
      </h2>
      <xsl:apply-templates select="p|para|pre|pre-fmt" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="chapter"
                mode="toc">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <li>
        <p class="block">
          <xsl:element name="a">
            <xsl:attribute name="href">
              <xsl:value-of select="concat('#', @id)" />
            </xsl:attribute>
            <xsl:value-of select="title" />
            <xsl:call-template name="fFmtReleaseInfoToc" />
          </xsl:element>
        </p>
      </li>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="chapter">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <hr />
      <h2 class="ch-title">
        <xsl:element name="a">
          <xsl:attribute name="name">
            <xsl:value-of select="@id" />
          </xsl:attribute>
          <xsl:apply-templates select="title" />
        </xsl:element>
      </h2>
      <xsl:call-template name="fFmtReleaseInfo" />
      <xsl:apply-templates select="prolog" />
      <xsl:apply-templates select="unit" />
      <xsl:apply-templates select="postlog" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fFmtReleaseInfoToc">
    <xsl:if test="@revision != 'final'">
      <xsl:if test="@revision = 'draft'">
        <xsl:value-of select="' - draft'" />
      </xsl:if>
      <xsl:if test="@revision = 'in-progress'">
        <xsl:value-of select="' - in progress'" />
      </xsl:if>
      <xsl:value-of select="concat(' (first post: ', chapter-info/pub-date, '; last update: ')" />
      <xsl:apply-templates select="chapter-info/release-info/@date" />
      <xsl:value-of select="')'" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fFmtReleaseInfo">
    <xsl:if test="@revision != 'final'">
      <br />
      <xsl:if test="@revision = 'in-progress'">
        <p class="block">In progress</p>
      </xsl:if>
      <xsl:if test="@revision = 'draft'">
        <p class="block">Draft</p>
      </xsl:if>
      <xsl:if test="name() = 'book'">
        <xsl:apply-templates select="book-info/release-info" />
      </xsl:if>
      <xsl:if test="name() = 'chapter'">
        <xsl:apply-templates select="chapter-info/release-info" />
      </xsl:if>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="release-info">
    <pre>
    
<xsl:if test="../pub-date">
      
<xsl:value-of select="concat('First Published: ', ../pub-date, $gNL)" />
    </xsl:if>
    
<xsl:if test="@date">
      
<xsl:value-of select="'Revision Date: '" />
      
<xsl:apply-templates select="@date" />
      
<xsl:value-of select="$gNL" />
    </xsl:if>
    
<xsl:if test="@rev">
      
<xsl:value-of select="'Revision: '" />
      
<xsl:apply-templates select="@rev" />
      
<xsl:value-of select="$gNL" />
    </xsl:if>
    
<xsl:if test="@source">
      
<xsl:value-of select="'Source: '" />
      
<xsl:apply-templates select="@source" />
      
<xsl:value-of select="$gNL" />
    </xsl:if>
    
<xsl:if test="@root">
      
<xsl:value-of select="'Root: '" />
      
<xsl:apply-templates select="@root" />
      
<xsl:value-of select="$gNL" />
    </xsl:if>
    
<xsl:if test="@repository">
      
<xsl:value-of select="'Repository: '" />
      
<xsl:apply-templates select="@repository" />
      
<xsl:value-of select="$gNL" />
    </xsl:if>
    
<xsl:if test="@file">
      
<xsl:value-of select="'File: '" />
      
<xsl:apply-templates select="@file" />
      
<xsl:value-of select="$gNL" />
    </xsl:if>
    
<xsl:if test="@svn-path">
      
<xsl:value-of select="'Subversion path: '" />
      
<xsl:apply-templates select="@svn-path" />
      
<xsl:value-of select="$gNL" />
    </xsl:if>
    
</pre>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="prolog">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <h3 class="prolog-title">
        <xsl:apply-templates select="title" />
      </h3>
      <xsl:apply-templates select="p|para|pre|pre-fmt" />
      <hr class="prolog" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="postlog">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <hr class="prolog" />
      <h3 class="prolog-title">
        <xsl:apply-templates select="title" />
      </h3>
      <xsl:apply-templates select="p|para|pre|pre-fmt" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="br">
    <hr class="break" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="rev">
    <xsl:call-template name="fRevisionFlag" />
  </xsl:template>
  <!-- **************************************************
Inline
-->
  <!-- ******************** -->
  <xsl:template match="author">
    <xsl:choose>
      <xsl:when test="position() = 1"></xsl:when>
      <xsl:when test="position() != last()">
        <xsl:value-of select="', '" />
      </xsl:when>
      <xsl:when test="position() = last()">
        <xsl:value-of select="', and '" />
      </xsl:when>
    </xsl:choose>
    <xsl:value-of select="concat(first-name, ' ', surname)" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="edition">
    <p class="block">
      <xsl:value-of select="concat('Edition: ', .)" />
    </p>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="biblio-id">
    <p class="block">
      <xsl:choose>
        <xsl:when test="@class = 'uri'">
          <xsl:value-of select="concat('URL: ', .)" />
        </xsl:when>
        <xsl:when test="@class = 'isbn'">
          <xsl:value-of select="concat('ISBN: ', .)" />
        </xsl:when>
        <xsl:when test="@class = 'doi'">
          <xsl:value-of select="concat('DOI: ', .)" />
        </xsl:when>
        <xsl:when test="@class = 'isrn'">
          <xsl:value-of select="concat('ISRN: ', .)" />
        </xsl:when>
        <xsl:when test="@class = 'issn'">
          <xsl:value-of select="concat('ISSN: ', .)" />
        </xsl:when>
        <xsl:when test="@class = 'library-of-congress'">
          <xsl:value-of select="concat('Library of Congress: ', .)" />
        </xsl:when>
        <xsl:when test="@class = 'pub-number'">
          <xsl:value-of select="concat('Publication Number: ', .)" />
        </xsl:when>
        <xsl:when test="@class = 'other'">
          <xsl:value-of select="concat(@other-class, ': ', .)" />
        </xsl:when>
      </xsl:choose>
    </p>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="publisher">
    <p class="block">
      <xsl:value-of select="publisher-name" />
      <xsl:apply-templates select="address" />
    </p>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="address">
    <xsl:apply-templates />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="street|pob|country|phone|fax|email|other-addr|city|state|post-code">

    <xsl:value-of select="concat(', ', .)" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@date">
    <xsl:value-of select="substring(., 8, 10)" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@rev">
    <xsl:value-of select="substring(substring-before(substring-after(., '$'), ' $'), 11, 256)" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@source">
    <xsl:value-of select="substring(substring-before(substring-after(., '$'), ' $'), 9, 256)" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@root">
    <xsl:value-of select="." />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@repository">
    <xsl:value-of select="." />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@file">
    <xsl:value-of select="." />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="@svn-path">
    <xsl:value-of select="." />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fImgUrl">
    <xsl:param name="pKey" />
    <xsl:variable name="tImage"
                  select="key('def-img-index', $pKey)" />
    <xsl:variable name="tImageBase">
      <xsl:value-of select="key('def-base-index', $tImage/@base-ref)/." />
    </xsl:variable>
    <xsl:value-of select="concat($tImageBase, $tImage/@url)" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fImgTag">
    <xsl:param name="pKey" />
    <xsl:variable name="tImagePath">
      <xsl:call-template name="fImgUrl">
        <xsl:with-param name="pKey"
                        select="$pKey" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="tImage"
                  select="key('def-img-index', $pKey)" />
    <xsl:if test="$gDebug">
      <xsl:message>
        <xsl:value-of select="concat('graphic src=', $tImagePath)" />
      </xsl:message>
    </xsl:if>
    <xsl:variable name="tWidth">
      <xsl:call-template name="fUnits">
        <xsl:with-param name="pFrom"
                        select="$tImage/width" />
        <xsl:with-param name="pTo"
                        select="'pt'" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="tHeight">
      <xsl:call-template name="fUnits">
        <xsl:with-param name="pFrom"
                        select="$tImage/height" />
        <xsl:with-param name="pTo"
                        select="'pt'" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:choose>
      <xsl:when test="@float = '1'">
        <img src="{$tImagePath}"
             width="{$tWidth}"
             height="{$tHeight}"
             alt="{$tImage/.}"
             border="0"
             align="left"
             style="margin: .5em" />
      </xsl:when>
      <xsl:otherwise>
        <img src="{$tImagePath}"
             width="{$tWidth}"
             height="{$tHeight}"
             alt="{$tImage/.}"
             border="0" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="img">
    <xsl:call-template name="fImgTag">
      <xsl:with-param name="pKey"
                      select="@ref" />
    </xsl:call-template>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="link">
    <xsl:choose>
      <xsl:when test="$gContentLink = 'full'">
        <xsl:call-template name="fLinkFull" />
      </xsl:when>
      <xsl:when test="$gContentLink = 'long'">
        <xsl:call-template name="fLinkLong" />
      </xsl:when>
      <xsl:when test="$gContentLink = 'short'">
        <xsl:call-template name="fLinkShort" />
      </xsl:when>
      <xsl:when test="$gContentLink = 'text'">
        <xsl:call-template name="fLinkText" />
      </xsl:when>
      <xsl:when test="$gContentLink = 'plain'">
        <xsl:call-template name="fLinkPlain" />
      </xsl:when>
      <xsl:when test="$gContentLink = 'default'">
        <xsl:call-template name="fLinkDefault" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:call-template name="fLinkDefault" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fLinkDefault">
    <xsl:variable name="tLink"
                  select="key('def-link-index', @ref)" />
    <xsl:variable name="tLinkBase">
      <xsl:value-of select="key('def-base-index', $tLink/@base-ref)/." />
    </xsl:variable>
    <xsl:variable name="tLinkURL">
      <xsl:value-of select="concat($tLinkBase, $tLink/@url)" />
    </xsl:variable>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="$tLinkURL" />
      </xsl:attribute>
      <xsl:if test="@img = '1' and $tLink/@img-ref != ''">
        <xsl:call-template name="fImgTag">
          <xsl:with-param name="pKey"
                          select="$tLink/@img-ref" />
        </xsl:call-template>
        <xsl:value-of select="' '" />
      </xsl:if>
      <xsl:if test=". != ''">
        <xsl:value-of select="." />
        <xsl:value-of select="' '" />
      </xsl:if>
      <xsl:if test="@title = '1' or (. = '' and @img = '0' and @url = '0')">

        <xsl:value-of select="$tLink" />
        <xsl:value-of select="' '" />
      </xsl:if>
      <xsl:if test="@url = '1'">
        <xsl:value-of select="concat(' (', $tLinkURL, ')')" />
      </xsl:if>
    </a>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fLinkFull">
    <xsl:variable name="tLink"
                  select="key('def-link-index', @ref)" />
    <xsl:variable name="tLinkBase">
      <xsl:value-of select="key('def-base-index', $tLink/@base-ref)/." />
    </xsl:variable>
    <xsl:variable name="tLinkURL">
      <xsl:value-of select="concat($tLinkBase, $tLink/@url)" />
    </xsl:variable>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="$tLinkURL" />
      </xsl:attribute>
      <xsl:if test="$tLink/@img-ref != ''">
        <xsl:call-template name="fImgTag">
          <xsl:with-param name="pKey"
                          select="$tLink/@img-ref" />
        </xsl:call-template>
        <xsl:value-of select="' '" />
      </xsl:if>
      <xsl:if test=". != ''">
        <xsl:value-of select="." />
        <xsl:value-of select="' '" />
      </xsl:if>
      <xsl:value-of select="concat($tLink, ' (', $tLinkURL, ')')" />
    </a>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fLinkLong">
    <xsl:variable name="tLink"
                  select="key('def-link-index', @ref)" />
    <xsl:variable name="tLinkBase">
      <xsl:value-of select="key('def-base-index', $tLink/@base-ref)/." />
    </xsl:variable>
    <xsl:variable name="tLinkURL">
      <xsl:value-of select="concat($tLinkBase, $tLink/@url)" />
    </xsl:variable>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="$tLinkURL" />
      </xsl:attribute>
      <xsl:if test=". != ''">
        <xsl:value-of select="." />
        <xsl:value-of select="' '" />
      </xsl:if>
      <xsl:value-of select="concat($tLink, ' (', $tLinkURL, ')')" />
    </a>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fLinkShort">
    <xsl:variable name="tLink"
                  select="key('def-link-index', @ref)" />
    <xsl:variable name="tLinkBase">
      <xsl:value-of select="key('def-base-index', $tLink/@base-ref)/." />
    </xsl:variable>
    <xsl:variable name="tLinkURL">
      <xsl:value-of select="concat($tLinkBase, $tLink/@url)" />
    </xsl:variable>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="$tLinkURL" />
      </xsl:attribute>
      <xsl:value-of select="concat($tLink, ' (', $tLinkURL, ')')" />
    </a>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fLinkText">
    <xsl:variable name="tLink"
                  select="key('def-link-index', @ref)" />
    <xsl:variable name="tLinkBase">
      <xsl:value-of select="key('def-base-index', $tLink/@base-ref)/." />
    </xsl:variable>
    <xsl:variable name="tLinkURL">
      <xsl:value-of select="concat($tLinkBase, $tLink/@url)" />
    </xsl:variable>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="$tLinkURL" />
      </xsl:attribute>
      <xsl:value-of select="concat($tLink, ' (', $tLinkURL, ')')" />
    </a>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fLinkPlain">
    <xsl:variable name="tLink"
                  select="key('def-link-index', @ref)" />
    <xsl:variable name="tLinkBase">
      <xsl:value-of select="key('def-base-index', $tLink/@base-ref)/." />
    </xsl:variable>
    <xsl:variable name="tLinkURL">
      <xsl:value-of select="concat($tLinkBase, $tLink/@url)" />
    </xsl:variable>
    <a>
      <xsl:attribute name="href">
        <xsl:value-of select="$tLinkURL" />
      </xsl:attribute>
      <xsl:value-of select="$tLink" />
    </a>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="b">
    <b>
      <xsl:apply-templates />
    </b>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="i">
    <i>
      <xsl:apply-templates />
    </i>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="tt">
    <tt>
      <xsl:apply-templates />
    </tt>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="text()">
    <xsl:value-of select="." />
  </xsl:template>
  <!-- ******************** -->
</xsl:stylesheet>
