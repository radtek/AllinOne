@echo off
REM Debug Version 
REM Todo:
REM #1 colorful command

setlocal EnableDelayedExpansion

if "%1"=="clean" goto l_clean
if "%1"=="copy" goto  mode

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

echo #########################################################
echo #                    Copy RSCertSafe                    #
echo #########################################################
REM RSCertSafe
set ProjectDir=.\RSCertSafe
set OutDir=%ProjectDir%\bin
xcopy /y %OutDir%\RS_CertSafe%postfix%.ocx %dest%
REM regsvr32 %OutDir%\RS_CertSafed.ocx

echo #########################################################
echo #                    Copy RSEvent                       #
echo #########################################################
REM RSEvent
set ProjectDir=.\RSEvent
set OutDir=%ProjectDir%\bin
xcopy /y %OutDir%\RSAsync%postfix%.ocx %dest%
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
REM .\rsyncClientd.exe /registerService /startup=manual

REM echo #########################################################
REM echo #                    Copy rsyncDaemon                   #
REM echo #########################################################
REM REM rsyncDaemon
REM set ProjectDir=.\rsyncDaemon
REM set OutDir=%ProjectDir%\bin

echo #########################################################
echo #                    Copy UKEYMonitor                   #
echo #########################################################
REM UKEYMonitor
set ProjectDir=.\UKEYMonitor
set OutDir=%ProjectDir%\bin
xcopy /y %OutDir%\UKEYMonitor%postfix%.exe %dest%
xcopy /y %OutDir%\UKEYMonitor.properties %dest%
xcopy /y %OutDir%\devicelist.json %dest%
REM .\UKEYMonitord.exe /registerService /startup=manual
goto end

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
	)
	
for %%f in (RS_CertSafe* RSAsync*) do (
		if "%%~xf"==".ocx" (
			echo %cd%\%%~f
			del /q %%f
		)
	)
	
for %%f in (rsyncAgent* rsyncClient* UKEYMonitor*) do (
		if "%%~xf"==".exe" (
			echo %cd%\%%~f
			del /q %%f
		)
	)

cd ..	
echo .........................................................
echo .            Current Working Directory                  .
echo              %cd%                               
echo .........................................................

:: echo ...
:: if exist %dest%\rsyncData.dll (
:: 	echo delete rsyncData
:: 	del /q %dest%\rsyncData.dll 
:: 	)
:: 
:: echo ......
:: if exist %dest%\rsyncFJCA.dll (
:: 	echo delete rsyncFJCA
:: 	del /q %dest%\rsyncFJCA.dll 
:: 	)
:: 	
:: echo .........
:: if exist %dest%\rsyncSOF.dll (
:: 	echo delete rsyncSOF
:: 	del /q %dest%\rsyncSOF.dll 
:: 	)
:: 	
:: echo ............
:: if exist %dest%\RS_CertSafe.ocx (
:: 	echo delete RS_CertSafe
:: 	del /q %dest%\RS_CertSafe.ocx 
:: )
:: 
:: echo ...............
:: if exist %dest%\RSAsync.ocx (
:: 	echo delete RSAsync
:: 	del /q %dest%\RSAsync.ocx  
:: )
:: 
:: echo ..................
:: if exist %dest%\rsyncAgent.exe (
:: 	echo delete rsyncAgent
:: 	del /q %dest%\rsyncAgent.exe 
:: )
:: 
:: echo .....................
:: if exist %dest%\rsyncClient.exe (
:: 	echo delete rsyncClient
:: 	del /q %dest%\rsyncClient.exe 
:: )
:: 
:: echo ........................
:: if exist %dest%\UKEYMonitor.exe (
:: 	echo delete UKEYMonitor
:: 	del /q %dest%\UKEYMonitor.exe 
:: )

goto end

:error
echo #########################################################
echo #             allinone.bat command mode                 #
echo #        command - copy / clean                         #
echo #        mode - debug / release mode compiled           #
echo #########################################################
REM
:end
echo #########################################################
echo #                     Done                              #
echo #########################################################
REM set list=SKF*.*;XSCipherService.*
REM for %%f in (%dll% %exe% %ocx%) do echo %%~nf d %%~xf
endlocal