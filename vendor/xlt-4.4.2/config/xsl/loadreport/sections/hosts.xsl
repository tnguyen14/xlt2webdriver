<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template name="hosts">
        <xsl:param name="rootNode"/>
        <xsl:param name="totalHits"/>

        <div class="section" id="hosts">
            <xsl:call-template name="headline-hosts"/>

            <div class="content">
                <xsl:call-template name="description-hosts"/>

                <div class="data">
                    <table class="table-autosort:0 table-autostripe table-stripeclass:odd">
                        <thead>
                            <tr>
                                <th class="table-sortable:alphanumeric">Host</th>
                                <th class="table-sortable:numeric">Count</th>
                                <th class="table-sortable:numeric">Percentage</th>
                            </tr>
                        </thead>
                        <xsl:choose>
                            <xsl:when test="count($rootNode/host) > 0">
                                <tfoot>
                                    <tr class="totals">
                                        <td class="key">Totals</td>
                                        <td class="value number">
                                            <xsl:value-of select="format-number($totalHits, '#,##0')"/>
                                        </td>
                                        <td class="value number">
                                            <xsl:value-of select="format-number(1, '#0.0%')"/>
                                        </td>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <xsl:for-each select="$rootNode/host">
                                        <xsl:sort select="name"/>
                                        <tr>
                                            <td class="key">
                                                <xsl:value-of select="name"/>
                                            </td>
                                            <td class="value">
                                                <xsl:value-of select="format-number(count, '#,##0')"/>
                                            </td>
                                            <td class="value">
                                                <xsl:value-of select="format-number(count div $totalHits, '#,##0.00%')"/>
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
                </div>
            </div>
        </div>

    </xsl:template>

</xsl:stylesheet>