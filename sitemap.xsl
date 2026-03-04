<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
                xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                exclude-result-prefixes="sitemap">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    <xsl:template match="/">
        <html lang="cs">
            <head>
                <title>XML Sitemap | ClickLLab</title>
                <style type="text/css">
                    body {
                        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                        background-color: #0a0a0c;
                        color: #f4f4f5;
                        margin: 0;
                        padding: 40px;
                    }
                    .container {
                        max-width: 1000px;
                        margin: 0 auto;
                        background: #121216;
                        padding: 40px;
                        border-radius: 20px;
                        border: 1px solid rgba(255,255,255,0.1);
                        box-shadow: 0 20px 40px rgba(0,0,0,0.5);
                    }
                    h1 { color: #fff; margin-bottom: 5px; font-size: 28px; }
                    h1 span { color: #8b5cf6; }
                    p { color: #a1a1aa; margin-bottom: 30px; font-size: 14px; }
                    table { width: 100%; border-collapse: collapse; }
                    th {
                        text-align: left;
                        padding: 12px;
                        border-bottom: 2px solid #8b5cf6;
                        color: #8b5cf6;
                        text-transform: uppercase;
                        font-size: 12px;
                        letter-spacing: 1px;
                    }
                    td {
                        padding: 15px 12px;
                        border-bottom: 1px solid rgba(255,255,255,0.05);
                        font-size: 14px;
                    }
                    tr:hover td { background: rgba(139, 92, 246, 0.05); }
                    a { color: #fff; text-decoration: none; font-weight: 500; }
                    a:hover { color: #8b5cf6; text-decoration: underline; }
                    .priority {
                        background: rgba(139, 92, 246, 0.15);
                        color: #a78bfa;
                        padding: 4px 10px;
                        border-radius: 6px;
                        font-weight: bold;
                        font-size: 12px;
                    }
                </style>
            </head>
            <body>
                <div class="container">
                    <h1>Click<span>LLab</span> Sitemap</h1>
                    <p>Seznam stránek pro vyhledávače (Google, Seznam). Celkem url: <xsl:value-of select="count(sitemap:urlset/sitemap:url)"/></p>
                    <table>
                        <thead>
                            <tr>
                                <th>URL Adresa</th>
                                <th>Priorita</th>
                                <th>Změna</th>
                                <th>Poslední modifikace</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="sitemap:urlset/sitemap:url">
                                <tr>
                                    <td>
                                        <a href="{sitemap:loc}"><xsl:value-of select="sitemap:loc"/></a>
                                    </td>
                                    <td>
                                        <span class="priority">
                                            <xsl:value-of select="concat(sitemap:priority * 100, '%')"/>
                                        </span>
                                    </td>
                                    <td><xsl:value-of select="sitemap:changefreq"/></td>
                                    <td><xsl:value-of select="sitemap:lastmod"/></td>
                                </tr>
                            </xsl:for-each>
                        </tbody>
                    </table>
                </div>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
