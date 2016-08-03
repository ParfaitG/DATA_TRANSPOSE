<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="UTF-8" />

<!-- CREDIT: @michael.hor257k user on StackOverflow -->

<xsl:key name="yearid" match="GoogleDoodles" use="substring(DoodleDate, 1, 4)" />
<xsl:key name="event-by-date" match="GoogleDoodles" use="DoodleDate" />

<xsl:template match="/dataroot">
    <xsl:text>Year,Day,January,February,March,April,May,June,July,August,September,October,November,December&#10;</xsl:text>    
        <xsl:for-each select="GoogleDoodles[count(. | key('yearid', substring(DoodleDate, 1, 4))[1]) = 1]">
            <xsl:sort select="substring(DoodleDate, 1, 4)" order="ascending" data-type="number"/>
            <xsl:sort select="substring(DoodleDate, 9, 2)" order="ascending" data-type="number"/>
            <xsl:call-template name="generate-rows">
                <xsl:with-param name="year" select="substring(DoodleDate, 1, 4) " />
            </xsl:call-template>            
        </xsl:for-each>    
</xsl:template>

<xsl:template name="generate-rows">
    <xsl:param name="year"/>
    <xsl:param name="day" select="1"/>
    <xsl:if test="$day &lt;= 31">
        <xsl:value-of select="$year"/>
        <xsl:text>&quot;,&quot;</xsl:text>
        <xsl:value-of select="$day"/>
        <xsl:call-template name="generate-cols">
            <xsl:with-param name="year" select="$year" />
            <xsl:with-param name="day" select="$day" />
        </xsl:call-template>
        <xsl:text>&quot;&#10;</xsl:text>
        <!-- recursive call --> 
        <xsl:call-template name="generate-rows">
            <xsl:with-param name="year" select="$year" />
            <xsl:with-param name="day" select="$day + 1" />
        </xsl:call-template>
    </xsl:if>
</xsl:template>

<xsl:template name="generate-cols">
    <xsl:param name="year"/>
    <xsl:param name="day"/>
    <xsl:param name="month"  select="1"/>
    <xsl:variable name="date">
        <xsl:value-of select="$year"/>
        <xsl:value-of select="format-number($month, '-00')"/>
        <xsl:value-of select="format-number($day, '-00')"/>
    </xsl:variable>
    <xsl:if test="$month &lt;= 12">
        <xsl:text>&quot;,&quot;</xsl:text>
        <xsl:value-of select="key('event-by-date', $date)/Doodle"/>
        <!-- recursive call -->
        <xsl:call-template name="generate-cols">
            <xsl:with-param name="year" select="$year" />
            <xsl:with-param name="day" select="$day" />
            <xsl:with-param name="month" select="$month + 1" />
        </xsl:call-template>
    </xsl:if>   
</xsl:template>

</xsl:stylesheet>