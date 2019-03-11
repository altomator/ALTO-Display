<?xml version="1.0" encoding="UTF-8"?>
<!-- edited with XMLSpy v2010 rel. 3 sp1 (http://www.altova.com) by BnF (BNF) -->
<!--Auteur  : BnF/DSR/DSC/NUM/JP Moreux, Version : 1.0 -->
<!-- NB : feuille à utiliser avec Xalan-Java 
 Objet : conversion ALTO prod v2.0 vers HTML -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0" xmlns:alto="http://www.loc.gov/standards/alto/ns-v3#" xmlns:str="http://exslt.org/strings" extension-element-prefixes="str">
	<xsl:output method="html" indent="no" omit-xml-declaration="yes"/>
	<xsl:template match="/">
		<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
        "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"&gt;</xsl:text>
		<xsl:text disable-output-escaping='yes'>&lt;html xmlns="http://www.w3.org/1999/xhtml"&gt;</xsl:text>
		<head>
			<xsl:text disable-output-escaping='yes'>&lt;meta http-equiv="Content-Type" content="application/xhtml+xml; charset=UTF-8"/&gt;</xsl:text>
			<xsl:text disable-output-escaping='yes'>&lt;link rel="stylesheet" href="..\..\..\CSS\stylesheet_alto2.css" type="text/css"/&gt;</xsl:text>
			<title>Affichage des contenus ALTO selon le taux de confiance</title>
		</head>
		<body>
			<script src="..\..\..\Scripts\jquery-1.11.2.js"/>
			<script src="..\..\..\Scripts\GUI.js"/>
			<div align="center">
				<form id="bar">
					<label id="illbut">Illisible<input name="illegible" type="checkbox"/>
					</label>
					<label id="wcbut">WC<input name="WC" type="checkbox"/>
					</label>
					<label id="deqbut">Deq.<input name="deq" type="checkbox"/>
					</label>
					<label id="impbut">Import.<input name="imp" type="checkbox"/>
					</label>
					<label id="enbut">EN<input name="en" type="checkbox"/>
					</label>
				</form>
			</div>
			<xsl:apply-templates select="//alto:Page"/>
		</body>
		<xsl:text disable-output-escaping='yes'>&lt;/html&gt;</xsl:text>
	</xsl:template>
	<xsl:template match="//alto:Page">
		<xsl:apply-templates/>
	</xsl:template>
	
	<!--                                    -->
	<!-- Traitement des marges : insérer un filet avant le bloc principal de texte  -->
	<xsl:template match="alto:PrintSpace"> <xsl:text disable-output-escaping='yes'>&lt;hr&gt;</xsl:text>
	<xsl:apply-templates/>
	</xsl:template>
	
	<!--                                                  -->
	<!-- Traitement du texte  -->
	<xsl:template match="alto:TextBlock">
		<xsl:variable name="typeBloc">
			<xsl:value-of select="@TAGREFS"/>
		</xsl:variable>
		<xsl:choose>
			<!-- titre -->
			<xsl:when test="contains(attribute::TAGREFS,'title1')">
				<xsl:variable name="id">
					<xsl:value-of select="@ID"/>
				</xsl:variable>
				<p class="TextBlock">
					<a name="{$id}"/>
					<span class="titre">1</span>&#160;<span class="titraille1">
						<xsl:apply-templates/>
					</span>
					<span class="tb">&#167;</span>
					<!-- tb : symbole de paragraphe  -->
				</p>
			</xsl:when>
			<xsl:when test="contains(attribute::TAGREFS,'title2')">
				<xsl:variable name="id">
					<xsl:value-of select="@ID"/>
				</xsl:variable>
				<p class="TextBlock">
					<a name="{$id}"/>
					<span class="titre">2</span>&#160;<span class="titraille2">
						<xsl:apply-templates/>
					</span>
					<span class="tb">&#167;</span>
				</p>
			</xsl:when>
			<!-- autres types de blocs déqualifiés-->
			<xsl:when test="contains(attribute::TAGREFS,'textStamped')">
				<p class="deqBloc">
					<span class="typeBloc">Tamp.</span>&#160;<xsl:apply-templates/>
					<span class="tb">&#167;</span>
				</p>
			</xsl:when>
			<xsl:when test="contains(attribute::TAGREFS,'table')">
				<xsl:choose>
					<xsl:when test="contains(attribute::TAGREFS,'illegible')">
						<p class="deqBloc">
							<span class="typeBloc">Table</span>&#160;<xsl:apply-templates/>
							<span class="tb">&#167;</span>
						</p>
					</xsl:when>
					<xsl:otherwise>
						<p class="TextBloc">
							<span class="typeBloc">Table</span>&#160;<xsl:apply-templates/>
							<span class="tb">&#167;</span>
						</p>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:when test="contains(attribute::TAGREFS,'advertisement')">
				<p class="deqBloc">
					<span class="typeBloc">Pub</span>&#160;<xsl:apply-templates/>
					<span class="tb">&#167;</span>
				</p>
			</xsl:when>
			<xsl:when test="contains(attribute::TAGREFS,'scriptFonts')">
				<p class="deqBloc">
					<span class="typeBloc">SF</span>&#160;<xsl:apply-templates/>
					<span class="tb">&#167;</span>
				</p>
			</xsl:when>
			<xsl:when test="contains(attribute::TAGREFS,'illegible')">
				<p class="deqBloc">
					<span class="typeBloc">Illis.</span>&#160;<span class="illegible">
						<xsl:apply-templates/>
					</span>
					<span class="tb">&#167;</span>
				</p>
			</xsl:when>
			<xsl:when test="contains(attribute::TAGREFS,'missing')">
				<p class="DeqBloc">
					<span class="typeBloc">Manq.</span>&#160;<xsl:apply-templates/>
					<span class="tb">&#167;</span>
				</p>
			</xsl:when>
			<xsl:otherwise>
				<p class="TextBlock">
					<xsl:apply-templates/>
					<span class="tb">&#167;</span>
				</p>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!--                                                  -->
	<!-- Traitement des lignes  -->
	<xsl:template match="//alto:TextLine">
		<xsl:choose>
			<!-- ligne illisible -->
			<xsl:when test="contains(attribute::TAGREFS,'illegible')">
				<span class="illegible">
					<xsl:apply-templates/>
				</span>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:if test="following-sibling::alto:TextLine">
			<!-- si une ligne suit, un retour à la ligne -->
			<span class="st">&#8629;</span>
			<br/>
		</xsl:if>
	</xsl:template>
	<!--                                                  -->
	<!-- Traitement des mots  -->
	<xsl:template match="//alto:String">
		<xsl:variable name="varWC">
			<xsl:value-of select="number(@WC)"/>
		</xsl:variable>
		<xsl:choose>
			<!-- mots "importants" -->
			<xsl:when test="contains(attribute::TAGREFS,'important')">
				<span class="important">
					<xsl:value-of select="@CONTENT"/>
				</span>
			</xsl:when>
			<!-- entités nommées" -->
			<xsl:when test="contains(attribute::TAGREFS,'TAG_NE')">
				<span class="en">
					<xsl:value-of select="@CONTENT"/>
				</span>
			</xsl:when>
			<!-- mots illisibles -->
			<xsl:when test="contains(attribute::TAGREFS,'illegible')">
				<span class="illegible">
					<xsl:value-of select="@CONTENT"/>
				</span>
			</xsl:when>
			<xsl:when test="$varWC=1">
				<xsl:value-of select="@CONTENT"/>
			</xsl:when>
			<xsl:when test="($varWC&lt;1) and ($varWC&gt;0.5)">
				<span class="B">
					<xsl:value-of select="@CONTENT"/>
				</span>
			</xsl:when>
			<xsl:when test="$varWC&lt;=0.5">
				<span class="C">
					<xsl:value-of select="@CONTENT"/>
				</span>
			</xsl:when>
		</xsl:choose>
		
	</xsl:template>
	
	<!--                                      -->
	<!-- Traitement des espaces  -->
	<xsl:template match="//alto:SP">
	    <xsl:text> </xsl:text>
	</xsl:template>
	<!--                                                  -->
	<!-- Traitement des blocs graphiques  -->
	<xsl:template match="alto:GraphicalElement">
		<xsl:variable name="childLines" select="child::*"/>
		<p class="GraphicalElement">
			<xsl:choose>
				<!-- Is there a tag?  -->
				<xsl:when test="@TAGREFS">
					<xsl:variable name="root" select="/"/>
					<xsl:variable name="tagID">
						<xsl:value-of select="@TAGREFS"/>
					</xsl:variable>
					<!-- Apply CSS on the tag content 
					<xsl:apply-templates select="$root/alto:alto/alto:Tags/*[@ID=$tagID]">
						<xsl:with-param name="param" select="$childLines"/>
					</xsl:apply-templates>-->
					<!-- add a HTML link on the tag ID  -->
					<xsl:variable name="tagLabel">
						<xsl:value-of select="$root/alto:alto/alto:Tags/*[@ID=$tagID]/@LABEL"/>
					</xsl:variable>
					<a>
						<xsl:attribute name="href">#<xsl:value-of select="$tagID"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="$tagLabel"/></xsl:attribute>
						<span class="ge">GE</span>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<span class="ge">GE</span>
				</xsl:otherwise>
			</xsl:choose>
		</p>
	</xsl:template>
	<!--                                                  -->
	<!-- Traitement des blocs d'illustration  -->
	<xsl:template match="alto:Illustration">
		<!-- Traitement des types de bloc  -->
		<xsl:variable name="childLines" select="child::*"/>
		<p class="Illustration">
			<xsl:choose>
				<!-- Is there a tag?  -->
				<xsl:when test="@TAGREFS">
					<xsl:variable name="root" select="/"/>
					<xsl:variable name="tagID">
						<xsl:value-of select="@TAGREFS"/>
					</xsl:variable>
					<!-- Apply CSS on the tag content 
					<xsl:apply-templates select="$root/alto:alto/alto:Tags/*[@ID=$tagID]">
						<xsl:with-param name="param" select="$childLines"/>
					</xsl:apply-templates> -->
					<!-- add a HTML link on the tag ID  -->
					<xsl:variable name="tagLabel">
						<xsl:value-of select="$root/alto:alto/alto:Tags/*[@ID=$tagID]/@LABEL"/>
					</xsl:variable>
					<a>
						<xsl:attribute name="href">#<xsl:value-of select="$tagID"/></xsl:attribute>
						<xsl:attribute name="title"><xsl:value-of select="$tagLabel"/></xsl:attribute>
						<span class="il">ill.</span>
					</a>
				</xsl:when>
				<xsl:otherwise>
					<span class="il">ill.</span>
				</xsl:otherwise>
			</xsl:choose>
		</p>
	</xsl:template>
	<!--                                                  -->
	<!-- Traitement des blocs composés  -->
	<xsl:template match="alto:ComposedBlock">
		<p class="ComposedBlockDebut">
			<span class="cb">CB {</span>
		</p>
		<xsl:apply-templates/>
		<p class="ComposedBlockFin">
			<span class="cb">} CB</span>
		</p>
	</xsl:template>
</xsl:stylesheet>
