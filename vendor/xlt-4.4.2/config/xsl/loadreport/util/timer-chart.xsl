<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">

    <xsl:template name="timer-chart">
        <xsl:param name="directory" />
        <xsl:param name="type" />

        <xsl:variable name="encodedName">
            <xsl:call-template name="convertIllegalCharactersInFileName">
                <xsl:with-param name="filename" select="name" />
            </xsl:call-template>
        </xsl:variable>

        <xsl:variable name="gid" select="generate-id(.)" />

        <a>
            <xsl:attribute name="id">timerchart-<xsl:value-of
                select="$gid" /></xsl:attribute>
            <xsl:comment>
                This is a placeholder for the anchor.
            </xsl:comment>
        </a>

        <div class="chart-group tabs">
            <ul>
                <li>
                    <a href="#Overview-{$gid}">Overview</a>
                </li>
                <li>
                    <a href="#Averages-{$gid}">Averages</a>
                </li>
                <li>
                    <a href="#Count-{$gid}">Count/s</a>
                </li>

                <xsl:if test="$type = 'transaction'">
                    <li>
                        <a href="#ArrivalRate-{$gid}">Arrival Rate</a>
                    </li>
                    <li>
                        <a href="#ConcurrentUsers-{$gid}">Concurrent Users</a>
                    </li>
                </xsl:if>

                <xsl:if test="$type = 'request'">
                    <li>
                        <a href="#Distribution-{$gid}">Distribution</a>
                    </li>
                    <li>
                        <a href="#Network-{$gid}">Network</a>
                    </li>
                </xsl:if>
            </ul>

            <xsl:if test="count(parent::summary)=0">
                <a href="#timer-{$gid}" class="backlink">Back to table</a>
            </xsl:if>
            <div id="Overview-{$gid}" class="tab">
                <div class="chart">
                    <img>
                        <xsl:attribute name="src">charts/placeholder.png</xsl:attribute>
                        <xsl:attribute name="alt">charts/<xsl:value-of
                            select="$directory" />/<xsl:value-of
                            select="$encodedName" />.png</xsl:attribute>
                    </img>
                </div>
            </div>

            <div id="Averages-{$gid}" class="tab">
                <div class="chart">
                    <img>
                        <xsl:attribute name="src">charts/placeholder.png</xsl:attribute>
                        <xsl:attribute name="alt">charts/<xsl:value-of
                            select="$directory" />/<xsl:value-of
                            select="$encodedName" />_Average.png</xsl:attribute>
                    </img>
                </div>
            </div>

            <div id="Count-{$gid}" class="tab">
                <div class="chart">
                    <img>
                        <xsl:attribute name="src">charts/placeholder.png</xsl:attribute>
                        <xsl:attribute name="alt">charts/<xsl:value-of
                            select="$directory" />/<xsl:value-of
                            select="$encodedName" />_CountPerSecond.png</xsl:attribute>
                    </img>
                </div>
            </div>

            <xsl:if test="$type = 'transaction'">
                <div id="ArrivalRate-{$gid}" class="tab">
                    <div class="chart">
                        <img>
                            <xsl:attribute name="src">charts/placeholder.png</xsl:attribute>
                            <xsl:attribute name="alt">charts/<xsl:value-of
                                select="$directory" />/<xsl:value-of
                                select="$encodedName" />_ArrivalRate.png</xsl:attribute>
                        </img>
                    </div>
                </div>
                <div id="ConcurrentUsers-{$gid}" class="tab">
                    <div class="chart">
                        <img>
                            <xsl:attribute name="src">charts/placeholder.png</xsl:attribute>
                            <xsl:attribute name="alt">charts/<xsl:value-of
                                select="$directory" />/<xsl:value-of
                                select="$encodedName" />_ConcurrentUsers.png</xsl:attribute>
                        </img>
                    </div>
                </div>
            </xsl:if>

            <xsl:if test="$type = 'request'">
                <div id="Distribution-{$gid}" class="tab">
                    <div class="chart">
                        <img>
                            <xsl:attribute name="src">charts/placeholder.png</xsl:attribute>
                            <xsl:attribute name="alt">charts/<xsl:value-of
                                select="$directory" />/<xsl:value-of
                                select="$encodedName" />_Histogram.png</xsl:attribute>
                        </img>
                    </div>
                </div>

                <div id="Network-{$gid}" class="tab">
                    <div class="chart">
                        <img>
                            <xsl:attribute name="src">charts/placeholder.png</xsl:attribute>
                            <xsl:attribute name="alt">charts/<xsl:value-of
                                select="$directory" />/<xsl:value-of
                                select="$encodedName" />_BytesReceivedPerSecond.png</xsl:attribute>
                        </img>
                    </div>
                </div>
            </xsl:if>
        </div>
    </xsl:template>

</xsl:stylesheet>