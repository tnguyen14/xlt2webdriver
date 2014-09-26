<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <!-- Magic to group errors by their message for counting them later on. -->
    <xsl:key name="errorsByMessage" match="errors/error" use="message"/>

    <xsl:template name="errors">
        <xsl:param name="rootNode"/>

        <div class="section" id="error-summary">
            <xsl:call-template name="headline-error-summary"/>

            <div class="content">
                <xsl:call-template name="description-error-summary"/>

                <div class="data">

                    <div class="charts">
                        <div class="chart">
                            <img src="charts/ErrorsAndEvents.png" alt="Errors and Events"/>
                        </div>
                    </div>

                    <h3>Overview</h3>
                    <table class="table-autosort:1 table-autosort-order:desc table-autostripe table-stripeclass:odd">
                        <thead>
                            <tr>
                                <th class="table-sortable:alphanumeric">Error Message</th>
                                <th class="table-sortable:numeric">Count</th>
                                <th class="table-sortable:numeric">Percentage</th>
                            </tr>
                        </thead>
                        <xsl:choose>
                            <xsl:when test="count($rootNode/error) > 0">
                                <xsl:variable name="totalErrorCount">
                                    <xsl:value-of select="sum($rootNode/error/count)"/>
                                </xsl:variable>
                                <tfoot>
                                    <tr class="totals">
                                        <td class="key">Totals</td>
                                        <td class="value number">
                                            <xsl:value-of select="format-number($totalErrorCount, '#,##0')"/>
                                        </td>
                                        <td class="value number">
                                            <xsl:value-of select="format-number(1, '#0.0%')"/>
                                        </td>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <!-- Here the grouping magic continues ... -->
                                    <xsl:for-each
                                        select="errors/error[generate-id() = generate-id(key('errorsByMessage', message)[1])]">
                                        <xsl:sort select="message"/>

                                        <xsl:variable name="errorCountByMessage">
                                            <xsl:value-of select="sum(key('errorsByMessage', message)/count)"/>
                                        </xsl:variable>

                                        <tr>
                                            <td class="value text">
                                                <xsl:value-of select="message"/>
                                            </td>
                                            <td class="value number count">
                                                <xsl:value-of select="format-number($errorCountByMessage, '#,##0')"/>
                                            </td>
                                            <td class="value number count">
                                                <xsl:value-of
                                                    select="format-number($errorCountByMessage div $totalErrorCount, '#0.0%')"/>
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </tbody>
                            </xsl:when>
                            <xsl:otherwise>
                                <tfoot>
                                    <tr>
                                        <td></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <tr>
                                        <td class="value text" colspan="3">There are no values to show in this table.</td>
                                    </tr>
                                </tbody>
                            </xsl:otherwise>
                        </xsl:choose>
                    </table>

                    <h3>Details</h3>
                    <table class="table-autosort:0 table-autosort-order:desc table-autostripe table-stripeclass:odd">
                        <thead>
                            <tr>
                                <th class="table-sortable:numeric">Count</th>
                                <th class="table-sortable:alphanumeric">Test Case</th>
                                <th>Directory</th>
                                <th class="table-sortable:alphanumeric">Error Information</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tfoot>
                        <xsl:choose>
                            <xsl:when test="count($rootNode/error) > 0">
                                <xsl:for-each select="$rootNode/error">
                                    <xsl:sort select="count" order="descending" data-type="number"/>

                                    <tr>
                                        <td class="value number count">
                                            <xsl:value-of select="format-number(count, '#,##0')"/>
                                        </td>
                                        <td class="value text testcasename">
                                            <xsl:value-of select="testCaseName"/>
                                        </td>
                                        <td class="value text directory">
                                            <xsl:for-each select="directoryHints/string">
                                                <xsl:choose>
                                                    <xsl:when test="$rootNode/resultsPathPrefix and normalize-space(.)!='...'">
                                                        <a>
                                                            <xsl:attribute name="href"><xsl:value-of
                                                                select="concat($rootNode/resultsPathPrefix, ., '/index.html')"/></xsl:attribute>
                                                            <xsl:attribute name="target">_blank</xsl:attribute>
                                                            <xsl:value-of select="."/>
                                                        </a>
                                                    </xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="."/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                                <br/>
                                            </xsl:for-each>
                                        </td>
                                        <td class="value text trace collapsible">
                                            <div>
                                                <xsl:value-of select="message"/>
                                            </div>
                                            <pre>
                                                <xsl:value-of select="trace"/>
                                            </pre>
                                        </td>
                                    </tr>
                                </xsl:for-each>
                            </xsl:when>
                            <xsl:otherwise>
                                <tr>
                                    <td class="value text" colspan="4">There are no values to show in this table.</td>
                                </tr>
                            </xsl:otherwise>
                        </xsl:choose>

                    </table>
                </div>
            </div>
        </div>

    </xsl:template>

</xsl:stylesheet>
