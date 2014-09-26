<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:template name="external">

    <div class="section" id="external-summary">
        <xsl:call-template name="headline-external" />
        <xsl:call-template name="description-external" />
    </div>

    <div class="content section">
        <xsl:choose>
            <xsl:when test="(count(genericReport) &gt; 0)">
                <xsl:for-each select="genericReport">
                    <xsl:call-template
                        name="external-subsection">
                    </xsl:call-template>
                </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <div>There is no data to show.</div>
            </xsl:otherwise>
        </xsl:choose>
    </div><!-- end content/section -->
</xsl:template>

<xsl:template name="external-subsection">

    <h2><xsl:value-of select="headline" /></h2>
    <xsl:call-template name="external-data-section-description">
        <xsl:with-param name="description" select="description" />
    </xsl:call-template>

    <xsl:for-each select="tables/table">
        <h3><xsl:value-of select="title" /></h3>

        <div class="data">
            <table class="table-autosort:0 table-autostripe table-stripeclass:odd">
                <xsl:if test="count(headRow) &gt; 0">
                    <tr>
                        <xsl:for-each select="headRow/cells/*">
                            <th><xsl:value-of select="." /></th>
                        </xsl:for-each>
                    </tr>
                </xsl:if>

                <xsl:for-each select="bodyRows/row">

                    <xsl:variable name="unit">
                        <xsl:value-of select="unit" />
                    </xsl:variable>

                    <xsl:variable name="description">
                        <xsl:value-of select="description" />
                    </xsl:variable>

                    <tr>
                        <xsl:for-each select="cells/*">

                            <!-- int, double, long, float will be right-aligned, 
                                others left-aligned -->

                            <xsl:variable name="valueType">
                                <xsl:choose>
                                    <xsl:when test="local-name()='int' or local-name()='double' or local-name()='long' or local-name()='float' or local-name()='big-decimal'">
                                        value number count
                                    </xsl:when>
                                    <xsl:otherwise>
                                        key
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:variable>

                            <td class="{$valueType}" title="{$description}">
                                <xsl:choose>
                                    <xsl:when test="local-name()='int' or local-name()='double' or local-name()='long' or local-name()='float' or local-name()='big-decimal'">
                                        <xsl:value-of select="format-number(., '#,##0.###')" />
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="." />
                                    </xsl:otherwise>
                                </xsl:choose>
                                <xsl:if test="position() &gt; 1">
                                    <xsl:text> </xsl:text>
                                    <xsl:copy-of select="$unit" />
                                </xsl:if>
                            </td>
                        </xsl:for-each>
                    </tr>

                </xsl:for-each>

            </table>
        </div><!-- end data -->
    </xsl:for-each>

    <xsl:choose>
        <xsl:when test="count(chartFileNames) &gt; 0">
            <div class="charts">
                <xsl:for-each select="chartFileNames/string">

                    <xsl:variable name="encodedChartFilename">
                        <xsl:call-template name="convertIllegalCharactersInFileName">
                            <xsl:with-param name="filename" select="." />
                        </xsl:call-template>
                    </xsl:variable>

                    <div class="chart">
                        <img>
                            <xsl:attribute name="src">charts/external/<xsl:value-of
                                select="$encodedChartFilename" />.png</xsl:attribute>
                            <xsl:attribute name="alt">Hits</xsl:attribute>
                        </img>
                    </div><!-- end chart -->
                </xsl:for-each>
            </div><!-- end charts -->
        </xsl:when>
    </xsl:choose>

</xsl:template>

</xsl:stylesheet>