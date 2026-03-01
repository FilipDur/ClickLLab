<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
                xmlns:html="http://www.w3.org/TR/REC-html40"
                xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
	<xsl:template match="/">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<title>XML Sitemap | ClickLLab</title>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
				<style type="text/css">
					body {
						font-family: 'Outfit', sans-serif;
						background-color: #0a0a0c;
						color: #f4f4f5;
						margin: 0;
						padding: 40px;
					}
					.container {
						max-width: 900px;
						margin: 0 auto;
						background: #121216;
						padding: 40px;
						border-radius: 20px;
						border: 1px solid rgba(255,255,255,0.1);
						box-shadow: 0 20px 40px rgba(0,0,0,0.4);
					}
					h1 {
						color: #fff;
						font-size: 32px;
						margin-bottom: 10px;
					}
					h1 span { color: #8b5cf6; }
					p { color: #a1a1aa; margin-bottom: 30px; }
					table {
						width: 100%;
						border-collapse: collapse;
					}
					th {
						text-align: left;
						padding: 12px;
						border-bottom: 2px solid #8b5cf6;
						color: #8b5cf6;
						text-transform: uppercase;
						font-size: 13px;
						letter-spacing: 1px;
					}
					td {
						padding: 15px 12px;
						border-bottom: 1px solid rgba(255,255,255,0.05);
						font-size: 14px;
					}
					tr:hover td {
						background: rgba(139, 92, 246, 0.05);
					}
					a {
						color: #fff;
						text-decoration: none;
						transition: 0.2s;
					}
					a:hover {
						color: #8b5cf6;
					}
					.priority {
						background: rgba(139, 92, 246, 0.2);
						color: #8b5cf6;
						padding: 4px 8px;
						border-radius: 6px;
						font-weight: bold;
						font-size: 12px;
					}
				</style>
			</head>
			<body>
				<div class="container">
					<h1>Click<span>LLab</span> Sitemap</h1>
					<p>Toto je soubor sitemap.xml vygenerovaný pro vyhledávače.</p>
					<table>
						<tr>
							<th>URL</th>
							<th>Priorita</th>
							<th>Frekvence</th>
							<th>Poslední změna</th>
						</tr>
						<xsl:for-each select="sitemap:urlset/sitemap:url">
							<tr>
								<td>
									<xsl:variable name="itemURL">
										<xsl:value-of select="sitemap:loc"/>
									</xsl:variable>
									<a href="{$itemURL}"><xsl:value-of select="sitemap:loc"/></a>
								</td>
								<td><span class="priority"><xsl:value-of select="concat(sitemap:priority*100,'%')"/></span></td>
								<td><xsl:value-of select="sitemap:changefreq"/></td>
								<td><xsl:value-of select="sitemap:lastmod"/></td>
							</tr>
						</xsl:for-each>
					</table>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
