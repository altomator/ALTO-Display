@echo off

title Parsing des fichiers ALTO pour rendu HTML

if %1"O" EQU "O" goto erreur
if %2"O" EQU "O" goto erreur


IF NOT EXIST %1 GOTO dossierMq

set dirSortie=HTML

if "%2" EQU "-x" goto exec

:start
echo Welcome, %USERNAME%
echo Que voulez-vous faire ?
echo.
echo 1. Simulation du traitement
echo 2. Lancement du traitement

echo. 
echo 0. Quitter
echo.

set /p choice="Entrer votre choix : "
if "%choice%"=="1" goto sim
if "%choice%"=="2" goto exec 
if "%choice%"=="0" goto fin
echo Choix invalide : %choice%
echo.
pause
cls
goto start

:sim
echo Simulation 
set monoption=-sim
goto debut

:exec
set monoption=-exec

echo. 
:debut
cd %1
for  /d %%a IN (*) do (
  echo. 
  echo Traitement du document : %%a
  echo. 
  cd %%a
  IF NOT EXIST %dirSortie%  MKDIR %dirSortie%
 for  /f  %%x IN ('dir /b X\*.xml') do (
    echo %%~nx
    @REM Traitement des fichiers ALTO : generation des fichiers maitre
    call ..\..\xslt.cmd X\%%x ..\..\XSL\affDoc2Imprimes.xsl  %dirSortie%\%%~nx html %%a %monoption%
    @REM Traitement des fichiers ALTO : generation des fichiers d'analyse
    call ..\..\xslt.cmd X\%%x ..\..\XSL\affOCR2Imprimes.xsl  %dirSortie%\%%~nx_ocr html %%a %monoption%
    @REM Traitement des fichiers ALTO : generation des fichiers texte
    call ..\..\xslt.cmd X\%%x ..\..\XSL\affTXT2.xsl  %dirSortie%\%%~nx_txt html %%a %monoption%
    
    @REM Traitement des images
    call ..\..\xslt.cmd X\%%x ..\..\XSL\affIMG2.xsl  %dirSortie%\%%~nx_img html %%a %monoption%
  )
  cd ..
)  
cd ..
goto fin

:erreur
@echo Usage : %0 dossier  -i (interactif)/-x (execution) 
goto fin


:dossierMq
@echo Le dossier des documents %1 n'existe pas !
goto fin

:fin
echo.


