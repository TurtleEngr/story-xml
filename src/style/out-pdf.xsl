<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:date="http://exslt.org/dates-and-times"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                exclude-result-prefixes="doc"
                xmlns:exsl="http://exslt.org/common"
                xmlns:str="http://exslt.org/strings"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
                extension-element-prefixes="date doc exsl str">
  <!--
        extension-element-prefixes="date doc exsl fo str"
-->
  <xsl:output method="xml"
              indent="yes" />
  <xsl:param name="gDraft"
             select="boolean(number('0'))" />
  <xsl:include href="com-param.xsl" />
  <!-- ************************************* -->
  <!-- Set page size variables -->
  <xsl:param name="gWidth">
    <xsl:choose>
      <xsl:when test="$gPrintRef/@page-width != '0'">
        <xsl:call-template name="fUnits">
          <xsl:with-param name="pFrom"
                          select="$gPrintRef/@page-width" />
          <xsl:with-param name="pTo"
                          select="'in'" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$gPrintRef/@page = '4.25x5.5in'">
            <xsl:value-of select="'4.25'" />
          </xsl:when>
          <xsl:when test="$gPrintRef/@page = '4.25x6.875in'">
            <xsl:value-of select="'4.25'" />
          </xsl:when>
          <xsl:when test="$gPrintRef/@page = '6x9in'">
            <xsl:value-of select="'6'" />
          </xsl:when>
          <xsl:when test="$gPrintRef/@page = '8.5x11in'">
            <xsl:value-of select="'8.5'" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'6'" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="gHeight">
    <xsl:choose>
      <xsl:when test="$gPrintRef/@page-height != '0'">
        <xsl:call-template name="fUnits">
          <xsl:with-param name="pFrom"
                          select="$gPrintRef/@page-height" />
          <xsl:with-param name="pTo"
                          select="'in'" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:choose>
          <xsl:when test="$gPrintRef/@page = '4.25x5.5in'">
            <xsl:value-of select="'5.5'" />
          </xsl:when>
          <xsl:when test="$gPrintRef/@page = '4.25x6.875in'">
            <xsl:value-of select="'6.875'" />
          </xsl:when>
          <xsl:when test="$gPrintRef/@page = '6x9in'">
            <xsl:value-of select="'9'" />
          </xsl:when>
          <xsl:when test="$gPrintRef/@page = '8.5x11in'">
            <xsl:value-of select="'11'" />
          </xsl:when>
          <xsl:otherwise>
            <xsl:value-of select="'9'" />
          </xsl:otherwise>
        </xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="gMargin">
    <xsl:call-template name="fUnits">
      <xsl:with-param name="pFrom"
                      select="$gPrintRef/@margin" />
      <xsl:with-param name="pTo"
                      select="'in'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gGutter">
    <xsl:call-template name="fUnits">
      <xsl:with-param name="pFrom"
                      select="$gPrintRef/@gutter" />
      <xsl:with-param name="pTo"
                      select="'in'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gBleedLeft">
    <xsl:call-template name="fUnits">
      <xsl:with-param name="pFrom"
                      select="$gPrintRef/@bleed-left" />
      <xsl:with-param name="pTo"
                      select="'in'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gBleedRight">
    <xsl:call-template name="fUnits">
      <xsl:with-param name="pFrom"
                      select="$gPrintRef/@bleed-right" />
      <xsl:with-param name="pTo"
                      select="'in'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gBleedTop">
    <xsl:call-template name="fUnits">
      <xsl:with-param name="pFrom"
                      select="$gPrintRef/@bleed-top" />
      <xsl:with-param name="pTo"
                      select="'in'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gBleedBottom">
    <xsl:call-template name="fUnits">
      <xsl:with-param name="pFrom"
                      select="$gPrintRef/@bleed-bottom" />
      <xsl:with-param name="pTo"
                      select="'in'" />
    </xsl:call-template>
  </xsl:param>
  <!-- Calculate dimensions -->
  <xsl:param name="gPageHeight"
             select="$gHeight + $gBleedTop + $gBleedBottom" />
  <xsl:param name="gPageWidth"
             select="$gWidth + $gBleedLeft + $gBleedRight" />
  <xsl:param name="gMarginTop"
             select="$gMargin + $gBleedTop" />
  <xsl:param name="gMarginBottom"
             select="$gMargin + $gBleedBottom" />
  <xsl:param name="gMarginOddLeft"
             select="$gMargin + $gGutter + $gBleedLeft" />
  <xsl:param name="gMarginOddRight"
             select="$gMargin + $gBleedRight" />
  <xsl:param name="gMarginEvenLeft">
    <xsl:if test="$gPrintRef/@duplex = '1'">
      <xsl:value-of select="$gMargin + $gBleedLeft" />
    </xsl:if>
    <xsl:if test="$gPrintRef/@duplex = '0'">
      <xsl:value-of select="$gMarginOddLeft" />
    </xsl:if>
  </xsl:param>
  <xsl:param name="gMarginEvenRight">
    <xsl:if test="$gPrintRef/@duplex ='1'">
      <xsl:value-of select="$gMargin + $gGutter + $gBleedRight" />
    </xsl:if>
    <xsl:if test="$gPrintRef/@duplex = '0'">
      <xsl:value-of select="$gMarginOddRight" />
    </xsl:if>
  </xsl:param>
  <xsl:param name="gBodySize">
    <xsl:call-template name="fUnits">
      <xsl:with-param name="pFrom"
                      select="$gPrintRef/@body-size" />
      <xsl:with-param name="pTo"
                      select="'pt'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gBodyWidth">
    <xsl:value-of select="$gWidth - $gMarginOddRight - $gMarginOddLeft" />
  </xsl:param>
  <xsl:param name="gBodyWidthPt">
    <xsl:call-template name="fUnits">
      <xsl:with-param name="pFrom"
                      select="concat($gBodyWidth,'in')" />
      <xsl:with-param name="pTo"
                      select="'pt'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gHalfBodyWidth">
    <xsl:value-of select="$gBodyWidth div 2" />
  </xsl:param>
  <xsl:param name="gLineHeight">
    <xsl:value-of select="number($gPrintRef/@line-height)" />
  </xsl:param>
  <xsl:param name="gHeaderHeight">
    <xsl:value-of select="$gBodySize * $gLineHeight div 100 * 2" />
  </xsl:param>
  <xsl:param name="gHeaderHeightIn">
    <xsl:call-template name="fUnits">
      <xsl:with-param name="pFrom"
                      select="concat($gHeaderHeight,'pt')" />
      <xsl:with-param name="pTo"
                      select="'in'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gBodyHeight">
    <xsl:value-of select="$gHeight - ($gMargin * 2) - $gHeaderHeightIn" />
  </xsl:param>
  <xsl:param name="gBodyHeightPt">
    <xsl:call-template name="fUnits">
      <xsl:with-param name="pFrom"
                      select="concat($gBodyHeight,'in')" />
      <xsl:with-param name="pTo"
                      select="'pt'" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gIndent">
    <xsl:value-of select="concat(number($gBodySize) * 2, 'pt')" />
  </xsl:param>
  <xsl:param name="gBodyFamily">
    <xsl:call-template name="fSelectFont">
      <xsl:with-param name="pFont"
                      select="$gPrintRef/@body-family" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gChTitleFamily">
    <xsl:call-template name="fSelectFont">
      <xsl:with-param name="pFont"
                      select="$gPrintRef/@ch-title-family" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gTitleFamily">
    <xsl:call-template name="fSelectFont">
      <xsl:with-param name="pFont"
                      select="$gPrintRef/@title-family" />
    </xsl:call-template>
  </xsl:param>
  <xsl:param name="gHeadFamily">
    <xsl:call-template name="fSelectFont">
      <xsl:with-param name="pFont"
                      select="$gPrintRef/@head-family" />
    </xsl:call-template>
  </xsl:param>
  <!-- =================================================================== -->
  <xsl:include href="com.xsl" />
  <xsl:template match="/content">
    <xsl:apply-templates select="book" />
  </xsl:template>
  <!-- ************************************************** -->
  <xsl:template match="book">
    <xsl:if test="$gDebug">
      <xsl:message>
        <xsl:value-of select="concat('Debug: gWidth=', $gWidth, $gNL)" />
        <xsl:value-of select="concat('Debug: gHeight=', $gHeight, $gNL)" />
        <xsl:value-of select="concat('Debug: bleed-left=', $gPrintRef/@bleed-left, $gNL)" />
        <xsl:value-of select="concat('Debug: gBleedLeft=', $gBleedLeft, $gNL)" />
        <xsl:value-of select="concat('Debug: gPageWidth=', $gPageWidth, $gNL)" />
        <xsl:value-of select="concat('Debug: gBodyWidth=', $gBodyWidth, 'in', $gNL)" />
        <xsl:value-of select="concat('Debug: gHalfBodyWidth=', $gHalfBodyWidth, $gNL)" />
        <xsl:value-of select="concat('Debug: gHeaderHeight=', $gHeaderHeight, $gNL)" />
        <xsl:value-of select="concat('Debug: gHeaderHeightIn=', $gHeaderHeightIn, $gNL)" />
        <xsl:value-of select="concat('Debug: gBodyHeight=', $gBodyHeight, 'in', $gNL)" />
      </xsl:message>
    </xsl:if>
    <!-- ************************************* -->
    <exsl:document method="xml"
                   href="{concat(@id, '.fo')}">
      <fo:root xmlns:fo="http://www.w3.org/1999/XSL/Format"
               text-align="start"
               font-family="{$gBodyFamily}"
               font-size="12pt"
               line-height="110%">
        <!--
FIX 2009-02-22
        <xsl:attribute name="font-size">
          <xsl:value-of select="concat($gBodySize,'pt')" />
        </xsl:attribute>
        <xsl:attribute name="line-height">
          <xsl:value-of select="concat($gLineHeight,'%')" />
        </xsl:attribute>
-->
        <xsl:comment>Begin:book</xsl:comment>
        <fo:layout-master-set>
          <fo:simple-page-master master-name="Title"
                                 page-width="{$gPageWidth}in"
                                 page-height="{$gPageHeight}in"
                                 margin-top="{$gMarginTop}in"
                                 margin-bottom="{$gMarginBottom}in"
                                 margin-left="{$gMarginOddLeft}in"
                                 margin-right="{$gMarginOddRight}in">
            <fo:region-body margin-top="1in"
                            margin-bottom="0pt" />
          </fo:simple-page-master>
          <fo:simple-page-master master-name="Copyright"
                                 page-width="{$gPageWidth}in"
                                 page-height="{$gPageHeight}in"
                                 margin-top="{$gMarginTop}in"
                                 margin-bottom="{$gMarginBottom}in"
                                 margin-left="{$gMarginEvenLeft}in"
                                 margin-right="{$gMarginEvenRight}in">
            <fo:region-body margin-top="{$gHeaderHeight}pt"
                            margin-bottom="0pt" />
          </fo:simple-page-master>
          <fo:simple-page-master master-name="TOC"
                                 page-width="{$gPageWidth}in"
                                 page-height="{$gPageHeight}in"
                                 margin-top="{$gMarginTop}in"
                                 margin-bottom="{$gMarginBottom}in"
                                 margin-left="{$gMarginOddLeft}in"
                                 margin-right="{$gMarginOddRight}in">
            <fo:region-body margin-top="{$gHeaderHeight}pt"
                            margin-bottom="0pt"
                            margin-left="0.5in"
                            margin-right="0in" />
          </fo:simple-page-master>
          <fo:simple-page-master master-name="ChOdd"
                                 page-width="{$gPageWidth}in"
                                 page-height="{$gPageHeight}in"
                                 margin-top="{$gMarginTop}in"
                                 margin-bottom="{$gMarginBottom}in"
                                 margin-left="{$gMarginOddLeft}in"
                                 margin-right="{$gMarginOddRight}in">
            <fo:region-body margin-top="{$gHeaderHeight}pt"
                            margin-bottom="0pt" />
            <fo:region-before extent="{$gHeaderHeight}pt"
                              region-name="ChOddBefore" />
          </fo:simple-page-master>
          <fo:simple-page-master master-name="ChEven"
                                 page-width="{$gPageWidth}in"
                                 page-height="{$gPageHeight}in"
                                 margin-top="{$gMarginTop}in"
                                 margin-bottom="{$gMarginBottom}in"
                                 margin-left="{$gMarginEvenLeft}in"
                                 margin-right="{$gMarginEvenRight}in">
            <fo:region-body margin-top="{$gHeaderHeight}pt"
                            margin-bottom="0pt" />
            <fo:region-before extent="{$gHeaderHeight}pt"
                              region-name="ChEvenBefore" />
          </fo:simple-page-master>
          <fo:page-sequence-master master-name="Book">
            <fo:single-page-master-reference master-reference="Title" />
            <fo:single-page-master-reference master-reference="Copyright" />
            <fo:single-page-master-reference master-reference="TOC" />
            <fo:repeatable-page-master-alternatives>
              <fo:conditional-page-master-reference master-reference="ChOdd"
                                                    page-position="any"
                                                    odd-or-even="odd" />
              <fo:conditional-page-master-reference master-reference="ChEven"
                                                    page-position="any"
                                                    odd-or-even="even" />
            </fo:repeatable-page-master-alternatives>
          </fo:page-sequence-master>
        </fo:layout-master-set>
        <fo:page-sequence master-reference="Book">
          <xsl:call-template name="fPageHeader" />
          <fo:flow flow-name="xsl-region-body">
            <xsl:call-template name="fTitlePage" />
            <xsl:call-template name="fCopyrightPage" />
            <xsl:if test="$gPrintRef/@toc = '1'">
              <xsl:call-template name="fTocPage" />
            </xsl:if>
            <xsl:apply-templates select="story-info/ch-preface" />
            <xsl:apply-templates select="preface" />
            <xsl:apply-templates select="chapter" />
            <xsl:apply-templates select="epilog" />
          </fo:flow>
        </fo:page-sequence>
        <xsl:comment>End:book</xsl:comment>
      </fo:root>
    </exsl:document>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fPageHeader">
    <xsl:comment>Begin:fPageHeader</xsl:comment>
    <!-- Page Numbering -->
    <fo:static-content flow-name="ChOddBefore">
      <fo:table table-layout="fixed"
                width="{$gBodyWidth}in"
                border-collapse="collapse">
        <fo:table-column column-width="{$gHalfBodyWidth}in" />
        <fo:table-column column-width="{$gHalfBodyWidth}in" />
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell>
              <fo:block text-align="left"
                        line-height="60%"
                        font-family="{$gHeadFamily}">
                <xsl:if test="not($gPrintRef/@head-type = 'page-no')">
                  <xsl:choose>
                    <xsl:when test="title-abbrev">
                      <xsl:value-of select="title-abbrev" />
                    </xsl:when>
                    <xsl:otherwise>
                      <xsl:value-of select="title" />
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:if>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block text-align="right"
                        line-height="60%"
                        font-family="{$gHeadFamily}">
                <fo:page-number />
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
      <fo:block text-align="left"
                line-height="60%">
        <fo:leader leader-pattern="rule"
                   leader-length="{$gBodyWidth}in" />
      </fo:block>
    </fo:static-content>
    <fo:static-content flow-name="ChEvenBefore">
      <fo:table table-layout="fixed"
                width="{$gBodyWidth}in"
                border-collapse="collapse">
        <fo:table-column column-width="{$gHalfBodyWidth}in" />
        <fo:table-column column-width="{$gHalfBodyWidth}in" />
        <fo:table-body>
          <fo:table-row>
            <fo:table-cell>
              <fo:block text-align="left"
                        line-height="60%"
                        font-family="{$gHeadFamily}">
                <fo:page-number />
              </fo:block>
            </fo:table-cell>
            <fo:table-cell>
              <fo:block text-align="right"
                        line-height="60%"
                        font-family="{$gHeadFamily}">
                <xsl:choose>
                  <xsl:when test="$gPrintRef/@head-type = 'page-no'">
                    <xsl:value-of select="' '" />
                  </xsl:when>
                  <xsl:when test="$gPrintRef/@head-type = 'title'">
                    <xsl:choose>
                      <xsl:when test="title-abbrev">
                        <xsl:value-of select="title-abbrev" />
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="title" />
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:when>
                  <xsl:when test="$gPrintRef/@head-type = 'title-author'">
                    <xsl:apply-templates select="book-info/author-group/author[1]" />
                  </xsl:when>
                  <xsl:when test="$gPrintRef/@head-type = 'title-chapter'">

                    <fo:retrieve-marker retrieve-class-name="page-head" />
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:value-of select="' '" />
                  </xsl:otherwise>
                </xsl:choose>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
      <fo:block text-align="left"
                line-height="60%">
        <fo:leader leader-pattern="rule"
                   leader-length="{$gBodyWidth}in" />
      </fo:block>
    </fo:static-content>
    <xsl:comment>End:fPageHeader</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fTitlePage">
    <xsl:comment>Begin:fTitlePage</xsl:comment>
    <fo:block text-align="center"
              line-height="110%"
              font-weight="bold"
              font-family="{$gTitleFamily}"
              font-size="{$gPrintRef/@title-size}">
      <xsl:value-of select="title" />
    </fo:block>
    <xsl:if test="subtitle">
      <fo:block text-align="center"
                line-height="110%"
                font-weight="bold"
                font-family="{$gTitleFamily}"
                font-size="{$gPrintRef/@ch-title-size}">
        <xsl:apply-templates select="subtitle" />
      </fo:block>
    </xsl:if>
    <fo:block text-align="center"
              line-height="110%"
              font-weight="bold"
              padding-top="1em"
              break-after="page"
              font-family="{$gTitleFamily}"
              font-size="{$gPrintRef/@ch-title-size}">
      <xsl:value-of select="'by '" />
      <xsl:apply-templates select="book-info/author-group/author" />
    </fo:block>
    <xsl:comment>End:fTitlePage</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fCopyrightPage">
    <xsl:comment>Begin:fCopyrightPage</xsl:comment>
    <!-- "$gPrintRef/@copyright-type" -->
    <fo:block font-weight="bold"
              keep-with-next.within-page="always">
      <xsl:value-of select="title" />
    </fo:block>
    <xsl:call-template name="fFmtCopyright" />
    <xsl:apply-templates select="book-info/edition" />
    <xsl:apply-templates select="book-info/publisher" />
    <xsl:apply-templates select="book-info/biblio-id" />
    <xsl:call-template name="fFmtReleaseInfo" />
    <fo:block keep-with-previous.within-page="always">&#160; 
    <fo:footnote>
      <fo:inline>&#160;</fo:inline>
      <fo:footnote-body>
        <fo:block keep-with-previous.within-page="always">
          <xsl:apply-templates select="book-info/legal-notice" />
          <fo:block padding-top=".5em"
                    padding-bottom=".5em"
                    font-weight="bold"
                    keep-with-previous.within-page="always">
            <xsl:value-of select="'Printed in the United States of America'" />
          </fo:block>
        </fo:block>
      </fo:footnote-body>
    </fo:footnote></fo:block>
    <xsl:comment>End:fCopyrightPage</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fTocPage">
    <xsl:comment>Begin:fTocPager</xsl:comment>
    <fo:block break-before="odd-page"
              line-height="110%"
              text-align="center"
              font-weight="bold"
              space-after="0.5in"
              font-family="{$gChTitleFamily}"
              font-size="{$gPrintRef/@ch-title-size}">
      <xsl:value-of select="'Contents'" />
    </fo:block>
    <xsl:if test="$gContentRef/@ch-preface = '1'">
      <xsl:apply-templates select="story-info/ch-preface"
                           mode="toc" />
    </xsl:if>
    <xsl:if test="$gContentRef/@preface = '1'">
      <xsl:apply-templates select="preface"
                           mode="toc" />
    </xsl:if>
    <xsl:apply-templates select="chapter"
                         mode="toc" />
    <xsl:if test="$gContentRef/@preface = '1'">
      <xsl:apply-templates select="epilog"
                           mode="toc" />
    </xsl:if>
    <fo:block break-before="page"></fo:block>
    <xsl:comment>End:fTocPager</xsl:comment>
  </xsl:template>
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
  <xsl:template match="ch-preface|preface|epilog"
                mode="toc">
    <xsl:comment>Begin:toc: ch-preface, preface, epilog</xsl:comment>
    <fo:block text-indent="-0.5in"
              text-align-last="justify">
      <xsl:apply-templates select="title"
                           mode="toc" />
      <fo:leader leader-length.minimum="12pt"
                 leader-length.optimum="40pt"
                 leader-length.maximum="100%"
                 leader-pattern="dots" />
      <fo:page-number-citation ref-id="{name()}" />
      <xsl:comment>End:toc: ch-preface, preface, epilog</xsl:comment>
    </fo:block>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="chapter"
                mode="toc">
    <xsl:comment>Begin:toc: chapter</xsl:comment>
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <fo:block text-indent="-0.5in"
                text-align-last="justify">
        <!--
      <xsl:value-of select="@id" />. 
-->
        <xsl:apply-templates select="title"
                             mode="toc" />
        <xsl:if test="@revision != 'final'">
          <xsl:if test="@revision = 'draft'">
            <xsl:value-of select="' - draft'" />
          </xsl:if>
          <xsl:if test="@revision = 'in-progress'">
            <xsl:value-of select="' - in progress'" />
          </xsl:if>
          <xsl:value-of select="concat('(first post: ', chapter-info/pub-date, '; last update: ')" />
          <xsl:apply-templates select="chapter-info/release-info/@date" />
          <xsl:value-of select="')'" />
        </xsl:if>
        <xsl:value-of select="' '" />
        <fo:leader leader-length.minimum="12pt"
                   leader-length.optimum="40pt"
                   leader-length.maximum="100%"
                   leader-pattern="dots" />
        <fo:page-number-citation>
          <xsl:attribute name="ref-id">
            <xsl:value-of select="concat('ch-', @id)" />
          </xsl:attribute>
        </fo:page-number-citation>
      </fo:block>
    </xsl:if>
    <xsl:comment>End:toc: chapter</xsl:comment>
  </xsl:template>
  <!-- **************************************************
Book
-->
  <!-- ******************** -->
  <xsl:template name="fFmtCopyright">
    <xsl:comment>Begin:fFmtCopyright</xsl:comment>
    <fo:block padding-top=".5em"
              font-weight="bold"
              keep-with-next.within-page="always">
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
    </fo:block>
    <xsl:comment>End:fFmtCopyright</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="legal-notice">
    <xsl:comment>Begin:legal-notice</xsl:comment>
    <fo:block padding-top=".5em"
              keep-with-previous.within-page="always">
      <xsl:apply-templates select="p|para|pre|pre-fmt|quote" />
    </fo:block>
    <xsl:comment>End:legal-notice</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="edition">
    <fo:block padding-top=".5em"
              keep-with-next.within-page="always">
      <xsl:value-of select="concat('Edition: ', .)" />
    </fo:block>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="biblio-id">
    <fo:block padding-top=".5em"
              keep-with-next.within-page="always">
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
    </fo:block>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fFmtReleaseInfo">
    <xsl:comment>Begin:fFmtReleaseInfo</xsl:comment>
    <xsl:if test="@revision = 'in-progress'">
      <fo:block padding-top=".5em"
                font-weight="bold"
                keep-with-next.within-page="always">In progress - Not for
                public release.</fo:block>
      <xsl:apply-templates select="book-info/release-info" />
    </xsl:if>
    <xsl:if test="@revision = 'draft'">
      <fo:block padding-top=".5em">Draft - Not for public
      release.</fo:block>
      <xsl:apply-templates select="book-info/release-info" />
    </xsl:if>
    <xsl:comment>End:fFmtReleaseInfo</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="publisher">
    <fo:block padding-top=".5em"
              padding-bottom=".5em"
              keep-with-next.within-page="always">
      <xsl:value-of select="publisher-name" />
      <xsl:apply-templates select="address" />
    </fo:block>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="address">
    <xsl:comment>Begin:address</xsl:comment>
    <xsl:apply-templates select="street" />
    <xsl:apply-templates select="pob" />
    <fo:block>
      <xsl:value-of select="concat(city, ', ', state, ' ', post-code)" />
    </fo:block>
    <xsl:apply-templates select="country" />
    <xsl:apply-templates select="phone" />
    <xsl:apply-templates select="fax" />
    <xsl:apply-templates select="email" />
    <xsl:apply-templates select="other-addr" />
    <xsl:comment>End:address</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="street|pob|country|phone|fax|email|other-addr">
    <fo:block>
      <xsl:value-of select="." />
    </fo:block>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="title">
    <xsl:comment>Begin: title</xsl:comment>
    <fo:block padding-bottom=".5em">
      <xsl:value-of select="." />
      <xsl:if test="../subtitle">
        <xsl:value-of select="concat(' - ', ../subtitle)" />
      </xsl:if>
    </fo:block>
    <xsl:comment>End: title</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="title"
                mode="toc">
    <xsl:comment>Begin:toc: title</xsl:comment>
    <xsl:value-of select="." />
    <xsl:comment>End:toc: title</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="title"
                mode="page-head">
    <xsl:comment>Begin:page-head: title</xsl:comment>
    <fo:marker marker-class-name="page-head">
      <xsl:choose>
        <xsl:when test="../title-abbrev">
          <xsl:value-of select="../title-abbrev" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="." />
        </xsl:otherwise>
      </xsl:choose>
    </fo:marker>
    <xsl:comment>End:page-head: title</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="ch-preface|preface|epilog">
    <xsl:comment>Begin: ch-preface, preface, epilog</xsl:comment>
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <xsl:call-template name="fPageBreak" />
      <fo:block id="{name()}"
                keep-with-next.within-page="always"
                text-align="left"
                line-height="110%"
                font-weight="bold"
                font-family="{$gChTitleFamily}"
                font-size="{$gPrintRef/@ch-title-size}">
        <xsl:apply-templates select="title" />
      </fo:block>
      <xsl:apply-templates select="p|para|pre|pre-fmt|quote" />
      <xsl:comment>End: ch-preface, preface, epilog</xsl:comment>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="chapter">
    <xsl:comment>Begin: chapter</xsl:comment>
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <xsl:call-template name="fPageBreak" />
      <xsl:call-template name="fChapterBody" />
    </xsl:if>
    <xsl:comment>End: chapter</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fChapterBody">
    <xsl:comment>Begin: fChapterBody</xsl:comment>
    <fo:block text-align="left"
              keep-with-next.within-page="always"
              line-height="110%"
              font-weight="bold"
              font-family="{$gChTitleFamily}"
              font-size="{$gPrintRef/@ch-title-size}">
      <xsl:attribute name="id">
        <xsl:value-of select="concat('ch-', @id)" />
      </xsl:attribute>
      <xsl:apply-templates select="title" />
    </fo:block>
    <xsl:if test="@revision != 'final'">
      <fo:block line-height="120%">
        <xsl:value-of select="@revision" />
      </fo:block>
      <xsl:apply-templates select="chapter-info/release-info" />
    </xsl:if>
    <xsl:apply-templates select="prolog" />
    <xsl:apply-templates select="unit" />
    <xsl:apply-templates select="postlog" />
    <xsl:comment>End: fChapterBody</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="prolog">
    <xsl:comment>Begin: prolog</xsl:comment>
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <fo:block padding-top=".5em"
                padding-bottom=".5em"
                keep-with-next.within-page="always"
                text-align="left"
                line-height="110%"
                font-weight="normal"
                font-family="{$gChTitleFamily}"
                font-size="{$gPrintRef/@ch-title-size}">
        <xsl:apply-templates select="title" />
      </fo:block>
      <xsl:apply-templates select="p|para|pre|pre-fmt|quote" />
      <fo:block text-align="left"
                padding-bottom=".5em"
                line-height="60%">
        <fo:leader leader-pattern="rule"
                   leader-length="2in" />
      </fo:block>
    </xsl:if>
    <xsl:comment>End: prolog</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="postlog">
    <xsl:comment>Begin: postlog</xsl:comment>
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <fo:block padding-top=".5em"
                text-align="left"
                keep-with-next.within-page="always"
                line-height="60%">
        <fo:leader leader-pattern="rule"
                   leader-length="2in" />
      </fo:block>
      <fo:block padding-top=".5em"
                padding-bottom=".5em"
                keep-with-next.within-page="always"
                text-align="left"
                line-height="110%"
                font-weight="normal"
                font-family="{$gChTitleFamily}"
                font-size="{$gPrintRef/@ch-title-size}">
        <xsl:apply-templates select="title" />
      </fo:block>
      <xsl:apply-templates select="p|para|pre|pre-fmt|quote" />
    </xsl:if>
    <xsl:comment>End: postlog</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="unit">
    <xsl:comment>Begin: unit</xsl:comment>
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <xsl:if test="$gPrintRef/@auto-break = '1' and position() != 1">
        <fo:block padding-top="1.5em"
                  line-height="120%" />
      </xsl:if>
      <xsl:apply-templates select="thread" />
    </xsl:if>
    <xsl:comment>End: unit</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="thread">
    <xsl:comment>Begin: thread</xsl:comment>
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <xsl:apply-templates select="p|s|t|pre|quote|br" />
    </xsl:if>
    <xsl:comment>End: thread</xsl:comment>
  </xsl:template>
  <!-- ************************************************************
Utility
-->
  <!-- ******************** -->
  <xsl:template name="fPageBreak">
    <xsl:comment>Begin: fPageBreak</xsl:comment>
    <xsl:choose>
      <xsl:when test="$gPrintRef/@ch-page-break = 'none'">
        <fo:block padding-top=".5em"
                  keep-with-next.within-page="always"
                  text-align="left"
                  line-height="60%">
          <fo:leader leader-pattern="rule"
                     leader-length="2in"
                     keep-with-next.within-page="always" />
        </fo:block>
        <fo:block padding-top=".5em"
                  keep-with-next.within-page="always">
          <xsl:apply-templates select="title"
                               mode="page-head" />
        </fo:block>
      </xsl:when>
      <xsl:when test="$gPrintRef/@ch-page-break = 'any'">
        <fo:block break-before="page"
                  keep-with-next.within-page="always">
          <xsl:apply-templates select="title"
                               mode="page-head" />
        </fo:block>
      </xsl:when>
      <xsl:when test="$gPrintRef/@ch-page-break = 'some-odd'">
        <xsl:choose>
          <xsl:when test="name() = 'chapter' and position() != 1">
            <fo:block break-before="page"
                      keep-with-next.within-page="always">
              <xsl:apply-templates select="title"
                                   mode="page-head" />
            </fo:block>
          </xsl:when>
          <xsl:otherwise>
            <fo:block break-before="odd-page"
                      keep-with-next.within-page="always">
              <xsl:apply-templates select="title"
                                   mode="page-head" />
            </fo:block>
          </xsl:otherwise>
        </xsl:choose>
      </xsl:when>
      <xsl:when test="$gPrintRef/@ch-page-break = 'all-odd'">
        <fo:block break-before="odd-page"
                  keep-with-next.within-page="always">
          <xsl:apply-templates select="title"
                               mode="page-head" />
        </fo:block>
      </xsl:when>
    </xsl:choose>
    <xsl:comment>End: fPageBreak</xsl:comment>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fSelectFont">
    <xsl:param name="pFont" />
    <xsl:choose>
      <xsl:when test="$pFont = 'century'">
        <xsl:value-of select="'Century, serif'" />
      </xsl:when>
      <xsl:when test="$pFont = 'times'">
        <xsl:value-of select="'Times, serif'" />
      </xsl:when>
      <xsl:when test="$pFont = 'helvetica'">
        <xsl:value-of select="'Helvetica, Arial, sans'" />
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="'Times, serif'" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <!-- **************************************************
Block
-->
  <!-- ******************** -->
  <xsl:template match="release-info">
    <xsl:comment>Begin: release-info</xsl:comment>
    <xsl:if test="../pub-date">
      <fo:block>First Published: 
      <xsl:value-of select="../pub-date" /></fo:block>
    </xsl:if>
    <xsl:if test="@date">
      <fo:block>Revision Date: 
      <xsl:apply-templates select="@date" /></fo:block>
    </xsl:if>
    <xsl:if test="@rev">
      <fo:block>Revision: 
      <xsl:apply-templates select="@rev" /></fo:block>
    </xsl:if>
    <xsl:if test="@source">
      <fo:block>Source: 
      <xsl:apply-templates select="@source" /></fo:block>
    </xsl:if>
    <xsl:if test="@root">
      <fo:block>Root: 
      <xsl:apply-templates select="@root" /></fo:block>
    </xsl:if>
    <xsl:if test="@repository">
      <fo:block>Repository: 
      <xsl:apply-templates select="@repository" /></fo:block>
    </xsl:if>
    <xsl:if test="@file">
      <fo:block>File: 
      <xsl:apply-templates select="@file" /></fo:block>
    </xsl:if>
    <xsl:if test="@svn-path">
      <fo:block>Subversion path: 
      <xsl:apply-templates select="@svn-path" /></fo:block>
    </xsl:if>
    <fo:block padding-bottom="1em"></fo:block>
    <xsl:comment>End: release-info</xsl:comment>
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
  <xsl:template match="br">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <fo:block padding-top="1.5em"
                line-height="120%" />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="p">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <fo:block text-align="justify"
                orphans="2"
                widows="2">
      <xsl:attribute name="text-indent">
        <xsl:value-of select="$gIndent" />
      </xsl:attribute>
      <xsl:apply-templates />&#160;</fo:block>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="para">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <fo:block text-align="justify"
                padding-top=".5em"
                orphans="2"
                widows="2">
      <xsl:apply-templates />&#160;</fo:block>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="quote">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <fo:block text-align="justify"
                orphans="2"
                widows="2"
                padding-top=".5em"
                margin-left="{$gMargin}in"
                margin-right="{$gMargin}in">
      <xsl:apply-templates />&#160;</fo:block>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="pre-fmt">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <fo:block font-family="Courier, monospace"
                keep-together.within-page="10"
                white-space="pre"
                padding-top=".2em"
                padding-bottom=".2em"
                white-space-treatment="preserve"
                white-space-collapse="false"
                linefeed-treatment="preserve">
        <xsl:attribute name="font-size">
          <xsl:value-of select="$gBodySize * 0.8" />
          <xsl:value-of select="'pt'" />
        </xsl:attribute>
        <xsl:apply-templates />
      </fo:block>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="pre">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <fo:block font-family="Courier, monospace"
                keep-together.within-page="10"
                padding-top=".2em"
                padding-bottom=".2em"
                white-space="pre"
                white-space-treatment="preserve"
                white-space-collapse="false"
                linefeed-treatment="preserve">
        <xsl:attribute name="font-size">
          <xsl:value-of select="ceiling($gBodySize * 0.8)" />
          <xsl:value-of select="'pt'" />
        </xsl:attribute>
        <xsl:apply-templates />
      </fo:block>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="s">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <fo:block text-align="justify"
                orphans="2"
                widows="2">
      <xsl:attribute name="text-indent">
        <xsl:value-of select="$gIndent" />
      </xsl:attribute>
      <xsl:apply-templates />&#160;</fo:block>
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="t">
    <xsl:variable name="tShow">
      <xsl:call-template name="fShowContent" />
    </xsl:variable>
    <xsl:if test="$tShow = '1'">
      <fo:block text-align="justify"
                orphans="2"
                widows="2">
      <xsl:attribute name="text-indent">
        <xsl:value-of select="$gIndent" />
      </xsl:attribute>
      <xsl:apply-templates />&#160;</fo:block>
    </xsl:if>
  </xsl:template>
  <!-- **************************************************
Inline
-->
  <!-- ******************** -->
  <xsl:template name="fImgUrl">
    <xsl:param name="pKey" />
    <xsl:variable name="tImage"
                  select="key('def-img-index', $pKey)" />
    <xsl:variable name="tImageURL"
                  select="$tImage/@url" />
    <xsl:variable name="tImageBase"
                  select="key('def-base-index', $tImage/@base-ref)/." />
    <xsl:value-of select="concat($tImageBase, $tImageURL)" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fImgTag">
    <xsl:param name="pKey" />
    <xsl:if test="$gDebug">
      <xsl:message>
        <xsl:value-of select="concat($gNL, 'In: fImgTag', $gNL, 'def-img id=', $pKey, $gNL)" />
      </xsl:message>
    </xsl:if>
    <xsl:variable name="tImagePath">
      <xsl:call-template name="fImgUrl">
        <xsl:with-param name="pKey"
                        select="$pKey" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="tPtWidth">
      <xsl:call-template name="fUnits">
        <xsl:with-param name="pFrom"
                        select="key('def-img-index', $pKey)/@width" />
        <xsl:with-param name="pTo"
                        select="'pt'" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="tPtHeight">
      <xsl:call-template name="fUnits">
        <xsl:with-param name="pFrom"
                        select="key('def-img-index', $pKey)/@height" />
        <xsl:with-param name="pTo"
                        select="'pt'" />
      </xsl:call-template>
    </xsl:variable>
    <xsl:variable name="tIndent"
                  select="number(substring-before($gIndent, 'pt'))" />
    <xsl:variable name="tDiffWidth"
                  select="$tPtWidth - $gBodyWidthPt - $tIndent" />
    <xsl:variable name="tDiffHeight"
                  select="$tPtHeight - $gBodyHeightPt" />
    <xsl:variable name="tScale">
      <xsl:choose>
        <xsl:when test="$tDiffWidth &gt; 0 or $tDiffHeight &gt; 0">
          <xsl:choose>
            <xsl:when test="$tDiffWidth &gt; $tDiffHeight">
              <xsl:value-of select="($gBodyWidthPt - $tIndent) div $tPtWidth" />
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="$gBodyHeightPt div $tPtHeight" />
            </xsl:otherwise>
          </xsl:choose>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="1" />
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>
    <xsl:variable name="tWidth"
                  select="concat(floor($tPtWidth * $tScale),'pt')" />
    <xsl:variable name="tHeight"
                  select="concat(floor($tPtHeight * $tScale),'pt')" />
    <xsl:if test="$gDebug">
      <xsl:message>
        <xsl:value-of select="concat('graphic src=', $tImagePath, $gNL)" />
      </xsl:message>
    </xsl:if>
    <xsl:if test="$gDebug and $tScale != 1">
      <xsl:message>
        <xsl:value-of select="concat('Image resized:', $gNL)" />
        <xsl:value-of select="concat('tIndent=', $tIndent, $gNL)" />
        <xsl:value-of select="concat('gBodyWidthPt=', $gBodyWidthPt, $gNL)" />
        <xsl:value-of select="concat('tPtWidth=', $tPtWidth, $gNL)" />
        <xsl:value-of select="concat('tDiffWidth=', $tDiffWidth, $gNL)" />
        <xsl:value-of select="concat('gBodyHeightPt=', $gBodyHeightPt, $gNL)" />
        <xsl:value-of select="concat('tPtHeight=', $tPtHeight, $gNL)" />
        <xsl:value-of select="concat('tDiffHeight=', $tDiffHeight, $gNL)" />
        <xsl:value-of select="concat('tScale=', $tScale, $gNL)" />
        <xsl:value-of select="concat('new tWidth=',$tWidth,$gNL)" />
        <xsl:value-of select="concat('new tHeight=',$tHeight,$gNL)" />
      </xsl:message>
    </xsl:if>
    <fo:external-graphic src="url({$tImagePath})"
                         width="{$tWidth}"
                         height="{$tHeight}"
                         content-width="scale-to-fit"
                         content-height="scale-to-fit" />
    <xsl:if test="$gDebug">
      <xsl:message>
        <xsl:value-of select="concat('Out: fImgTag', $gNL)" />
      </xsl:message>
    </xsl:if>
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
    <fo:inline text-decoration="underline">
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
    </fo:inline>
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
    <fo:inline text-decoration="underline">
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
    </fo:inline>
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
    <fo:inline text-decoration="underline">
      <xsl:if test=". != ''">
        <xsl:value-of select="." />
        <xsl:value-of select="' '" />
      </xsl:if>
      <xsl:value-of select="concat($tLink,' (', $tLinkURL, ')')" />
    </fo:inline>
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
    <fo:inline text-decoration="underline">
      <xsl:value-of select="concat($tLink, ' (', $tLinkURL, ')')" />
    </fo:inline>
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
    <fo:inline text-decoration="underline">
      <xsl:value-of select="concat($tLink, ' (', $tLinkURL, ')')" />
    </fo:inline>
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
    <fo:inline text-decoration="underline">
      <xsl:value-of select="$tLink" />
    </fo:inline>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="b">
    <fo:inline font-weight="bold">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="i">
    <fo:inline font-style="italic">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="tt">
    <fo:inline font-family="Courier, monospace">
      <xsl:apply-templates />
    </fo:inline>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template name="fRevisionFlag">
    <xsl:if test="not(@revision-flag='deleted')">
      <xsl:apply-templates />
    </xsl:if>
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="rev">
    <xsl:call-template name="fRevisionFlag" />
  </xsl:template>
  <!-- ******************** -->
  <xsl:template match="text()">
    <xsl:value-of select="." />
  </xsl:template>
</xsl:stylesheet>
