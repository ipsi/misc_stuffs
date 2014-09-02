<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="xml" indent="yes" encoding="UTF-8"
		omit-xml-declaration="yes" />

	<!-- This template exists to remove any nodes whose children consist entirely 
		of empty text. Partly this is because JAXB marshals empty elements (e.g. 
		<a />) into the empty string, while if an element is simply not present, 
		it will get marshalled to null (which is preferred), and partly because we 
		do not want objects created if they're empty, because then certain optional 
		sections will get created. -->
	<xsl:template match="node()|@*">
			<xsl:copy>
				<xsl:apply-templates select="@*|node()" />
			</xsl:copy>
	</xsl:template>

	<xsl:template match="*[string-length(normalize-space(.))=0 and string-length(normalize-space(descendant::text()))=0]"/>

	<xsl:template match="text()[string-length(normalize-space(.))>0]">
		<xsl:value-of select="normalize-space(.)" />
	</xsl:template>

	<xsl:template match="text()" />

</xsl:stylesheet>
