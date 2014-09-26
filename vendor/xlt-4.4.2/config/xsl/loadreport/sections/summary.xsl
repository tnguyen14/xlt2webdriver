<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template name="summary">

        <div class="section" id="summary">
            <xsl:call-template name="headline-summary"/>

            <div class="content">
                <xsl:call-template name="description-summary"/>

                <div class="data">

                    <table class="table-autostripe table-stripeclass:odd">
                        <thead>
                            <tr>
                                <th rowspan="2">Summary</th>
                                <th colspan="5">Count</th>
                                <th colspan="2">Errors</th>
                                <th>Events</th>
                                <th colspan="5">Runtime [ms]</th>
                            </tr>
                            <tr>
                                <th>Total</th>
                                <th>1/s</th>
                                <th>1/min</th>
                                <th>1/h*</th>
                                <th>1/d*</th>
                                <th>Total</th>
                                <th>%</th>
                                <th>Total</th>
                                <th title="The median of the data series.">Med.</th>
                                <th title="The arithmetic mean of the data series.">Mean</th>
                                <th title="The smallest value of the data series.">Min.</th>
                                <th title="The largest value of the data series.">Max.</th>
                                <th title="The standard deviation of all values in the data series.">Dev.</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tfoot>
                        <tbody>
                            <xsl:call-template name="summary-timer-row">
                                <xsl:with-param name="name" select="'Transactions'"/>
                                <xsl:with-param name="link" select="'transactions'"/>
                                <xsl:with-param name="element" select="summary/transactions"/>
                            </xsl:call-template>
                            <xsl:call-template name="summary-timer-row">
                                <xsl:with-param name="name" select="'Actions'"/>
                                <xsl:with-param name="link" select="'actions'"/>
                                <xsl:with-param name="element" select="summary/actions"/>
                            </xsl:call-template>
                            <xsl:call-template name="summary-timer-row">
                                <xsl:with-param name="name" select="'Requests'"/>
                                <xsl:with-param name="link" select="'requests'"/>
                                <xsl:with-param name="element" select="summary/requests"/>
                            </xsl:call-template>
                            <xsl:call-template name="summary-timer-row">
                                <xsl:with-param name="name" select="'Custom Timers'"/>
                                <xsl:with-param name="link" select="'custom'"/>
                                <xsl:with-param name="element" select="summary/customTimers"/>
                            </xsl:call-template>
                        </tbody>
                    </table>

                </div>
            </div>
        </div>

    </xsl:template>
</xsl:stylesheet>
