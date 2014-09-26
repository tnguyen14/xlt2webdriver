<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:template name="timer-section">
        <xsl:param name="elements"/>
        <xsl:param name="summaryElement"/>
        <xsl:param name="tableRowHeader"/>
        <xsl:param name="directory"/>
        <xsl:param name="runtimeIntervalsNode"/>
        <xsl:param name="type"/>

        <xsl:choose>
            <xsl:when test="$type = 'request'">
                <div class="tabs">
                    <ul>
                        <li>
                            <a href="#Overview">Overview</a>
                        </li>
                        <li>
                            <a href="#Bandwidth">Bandwidth</a>
                        </li>
                        <li>
                            <a href="#NetworkTiming">Network Timing</a>
                        </li>
                    </ul>

                    <div id="Overview" class="tab">
                        <xsl:call-template name="timer-table">
                            <xsl:with-param name="elements" select="$elements"/>
                            <xsl:with-param name="summaryElement" select="$summaryElement"/>
                            <xsl:with-param name="tableRowHeader" select="$tableRowHeader"/>
                            <xsl:with-param name="runtimeIntervalsNode" select="$runtimeIntervalsNode"/>
                            <xsl:with-param name="type" select="$type"/>
                        </xsl:call-template>
                    </div>

                    <div id="Bandwidth" class="tab">
                        <table class="table-autosort:0 table-autostripe table-stripeclass:odd">
                            <thead>
                                <tr>
                                    <th rowspan="2" class="table-sortable:alphanumeric colgroup1">
                                        <xsl:value-of select="$tableRowHeader"/>
                                    </th>
                                    <th colspan="8">Bytes Sent</th>
                                    <th colspan="8" class="colgroup1">Bytes Received</th>
                                </tr>
                                <tr>
                                    <th class="table-sortable:numeric">Total</th>
                                    <th class="table-sortable:numeric">1/s</th>
                                    <th class="table-sortable:numeric">1/min</th>
                                    <th class="table-sortable:numeric">1/h</th>
                                    <th class="table-sortable:numeric">1/d</th>
                                    <th class="table-sortable:numeric" title="The arithmetic mean.">Mean</th>
                                    <th class="table-sortable:numeric">Min.</th>
                                    <th class="table-sortable:numeric">Max.</th>

                                    <th class="table-sortable:numeric colgroup1">Total</th>
                                    <th class="table-sortable:numeric colgroup1">1/s</th>
                                    <th class="table-sortable:numeric colgroup1">1/min</th>
                                    <th class="table-sortable:numeric colgroup1">1/h</th>
                                    <th class="table-sortable:numeric colgroup1">1/d</th>
                                    <th class="table-sortable:numeric colgroup1" title="The arithmetic mean.">Mean</th>
                                    <th class="table-sortable:numeric colgroup1">Min.</th>
                                    <th class="table-sortable:numeric colgroup1">Max.</th>
                                </tr>
                            </thead>
                            <xsl:choose>
                                <xsl:when test="count($elements) > 0">
                                    <tfoot>
                                        <xsl:for-each select="$summaryElement">
                                            <tr class="totals">
                                                <td class="key colgroup1">Totals</td>

                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/totalCount, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/countPerSecond, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/countPerMinute, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/countPerHour, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/countPerDay, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/mean, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/min, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/max, '#,##0')"></xsl:value-of>
                                                </td>

                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/totalCount, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/countPerSecond, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/countPerMinute, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/countPerHour, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/countPerDay, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/mean, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/min, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/max, '#,##0')"></xsl:value-of>
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </tfoot>
                                    <tbody>
                                        <xsl:for-each select="$elements">
                                            <xsl:sort select="name"/>

                                            <xsl:variable name="gid" select="generate-id(.)"/>

                                            <tr>
                                                <td class="key colgroup1">
                                                    <a>
                                                        <xsl:attribute name="href">#timerchart-<xsl:value-of
                                                            select="$gid"/></xsl:attribute>
                                                        <xsl:attribute name="data-timer-id"><xsl:value-of select="$gid"/></xsl:attribute>
                                                        <xsl:if test="count(urls) &gt; 0">
                                                            <!-- title and class only for requests with urls -->
                                                            <xsl:attribute name="data-rel">#url-listing-<xsl:value-of
                                                                select="$gid"/></xsl:attribute>
                                                            <xsl:attribute name="class">cluetip</xsl:attribute>
                                                        </xsl:if>
                                                        <xsl:value-of select="name"/>
                                                    </a>
                                                </td>

                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/totalCount, '#,##0')"/>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/countPerSecond, '#,##0')"/>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/countPerMinute, '#,##0')"/>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/countPerHour, '#,##0')"/>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/countPerDay, '#,##0')"/>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/mean, '#,##0')"/>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/min, '#,##0')"/>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(bytesSent/max, '#,##0')"/>
                                                </td>

                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/totalCount, '#,##0')"/>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/countPerSecond, '#,##0')"/>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/countPerMinute, '#,##0')"/>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/countPerHour, '#,##0')"/>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/countPerDay, '#,##0')"/>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/mean, '#,##0')"/>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/min, '#,##0')"/>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(bytesReceived/max, '#,##0')"/>
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </xsl:when>
                                <xsl:otherwise>
                                    <tbody class="table-nosort">
                                        <tr>
                                            <td colspan="17">There are no values to show in this table.</td>
                                        </tr>
                                    </tbody>
                                </xsl:otherwise>
                            </xsl:choose>
                        </table>
                    </div>

                    <div id="NetworkTiming" class="tab">
                        <table class="table-autosort:0 table-autostripe table-stripeclass:odd">
                            <thead>
                                <tr>
                                    <th rowspan="2" class="table-sortable:alphanumeric colgroup1">
                                        <xsl:value-of select="$tableRowHeader"/>
                                    </th>
                                    <th colspan="3">Connect Time [ms]</th>
                                    <th colspan="3" class="colgroup1">Send Time [ms]</th>
                                    <th colspan="3">Server Busy Time [ms]</th>
                                    <th colspan="3" class="colgroup1">Receive Time [ms]</th>
                                    <th colspan="3" title="Time To First Bytes">Time to First [ms]</th>
                                    <th colspan="3" class="colgroup1" title="Time To Last Bytes">Time to Last [ms]</th>
                                </tr>
                                <tr>
                                    <th class="table-sortable:numeric" title="The arithmetic mean.">Mean</th>
                                    <th class="table-sortable:numeric">Min.</th>
                                    <th class="table-sortable:numeric">Max.</th>

                                    <th class="table-sortable:numeric colgroup1" title="The arithmetic mean.">Mean</th>
                                    <th class="table-sortable:numeric colgroup1">Min.</th>
                                    <th class="table-sortable:numeric colgroup1">Max.</th>

                                    <th class="table-sortable:numeric" title="The arithmetic mean.">Mean</th>
                                    <th class="table-sortable:numeric">Min.</th>
                                    <th class="table-sortable:numeric">Max.</th>

                                    <th class="table-sortable:numeric colgroup1" title="The arithmetic mean.">Mean</th>
                                    <th class="table-sortable:numeric colgroup1">Min.</th>
                                    <th class="table-sortable:numeric colgroup1">Max.</th>

                                    <th class="table-sortable:numeric" title="The arithmetic mean.">Mean</th>
                                    <th class="table-sortable:numeric">Min.</th>
                                    <th class="table-sortable:numeric">Max.</th>

                                    <th class="table-sortable:numeric colgroup1" title="The arithmetic mean.">Mean</th>
                                    <th class="table-sortable:numeric colgroup1">Min.</th>
                                    <th class="table-sortable:numeric colgroup1">Max.</th>
                                </tr>
                            </thead>
                            <xsl:choose>
                                <xsl:when test="count($elements) > 0">
                                    <tfoot>
                                        <xsl:for-each select="$summaryElement">
                                            <tr class="totals">
                                                <td>
                                                    Totals
                                                </td>

                                                <td class="value number">
                                                    <xsl:value-of select="format-number(connectTime/mean, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(connectTime/min, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(connectTime/max, '#,##0')"></xsl:value-of>
                                                </td>

                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(sendTime/mean, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(sendTime/min, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(sendTime/max, '#,##0')"></xsl:value-of>
                                                </td>

                                                <td class="value number">
                                                    <xsl:value-of select="format-number(serverBusyTime/mean, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(serverBusyTime/min, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(serverBusyTime/max, '#,##0')"></xsl:value-of>
                                                </td>

                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(receiveTime/mean, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(receiveTime/min, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(receiveTime/max, '#,##0')"></xsl:value-of>
                                                </td>

                                                <td class="value number">
                                                    <xsl:value-of select="format-number(timeToFirstBytes/mean, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(timeToFirstBytes/min, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(timeToFirstBytes/max, '#,##0')"></xsl:value-of>
                                                </td>

                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(timeToLastBytes/mean, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(timeToLastBytes/min, '#,##0')"></xsl:value-of>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(timeToLastBytes/max, '#,##0')"></xsl:value-of>
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </tfoot>
                                    <tbody>
                                        <xsl:for-each select="$elements">
                                            <xsl:sort select="name"/>

                                            <xsl:variable name="gid" select="generate-id(.)"/>

                                            <tr>
                                                <td class="key colgroup1">
                                                    <a>
                                                        <xsl:attribute name="href">#timerchart-<xsl:value-of
                                                            select="$gid"/></xsl:attribute>
                                                        <xsl:attribute name="data-timer-id"><xsl:value-of select="$gid"/></xsl:attribute>
                                                        <xsl:if test="count(urls) &gt; 0">
                                                            <!-- title and class only for requests with urls -->
                                                            <xsl:attribute name="data-rel">#url-listing-<xsl:value-of
                                                                select="$gid"/></xsl:attribute>
                                                            <xsl:attribute name="class">cluetip</xsl:attribute>
                                                        </xsl:if>
                                                        <xsl:value-of select="name"/>
                                                    </a>
                                                </td>

                                                <td class="value number">
                                                    <xsl:value-of select="format-number(connectTime/mean, '#,##0')"/>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(connectTime/min, '#,##0')"/>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(connectTime/max, '#,##0')"/>
                                                </td>

                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(sendTime/mean, '#,##0')"/>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(sendTime/min, '#,##0')"/>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(sendTime/max, '#,##0')"/>
                                                </td>

                                                <td class="value number">
                                                    <xsl:value-of select="format-number(serverBusyTime/mean, '#,##0')"/>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(serverBusyTime/min, '#,##0')"/>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(serverBusyTime/max, '#,##0')"/>
                                                </td>

                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(receiveTime/mean, '#,##0')"/>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(receiveTime/min, '#,##0')"/>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(receiveTime/max, '#,##0')"/>
                                                </td>

                                                <td class="value number">
                                                    <xsl:value-of select="format-number(timeToFirstBytes/mean, '#,##0')"/>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(timeToFirstBytes/min, '#,##0')"/>
                                                </td>
                                                <td class="value number">
                                                    <xsl:value-of select="format-number(timeToFirstBytes/max, '#,##0')"/>
                                                </td>

                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(timeToLastBytes/mean, '#,##0')"/>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(timeToLastBytes/min, '#,##0')"/>
                                                </td>
                                                <td class="value number colgroup1">
                                                    <xsl:value-of select="format-number(timeToLastBytes/max, '#,##0')"/>
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </tbody>
                                </xsl:when>
                                <xsl:otherwise>
                                    <tbody class="table-nosort">
                                        <tr>
                                            <td colspan="19">There are no values to show in this table.</td>
                                        </tr>
                                    </tbody>
                                </xsl:otherwise>
                            </xsl:choose>
                        </table>
                    </div>
                </div>
            </xsl:when>
            <xsl:otherwise>
                <div class="data">
                    <xsl:call-template name="timer-table">
                        <xsl:with-param name="elements" select="$elements"/>
                        <xsl:with-param name="summaryElement" select="$summaryElement"/>
                        <xsl:with-param name="tableRowHeader" select="$tableRowHeader"/>
                        <xsl:with-param name="runtimeIntervalsNode" select="$runtimeIntervalsNode"/>
                        <xsl:with-param name="type" select="$type"/>
                    </xsl:call-template>
                </div>
            </xsl:otherwise>
        </xsl:choose>

        <xsl:if test="count($elements) &gt; 0">
            <div>
                <h3>Summary</h3>
                <div class="charts">
                    <xsl:for-each select="$summaryElement">
                        <!-- There is only one matching node. -->
                        <xsl:call-template name="timer-chart">
                            <xsl:with-param name="directory" select="$directory"/>
                            <xsl:with-param name="type" select="$type"/>
                        </xsl:call-template>
                    </xsl:for-each>
                </div>

                <h3>
                    <xsl:if test="$type = 'transaction'">
                        Individual Transactions
                    </xsl:if>
                    <xsl:if test="$type = 'action'">
                        Individual Actions
                    </xsl:if>
                    <xsl:if test="$type = 'request'">
                        Individual Requests
                    </xsl:if>
                    <xsl:if test="$type = 'custom'">
                        Individual Custom Timers
                    </xsl:if>
                </h3>
                <div class="charts">
                    <xsl:for-each select="$elements">
                        <xsl:sort select="name"/>
                        <xsl:call-template name="timer-chart">
                            <xsl:with-param name="directory" select="$directory"/>
                            <xsl:with-param name="type" select="$type"/>
                        </xsl:call-template>
                    </xsl:for-each>
                </div>
            </div>
        </xsl:if>

    </xsl:template>

</xsl:stylesheet>