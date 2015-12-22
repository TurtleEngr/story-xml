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
$Header: /repo/local.cvs/app/story-xml/src/story2/story-com.xsl,v 1.16 2008/01/07 02:35:52 bruce Exp $
-->
  <!-- ************************************************** -->
  <!-- External parameters -->
  <xsl:param name="style"
	     select="''" />
  <xsl:param name="draft"
	     select="0" />
  <xsl:param name="debug"
	     select="0" />
  <xsl:strip-space elements="*" />
  <xsl:preserve-space elements="pre" />
  <xsl:param name="gNL">
    <xsl:text></xsl:text>
  </xsl:param>
  <!-- ************************************************** -->
  <xsl:key name="style-index"
	   match="def-style"
	   use="@id" />
  <xsl:key name="content-index"
	   match="def-content"
	   use="@id" />
  <xsl:key name="draft-index"
	   match="def-draft"
	   use="@id" />
  <xsl:key name="print-index"
	   match="def-print"
	   use="@id" />
  <xsl:key name="page-index"
	   match="page"
	   use="@id" />
  <xsl:key name="book-index"
	   match="book"
	   use="@id" />
  <xsl:key name="chapter-index"
	   match="chapter"
	   use="@id" />
  <xsl:key name="unit-index"
	   match="unit"
	   use="@id" />
  <xsl:key name="def-base-index"
	   match="def-base"
	   use="@id" />
  <xsl:key name="def-img-index"
	   match="def-img"
	   use="@id" />
  <xsl:key name="def-link-index"
	   match="def-link"
	   use="@id" />
  <xsl:key name="def-thread-index"
	   match="def-thread"
	   use="@id" />
  <xsl:key name="def-where-index"
	   match="def-where"
	   use="@id" />
  <xsl:key name="def-who-index"
	   match="def-who"
	   use="@id" />
  <!-- ******************** -->
  <!--
The content style can be selected by defining the 'style' external parameter.
If it is not defined, then the story's
/content/site/style/@style-ref will be used.
-->
  <xsl:param name="gStyleName">
    <xsl:choose>
      <xsl:when test="$style = ''">
	<xsl:value-of select="/content/site/style/@style-ref" />
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="$style" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="gStyleRef"
	     select="key('style-index', $gStyleName)" />
  <xsl:param name="gContentRef"
	     select="key('content-index', $gStyleRef/@content-ref)" />
  <xsl:param name="gPrintRef"
	     select="key('print-index', $gStyleRef/@print-ref)" />
  <xsl:param name="gDraftRef"
	     select="key('draft-index', $gStyleRef/@draft-ref)" />
  <xsl:param name="gDraft">
    <xsl:choose>
      <xsl:when test="boolean(number($draft))">
	<xsl:value-of select="true()" />
	<xsl:message>draft= 
	<xsl:value-of select="$draft" /></xsl:message>
	<xsl:message>bool draft= 
	<xsl:value-of select="boolean(number($draft))" /></xsl:message>
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="boolean(number($gStyleRef/@draft))" />
	<xsl:message>style draft= 
	<xsl:value-of select="boolean(number($gStyleRef/@draft))" /></xsl:message>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="gDebug">
    <xsl:choose>
      <xsl:when test="boolean(number($debug))">
	<xsl:value-of select="true()" />
      </xsl:when>
      <xsl:otherwise>
	<xsl:value-of select="boolean(number($gStyleRef/@debug))" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:param>
  <xsl:param name="gContentThread">
    <xsl:text>
 
</xsl:text>
    <xsl:value-of select="$gContentRef/@thread" />
    <xsl:text>
 
</xsl:text>
  </xsl:param>
  <xsl:param name="gContentLink">
    <xsl:value-of select="$gContentRef/@link-fmt" />
  </xsl:param>
  <xsl:param name="gContentCh">
    <xsl:if test="$gContentRef/@ch-list != ''">
      <xsl:text>
 
</xsl:text>
      <xsl:value-of select="$gContentRef/@ch-list" />
      <xsl:text>
 
</xsl:text>
    </xsl:if>
  </xsl:param>
  <xsl:param name="gContentUnit">
    <xsl:if test="$gContentRef/@unit-list != ''">
      <xsl:text>
 
</xsl:text>
      <xsl:value-of select="$gContentRef/@unit-list" />
      <xsl:text>
 
</xsl:text>
    </xsl:if>
  </xsl:param>
  <xsl:param name="gPageStatus">
    <xsl:if test="boolean(number($gContentRef/@page-done))">
      <xsl:value-of select="' page-done'" />
    </xsl:if>
    <xsl:if test="boolean(number($gContentRef/@page-draft))">
      <xsl:value-of select="' page-draft'" />
    </xsl:if>
    <xsl:if test="boolean(number($gContentRef/@page-in-progress))">
      <xsl:value-of select="' page-in-progress'" />
    </xsl:if>
    <xsl:text>
 
</xsl:text>
  </xsl:param>
  <xsl:param name="gBookStatus">
    <xsl:if test="boolean(number($gContentRef/@book-done))">
      <xsl:value-of select="' book-done'" />
    </xsl:if>
    <xsl:if test="boolean(number($gContentRef/@book-draft))">
      <xsl:value-of select="' book-draft'" />
    </xsl:if>
    <xsl:if test="boolean(number($gContentRef/@book-in-progress))">
      <xsl:value-of select="' book-in-progress'" />
    </xsl:if>
    <xsl:text>
 
</xsl:text>
  </xsl:param>
  <xsl:param name="gChStatus">
    <xsl:if test="boolean(number($gContentRef/@ch-done))">
      <xsl:value-of select="' ch-done'" />
    </xsl:if>
    <xsl:if test="boolean(number($gContentRef/@ch-draft))">
      <xsl:value-of select="' ch-draft'" />
    </xsl:if>
    <xsl:if test="boolean(number($gContentRef/@ch-in-progress))">
      <xsl:value-of select="' ch-in-progress'" />
    </xsl:if>
    <xsl:text>
 
</xsl:text>
  </xsl:param>
  <xsl:param name="gUnitStatus">
    <xsl:if test="boolean(number($gContentRef/@unit-done))">
      <xsl:value-of select="' unit-done'" />
    </xsl:if>
    <xsl:if test="boolean(number($gContentRef/@unit-draft))">
      <xsl:value-of select="' unit-draft'" />
    </xsl:if>
    <xsl:if test="boolean(number($gContentRef/@unit-in-progress))">
      <xsl:value-of select="' unit-in-progress'" />
    </xsl:if>
    <xsl:text>
 
</xsl:text>
  </xsl:param>
  <!-- ************************************************************
Utility
-->
  <xsl:template name="units">
    <xsl:param name="pFrom" />
    <xsl:param name="pTo" />
    <!--
<xsl:message>
  <xsl:value-of select="concat('Debug units: pFrom=', $pFrom)"/>
  <xsl:value-of select="$gNL"/>
  <xsl:value-of select="concat('Debug units: pTo=', $pTo)"/>
  <xsl:value-of select="$gNL"/>
</xsl:message>
-->
    <xsl:choose>
      <xsl:when test="$pFrom = 0">
	<xsl:value-of select="0" />
      </xsl:when>
      <xsl:otherwise>
	<!-- Get the tFromUnits: last two char. of pFrom -->
	<xsl:variable name="tFromUnits"
		      select="substring($pFrom, string-length($pFrom) - 1, 2)" />
	<xsl:variable name="tFrom"
		      select="number(substring-before($pFrom, $tFromUnits))" />
	<!--
<xsl:message>
  <xsl:value-of select="concat('Debug units: tFromUnits=', $tFromUnits)"/>
  <xsl:value-of select="$gNL"/>
  <xsl:value-of select="concat('Debug units: tFrom=', $tFrom)"/>
  <xsl:value-of select="$gNL"/>
</xsl:message>
-->
	<xsl:choose>
	  <xsl:when test="$tFromUnits = $pTo">
	    <xsl:value-of select="$tFrom" />
	  </xsl:when>
	  <xsl:otherwise>
	    <xsl:choose>
	      <xsl:when test="$tFromUnits = 'in'">
		<xsl:choose>
		  <xsl:when test="$pTo = 'mm'">
		    <xsl:value-of select="$tFrom * 25.4" />
		  </xsl:when>
		  <xsl:when test="$pTo = 'cm'">
		    <xsl:value-of select="$tFrom * 2.54" />
		  </xsl:when>
		  <xsl:when test="$pTo = 'pc'">
		    <xsl:value-of select="$tFrom * 6" />
		  </xsl:when>
		  <xsl:when test="$pTo = 'pt'">
		    <xsl:value-of select="$tFrom * 72" />
		  </xsl:when>
		</xsl:choose>
	      </xsl:when>
	      <xsl:when test="$tFromUnits = 'cm'">
		<xsl:choose>
		  <xsl:when test="$pTo = 'mm'">
		    <xsl:value-of select="$tFrom * 10" />
		  </xsl:when>
		  <xsl:when test="$pTo = 'in'">
		    <xsl:value-of select="$tFrom / 2.54" />
		  </xsl:when>
		  <xsl:when test="$pTo = 'pc'">
		    <xsl:value-of select="$tFrom / 2.54 * 6" />
		  </xsl:when>
		  <xsl:when test="$pTo = 'pt'">
		    <xsl:value-of select="$tFrom / 2.54 * 72" />
		  </xsl:when>
		</xsl:choose>
	      </xsl:when>
	      <xsl:when test="$tFromUnits = 'pc'">
		<xsl:choose>
		  <xsl:when test="$pTo = 'mm'">
		    <xsl:value-of select="$tFrom / 12 * 25.4" />
		  </xsl:when>
		  <xsl:when test="$pTo = 'cm'">
		    <xsl:value-of select="$tFrom / 12 * 2.54" />
		  </xsl:when>
		  <xsl:when test="$pTo = 'in'">
		    <xsl:value-of select="$tFrom / 6" />
		  </xsl:when>
		  <xsl:when test="$pTo = 'pt'">
		    <xsl:value-of select="$tFrom * 6" />
		  </xsl:when>
		</xsl:choose>
	      </xsl:when>
	      <xsl:when test="$tFromUnits = 'pt'">
		<xsl:choose>
		  <xsl:when test="$pTo = 'mm'">
		    <xsl:value-of select="$tFrom / 72 * 25.4" />
		  </xsl:when>
		  <xsl:when test="$pTo = 'cm'">
		    <xsl:value-of select="$tFrom / 72 * 2.54" />
		  </xsl:when>
		  <xsl:when test="$pTo = 'pc'">
		    <xsl:value-of select="$tFrom / 6" />
		  </xsl:when>
		  <xsl:when test="$pTo = 'in'">
		    <xsl:value-of select="$tFrom / 72" />
		  </xsl:when>
		</xsl:choose>
	      </xsl:when>
	    </xsl:choose>
	  </xsl:otherwise>
	</xsl:choose>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  <xsl:template name="DebugBook">
    <!--
  <xsl:if test="$gDraft">
  </xsl:if>
  <xsl:if test="$gDebug">
-->
    <xsl:comment>style= 
    <xsl:value-of select="$style" />gStyleName= 
    <xsl:value-of select="$gStyleName" />draft= 
    <xsl:value-of select="$draft" />gDraft= 
    <xsl:value-of select="$gDraft" />debug= 
    <xsl:value-of select="$debug" />gDebug= 
    <xsl:value-of select="$gDebug" />gContentThread= 
    <xsl:value-of select="$gContentThread" />gContentLink= 
    <xsl:value-of select="$gContentLink" />gContentCh= 
    <xsl:value-of select="$gContentCh" />gContentUnit= 
    <xsl:value-of select="$gContentUnit" />gPageStatus= 
    <xsl:value-of select="$gPageStatus" />gBookStatus= 
    <xsl:value-of select="$gBookStatus" />gChStatus= 
    <xsl:value-of select="$gChStatus" />gUnitStatus= 
    <xsl:value-of select="$gUnitStatus" /></xsl:comment>
    <!--
  </xsl:if>
-->
  </xsl:template>
</xsl:stylesheet>
