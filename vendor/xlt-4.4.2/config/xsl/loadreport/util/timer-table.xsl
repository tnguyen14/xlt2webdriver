<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template name="timer-table">
        <xsl:param name="elements"/>
        <xsl:param name="summaryElement"/>
        <xsl:param name="tableRowHeader"/>
        <xsl:param name="runtimeIntervalsNode"/>
        <xsl:param name="type"/>

        <table class="table-autosort:0 table-autostripe table-stripeclass:odd">
            <thead>
                <tr>
                    <th rowspan="2" class="table-sortable:alphanumeric colgroup1">
                        <xsl:value-of select="$tableRowHeader"/>
                    </th>
                    <th colspan="5">Count</th>
                    <th colspan="2" class="colgroup1">Errors</th>
                    <xsl:if test="$type = 'transaction'">
                        <th class="colgroup1">Events</th>
                    </xsl:if>
                    <th colspan="5">Runtime [ms]</th>
                    <xsl:if test="$type = 'request'">
                        <th>
                            <xsl:attribute name="colspan"><xsl:value-of select="count($runtimeIntervalsNode/interval)"/></xsl:attribute>
                            <xsl:attribute name="class">colgroup1</xsl:attribute>
                            Runtime Segmentation [ms]
                        </th>
                    </xsl:if>
                </tr>
                <tr>
                    <th class="table-sortable:numeric">Total</th>
                    <th class="table-sortable:numeric">1/s</th>
                    <th class="table-sortable:numeric">1/min</th>
                    <th class="table-sortable:numeric">1/h*</th>
                    <th class="table-sortable:numeric">1/d*</th>
                    <th class="table-sortable:numeric colgroup1">Total</th>
                    <th class="table-sortable:numeric colgroup1">%</th>
                    <xsl:if test="$type = 'transaction'">
                        <th class="table-sortable:numeric colgroup1">Total</th>
                    </xsl:if>
                    <th class="table-sortable:numeric" title="The median of the data series.">Med.</th>
                    <th class="table-sortable:numeric" title="The arithmetic mean of the data series.">Mean</th>
                    <th class="table-sortable:numeric" title="The smallest value of the data series.">Min.</th>
                    <th class="table-sortable:numeric" title="The largest value of the data series.">Max.</th>
                    <th class="table-sortable:numeric" title="The standard deviation of all data within this data series.">Dev.</th>
                    <xsl:if test="$type = 'request'">
                        <xsl:choose>
                            <xsl:when test="count($runtimeIntervalsNode/interval) &gt; 0">
                                <xsl:for-each select="$runtimeIntervalsNode/interval">
                                    <th class="table-sortable:numeric colgroup1"
                                        title="A data segment and the percentage of data from the time series that is located within.">
                                        <xsl:choose>
                                            <xsl:when test="position() &lt; count($runtimeIntervalsNode/interval)">
                                                <xsl:text disable-output-escaping="yes">&amp;le;</xsl:text>
                                                <xsl:value-of select="format-number(@to, '#,##0')"/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:text disable-output-escaping="yes">&amp;gt;</xsl:text>
                                                <xsl:value-of select="format-number(@from, '#,##0')"/>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </th>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <th></th>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:if>
                </tr>
            </thead>
            <xsl:choose>
                <xsl:when test="count($elements) > 0">
                    <tfoot>
                        <xsl:for-each select="$summaryElement">
                            <!-- There is only one matching node. -->
                            <xsl:call-template name="timer-summary-row">
                                <xsl:with-param name="type" select="$type"/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </tfoot>
                    <tbody>
                        <xsl:for-each select="$elements">
                            <xsl:sort select="name"/>
                            <xsl:call-template name="timer-row">
                                <xsl:with-param name="type" select="$type"/>
                            </xsl:call-template>
                        </xsl:for-each>
                    </tbody>
                </xsl:when>
                <xsl:otherwise>
                    <tbody class="table-nosort">
                        <tr>
                            <td>
                                <xsl:choose>
                                    <xsl:when test="$type = 'request'">
                                        <xsl:attribute name="colspan">
                                                <xsl:value-of select="13 + count($runtimeIntervalsNode/interval)"/>
                                            </xsl:attribute>
                                    </xsl:when>
                                    <xsl:when test="$type = 'transaction'">
                                        <xsl:attribute name="colspan">14</xsl:attribute>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:attribute name="colspan">13</xsl:attribute>
                                    </xsl:otherwise>
                                </xsl:choose>
                                There are no values to show in this table.
                            </td>
                        </tr>
                    </tbody>
                </xsl:otherwise>
            </xsl:choose>
        </table>

    </xsl:template>

</xsl:stylesheet>
