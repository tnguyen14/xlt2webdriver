<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template name="timer-row">
        <xsl:param name="type"/>
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
                        <xsl:value-of select="name"/>
                    </xsl:otherwise>
                </xsl:choose>
            </td>

            <!-- count -->
            <xsl:call-template name="timer-cell">
                <xsl:with-param name="node" select="count"/>
                <xsl:with-param name="isInverse" select="true()"/>
                <xsl:with-param name="format" select="'#,##0'"/>
            </xsl:call-template>

            <!-- count per sec -->
            <xsl:call-template name="timer-cell">
                <xsl:with-param name="node" select="countPerSecond"/>
                <xsl:with-param name="isInverse" select="true()"/>
                <xsl:with-param name="format" select="'#,##0.0'"/>
            </xsl:call-template>

            <!-- count per minute -->
            <xsl:call-template name="timer-cell">
                <xsl:with-param name="node" select="countPerMinute"/>
                <xsl:with-param name="isInverse" select="true()"/>
                <xsl:with-param name="format" select="'#,##0.0'"/>
            </xsl:call-template>

            <!-- count per hour -->
            <xsl:call-template name="timer-cell">
                <xsl:with-param name="node" select="countPerHour"/>
                <xsl:with-param name="isInverse" select="true()"/>
                <xsl:with-param name="format" select="'#,##0'"/>
            </xsl:call-template>

            <!-- count per day -->
            <xsl:call-template name="timer-cell">
                <xsl:with-param name="node" select="countPerDay"/>
                <xsl:with-param name="isInverse" select="true()"/>
                <xsl:with-param name="format" select="'#,##0'"/>
            </xsl:call-template>

            <!-- errors -->
            <xsl:call-template name="timer-cell">
                <xsl:with-param name="node" select="errors"/>
                <xsl:with-param name="format" select="'#,##0'"/>
            </xsl:call-template>

            <!-- events -->
            <xsl:if test="$type = 'transaction'">
                <xsl:call-template name="timer-cell">
                    <xsl:with-param name="node" select="events"/>
                    <xsl:with-param name="format" select="'#,##0'"/>
                </xsl:call-template>
            </xsl:if>

            <!-- median -->
            <xsl:call-template name="timer-cell">
                <xsl:with-param name="node" select="median"/>
                <xsl:with-param name="format" select="'#,##0'"/>
            </xsl:call-template>

            <!-- mean -->
            <xsl:call-template name="timer-cell">
                <xsl:with-param name="node" select="mean"/>
                <xsl:with-param name="format" select="'#,##0'"/>
            </xsl:call-template>

            <!-- min -->
            <xsl:call-template name="timer-cell">
                <xsl:with-param name="node" select="min"/>
                <xsl:with-param name="format" select="'#,##0'"/>
            </xsl:call-template>

            <!-- max -->
            <xsl:call-template name="timer-cell">
                <xsl:with-param name="node" select="max"/>
                <xsl:with-param name="format" select="'#,##0'"/>
            </xsl:call-template>

            <!-- deviation -->
            <xsl:call-template name="timer-cell">
                <xsl:with-param name="node" select="deviation"/>
                <xsl:with-param name="format" select="'#,##0'"/>
            </xsl:call-template>
        </tr>

    </xsl:template>

</xsl:stylesheet>
