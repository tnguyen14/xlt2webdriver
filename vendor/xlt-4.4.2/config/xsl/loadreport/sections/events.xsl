<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

    <xsl:template name="events">
        <xsl:param name="rootNode"/>

        <div class="section" id="event-summary">
            <xsl:call-template name="headline-event-summary"/>

            <div class="content">
                <xsl:call-template name="description-event-summary"/>

                <div class="data">
                    <table>
                        <thead>
                            <tr>
                                <th rowspan="2">Test Case</th>
                                <th rowspan="2">Event</th>
                                <th rowspan="2">Total Count</th>
                                <th colspan="2">Event Information</th>
                            </tr>
                            <tr>
                                <th>Count</th>
                                <th>Message</th>
                            </tr>
                        </thead>
                        <tfoot>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td></td>
                            </tr>
                        </tfoot>
                        <tbody>
                            <xsl:choose>
                                <xsl:when test="count($rootNode/event) > 0">
                                    <xsl:for-each select="$rootNode/event">
                                        <xsl:sort select="totalCount" order="descending" data-type="number"/>

                                        <xsl:variable name="even-or-odd">
                                            <xsl:choose>
                                                <xsl:when test="position() mod 2 = 0">
                                                    <xsl:text>odd</xsl:text>
                                                </xsl:when>
                                                <xsl:otherwise>
                                                    <xsl:text>even</xsl:text>
                                                </xsl:otherwise>
                                            </xsl:choose>
                                        </xsl:variable>

                                        <xsl:variable name="messageCount" select="count(messages/message)"/>

                                        <xsl:for-each select="messages/message">
                                            <xsl:sort select="count" order="descending" data-type="number"/>

                                            <tr class="{$even-or-odd}">
                                                <xsl:choose>
                                                    <xsl:when test="position() = 1">
                                                        <td class="value text">
                                                            <xsl:attribute name="rowspan">
                                                                <xsl:value-of select="$messageCount"/>       														
                                                            </xsl:attribute>
                                                            <xsl:value-of select="../../testCaseName"/>
                                                        </td>
                                                        <td class="value text">
                                                            <xsl:attribute name="rowspan">
                                                                <xsl:value-of select="$messageCount"/>
                                                            </xsl:attribute>
                                                            <xsl:value-of select="../../name"/>
                                                        </td>
                                                        <td class="value number">
                                                            <xsl:attribute name="rowspan">
                                                                <xsl:value-of select="$messageCount"/>
                                                            </xsl:attribute>
                                                            <xsl:value-of select="format-number(../../totalCount, '#,##0')"/>
                                                        </td>
                                                    </xsl:when>
                                                </xsl:choose>

                                                <td class="value number">
                                                    <xsl:value-of select="format-number(count, '#,##0')"/>
                                                </td>
                                                <td class="value text">
                                                    <xsl:value-of select="info"/>
                                                </td>
                                            </tr>
                                        </xsl:for-each>
                                    </xsl:for-each>
                                </xsl:when>
                                <xsl:otherwise>
                                    <tr>
                                        <td class="value text" colspan="5">There are no values to show in this table.</td>
                                    </tr>
                                </xsl:otherwise>
                            </xsl:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

    </xsl:template>

</xsl:stylesheet>