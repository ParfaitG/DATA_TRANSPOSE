<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">

<xsl:key name="monthid" match="GoogleDoodles" use="DoodleDate" />

<xsl:template match="dataroot">
  <xsl:element name="Data">
     <xsl:for-each select="GoogleDoodles[count(. | key('monthid', DoodleDate)[1]) = 1]">
      <xsl:sort select="DoodleDate" order="ascending"/>
	<xsl:for-each select="key('monthid', DoodleDate)[1]">
	  <xsl:element name="GoogleDoodle">
		<DoodleDate><xsl:value-of select="DoodleDate"/></DoodleDate>
                <Doodle><xsl:value-of select="Doodle"/></Doodle>
	        <Year><xsl:value-of select="substring(DoodleDate, 1, 4)"/></Year>
	        <Month><xsl:value-of select="substring(DoodleDate, 6, 2)"/></Month>	        
	        <Day><xsl:value-of select="substring(DoodleDate, 9, 2)"/></Day>		
	    </xsl:element>
	  </xsl:for-each>
      </xsl:for-each>
  </xsl:element>  
</xsl:template>



</xsl:stylesheet>