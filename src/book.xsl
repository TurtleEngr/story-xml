<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:date="http://exslt.org/dates-and-times"
xmlns:exsl="http://exslt.org/common"
extension-element-prefixes="date exsl"
>
<!--
Includes for all:
	inc-text.xsl
	inc-util.xsl

series-toc.xsl
	Description:
	Output:
	Input: site.xml, book.xml, ch*.xml

series-ch.xsl
	Description:
		TOC only has file name links.
		Chap. files, no next/prev, all notes/pref, no icons,
		url links Include ch-preface before each chapter.
		Book preface is put in the first chapter file.
		Book epilog is put in last chapter file (only if book
		status is: done).
	Output:
		series/<file-prefix>-toc.html
		series/<file-prefix>-<ch-no>.html
	Input: site.xml, book.xml, ch*.xml

web-page.xsl
	Description:
		Generate general web pages (site style)
	Output:
		web/<page-id>.html
	Input: site.xml, page*.xml

web-index.xsl
	Description:
		Index of with links to all book-index files (status:
		in-progress, done)
	Output:
		web/book-index.html
	Input: site.xml, book.xml

web-book.xsl
	Description:
		master index with links to: chapter-toc, manuscript, ...
		(if status: in-progress or done)
	Output:
		web/<file-prefix>-index.html
	Input: site.xml, book.xml

web-toc.xsl
	Description:
		Create the book's toc, based on chapter heading.
		Include the book's preface.
	Output:
		web/<file-prefix>-toc.html
	Input: site.xml, book.xml, ch*.xml

web-chapter.xsl
	Description:
		Chapter html files with links to toc, chapter files,
		next/prev/toc/site-home.
		(if status: done)
	Output:
		web/<file-prefix>-<ch-no>.html
	Input: site.xml, book.xml, ch*.xml

web-one-file.xml
	Description:
		toc, preface, notes.  (ch status: done)
	Output:
		web/<file-prefix>.html
	Input: site.xml, book.xml, ch*.xml

web-manuscript.xsl
	Description:
		No toc, simple headings, no preface, no notes
		(ch status: done)
	Output:
		web/<file-prefix>-manuscript.html
	Input: site.xml, book.xml, ch*.xml

pdf-manuscript.xsl
	Description:
		No toc, no preface, no notes, double space, pages
		(ch status: user selects)
	Output:
		print/<file-prefix>-manuscript.pdf
	Input: site.xml, book.xml, ch*.xml

draft-series.xsl
	Description:
		Only chapters with status: draft or in-progress.
		Only file name links in toc.
	Output:
		draft/<file-prefix>-toc.html
		draft/<file-prefix>-<ch-no>.html
	Input: site.xml, book.xml, ch*.xml

outline-only.xsl
	Description:
		No text content, no preface, no notes, everything else.
		TOC file only has file name links.
	Output:
		outline/<file-prefix>-toc.html
		outline/<file-prefix>-<ch-no>.html
	Input: site.xml, book.xml, ch*.xml

outline-draft.xsl
	Description:
		All outline and text
		TOC file only has file name links.
	Output:
		outline/<file-prefix>-toc.html
		outline/<file-prefix>-<ch-no>.html
	Input: site.xml, book.xml, ch*.xml
-->

<xsl:output method="html" indent="yes"/>

<!-- ******************************* -->
<xsl:template match="/content">
  <xsl:apply-templates select="page"/>
  <xsl:apply-templates select="book" mode="toc"/>
  <xsl:apply-templates select="book/chapter" mode="file"/>
  <xsl:apply-templates select="book" mode="one-file"/>
  <xsl:apply-templates select="book" mode="outline"/>
</xsl:template>

<!-- ******************************* -->
<xsl:include href="inc-util.xsl"/>
<xsl:include href="inc-key.xsl"/>
<xsl:include href="inc-text.xsl"/>

<xsl:include href="inc-style-toc.xsl"/>


<!-- ******************************* -->
<xsl:template match="book" mode="one-file">
  <exsl:document method="html" href="{concat('web/',file-prefix,'.html')}">
<html>
<head>
<title>
    <xsl:value-of select="title"/>
</title>
</head>
<body>
<h1>
    <xsl:value-of select="title"/>
</h1>
<p>by <xsl:value-of select="author"/></p>

<hr/>
<h2>Preface</h2>
<xsl:apply-templates select="preface/text"/>

<hr/>
<h2>TOC</h2>
<xsl:apply-templates select="chapter" mode="toc-one-file"/>

<xsl:apply-templates select="chapter" mode="one-file"/>

</body>
</html>
  </exsl:document>
</xsl:template>

<!-- ******************************* -->
<xsl:template match="book" mode="outline">
  <exsl:document method="html" href="{concat('draft/',file-prefix,'-outline.html')}">
<html>
<head>
<title>
    Outline: <xsl:value-of select="title"/>
</title>
</head>
<body>
<h1>
    Outline: <xsl:value-of select="title"/>
</h1>
<p>by <xsl:value-of select="author"/></p>

<xsl:apply-templates select="def-who" mode="outline"/>
<xsl:apply-templates select="def-where" mode="outline"/>
<xsl:apply-templates select="def-thread" mode="outline"/>

<hr/>
<h2>TOC</h2>
<xsl:apply-templates select="chapter" mode="toc-outline"/>

<xsl:apply-templates select="chapter" mode="outline"/>

</body>
</html>
  </exsl:document>
</xsl:template>

<xsl:template match="def-who" mode="outline"/>
<xsl:if test="position()=1">
<hr/>
</xsl:if>
<h2>Who: <xsl:value-of select="@id"/></h2>
  <xsl:apply-templates select="text"/>
</xsl:template>

<xsl:template match="def-where" mode="outline"/>
<xsl:if test="position()=1">
<hr/>
</xsl:if>
<h2>Where: <xsl:value-of select="@id"/></h2>
  <xsl:apply-templates select="text"/>
</xsl:template>

<xsl:template match="def-thread" mode="outline"/>
<xsl:if test="position()=1">
<hr/>
</xsl:if>
<h2>Thread: <xsl:value-of select="@id"/></h2>
  <xsl:apply-templates select="text"/>
</xsl:template>


<!-- ******************************* -->
<xsl:template match="chapter" mode="toc-one-file">
<xsl:element name="a">
<xsl:attribute name="href">
<xsl:value-of select="concat('#',../file-prefix,'-',@id)"/>
</xsl:attribute>
Chapter <xsl:value-of select="position()"/>.
<xsl:value-of select="title"/>
</xsl:element>
<br/>
</xsl:template>

<!-- ******************************* -->
<xsl:template match="chapter" mode="toc-outline">
<xsl:element name="a">
<xsl:attribute name="href">
<xsl:value-of select="concat('#',../file-prefix,'-',@id)"/>
</xsl:attribute>
Chapter <xsl:value-of select="position()"/>.
<xsl:value-of select="title"/>
</xsl:element>
<br/>
</xsl:template>

<!-- ******************************* -->
<xsl:template name="chapter-content">
<hr/>
<xsl:element name="a">
<xsl:attribute name="name">
<xsl:value-of select="concat(../file-prefix,'-',@id)"/>
</xsl:attribute>
</xsl:element>
<br/>
  <h1>
Chapter <xsl:value-of select="position()"/>.
<xsl:value-of select="title"/>
  </h1>
<xsl:value-of select="$nl"/>

  <xsl:comment>
<xsl:apply-templates select="cvs-source"/>
<xsl:value-of select="$nl"/>

Rev: <xsl:apply-templates select="cvs-rev"/>
<xsl:value-of select="$nl"/>

Publish Date: <xsl:apply-templates select="pub-date"/>
<xsl:value-of select="$nl"/>

Update <xsl:apply-templates select="cvs-date"/>
<xsl:value-of select="$nl"/>

Status: <xsl:value-of select="status"/>
<xsl:value-of select="$nl"/>

  </xsl:comment>
<xsl:value-of select="$nl"/>


  <xsl:apply-templates select="../ch-preface/text"/>
  <hr/>

  <h2>Prolog</h2>
  <xsl:apply-templates select="prolog/text"/>
  <hr/>

  <xsl:apply-templates select="unit"/>

  <hr/>
  <h2>Postlog</h2>
  <xsl:apply-templates select="postlog/text"/>
</xsl:template>

<!-- ******************************* -->
<xsl:template match="chapter" mode="one-file">
<xsl:call-template name="chapter-content"/>
</xsl:template>

<!-- ******************************* -->
<xsl:template match="chapter" mode="file">
  <exsl:document method="html" href="{concat('web/',../file-prefix,'-',@id,'.html')}">
<html>
<head>
<title>
Chapter <xsl:value-of select="position()"/>.
<xsl:value-of select="title"/>
</title>
</head>
<body>
<xsl:call-template name="chapter-content"/>
</body>
</html>
  </exsl:document>
</xsl:template>

<!-- ******************************* -->
<xsl:template match="chapter" mode="outline">
<hr/>
<xsl:element name="a">
<xsl:attribute name="name">
<xsl:value-of select="concat(../file-prefix,'-',@id)"/>
</xsl:attribute>
</xsl:element>
<br/>
  <h1>
Chapter <xsl:value-of select="position()"/>.
<xsl:value-of select="title"/>
  </h1>
<xsl:value-of select="$nl"/>

<xsl:apply-templates select="cvs-source"/><br/>
Rev: <xsl:apply-templates select="cvs-rev"/><br/>
Publish Date: <xsl:apply-templates select="pub-date"/><br/>
Update <xsl:apply-templates select="cvs-date"/><br/>
Status: <xsl:value-of select="status"/><br/>
<xsl:value-of select="$nl"/>
  <xsl:apply-templates select="unit" mode="outline"/>
</xsl:template>

<!-- ******************************* -->
<xsl:template match="unit">
  <xsl:apply-templates select="text"/>
  <xsl:apply-templates select="thread"/>
</xsl:template>

<!-- ******************************* -->
<xsl:template match="unit" mode="outline">
<hr/>
<pre>
Unit: <xsl:value-of select="concat(@type,' ',@id,': ',title)"/>
Outline:
<xsl:value-of select="outline"/>
<xsl:apply-templates select="thread" mode="outline"/>
</pre>
</xsl:template>

<!-- ******************************* -->
<xsl:template match="thread">
  <xsl:apply-templates select="text"/>
</xsl:template>

<!-- ******************************* -->
<xsl:template match="thread" mode="outline">
Thread: <xsl:value-of select="@ref"/> <xsl:value-of select="@next-unit"/>
</xsl:template>

<!-- ******************************* -->
<xsl:template match="page">
  <exsl:document method="html" href="{concat('web/',@id,'.html')}">
<html>
<head>
<title>
    <xsl:value-of select="title"/>
</title>
</head>
<body>
<h1>
  <xsl:value-of select="title"/>
</h1>
<p><xsl:value-of select="description"/></p>
  <xsl:apply-templates select="h2"/>
  <xsl:apply-templates select="item/text"/>
</body>
</html>
  </exsl:document>
</xsl:template>

<!-- ******************************* -->
<xsl:template match="h2">
<h2><xsl:value-of select="."/></h2>
</xsl:template>

</xsl:stylesheet>
