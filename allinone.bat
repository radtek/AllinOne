@echo off
REM Debug Version 
REM Todo:
REM #1 colorful command

setlocal EnableDelayedExpansion

if "%1"=="clean" goto l_clean
if "%1"=="copy" goto  mode
if "%1"=="pdb" goto pdb

:: set dll=rsyncData.dll;rsyncFJCA.dll;rsyncSOF.dll;
:: set ocx=RS_CertSafe.ocx;RSAsync.ocx
:: set exe=rsyncClient.exe;rsyncAgent.exe;UKEYMonitor.exe

:mode
set mode=%2
if "%mode%"=="" goto error
if "%mode%"=="debug" (
	set postfix=d
	goto l_copy
	) else (
		if "%mode%"=="release" (
			set postfix=
			goto l_copy
		)
	)
:l_copy

set dest=.\bin
REM RData
echo #########################################################
echo #                    Copy RData                         #
echo #########################################################

set ProjectDir=.\RData
set OutDir=%ProjectDir%\bin
xcopy /y %OutDir%\rsyncData%postfix%.dll %dest%
xcopy /y %OutDir%\rsyncFJCA%postfix%.dll %dest%
xcopy /y %OutDir%\rsyncSOF%postfix%.dll %dest%

xcopy /y %OutDir%\rsyncData%postfix%.pdb %dest%
xcopy /y %OutDir%\rsyncFJCA%postfix%.pdb %dest%
xcopy /y %OutDir%\rsyncSOF%postfix%.pdb %dest%

echo #########################################################
echo #                    Copy RSCertSafe                    #
echo #########################################################
REM RSCertSafe
set ProjectDir=.\RSCertSafe
set OutDir=%ProjectDir%\bin
xcopy /y %OutDir%\RS_CertSafe%postfix%.ocx %dest%
xcopy /y %OutDir%\RS_CertSafe%postfix%.pdb %dest%
REM regsvr32 %OutDir%\RS_CertSafed.ocx

echo #########################################################
echo #                    Copy RSEvent                       #
echo #########################################################
REM RSEvent
set ProjectDir=.\RSEvent
set OutDir=%ProjectDir%\bin
xcopy /y %OutDir%\RSAsync%postfix%.ocx %dest%
xcopy /y %OutDir%\RSAsync%postfix%.pdb %dest%
REM regsvr32 %OutDir%\RSAsyncd.ocx

echo #########################################################
echo #                    Copy rsyncAgent                    #
echo #########################################################
REM rsyncAgent
set ProjectDir=.\rsyncAgent
set OutDir=%ProjectDir%\bin
xcopy /y %OutDir%\rsyncAgent%postfix%.exe %dest%
xcopy /y %OutDir%\rsyncAgent.properties %dest%
xcopy /y %OutDir%\rsyncAgent_gtjd.properties %dest%
xcopy /y %OutDir%\Language.ini %dest%
xcopy /y %OutDir%\rsyncAgent%postfix%.pdb %dest%
REM .\rsyncAgentd.exe /registerService /startup=manual

echo #########################################################
echo #                    Copy rsyncClient                   #
echo #########################################################
REM rsyncClient
set ProjectDir=.\rsyncClient
set OutDir=%ProjectDir%\bin
xcopy /y %OutDir%\rsyncClient%postfix%.exe %dest%
xcopy /y %OutDir%\rsyncClient.properties %dest%
xcopy /y %OutDir%\QZSyncWorker.json %dest%
xcopy /y %OutDir%\CASignature.xml %dest%
xcopy /y %OutDir%\rsyncClient%postfix%.pdb %dest%
REM .\rsyncClientd.exe /registerService /startup=manual

echo #########################################################
echo #                    Copy rsyncDaemon                   #
echo #########################################################
REM rsyncDaemon
set ProjectDir=.\rsyncDaemon
set OutDir=%ProjectDir%\bin
xcopy /y %OutDir%\rsyncDaemon%postfix%.exe %dest%
xcopy /y %OutDir%\rsyncDaemon%postfix%.pdb %dest%
xcopy /y %OutDir%\rsyncDaemon.properties %dest%

echo #########################################################
echo #                    Copy UKEYMonitor                   #
echo #########################################################
REM UKEYMonitor
set ProjectDir=.\UKEYMonitor
set OutDir=%ProjectDir%\bin
xcopy /y %OutDir%\UKEYMonitor%postfix%.exe %dest%
xcopy /y %OutDir%\UKEYMonitor.properties %dest%
xcopy /y %OutDir%\devicelist.json %dest%
xcopy /y %OutDir%\UKEYMonitor%postfix%.pdb %dest%
REM .\UKEYMonitord.exe /registerService /startup=manual
echo #########################################################
echo #                     Done                              #
echo #########################################################
goto :EOF

:l_clean 
echo #########################################################
echo #                    Clean All                          #
echo #########################################################

set dest=.\bin

cd %dest%
echo .........................................................
echo .            Current Working Directory                  .
echo              %cd%                                        
echo .........................................................

for %%f in (rsyncData* rsyncFJCA* rsyncSOF*) do (
	if "%%~xf"==".dll" (
		echo %cd%\%%~f
		del /q %%f
		)
	if "%%~xf"==".pdb" (
		echo %cd%\%%~f
		del /q %%f
		)
	)
	
for %%f in (RS_CertSafe* RSAsync*) do (
		if "%%~xf"==".ocx" (
			echo %cd%\%%~f
			del /q %%f
		)
		if "%%~xf"==".pdb" (
			echo %cd%\%%~f
			del /q %%f
		)
	)
	
for %%f in (rsyncAgent* rsyncClient* UKEYMonitor* rsyncDaemon*) do (
		if "%%~xf"==".exe" (
			echo %cd%\%%~f
			del /q %%f
		)
		if "%%~xf"==".pdb" (
			echo %cd%\%%~f
			del /q %%f
		)
	)

cd ..	
echo .........................................................
echo .            Current Working Directory                  .
echo              %cd%                               
echo .........................................................

goto :EOF

:pdb
set src=.\bin
set cabName=symbol_release_%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%.cab
echo %cabName%
set BASE=%CD%
cd .\bin
makecab /v /F PDBList.txt /d maxdisksize=409600000
xcopy /y .\disk1\1.cab %BASE%\pdb\
del /q .\disk1\1.cab

cd %BASE%\pdb\
rename 1.cab %cabName%

cd %BASE%
goto :EOF

:error
echo #########################################################
echo #             allinone.bat command mode                 #
echo #        command - copy / clean                         #
echo #        mode - debug / release mode compiled           #
echo #########################################################
REM
REM set list=SKF*.*;XSCipherService.*
REM for %%f in (%dll% %exe% %ocx%) do echo %%~nf d %%~xf
endlocal