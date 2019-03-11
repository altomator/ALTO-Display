<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2010 rel. 3 sp1 (http://www.altova.com) by BnF (BNF) -->

<!--Auteur  : BnF/DSR/DSC/NUM/JP Moreux, Version : 1.0 -->
<!-- NB : feuille à utiliser avec Xalan-Java -->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" 
 xmlns:alto="http://www.loc.gov/standards/alto/ns-v3#"
 xmlns:str="http://exslt.org/strings" extension-element-prefixes="str">


<xsl:output method="html" indent="no" omit-xml-declaration="yes"/>

<xsl:template match="/">

      <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;</xsl:text>
      <xsl:text disable-output-escaping='yes'>&lt;html xmlns="http://www.w3.org/1999/xhtml"&gt;</xsl:text>
      <head>
         <xsl:text disable-output-escaping='yes'>&lt;meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8"/&gt;</xsl:text>      
         <xsl:text disable-output-escaping='yes'>&lt;link rel="stylesheet" href="..\..\..\CSS\stylesheet.css" type="text/css"/&gt;</xsl:text>
         
         <title>Affichage des contenus ALTO</title> 
   </head>
   
   <!-- calcul du nom des fichiers liés  -->
  <xsl:variable name="nPage"><xsl:value-of select="//alto:Page/@PHYSICAL_IMG_NR"/></xsl:variable>
  <!--NPAGE : <xsl:value-of select="$nPage"/>-->
  
  <xsl:variable name="folio"><xsl:value-of select="number($nPage)"/></xsl:variable> 
  <!--FOLIO : <xsl:value-of select="$folio"/>-->
  <xsl:variable name="pageLong"><xsl:value-of select="string-length($folio)"/></xsl:variable>
 
  <xsl:variable name="padding"><xsl:value-of select="substring('00000000000',1,number(7-$pageLong))"/></xsl:variable>  
  <!--PADDING : <xsl:value-of select="$padding"/>-->

<FRAMESET ROWS="10%,90%">
   <xsl:text disable-output-escaping='yes'>&lt;FRAME SRC="X</xsl:text><xsl:value-of select="$padding"/><xsl:value-of select="$folio"/><xsl:text disable-output-escaping='yes'>_ocr.html" NAME="ocr"&gt;</xsl:text>
   
   <FRAMESET COLS="30%,70%">
   <xsl:text disable-output-escaping='yes'>&lt;FRAME SRC="X</xsl:text><xsl:value-of select="$padding"/><xsl:value-of select="$folio"/><xsl:text disable-output-escaping='yes'>_txt.html" NAME="txt" &gt;</xsl:text>
   <xsl:text disable-output-escaping='yes'>&lt;FRAME SRC="X</xsl:text><xsl:value-of select="$padding"/><xsl:value-of select="$folio"/><xsl:text disable-output-escaping='yes'>_img.html" NAME="img" &gt;</xsl:text>
  </FRAMESET>
</FRAMESET>
   <xsl:text disable-output-escaping='yes'>&lt;/html&gt;</xsl:text>
</xsl:template>




       
</xsl:stylesheet>
