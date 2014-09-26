<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template name="agents">
        <xsl:param name="rootNode"/>

        <div class="section" id="agents">
            <xsl:call-template name="headline-agents"/>

            <div class="content">
                <xsl:call-template name="description-agents"/>

                <div class="data">
                    <table class="table-autosort:0 table-autostripe table-stripeclass:odd">
                        <thead>
                            <tr>
                                <th rowspan="2" class="table-sortable:alphanumeric colgroup1">Agent Name</th>
                                <th rowspan="2" class="table-sortable:numeric">Total CPU [%]</th>
                                <th rowspan="2" class="table-sortable:numeric colgroup1">Agent CPU [%]</th>
                                <th colspan="3">Minor GC</th>
                                <th colspan="3" class="colgroup1">Full GC</th>
                            </tr>
                            <tr>
                                <th class="table-sortable:numeric">Count</th>
                                <th class="table-sortable:numeric">Time [ms]</th>
                                <th class="table-sortable:numeric">CPU [%]</th>
                                <th class="table-sortable:numeric colgroup1">Count</th>
                                <th class="table-sortable:numeric colgroup1">Time [ms]</th>
                                <th class="table-sortable:numeric colgroup1">CPU [%]</th>
                            </tr>
                        </thead>
                        <xsl:variable name="count" select="count($rootNode/agent)"/>
                        <xsl:choose>
                            <xsl:when test="$count > 0">
                                <tfoot>
                                    <tr class="totals">
                                        <td class="key colgroup1">Totals</td>
                                        <td class="value number">
                                            <xsl:value-of select="format-number(sum($rootNode/agent/totalCpuUsage) div $count, '#,##0.00')"/>
                                        </td>
                                        <td class="value number colgroup1">
                                            <xsl:value-of select="format-number(sum($rootNode/agent/cpuUsage) div $count, '#,##0.00')"/>
                                        </td>
                                        <td class="value number">
                                            <xsl:value-of select="format-number(sum($rootNode/agent/minorGcCount) div $count, '#,##0')"/>
                                        </td>
                                        <td class="value number">
                                            <xsl:value-of select="format-number(sum($rootNode/agent/minorGcTime) div $count, '#,##0')"/>
                                        </td>
                                        <td class="value number">
                                            <xsl:value-of select="format-number(sum($rootNode/agent/minorGcCpuUsage) div $count, '#,##0.00')"/>
                                        </td>
                                        <td class="value number colgroup1">
                                            <xsl:value-of select="format-number(sum($rootNode/agent/fullGcCount) div $count, '#,##0')"/>
                                        </td>
                                        <td class="value number colgroup1">
                                            <xsl:value-of select="format-number(sum($rootNode/agent/fullGcTime) div $count, '#,##0')"/>
                                        </td>
                                        <td class="value number colgroup1">
                                            <xsl:value-of select="format-number(sum($rootNode/agent/fullGcCpuUsage) div $count, '#,##0.00')"/>
                                        </td>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <xsl:for-each select="$rootNode/agent">
                                        <xsl:sort select="name"/>
                                        <tr>
                                            <td class="value text colgroup1">
                                                <a>
                                                    <xsl:attribute name="href">#<xsl:value-of select="name"/></xsl:attribute>
                                                    <xsl:value-of select="name"/>
                                                </a>
                                            </td>
                                            <td class="value number">
                                                <xsl:value-of select="format-number(totalCpuUsage, '#,##0.00')"/>
                                            </td>
                                            <td class="value number colgroup1">
                                                <xsl:value-of select="format-number(cpuUsage, '#,##0.00')"/>
                                            </td>
                                            <td class="value number">
                                                <xsl:value-of select="format-number(minorGcCount, '#,##0')"/>
                                            </td>
                                            <td class="value number">
                                                <xsl:value-of select="format-number(minorGcTime, '#,##0')"/>
                                            </td>
                                            <td class="value number">
                                                <xsl:value-of select="format-number(minorGcCpuUsage, '#,##0.00')"/>
                                            </td>
                                            <td class="value number colgroup1">
                                                <xsl:value-of select="format-number(fullGcCount, '#,##0')"/>
                                            </td>
                                            <td class="value number colgroup1">
                                                <xsl:value-of select="format-number(fullGcTime, '#,##0')"/>
                                            </td>
                                            <td class="value number colgroup1">
                                                <xsl:value-of select="format-number(fullGcCpuUsage, '#,##0.00')"/>
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </tbody>
                            </xsl:when>
                            <xsl:otherwise>
                                <tfoot>
                                    <tr>
                                        <td class="colgroup1"></td>
                                        <td></td>
                                        <td class="colgroup1"></td>
                                        <td colspan="3"></td>
                                        <td colspan="3" class="colgroup1"></td>
                                    </tr>
                                </tfoot>
                                <tbody>
                                    <tr>
                                        <td class="value text" colspan="9">There are no values to show in this table.</td>
                                    </tr>
                                </tbody>
                            </xsl:otherwise>
                        </xsl:choose>
                    </table>
                </div>

                <div class="charts">
                    <xsl:for-each select="$rootNode/agent/name[.!='']/..">
                        <xsl:sort select="name"/>

                        <!-- unique id -->
                        <xsl:variable name="gid" select="generate-id(.)"/>

                        <a>
                            <xsl:attribute name="id"><xsl:value-of select="name"/></xsl:attribute>
                            <xsl:comment>
                                This is a placeholder for the anchor.
                            </xsl:comment>
                        </a>

                        <div class="chart-group tabs">
                            <ul>
                                <li>
                                    <a href="#CPU-{$gid}">CPU</a>
                                </li>
                                <li>
                                    <a href="#Memory-{$gid}">Memory</a>
                                </li>
                                <li>
                                    <a href="#Threads-{$gid}">Threads</a>
                                </li>
                            </ul>

                            <div id="CPU-{$gid}" class="tab">
                                <div class="chart">
                                    <img>
                                        <xsl:attribute name="src">charts/placeholder.png</xsl:attribute>
                                        <xsl:attribute name="alt">charts/agents/<xsl:value-of select="name"/>/CpuUsage.png</xsl:attribute>
                                    </img>
                                </div>
                            </div>

                            <div id="Memory-{$gid}" class="tab">
                                <div class="chart">
                                    <img>
                                        <xsl:attribute name="src">charts/placeholder.png</xsl:attribute>
                                        <xsl:attribute name="alt">charts/agents/<xsl:value-of select="name"/>/MemoryUsage.png</xsl:attribute>
                                    </img>
                                </div>
                            </div>

                            <div id="Threads-{$gid}" class="tab">
                                <div class="chart">
                                    <img>
                                        <xsl:attribute name="src">charts/placeholder.png</xsl:attribute>
                                        <xsl:attribute name="alt">charts/agents/<xsl:value-of select="name"/>/Threads.png</xsl:attribute>
                                    </img>
                                </div>
                            </div>
                        </div>
                    </xsl:for-each>
                </div>
            </div>
        </div>

    </xsl:template>

</xsl:stylesheet>
