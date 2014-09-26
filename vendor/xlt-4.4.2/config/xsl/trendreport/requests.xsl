<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="html" 
            indent="no" 
            omit-xml-declaration="yes"
            encoding="UTF-8"
             />

<!-- 
    Generate the page frame 
-->

<xsl:include href="../common/util/string-replace-all.xsl" />
<xsl:include href="../common/util/convertIllegalCharactersInFileName.xsl" />

<xsl:include href="util/timer-cell.xsl" />
<xsl:include href="util/timer-row-abs.xsl" />
<xsl:include href="util/timer-row-rel.xsl" />
<xsl:include href="util/timer-chart.xsl" />
<xsl:include href="util/timer-table.xsl" />
<xsl:include href="util/timer-section.xsl" />

<xsl:include href="text/descriptions.xsl" />

<xsl:include href="sections/requests.xsl" />

<xsl:include href="../common/sections/head.xsl" />
<xsl:include href="../common/sections/header.xsl" />
<xsl:include href="sections/navigation.xsl" />
<xsl:include href="../common/sections/footer.xsl" />

<xsl:include href="../common/sections/javascript.xsl" />



<xsl:param name="productName" />
<xsl:param name="productVersion" />
<xsl:param name="productUrl" />

<xsl:template match="trendreport">

<xsl:text disable-output-escaping="yes">&lt;!</xsl:text><xsl:text>DOCTYPE html</xsl:text><xsl:text disable-output-escaping="yes">&gt;&#13;</xsl:text>
<html>    
<head>
    <title>Xceptance LoadTest - Performance Trend Report</title>

	<xsl:call-template name="head" />
</head>
<body id="trendreport">
<div id="container">
    <div id="content">
        <xsl:call-template name="header">
			<xsl:with-param name="title" select="'Performance Trend Report'" />
			<xsl:with-param name="productName" select="$productName" />
			<xsl:with-param name="productVersion" select="$productVersion" />
			<xsl:with-param name="productUrl" select="$productUrl" />
        </xsl:call-template>

        <div id="data-content">

        	<!--
        		************************************
        		* Requests
        		************************************
        	-->
			<xsl:call-template name="requests"/>

        </div> <!-- data-content -->

        <xsl:call-template name="footer" />
    </div> <!-- data-content -->
</div> <!-- end container -->    

<xsl:call-template name="javascript" />

</body>
</html>

</xsl:template>

</xsl:stylesheet>
