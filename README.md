# ALTO-Display
*Convert ALTO based documents to HTML*


### Synopsis
This batch script converts collection of ALTO (https://www.loc.gov/standards/alto) based documents to HTML. OCR text is converted at the page level, and navigation threw the pages document is allowed. Images are also displayed. It also renders other kind of information: word confidences, tags and statistical analysis of the OCR. 

The script have been coded for the BnF documents (ALTO BnF v2, see http://bibnum.bnf.fr/alto_bnf-v2_0/index.html), but this can be easily fixed for other contexts. 


### Installation
The script needs xalan-java.

A sample document is stored in the "DOCS" folder. 
Documents architecture must follow this rules:
- OCR must be stored in the X folder (pages sequential order). ALTO filenames must have this pattern: X\d{8}.xml
- Images may be stored in the D folder. Filenames must have this pattern: D\d{8}.jpg


#### XSLT
Two DOS shell scripts are used:
- parseAltos2Imprimes.bat
- xslt.cmd

4 XSLT stylesheets are located in the XLST folder

The XSLT transformations are performed with Xalan-Java. Path to the Java binary must be set in xslt.cmd.
For each document stored in the DOCS folder, all the ALTO files found in the X folder are processed.

The HTML format is generated in a "HTML" folder and rendered with CSS stylesheets.

##### Test
1. Open a DOS terminal.
2. Change dir to the folder containing the DOCS folder
3. >parseAltos2Imprimes.bat DOCS -x

### Misc
These symbols are used to transcribe the OCR information:
- end of line: ↵
- end of block: §
- composed block: CB{  }CB
- illegible block: ILLEG
- graphical element: GE 
- music score: P 
- maths formula: F 
- illustration : ill.
- non-latine font: NLS
- script font: SF
- headings: T  or  1  ou  2  ou  3 
- stamp: Tamp.
- table: Table
- add: Pub

Color codes:
- no highlight: words with WC = 1 
- pale yellow: words with  WC > 0,5 
- red: words with WC <= 0,5


