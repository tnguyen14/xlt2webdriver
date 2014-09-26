<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:output method="html" 
            indent="yes" 
            omit-xml-declaration="yes"
            encoding="UTF-8"
             />

<!-- 
    Generate the page frame 
-->
<xsl:include href="../common/util/convertIllegalCharactersInFileName.xsl" />
<xsl:include href="../common/util/string-replace-all.xsl" />
<xsl:include href="../common/util/percentage.xsl" />
<xsl:include href="../common/util/format-bytes.xsl" />
<xsl:include href="../common/util/format-msec-to-h.xsl" />

<xsl:include href="text/descriptions.xsl" />

<xsl:include href="sections/errors.xsl" />
<xsl:include href="sections/events.xsl" />

<xsl:include href="../common/sections/head.xsl" />
<xsl:include href="../common/sections/header.xsl" />
<xsl:include href="sections/navigation.xsl" />
<xsl:include href="../common/sections/footer.xsl" />

<xsl:include href="../common/sections/javascript.xsl" />

<xsl:template match="/testreport">

<xsl:text disable-output-escaping="yes">&lt;!</xsl:text><xsl:text>DOCTYPE html</xsl:text><xsl:text disable-output-escaping="yes">&gt;&#13;</xsl:text>
<html>    
<head>
    <title>Xceptance LoadTest Report - Errors &amp; Events</title>

	<xsl:call-template name="head" />
</head>
<body id="loadtestreport">
<div id="container">
    <div id="content">
        <xsl:call-template name="header" />

        <div id="data-content">

        	<!--
        		************************************
        		* Error Summary
        		************************************
        	-->
			<xsl:call-template name="errors">
				<xsl:with-param name="rootNode" select="errors" />
			</xsl:call-template>

        	<!--
        		************************************
        		* Event Summary
        		************************************
        	-->
			<xsl:call-template name="events">
				<xsl:with-param name="rootNode" select="events" />
			</xsl:call-template>

        </div> <!-- data-content -->

        <xsl:call-template name="footer" />
    </div> <!-- data-content -->
</div> <!-- end container -->    

<xsl:call-template name="javascript" />

</body>
</html>

</xsl:template>

</xsl:stylesheet>
