<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:date="http://exslt.org/dates-and-times"
                xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                exclude-result-prefixes="doc"
                xmlns:exsl="http://exslt.org/common"
                xmlns:str="http://exslt.org/strings"
                extension-element-prefixes="date doc exsl str">
    <xsl:output method="html"
                indent="yes" />
    <xsl:param name="gDraft"
               select="boolean(number('1'))" />
    <xsl:include href="com-param.xsl" />
    <xsl:include href="com-html.xsl" />
    <xsl:include href="com.xsl" />
    <xsl:include href="com-timeline.xsl" />
    <!-- ************************************************** -->
    <xsl:template match="/content">
        <xsl:apply-templates select="story-dtd" />
        <xsl:apply-templates select="book" />
        <xsl:call-template name="fOutputList" />
    </xsl:template>
 
    <!-- ************************************************** -->
    <xsl:template name="fOutputList">
        <exsl:document method="text"
                       href="output-list.txt">
            <xsl:apply-templates select="book"
                                 mode="output-list" />
        </exsl:document>
    </xsl:template>
 
    <xsl:template match="book"
                  mode="output-list">
        <xsl:value-of select="concat(@id,'-draft.html')" />
        <xsl:value-of select="$gNL" />
    </xsl:template>
 
    <!-- ************************************************** -->
    <xsl:template match="book">
        <!--
    <xsl:if test="$gDebug">
      <xsl:message>
        <xsl:value-of select="concat('Debug: text=', $gPrintRef/@text)" />
      </xsl:message>
    </xsl:if>
-->
        <!-- ************************ -->
        <exsl:document method="html"
                       href="{concat(@id, '-draft.html')}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="title" />
                    </title>
                    <xsl:call-template name="fMetaHead" />
                    <xsl:call-template name="fHtmlStyle" />
                </head>
                <body>
                    <xsl:call-template name="fBodyAttr" />
                    <xsl:call-template name="fTitlePage" />
                    <xsl:call-template name="fCopyrightPage" />
                    <xsl:call-template name="fTocPage" />
                    <xsl:call-template name="fDefBook" />
                    <xsl:apply-templates select="preface" />
                    <xsl:apply-templates select="chapter" />
                    <xsl:apply-templates select="epilog" />
                </body>
            </html>
        </exsl:document>
    </xsl:template>
 
    <!-- **************************************************
Page
-->
    <!-- ******************** -->
    <xsl:template name="fDefBook">
        <hr />
        <h2>
            <font class="draft">Draft Color Key</font>
        </h2>
        <table border="1"
               cellpadding="4"
               cellspacing="0">
            <tr align="left"
                valign="top">
                <th width="30%">Color/Style</th>
                <th width="70%">Descripton</th>
            </tr>
            <tr align="left"
                valign="top">
                <td>
                    <p class="block">Black</p>
                </td>
                <td>
                    <p class="block">
                        <font class="draft">Black text will print in final
                        non-draft copy.</font>
                    </p>
                </td>
            </tr>
            <tr align="left"
                valign="top">
                <td>
                    <p class="block">
                        <font class="draft">Red, Italic</font>
                    </p>
                </td>
                <td>
                    <p class="block">
                        <font class="draft">This text only prints in draft
                        copies.</font>
                    </p>
                </td>
            </tr>
            <tr align="left"
                valign="top">
                <td>
                    <p class="block">
                        <font class="del">Red, Strike</font>
                    </p>
                </td>
                <td>
                    <p class="block">
                        <font class="draft">This is deleted text, which only
                        prints in draft copies, if the @deleted draft option
                        is on.</font>
                    </p>
                </td>
            </tr>
            <tr align="left"
                valign="top">
                <td>
                    <p class="block">
                        <font class="change">Blue, Underline</font>
                    </p>
                </td>
                <td>
                    <p class="block">
                        <font class="draft">This is changed text. It will be
                        black in non-draft copies.</font>
                    </p>
                </td>
            </tr>
            <tr align="left"
                valign="top">
                <td>
                    <p class="block">
                        <font class="ins">Green, Underlined</font>
                    </p>
                </td>
                <td>
                    <p class="block">
                        <font class="draft">This is added text. It will be
                        black in non-draft copies.</font>
                    </p>
                </td>
            </tr>
            <tr align="left"
                valign="top">
                <td>
                    <p class="block">
                        <div class="ins">
                            <font class="draft">Red, Italic, with Green
                            Underline</font>
                        </div>
                    </p>
                </td>
                <td>
                    <p class="block">
                        <font class="draft">This is draft text in a block
                        that has a RevisionFlag="added". It will only print
                        in draft copies, if the @deleted draft option is
                        on.</font>
                    </p>
                </td>
            </tr>
            <tr align="left"
                valign="top">
                <td>
                    <p class="block">
                        <div class="change">
                            <font class="draft">Red, Italic, with Blue
                            Underline</font>
                        </div>
                    </p>
                </td>
                <td>
                    <p class="block">
                        <font class="draft">This is draft text in a block
                        that has a RevisionFlag="changed". It will only print
                        in draft copies.</font>
                    </p>
                </td>
            </tr>
            <tr align="left"
                valign="top">
                <td>
                    <p class="block">
                        <div class="del">
                            <font class="draft">Red, Italic, Strike</font>
                        </div>
                    </p>
                </td>
                <td>
                    <p class="block">
                        <font class="draft">This is draft text in a block
                        that has a RevisionFlag="deleted". It will only print
                        in draft copies.</font>
                    </p>
                </td>
            </tr>
        </table>
        <font class="draft">
            <hr />
            <h2>style-info</h2>
            <p class="block">
                <xsl:value-of select="concat('thread-refs=', style-info/@thread-refs)" />
            </p>
            <p class="block">
                <xsl:value-of select="concat('style-ref=', style-info/@style-ref)" />
            </p>
            <p class="block">
                <xsl:value-of select="concat('meta-description=', style-info/meta-description)" />
            </p>
            <p class="block">
                <xsl:value-of select="concat('file-prefix=', style-info/file-prefix)" />
            </p>
            <h3>def-style</h3>
            <table border="1"
                   cellpadding="4"
                   cellspacing="0">
                <tr align="left"
                    valign="top">
                    <th>id</th>
                    <th>print-ref</th>
                    <th>content-ref</th>
                    <th>draft-ref</th>
                    <th>draft</th>
                    <th>debug</th>
                </tr>
                <xsl:apply-templates select="style-info/def-style"
                                     mode="draft" />
            </table>
            <h3>def-content</h3>
            <table border="1"
                   cellpadding="4"
                   cellspacing="0">
                <tr align="left"
                    valign="top">
                    <th>id</th>
                    <th>ch- 
                    <br />draft</th>
                    <th>ch- 
                    <br />final</th>
                    <th>ch- 
                    <br />in- 
                    <br />progress</th>
                    <th>ch- 
                    <br />preface</th>
                    <th>ch- 
                    <br />refs</th>
                    <th>link- 
                    <br />fmt</th>
                    <th>preface</th>
                    <th>prolog</th>
                    <th>thread- 
                    <br />refs</th>
                    <th>unit- 
                    <br />draft</th>
                    <th>unit- 
                    <br />final</th>
                    <th>unit- 
                    <br />in- 
                    <br />progress</th>
                </tr>
                <xsl:apply-templates select="style-info/def-content"
                                     mode="draft" />
            </table>
            <h3>def-draft</h3>
            <table border="1"
                   cellpadding="4"
                   cellspacing="0">
                <tr align="left"
                    valign="top">
                    <th>id</th>
                    <th>def- 
                    <br />base</th>
                    <th>def- 
                    <br />img</th>
                    <th>def- 
                    <br />link</th>
                    <th>def- 
                    <br />thread</th>
                    <th>def- 
                    <br />when</th>
                    <th>def- 
                    <br />where</th>
                    <th>def- 
                    <br />who</th>
                    <th>deleted</th>
                    <th>thread- 
                    <br />all</th>
                    <th>thread- 
                    <br />all- 
                    <br />vp</th>
                    <th>thread- 
                    <br />content</th>
                    <th>thread- 
                    <br />id- 
                    <br />vp</th>
                    <th>thread- 
                    <br />ref</th>
                </tr>
                <xsl:apply-templates select="style-info/def-draft"
                                     mode="draft1" />
            </table>
            <br />
            <table border="1"
                   cellpadding="4"
                   cellspacing="0">
                <tr align="left"
                    valign="top">
                    <th>id</th>
                    <th>time 
                    <br />line</th>
                    <th>unit- 
                    <br />outline</th>
                    <th>unit- 
                    <br />title</th>
                    <th>unit- 
                    <br />when</th>
                    <th>unit- 
                    <br />where</th>
                    <th>unit- 
                    <br />who</th>
                </tr>
                <xsl:apply-templates select="style-info/def-draft"
                                     mode="draft2" />
            </table>
            <h3>def-print</h3>
            <p class="block">
                <b>common</b>
            </p>
            <table border="1"
                   cellpadding="4"
                   cellspacing="0">
                <tr align="left"
                    valign="top">
                    <th>id</th>
                    <th>auto- 
                    <br />break</th>
                    <th>body- 
                    <br />family</th>
                    <th>body- 
                    <br />size</th>
                    <th>ch- 
                    <br />title- 
                    <br />family</th>
                    <th>ch- 
                    <br />title- 
                    <br />size</th>
                    <th>copyright- 
                    <br />type</th>
                    <th>mar 
                    <br />gin</th>
                    <th>out 
                    <br />put- 
                    <br />type</th>
                    <th>title- 
                    <br />family</th>
                    <th>title- 
                    <br />size</th>
                    <th>toc</th>
                </tr>
                <xsl:apply-templates select="style-info/def-print"
                                     mode="draft-com" />
            </table>
            <p class="block">
                <b>html only</b>
            </p>
            <table border="1"
                   cellpadding="4"
                   cellspacing="0">
                <tr align="left"
                    valign="top">
                    <th>id</th>
                    <th>alink</th>
                    <th>bgcolor</th>
                    <th>draft</th>
                    <th>img- 
                    <br />ref</th>
                    <th>link</th>
                    <th>multi- 
                    <br />file</th>
                    <th>next- 
                    <br />prev</th>
                    <th>text</th>
                    <th>vlink</th>
                </tr>
                <xsl:apply-templates select="style-info/def-print"
                                     mode="draft-html" />
            </table>
            <p class="block">
                <b>print only</b>
            </p>
            <table border="1"
                   cellpadding="4"
                   cellspacing="0">
                <tr align="left"
                    valign="top">
                    <th>id</th>
                    <th>bleed- 
                    <br />bottom</th>
                    <th>bleed- 
                    <br />left</th>
                    <th>bleed- 
                    <br />right</th>
                    <th>bleed- 
                    <br />top</th>
                    <th>ch- 
                    <br />page- 
                    <br />break</th>
                    <th>du 
                    <br />plex</th>
                    <th>gut 
                    <br />ter</th>
                    <th>head- 
                    <br />align</th>
                    <th>head- 
                    <br />family</th>
                    <th>head- 
                    <br />loca 
                    <br />tion</th>
                    <th>head- 
                    <br />size</th>
                    <th>head- 
                    <br />type</th>
                    <th>line- 
                    <br />height</th>
                    <th>page</th>
                </tr>
                <xsl:apply-templates select="style-info/def-print"
                                     mode="draft-print" />
            </table>
            <h3>def-base</h3>
            <table border="1"
                   cellpadding="4"
                   cellspacing="0">
                <tr align="left"
                    valign="top">
                    <th>id</th>
                    <th>value</th>
                </tr>
                <xsl:apply-templates select="style-info/def-base"
                                     mode="draft" />
            </table>
            <h3>def-img</h3>
            <table border="1"
                   cellpadding="4"
                   cellspacing="0">
                <tr align="left"
                    valign="top">
                    <th>id</th>
                    <th>base-ref</th>
                    <th>url</th>
                    <th>alt</th>
                </tr>
                <xsl:apply-templates select="style-info/def-img"
                                     mode="draft" />
            </table>
            <h3>def-link</h3>
            <table border="1"
                   cellpadding="4"
                   cellspacing="0">
                <tr align="left"
                    valign="top">
                    <th>id</th>
                    <th>base-ref</th>
                    <th>url</th>
                    <th>img-ref</th>
                    <th>title</th>
                </tr>
                <xsl:apply-templates select="style-info/def-link"
                                     mode="draft" />
            </table>
            <hr />
            <h2>story-info</h2>
            <xsl:if test="$gDraftRef/@timeline = '1'">
                <xsl:call-template name="fTimeline" />
                <xsl:call-template name="fFmtTimeline" />
                <h3>
                    <font class="draft">
                        <a href="{concat(@id, '-timeline.html')}">
                            <xsl:value-of select="concat(@id, '-timeline.html')" />
                        </a>
                    </font>
                </h3>
            </xsl:if>
            <xsl:if test="$gDraftRef/@def-when = '1'">
                <h3>def-when</h3>
                <xsl:apply-templates select="story-info/def-when"
                                     mode="draft" />
            </xsl:if>
            <xsl:if test="$gDraftRef/@def-who = '1'">
                <h3>def-who</h3>
                <table border="1"
                       cellpadding="4"
                       cellspacing="0">
                    <tr align="left"
                        valign="top">
                        <th>id</th>
                        <th>description</th>
                    </tr>
                    <xsl:apply-templates select="story-info/def-who"
                                         mode="draft" />
                </table>
            </xsl:if>
            <xsl:if test="$gDraftRef/@def-when = '1'">
                <h3>def-when</h3>
                <pre>
year=
<xsl:value-of select="story-info/def-when/@year" />
month=
<xsl:value-of select="story-info/def-when/@month" />
day=
<xsl:value-of select="story-info/def-when/@day" />
hour=
<xsl:value-of select="story-info/def-when/@hour" />
min=
<xsl:value-of select="story-info/def-when/@min" />
gmt=
<xsl:value-of select="story-info/def-when/@gmt" />
        
</pre>
            </xsl:if>
            <xsl:if test="$gDraftRef/@def-where = '1'">
                <h3>def-where</h3>
                <table border="1"
                       cellpadding="4"
                       cellspacing="0">
                    <tr align="left"
                        valign="top">
                        <th>id</th>
                        <th>description</th>
                    </tr>
                    <xsl:apply-templates select="story-info/def-where"
                                         mode="draft" />
                </table>
            </xsl:if>
            <xsl:if test="$gDraftRef/@def-thread = '1'">
                <h3>def-thread</h3>
                <table border="1"
                       cellpadding="4"
                       cellspacing="0">
                    <tr align="left"
                        valign="top">
                        <th width="20%">id</th>
                        <th width="80%">description</th>
                    </tr>
                    <xsl:apply-templates select="story-info/def-thread"
                                         mode="draft" />
                </table>
            </xsl:if>
            <h3>ch-preface</h3>
            <xsl:apply-templates select="story-info/ch-preface"
                                 mode="draft" />
        </font>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="def-style"
                  mode="draft">
        <tr>
            <td>
                <xsl:value-of select="@id" />
            </td>
            <td>
                <xsl:value-of select="@print-ref" />
            </td>
            <td>
                <xsl:value-of select="@content-ref" />
            </td>
            <td>
                <xsl:value-of select="@draft-ref" />
            </td>
            <td align="center">
                <xsl:if test="@draft != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@debug != '0'">*</xsl:if>
            </td>
        </tr>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="def-content"
                  mode="draft">
        <tr align="left"
            valign="top">
            <td>
                <xsl:value-of select="@id" />
            </td>
            <td align="center">
                <xsl:if test="@ch-draft != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@ch-final != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@ch-in-progress != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@ch-preface != '0'">*</xsl:if>
            </td>
            <td>
                <xsl:value-of select="@ch-refs" />
            </td>
            <td>
                <xsl:value-of select="@link-fmt" />
            </td>
            <td align="center">
                <xsl:if test="@preface != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@prolog != '0'">*</xsl:if>
            </td>
            <td>
                <xsl:value-of select="@thread-refs" />
            </td>
            <td align="center">
                <xsl:if test="@unit-draft != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@unit-final != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@unit-in-progress != '0'">*</xsl:if>
            </td>
        </tr>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="def-draft"
                  mode="draft1">
        <tr align="left"
            valign="top">
            <td>
                <xsl:value-of select="@id" />
            </td>
            <td align="center">
                <xsl:if test="@def-base != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@def-img != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@def-link != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@def-thread != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@def-when != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@def-where != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@def-who != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@deleted != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@thread-all != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@thread-all-vp != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@thread-content != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@thread-id-vp != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@thread-ref != '0'">*</xsl:if>
            </td>
        </tr>
    </xsl:template>
 
    <xsl:template match="def-draft"
                  mode="draft2">
        <tr align="left"
            valign="top">
            <td>
                <xsl:value-of select="@id" />
            </td>
            <td align="center">
                <xsl:if test="@timeline != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:value-of select="@unit-outline" />
            </td>
            <td align="center">
                <xsl:if test="@unit-title != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@unit-when != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@unit-where != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@unit-who != '0'">*</xsl:if>
            </td>
        </tr>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="def-print"
                  mode="draft-com">
        <tr align="left"
            valign="top">
            <td>
                <xsl:value-of select="@id" />
            </td>
            <td align="center">
                <xsl:if test="@auto-break != '0'">*</xsl:if>
            </td>
            <td>
                <xsl:value-of select="@body-family" />
            </td>
            <td>
                <xsl:value-of select="@body-size" />
            </td>
            <td>
                <xsl:value-of select="@ch-title-family" />
            </td>
            <td>
                <xsl:value-of select="@ch-title-size" />
            </td>
            <td>
                <xsl:value-of select="@copyright-type" />
            </td>
            <td>
                <xsl:value-of select="@margin" />
            </td>
            <td>
                <xsl:value-of select="@output-type" />
            </td>
            <td>
                <xsl:value-of select="@title-family" />
            </td>
            <td>
                <xsl:value-of select="@title-size" />
            </td>
            <td align="center">
                <xsl:if test="@toc != '0'">*</xsl:if>
            </td>
        </tr>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="def-print"
                  mode="draft-html">
        <tr align="left"
            valign="top">
            <td>
                <xsl:value-of select="@id" />
            </td>
            <td>
                <xsl:value-of select="@alink" />
            </td>
            <td>
                <xsl:value-of select="@bgcolor" />
            </td>
            <td>
                <xsl:value-of select="@draft" />
            </td>
            <td>
                <xsl:value-of select="@img-ref" />
            </td>
            <td>
                <xsl:value-of select="@link" />
            </td>
            <td align="center">
                <xsl:if test="@multi-file != '0'">*</xsl:if>
            </td>
            <td align="center">
                <xsl:if test="@next-prev != '0'">*</xsl:if>
            </td>
            <td>
                <xsl:value-of select="@text" />
            </td>
            <td>
                <xsl:value-of select="@vlink" />
            </td>
        </tr>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="def-print"
                  mode="draft-print">
        <tr align="left"
            valign="top">
            <td>
                <xsl:value-of select="@id" />
            </td>
            <td>
                <xsl:value-of select="@bleed-bottom" />
            </td>
            <td>
                <xsl:value-of select="@bleed-left" />
            </td>
            <td>
                <xsl:value-of select="@bleed-right" />
            </td>
            <td>
                <xsl:value-of select="@bleed-top" />
            </td>
            <td>
                <xsl:value-of select="@ch-page-break" />
            </td>
            <td align="center">
                <xsl:if test="@duplex != '0'">*</xsl:if>
            </td>
            <td>
                <xsl:value-of select="@gutter" />
            </td>
            <td>
                <xsl:value-of select="@head-align" />
            </td>
            <td>
                <xsl:value-of select="@head-family" />
            </td>
            <td>
                <xsl:value-of select="@head-location" />
            </td>
            <td>
                <xsl:value-of select="@head-size" />
            </td>
            <td>
                <xsl:value-of select="@head-type" />
            </td>
            <td>
                <xsl:value-of select="@line-height" />
            </td>
            <td>
                <xsl:value-of select="@page" />
            </td>
        </tr>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="def-base"
                  mode="draft">
        <tr align="left"
            valign="top">
            <td>
                <xsl:value-of select="@id" />
            </td>
            <td>
                <xsl:value-of select="." />
            </td>
        </tr>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="def-img"
                  mode="draft">
        <tr align="left"
            valign="top">
            <td>
                <xsl:value-of select="@id" />
            </td>
            <td>
                <xsl:value-of select="@base-ref" />
            </td>
            <td>
                <xsl:value-of select="@url" />
            </td>
            <td>
                <xsl:value-of select="." />
            </td>
        </tr>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="def-link"
                  mode="draft">
        <tr align="left"
            valign="top">
            <td>
                <xsl:value-of select="@id" />
            </td>
            <td>
                <xsl:value-of select="@base-ref" />
            </td>
            <td>
                <xsl:value-of select="@url" />
            </td>
            <td>
                <xsl:value-of select="@img-ref" />
            </td>
            <td>
                <xsl:value-of select="." />
            </td>
        </tr>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="def-when"
                  mode="draft">
        <p class="block">Default Unit start-date (only missing attributes are
        replaced with the corresponding values): 
        <br />
        <xsl:value-of select="concat('year-month-day=', @year, '-', format-number(@month, '00'), '-', format-number(@day, '00'))" />
        <xsl:value-of select="concat('; hour:min gmt=', format-number(@hour, '00'), ':', format-number(@min, '00'), ' ', @gmt)" /></p>
        <p class="block">Default Duration, if no duration or end-date is
        specified: 
        <br />
        <xsl:value-of select="concat('year-month-day=', @d-year, '-', @d-month, '-', @d-day)" />
        <xsl:value-of select="concat('; hour:min=', format-number(@d-hour, '00'), ':', format-number(@d-min, '00'))" /></p>
        <p class="block">(Note: end-date will get it's default values from
        the start-date.)</p>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="def-who"
                  mode="draft">
        <tr align="left"
            valign="top">
            <td>
                <xsl:value-of select="@id" />
            </td>
            <td>
                <xsl:apply-templates select="p|para|pre|pre-fmt|quote" />
            </td>
        </tr>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="def-where"
                  mode="draft">
        <tr align="left"
            valign="top">
            <td>
                <xsl:value-of select="@id" />
            </td>
            <td>
                <xsl:apply-templates select="p|para|pre|pre-fmt|quote" />
            </td>
        </tr>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="def-thread"
                  mode="draft">
        <tr align="left"
            valign="top">
            <td>
                <xsl:value-of select="@id" />
            </td>
            <td>
                <xsl:apply-templates select="p|para|pre|pre-fmt|quote" />
            </td>
        </tr>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="ch-preface"
                  mode="draft">
        <p class="block">
            <xsl:value-of select="concat('id=', @id)" />
        </p>
        <xsl:apply-templates select="p|para|pre|pre-fmt|quote" />
    </xsl:template>
 
    <!-- **************************************************
Book
-->
    <!-- ******************** -->
    <xsl:template match="unit">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:if test="$tShow = '1'">
            <xsl:call-template name="fRevFlag">
                <xsl:with-param name="pContent">
                    <xsl:call-template name="fFmtDraft">
                        <xsl:with-param name="pDraft"
                                        select="$gDraftRef/@unit-title" />
                        <xsl:with-param name="pContent">
                            <h3>
                                <xsl:value-of select="concat('Unit: (', @id, ') ', title, ' - ', @type)" />
                            </h3>
                            <p class="block">
                                <xsl:value-of select="concat('revision=', @revision, '; revision-flag=', @revision-flag)" />
                            </p>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="fFmtDraft">
                        <xsl:with-param name="pDraft"
                                        select="$gDraftRef/@unit-when" />
                        <xsl:with-param name="pContent">
                            <h3>when</h3>
                            <table border="1"
                                   cellpadding="4"
                                   cellspacing="0">
                                <tr align="left"
                                    valign="top">
                                    <th width="20%">start-date</th>
                                    <th width="20%">end-date</th>
                                    <th width="20%">Duration</th>
                                    <th width="40%">Description</th>
                                </tr>
                                <xsl:apply-templates select="outline/when" />
                            </table>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="fFmtDraft">
                        <xsl:with-param name="pDraft"
                                        select="$gDraftRef/@unit-where" />
                        <xsl:with-param name="pContent">
                            <h3>where</h3>
                            <table border="1"
                                   cellpadding="4"
                                   cellspacing="0">
                                <tr align="left"
                                    valign="top">
                                    <th width="10%">ref</th>
                                    <th width="40%">Base Description</th>
                                    <th width="40%">Alt. Description</th>
                                </tr>
                                <xsl:apply-templates select="outline/where" />
                            </table>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="fFmtDraft">
                        <xsl:with-param name="pDraft"
                                        select="$gDraftRef/@unit-who" />
                        <xsl:with-param name="pContent">
                            <h3>who</h3>
                            <table border="1"
                                   cellpadding="4"
                                   cellspacing="0">
                                <tr align="left"
                                    valign="top">
                                    <th width="10%">ref</th>
                                    <th width="40%">Base Description</th>
                                    <th width="40%">Alt. Description</th>
                                </tr>
                                <xsl:apply-templates select="outline/who" />
                            </table>
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:call-template name="fFmtDraft">
                        <xsl:with-param name="pDraft"
                                        select="number($gDraftRef/@unit-outline = '1' or ($gDraftRef/@unit-outline = '2' and @revision='in-progress'))" />
                        <xsl:with-param name="pContent">
                            <h3>outline</h3>
                            <xsl:apply-templates select="outline/description" />
                        </xsl:with-param>
                    </xsl:call-template>
                    <xsl:if test="$gPrintRef/@auto-break = '1' and position() != 1">

                        <hr class="break" />
                    </xsl:if>
                    <xsl:apply-templates select="thread" />
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="when">
        <xsl:variable name="tStartDate">
            <xsl:call-template name="fToXMLTime">
                <xsl:with-param name="pNode"
                                select="start-date" />
                <xsl:with-param name="pDefNode1"
                                select="/content/book/story-info/def-when" />
                <xsl:with-param name="pDefNode2"
                                select="/content/book/story-info/def-when" />
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="tEndDate">
            <xsl:call-template name="fToXMLTime">
                <xsl:with-param name="pNode"
                                select="end-date" />
                <xsl:with-param name="pDefNode1"
                                select="start-date" />
                <xsl:with-param name="pDefNode2"
                                select="/content/book/story-info/def-when" />
            </xsl:call-template>
        </xsl:variable>
        <xsl:variable name="tDuration">
            <xsl:value-of select="date:difference($tStartDate, $tEndDate)" />
        </xsl:variable>
        <tr>
            <td>
                <xsl:call-template name="fFmtXMLTime">
                    <xsl:with-param name="pTime"
                                    select="$tStartDate" />
                    <xsl:with-param name="pTag"
                                    select="' '" />
                    <xsl:with-param name="pDay"
                                    select="1" />
                </xsl:call-template>
            </td>
            <td>
                <xsl:call-template name="fFmtXMLTime">
                    <xsl:with-param name="pTime"
                                    select="$tEndDate" />
                    <xsl:with-param name="pTag"
                                    select="' '" />
                    <xsl:with-param name="pDay"
                                    select="1" />
                </xsl:call-template>
            </td>
            <td>
                <xsl:value-of select="$tDuration" />
            </td>
            <td>
                <xsl:apply-templates select="description" />
            </td>
        </tr>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="where">
        <tr>
            <td>
                <xsl:value-of select="@ref" />
            </td>
            <td>
                <xsl:apply-templates select="key('def-where-index',@ref)/*" />
            </td>
            <td>
                <xsl:apply-templates select="p|para|pre|pre-fmt|quote" />
            </td>
        </tr>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="who">
        <tr>
            <td>
                <xsl:value-of select="@ref" />
            </td>
            <td>
                <xsl:apply-templates select="key('def-who-index',@ref)/*" />
            </td>
            <td>
                <xsl:apply-templates select="p|para|pre|pre-fmt|quote" />
            </td>
        </tr>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="description">
        <xsl:apply-templates select="p|para|pre|pre-fmt|quote" />
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="thread">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:if test="$tShow = '1'">
            <xsl:call-template name="fFmtDraft">
                <xsl:with-param name="pDraft"
                                select="$gDraftRef/@thread-ref" />
                <xsl:with-param name="pContent">
                    <xsl:value-of select="concat('thread ref=',@ref)" />
                    <br />
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="fFmtDraft">
                <xsl:with-param name="pDraft"
                                select="$gDraftRef/@thread-id-vp" />
                <xsl:with-param name="pContent">
                    <xsl:value-of select="concat('thread who-refs=',@who-refs)" />
                    <br />
                </xsl:with-param>
            </xsl:call-template>
            <xsl:if test="$gDraftRef/@thread-content = '1'">
                <xsl:apply-templates select="p|s|t|pre|quote|br" />
            </xsl:if>
        </xsl:if>
        <xsl:if test="$tShow = '0' and $gDraftRef/@thread-all = '1'">
            <xsl:call-template name="fFmtDraft">
                <xsl:with-param name="pDraft"
                                select="$gDraftRef/@thread-ref" />
                <xsl:with-param name="pContent">
                    <xsl:value-of select="concat('thread ref=',@ref)" />
                    <br />
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="fFmtDraft">
                <xsl:with-param name="pDraft"
                                select="$gDraftRef/@thread-id-vp" />
                <xsl:with-param name="pContent">
                    <xsl:value-of select="concat('thread who-refs=',@who-refs)" />
                    <br />
                </xsl:with-param>
            </xsl:call-template>
            <xsl:call-template name="fFmtDraft">
                <xsl:with-param name="pDraft"
                                select="$gDraftRef/@thread-content" />
                <xsl:with-param name="pContent">
                    <xsl:apply-templates select="p|s|t|pre|quote|br" />
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
 
    <!-- **************************************************
Block
-->
    <!-- ******************** -->
    <xsl:template match="p">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:if test="$tShow = '1'">
            <p>
                <xsl:call-template name="fRevisionFlag" />
            </p>
        </xsl:if>
        <xsl:if test="$tShow = '0' and $gDraftRef/@thread-all = '1'">
            <xsl:call-template name="fFmtDraft">
                <xsl:with-param name="pDraft"
                                select="'1'" />
                <xsl:with-param name="pContent">
                    <p>
                        <xsl:call-template name="fRevisionFlag" />
                    </p>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="para">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:if test="$tShow = '1'">
            <p class="block">
                <xsl:call-template name="fRevisionFlag" />
            </p>
        </xsl:if>
        <xsl:if test="$tShow = '0' and $gDraftRef/@thread-all = '1'">
            <xsl:call-template name="fFmtDraft">
                <xsl:with-param name="pDraft"
                                select="'1'" />
                <xsl:with-param name="pContent">
                    <p>
                        <xsl:call-template name="fRevisionFlag" />
                    </p>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="pre|pre-fmt">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:if test="$tShow = '1'">
            <pre>
      
<xsl:call-template name="fRevisionFlag" />
      
</pre>
        </xsl:if>
        <xsl:if test="$tShow = '0' and $gDraftRef/@thread-all = '1'">
            <xsl:call-template name="fFmtDraft">
                <xsl:with-param name="pDraft"
                                select="'1'" />
                <xsl:with-param name="pContent">
                    <pre>
          
<xsl:call-template name="fRevisionFlag" />
          
</pre>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="quote">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:if test="$tShow = '1'">
            <p class="quote">
                <xsl:call-template name="fRevisionFlag" />
            </p>
        </xsl:if>
        <xsl:if test="$tShow = '0' and $gDraftRef/@thread-all = '1'">
            <xsl:call-template name="fFmtDraft">
                <xsl:with-param name="pDraft"
                                select="'1'" />
                <xsl:with-param name="pContent">
                    <p class="quote">
                        <xsl:call-template name="fRevisionFlag" />
                    </p>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="s">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:if test="$tShow = '1'">
            <p>
                <xsl:call-template name="fRevisionFlag" />
                <xsl:call-template name="fFmtDraft">
                    <xsl:with-param name="pDraft"
                                    select="$gDraftRef/@thread-id-vp" />
                    <xsl:with-param name="pContent"
                                    select="concat(' (who-ref=',@who-ref,')')" />
                </xsl:call-template>
            </p>
        </xsl:if>
        <xsl:if test="$tShow = '0' and $gDraftRef/@thread-all = '1'">
            <xsl:call-template name="fFmtDraft">
                <xsl:with-param name="pDraft"
                                select="'1'" />
                <xsl:with-param name="pContent">
                    <p>
                        <xsl:call-template name="fRevisionFlag" />
                        <xsl:value-of select="concat(' (who-ref=',@who-ref,')')" />
                    </p>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template match="t">
        <xsl:variable name="tShow">
            <xsl:call-template name="fShowContent" />
        </xsl:variable>
        <xsl:if test="$tShow = '1'">
            <p>
                <xsl:call-template name="fRevisionFlag" />
                <xsl:call-template name="fFmtDraft">
                    <xsl:with-param name="pDraft"
                                    select="$gDraftRef/@thread-id-vp" />
                    <xsl:with-param name="pContent"
                                    select="concat(' (who-ref=',@who-ref,')')" />
                </xsl:call-template>
            </p>
        </xsl:if>
        <xsl:if test="$tShow = '0' and $gDraftRef/@thread-all = '1'">
            <xsl:call-template name="fFmtDraft">
                <xsl:with-param name="pDraft"
                                select="$gDraftRef/@thread-all-vp" />
                <xsl:with-param name="pContent">
                    <p>
                        <xsl:call-template name="fRevisionFlag" />
                        <xsl:value-of select="concat(' (who-ref=',@who-ref,')')" />
                    </p>
                </xsl:with-param>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
 
    <!-- ******************** -->
    <xsl:template name="fFmtDraft">
        <xsl:param name="pDraft" />
        <xsl:param name="pContent" />
        <xsl:if test="$pDraft = '1'">
            <font class="draft">
                <xsl:copy-of select="$pContent" />
            </font>
        </xsl:if>
    </xsl:template>
 
    <!-- ******************** -->
</xsl:stylesheet>
