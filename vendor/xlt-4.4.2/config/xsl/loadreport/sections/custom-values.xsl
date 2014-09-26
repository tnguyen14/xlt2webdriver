<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

	<xsl:template name="custom-values">

		<div class="section" id="custom-values-summary">
			<xsl:call-template name="headline-custom-values-summary" />

            <div class="content">
				<xsl:call-template name="description-custom-values-summary" />
				
				<table class="table-autosort:0 table-autostripe table-stripeclass:odd">
					<thead>
						<tr>
							<th class="table-sortable:alphanumeric colgroup1">Value Name</th>
							<th class="table-sortable:numeric">Count</th>
							<th class="table-sortable:numeric" title="The arithmetic mean.">Mean</th>
							<th class="table-sortable:numeric">Min.</th>
							<th class="table-sortable:numeric">Max.</th>
							<th class="table-sortable:numeric" title="The standard deviation.">Dev.</th>
						</tr>
					</thead>
					<xsl:choose>
						<xsl:when test="count(customValues/*) > 0">
							<tbody>
								<xsl:for-each select="customValues/*">
									
									<xsl:sort select="name"/>
									
									<xsl:variable name="encodedChartFilename">
										<xsl:call-template name="convertIllegalCharactersInFileName">
											<xsl:with-param name="filename" select="chartFilename" />
										</xsl:call-template>
									</xsl:variable>
									
									<tr>
										<td class="key colgroup1">
											<a>
												<xsl:attribute name="href">#chart-<xsl:value-of select="$encodedChartFilename"/></xsl:attribute>
												<xsl:if test="count(chartFilename) &gt; 0">
													<xsl:attribute name="data-rel">#url-listing-<xsl:value-of select="$encodedChartFilename"/></xsl:attribute>
													<xsl:attribute name="class">cluetip</xsl:attribute>
												</xsl:if>
												<xsl:value-of select="name"/>
											</a>
										</td>
										<td class="value number">
											<xsl:value-of select="format-number(count, '#0')"></xsl:value-of>
										</td>
										<td class="value number">
											<xsl:value-of select="format-number(mean, '#,##0.###')"></xsl:value-of>
										</td>
										<td class="value number">
											<xsl:value-of select="format-number(min, '#,##0.###')"></xsl:value-of>
										</td>
										<td class="value number">
											<xsl:value-of select="format-number(max, '#,##0.###')"></xsl:value-of>
										</td>
										<td class="value number">
											<xsl:value-of select="format-number(standardDeviation, '#,##0.###')"></xsl:value-of>
										</td>
									</tr>
								</xsl:for-each>
							</tbody>
						</xsl:when>
						<xsl:otherwise>
							<tbody class="table-nosort">
								<tr>
									<td colspan="6">There are no values to show in this table.</td>
								</tr>
							</tbody>
						</xsl:otherwise>
					</xsl:choose>
				</table>
				
				<xsl:for-each select="customValues/*">
				
					<xsl:sort select="name"/>
					
					<xsl:variable name="encodedChartFilename">
						<xsl:call-template name="convertIllegalCharactersInFileName">
							<xsl:with-param name="filename" select="chartFilename" />
						</xsl:call-template>
					</xsl:variable>
									
					<xsl:choose>
						<xsl:when test="count(chartFilename) > 0">
							<div class="section" id="general">
								<div class="description">
									<xsl:attribute name="id">chart-<xsl:value-of select="$encodedChartFilename"/></xsl:attribute>
									<p><xsl:value-of select="description" /></p>
	                  			</div>
								<div class="charts">
					            	<div class="chart">
					                	<img>
					                    	<xsl:attribute name="src">charts/customvalues/<xsl:value-of select="$encodedChartFilename" />.png</xsl:attribute>
					                	</img>
					            	</div>
					            </div>
                  			</div>
				       	</xsl:when>
					</xsl:choose>
				</xsl:for-each>
			</div>
		</div>

	</xsl:template>

</xsl:stylesheet>
