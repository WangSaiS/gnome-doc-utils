<?xml version='1.0' encoding='utf-8'?><!-- -*- indent-tabs-mode: nil -*- -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:doc="http://www.gnome.org/~shaunm/xsldoc"
                exclude-result-prefixes="doc"
                version="1.0">

<doc:title>Division Elements</doc:title>


<!-- == db2html.division.html ============================================== -->

<template xmlns="http://www.gnome.org/~shaunm/xsldoc">
  <name>db2html.division.html</name>
  <description>
    Render a complete HTML page for a division element
  </description>
  <parameter>
    <name>depth_of_chunk</name>
    <description>
      The depth of the containing chunk in the document
    </description>
  </parameter>
</template>

<xsl:template name="db2html.division.html">
  <xsl:param name="depth_of_chunk">
    <xsl:call-template name="db.chunk.depth-of-chunk"/>
  </xsl:param>
  <!-- FIXME -->
  <html>
    <body>
      <xsl:apply-templates select=".">
        <xsl:with-param name="depth_in_chunk" select="0"/>
        <xsl:with-param name="depth_of_chunk" select="$depth_of_chunk"/>
      </xsl:apply-templates>
    </body>
  </html>
</xsl:template>


<!-- == db2html.division.content =========================================== -->

<template xmlns="http://www.gnome.org/~shaunm/xsldoc">
  <name>db2html.division.content</name>
  <description>
    Render the content of a division element, chunking children if necessary
  </description>
  <parameter>
    <name>divisions</name>
    <description>
      The division-level child elements
    </description>
  </parameter>
  <parameter>
    <name>depth_in_chunk</name>
    <description>
      The depth of the element in the containing chunk
    </description>
  </parameter>
  <parameter>
    <name>depth_of_chunk</name>
    <description>
      The depth of the containing chunk in the document
    </description>
  </parameter>
</template>

<xsl:template name="db2html.division.content">
  <xsl:param name="divisions"/>
  <xsl:param name="depth_in_chunk">
    <xsl:call-template name="db.chunk.depth-in-chunk"/>
  </xsl:param>
  <xsl:param name="depth_of_chunk">
    <xsl:call-template name="db.chunk.depth-of-chunk"/>
  </xsl:param>
  <xsl:choose>
    <xsl:when test="$depth_in_chunk = 0 and
                    $depth_of_chunk &lt; $db.chunk.max_depth">
      <xsl:for-each select="*">
        <xsl:if test="not(. = $divisions)">
          <xsl:apply-templates select=".">
            <xsl:with-param name="depth_in_chunk" select="1"/>
          </xsl:apply-templates>
        </xsl:if>
      </xsl:for-each>
      <xsl:for-each select="$divisions">
        <xsl:call-template name="db.chunk.chunk">
          <xsl:with-param name="depth_of_chunk" select="$depth_of_chunk + 1"/>
        </xsl:call-template>
      </xsl:for-each>
    </xsl:when>
    <xsl:otherwise>
      <xsl:apply-templates>
        <xsl:with-param name="depth_in_chunk" select="1"/>
      </xsl:apply-templates>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>


<!-- == db.chunk.mode ====================================================== -->

<xsl:template mode="db.chunk.mode" match="*">
  <xsl:param name="depth_of_chunk">
    <xsl:call-template name="db.chunk.depth-of-chunk"/>
  </xsl:param>
  <xsl:call-template name="db2html.division.html">
    <xsl:with-param name="depth_of_chunk" select="$depth_of_chunk"/>
  </xsl:call-template>
</xsl:template>


<!-- == Matched Templates ================================================== -->

<!-- = book = -->
<xsl:template match="book">
  <xsl:param name="depth_in_chunk">
    <xsl:call-template name="db.chunk.depth-in-chunk"/>
  </xsl:param>
  <xsl:param name="depth_of_chunk">
    <xsl:call-template name="db.chunk.depth-of-chunk"/>
  </xsl:param>
  <xsl:call-template name="db2html.division.content">
    <xsl:with-param name="divisions" select="
                    appendix | article    | bibliography | chapter   |
                    colophon | dedication | glossary     | index     |
                    lot      | part       | preface      | reference |
                    setindex | toc        "/>
    <xsl:with-param name="depth_in_chunk" select="$depth_in_chunk"/>
    <xsl:with-param name="depth_of_chunk" select="$depth_of_chunk"/>
  </xsl:call-template>
</xsl:template>

<!-- = chapter = -->
<xsl:template match="chapter">
  <xsl:param name="depth_in_chunk">
    <xsl:call-template name="db.chunk.depth-in-chunk"/>
  </xsl:param>
  <xsl:param name="depth_of_chunk">
    <xsl:call-template name="db.chunk.depth-of-chunk"/>
  </xsl:param>
  <xsl:call-template name="db2html.division.content">
    <xsl:with-param name="divisions" select="
                    bibliography | glossary | index      | lot | refentry |
                    sect1        | section  | simplesect | toc "/>
    <xsl:with-param name="depth_in_chunk" select="$depth_in_chunk"/>
    <xsl:with-param name="depth_of_chunk" select="$depth_of_chunk"/>
  </xsl:call-template>
</xsl:template>

<!-- = part = -->
<xsl:template match="part">
  <xsl:param name="depth_in_chunk">
    <xsl:call-template name="db.chunk.depth-in-chunk"/>
  </xsl:param>
  <xsl:param name="depth_of_chunk">
    <xsl:call-template name="db.chunk.depth-of-chunk"/>
  </xsl:param>
  <xsl:call-template name="db2html.division.content">
    <xsl:with-param name="divisions" select="
                    appendix | article   | bibliography | chapter |
                    glossary | index     | lot          | preface |
                    refentry | reference | toc          "/>
    <xsl:with-param name="depth_in_chunk" select="$depth_in_chunk"/>
    <xsl:with-param name="depth_of_chunk" select="$depth_of_chunk"/>
  </xsl:call-template>
</xsl:template>

<!-- = sect1 = -->
<xsl:template match="sect1">
  <xsl:param name="depth_in_chunk">
    <xsl:call-template name="db.chunk.depth-in-chunk"/>
  </xsl:param>
  <xsl:param name="depth_of_chunk">
    <xsl:call-template name="db.chunk.depth-of-chunk"/>
  </xsl:param>
  <xsl:call-template name="db2html.division.content">
    <xsl:with-param name="divisions" select="
                    bibliography | glossary | index      | lot |
                    refentry     | sect2    | simplesect | toc "/>
    <xsl:with-param name="depth_in_chunk" select="$depth_in_chunk"/>
    <xsl:with-param name="depth_of_chunk" select="$depth_of_chunk"/>
  </xsl:call-template>
</xsl:template>

<!-- = sect2 = -->
<xsl:template match="sect2">
  <xsl:param name="depth_in_chunk">
    <xsl:call-template name="db.chunk.depth-in-chunk"/>
  </xsl:param>
  <xsl:param name="depth_of_chunk">
    <xsl:call-template name="db.chunk.depth-of-chunk"/>
  </xsl:param>
  <xsl:call-template name="db2html.division.content">
    <xsl:with-param name="divisions" select="
                    bibliography | glossary | index      | lot |
                    refentry     | sect3    | simplesect | toc "/>
    <xsl:with-param name="depth_in_chunk" select="$depth_in_chunk"/>
    <xsl:with-param name="depth_of_chunk" select="$depth_of_chunk"/>
  </xsl:call-template>
</xsl:template>

<!-- = sect3 = -->
<xsl:template match="sect3">
  <xsl:param name="depth_in_chunk">
    <xsl:call-template name="db.chunk.depth-in-chunk"/>
  </xsl:param>
  <xsl:param name="depth_of_chunk">
    <xsl:call-template name="db.chunk.depth-of-chunk"/>
  </xsl:param>
  <xsl:call-template name="db2html.division.content">
    <xsl:with-param name="divisions" select="
                    bibliography | glossary | index      | lot |
                    refentry     | sect4    | simplesect | toc "/>
    <xsl:with-param name="depth_in_chunk" select="$depth_in_chunk"/>
    <xsl:with-param name="depth_of_chunk" select="$depth_of_chunk"/>
  </xsl:call-template>
</xsl:template>

<!-- = sect4 = -->
<xsl:template match="sect4">
  <xsl:param name="depth_in_chunk">
    <xsl:call-template name="db.chunk.depth-in-chunk"/>
  </xsl:param>
  <xsl:param name="depth_of_chunk">
    <xsl:call-template name="db.chunk.depth-of-chunk"/>
  </xsl:param>
  <xsl:call-template name="db2html.division.content">
    <xsl:with-param name="divisions" select="
                    bibliography | glossary | index      | lot |
                    refentry     | sect5    | simplesect | toc "/>
    <xsl:with-param name="depth_in_chunk" select="$depth_in_chunk"/>
    <xsl:with-param name="depth_of_chunk" select="$depth_of_chunk"/>
  </xsl:call-template>
</xsl:template>

<!-- = sect5 = -->
<xsl:template match="sect5">
  <xsl:param name="depth_in_chunk">
    <xsl:call-template name="db.chunk.depth-in-chunk"/>
  </xsl:param>
  <xsl:param name="depth_of_chunk">
    <xsl:call-template name="db.chunk.depth-of-chunk"/>
  </xsl:param>
  <xsl:call-template name="db2html.division.content">
    <xsl:with-param name="divisions" select="
                    bibliography | glossary   | index | lot |
                    refentry     | simplesect | toc   "/>
    <xsl:with-param name="depth_in_chunk" select="$depth_in_chunk"/>
    <xsl:with-param name="depth_of_chunk" select="$depth_of_chunk"/>
  </xsl:call-template>
</xsl:template>

<!-- = section = -->
<xsl:template match="section">
  <xsl:param name="depth_in_chunk">
    <xsl:call-template name="db.chunk.depth-in-chunk"/>
  </xsl:param>
  <xsl:param name="depth_of_chunk">
    <xsl:call-template name="db.chunk.depth-of-chunk"/>
  </xsl:param>
  <xsl:call-template name="db2html.division.content">
    <xsl:with-param name="divisions" select="
                    bibliography | glossary | index      | lot |
                    refentry     | section  | simplesect | toc "/>
    <xsl:with-param name="depth_in_chunk" select="$depth_in_chunk"/>
    <xsl:with-param name="depth_of_chunk" select="$depth_of_chunk"/>
  </xsl:call-template>
</xsl:template>

</xsl:stylesheet>
