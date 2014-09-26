<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0" xmlns:xalan="http://xml.apache.org/xalan"
    exclude-result-prefixes="xalan">

    <xsl:template name="timer-row-abs">
        <xsl:param name="gid"/>
        <xsl:param name="valueName"/>
        <xsl:param name="showValues"/>
        <xsl:param name="format"/>
        <xsl:param name="isSummaryRow"/>

        <tr>
            <xsl:if test="$isSummaryRow">
                <xsl:attribute name="class">totals</xsl:attribute>
            </xsl:if>

            <!-- name -->
            <td class="key">
                <xsl:choose>
                    <xsl:when test="$isSummaryRow">
                        Totals
                    </xsl:when>
                    <xsl:otherwise>
                        <a>
                            <xsl:attribute name="href">#timerchart-<xsl:value-of select="$gid"/></xsl:attribute>
                            <xsl:value-of select="name"/>
                        </a>
                    </xsl:otherwise>
                </xsl:choose>
            </td>

            <!-- value -->
            <xsl:variable name="baseValue" select="trendValues/trendValue[1]"/>
            <xsl:for-each select="trendValues/trendValue">
                <xsl:call-template name="timer-cell">
                    <xsl:with-param name="node" select="*[name() = $valueName]"/>
                    <xsl:with-param name="baselineNode" select="$baseValue/*[name() = $valueName]"/>
                    <xsl:with-param name="format" select="$format"/>
                    <xsl:with-param name="showValue" select="$showValues"/>
                    <xsl:with-param name="position" select="position()"/>
                </xsl:call-template>
            </xsl:for-each>
        </tr>

    </xsl:template>

</xsl:stylesheet>
