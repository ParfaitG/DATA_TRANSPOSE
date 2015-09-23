<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:key name="dayid" match="GoogleDoodle" use="concat(Year, Day)" />

<xsl:template match="Data">
  <xsl:element name="Data">    
    <xsl:for-each select="GoogleDoodle[count(. | key('dayid', concat(Year, Day))[1]) = 1]">      
      <xsl:element name="GoogleDoodles">	
	<Year><xsl:value-of select="Year"/></Year>
	<Day><xsl:value-of select="Day"/></Day>
	<xsl:for-each select="key('dayid', concat(Year, Day))">
	  <xsl:sort select="key('dayid', concat(Year, Day))" order="ascending"/>
	  <xsl:if test="Month=1"><January><xsl:value-of select="Doodle"/></January></xsl:if>
	  <xsl:if test="Month=2"><February><xsl:value-of select="Doodle"/></February></xsl:if>
	  <xsl:if test="Month=3"><March><xsl:value-of select="Doodle"/></March></xsl:if>
	  <xsl:if test="Month=4"><April><xsl:value-of select="Doodle"/></April></xsl:if>
	  <xsl:if test="Month=5"><May><xsl:value-of select="Doodle"/></May></xsl:if>
	  <xsl:if test="Month=6"><June><xsl:value-of select="Doodle"/></June></xsl:if>
	  <xsl:if test="Month=7"><July><xsl:value-of select="Doodle"/></July></xsl:if>
	  <xsl:if test="Month=8"><August><xsl:value-of select="Doodle"/></August></xsl:if>
	  <xsl:if test="Month=9"><September><xsl:value-of select="Doodle"/></September></xsl:if>
	  <xsl:if test="Month=10"><October><xsl:value-of select="Doodle"/></October></xsl:if>
	  <xsl:if test="Month=11"><November><xsl:value-of select="Doodle"/></November></xsl:if>
	  <xsl:if test="Month=12"><December><xsl:value-of select="Doodle"/></December></xsl:if>
        </xsl:for-each>
      </xsl:element>
    </xsl:for-each>    
  </xsl:element>  
</xsl:template>



</xsl:stylesheet>