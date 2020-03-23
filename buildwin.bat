@echo off

setlocal EnableDelayedExpansion

rem set INCLUDE=%INCLUDE%;%OPENSSL_INCLUDE%
rem set LIB=%LIB%;%OPENSSL_LIB%

set POCO_BASE=%CD%
rem set PATH=%POCO_BASE%\bin64;%POCO_BASE%\bin;%PATH%

rem VS_VERSION {90 | 100 | 110 | 120 | 140 | 150}
if "%1"=="" goto usage

set VS_VERSION=vs140
if %VS_VERSION%==vs150 (
  set VS_VARSALL=..\..\VC\Auxiliary\Build\vcvarsall.bat
) else (
  set VS_VARSALL=..\..\VC\vcvarsall.bat
)

rem PLATFORM [Win32|x64]
set PLATFORM=%3
if "%PLATFORM%"=="" (set PLATFORM=Win32)
if not "%PLATFORM%"=="Win32" (
if not "%PLATFORM%"=="x64" (
if not "%PLATFORM%"=="WinCE" (
if not "%PLATFORM%"=="WEC2013" goto usage)))

if not defined VCINSTALLDIR (
  if %VS_VERSION%==vs90 (
    if %PLATFORM%==x64 (
      call "%VS90COMNTOOLS%%VS_VARSALL%" x86_amd64
    ) else (
      call "%VS90COMNTOOLS%%VS_VARSALL%" x86
    )
  ) else (
    if %VS_VERSION%==vs100 (
      if %PLATFORM%==x64 (
        call "%VS100COMNTOOLS%%VS_VARSALL%" x86_amd64
      ) else (
        call "%VS100COMNTOOLS%%VS_VARSALL%" x86
      )
    ) else (
      if %VS_VERSION%==vs110 (
        if %PLATFORM%==x64 (
          call "%VS110COMNTOOLS%%VS_VARSALL%" x86_amd64
        ) else (
          call "%VS110COMNTOOLS%%VS_VARSALL%" x86
        )
      ) else (
        if %VS_VERSION%==vs120 (
          if %PLATFORM%==x64 (
            call "%VS120COMNTOOLS%%VS_VARSALL%" x86_amd64
          ) else (
            call "%VS120COMNTOOLS%%VS_VARSALL%" x86
          )
        ) else (
          if %VS_VERSION%==vs140 (
            if %PLATFORM%==x64 (
              call "%VS140COMNTOOLS%%VS_VARSALL%" x86_amd64
            ) else (
              call "%VS140COMNTOOLS%%VS_VARSALL%" x86
            )
          ) else (
            if %VS_VERSION%==vs150 (
              if %PLATFORM%==x64 (
                call "%VS150COMNTOOLS%%VS_VARSALL%" x86_amd64
              ) else (
                call "%VS150COMNTOOLS%%VS_VARSALL%" x86
              )
            )
          )
        )
      )
    )
  )
)

if not defined VSINSTALLDIR (
  echo Error: No Visual C++ environment found.
  echo Please run this script from a Visual Studio Command Prompt
  echo or run "%%VSnnCOMNTOOLS%%\vsvars32.bat" first.
  goto :EOF
)

set VCPROJ_EXT=vcproj
if %VS_VERSION%==vs100 (set VCPROJ_EXT=vcxproj)
if %VS_VERSION%==vs110 (set VCPROJ_EXT=vcxproj)
if %VS_VERSION%==vs120 (set VCPROJ_EXT=vcxproj)
if %VS_VERSION%==vs140 (set VCPROJ_EXT=vcxproj)
if %VS_VERSION%==vs150 (set VCPROJ_EXT=vcxproj)
goto use_custom

:use_custom
set BUILD_TOOL=msbuild
if not "%BUILD_TOOL%"=="msbuild" (set USEENV=/useenv)
if "%BUILD_TOOL%"=="msbuild" (
  set ACTIONSW=/t:
  set CONFIGSW=/p:Configuration=
  set EXTRASW=/m
  set USEENV=/p:UseEnv=true
)

rem ACTION [build|rebuild|clean]
set ACTION=%1
if "%ACTION%"=="" (set ACTION=build)
if not "%ACTION%"=="build" (
if not "%ACTION%"=="rebuild" (
if not "%ACTION%"=="clean" goto usage))

rem CONFIGURATION [release|debug|both]
set CONFIGURATION=%2
if "%CONFIGURATION%"=="" (set CONFIGURATION=both)
if not "%CONFIGURATION%"=="release" (
if not "%CONFIGURATION%"=="debug" (
if not "%CONFIGURATION%"=="both" goto usage))

if "%PLATFORM%"=="Win32" (set PLATFORM_SUFFIX=) else (
if "%PLATFORM%"=="x64" (set PLATFORM_SUFFIX=_x64) else (
if "%PLATFORM%"=="WinCE" (set PLATFORM_SUFFIX=_CE) else (
if "%PLATFORM%"=="WEC2013" (set PLATFORM_SUFFIX=_WEC2013))))

if "%PLATFORM%"=="WEC2013" (
if "%WEC2013_PLATFORM%"=="" (
echo WEC2013_PLATFORM not set. Exiting.
exit /b 1
)
set PLATFORMSW=/p:Platform=%WEC2013_PLATFORM%
set USEENV=
if %VS_VERSION%==vs110 (set EXTRASW=/m /p:VisualStudioVersion=11.0)
if %VS_VERSION%==vs120 (set EXTRASW=/m /p:VisualStudioVersion=12.0)
if %VS_VERSION%==vs140 (set EXTRASW=/m /p:VisualStudioVersion=14.0)
if %VS_VERSION%==vs150 (set EXTRASW=/m /p:VisualStudioVersion=15.0)
)


set DEBUG_SHARED=0
set RELEASE_SHARED=0

if %CONFIGURATION%==debug (
set DEBUG_SHARED=1) else (
if %CONFIGURATION%==release (
set RELEASE_SHARED=1) else (
if %CONFIGURATION%==both (
set DEBUG_SHARED=1
set RELEASE_SHARED=1) else (
if "%CONFIGURATION%"=="" (
set DEBUG_SHARED=1
set RELEASE_SHARED=1))))

echo.
echo.
echo ########################################################################
echo ####
echo #### STARTING VISUAL STUDIO BUILD (%VS_VERSION%, %PLATFORM%)
echo ####
echo ########################################################################
echo.
echo.
echo The following configurations will be built:

if %DEBUG_SHARED%==1      (echo debug_shared)
if %RELEASE_SHARED%==1    (echo release_shared)

rem build for up to 4 levels deep
for /f %%G in ('findstr /R "." components') do (
  if exist %%G (
    cd %%G
    for /f "tokens=1,2,3,4 delims=/" %%Q in ("%%G") do (
      set PROJECT_FILE=%%Q%PLATFORM_SUFFIX%_%VS_VERSION%.%VCPROJ_EXT%
      if exist !PROJECT_FILE! (
        call :build %%G
        if ERRORLEVEL 1 goto buildfailed
      )
      set PROJECT_FILE=%%R%PLATFORM_SUFFIX%_%VS_VERSION%.%VCPROJ_EXT%
      if exist !PROJECT_FILE! (
        call :build %%G
        if ERRORLEVEL 1 goto buildfailed
      )
      set PROJECT_FILE=%%S%PLATFORM_SUFFIX%_%VS_VERSION%.%VCPROJ_EXT%
      if exist !PROJECT_FILE! (
        call :build %%G
        if ERRORLEVEL 1 goto buildfailed
      )
      set PROJECT_FILE=%%T%PLATFORM_SUFFIX%_%VS_VERSION%.%VCPROJ_EXT%
      if exist !PROJECT_FILE! (
        call :build %%G
        if ERRORLEVEL 1 goto buildfailed
      )
    )
  )
  cd "%POCO_BASE%"
)

echo.
echo ------------------------------------------------------------------------
echo ------------------------------------------------------------------------
echo ---- Build completed.
echo ------------------------------------------------------------------------
echo ------------------------------------------------------------------------
echo.

goto :EOF

rem ////////////////////
rem / build subroutine /
rem ////////////////////
:build

echo.
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo ++++ Building [!PROJECT_FILE!]
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.

if %DEBUG_SHARED%==1 (
echo !BUILD_TOOL! %USEENV% %EXTRASW% %ACTIONSW%%ACTION% %CONFIGSW%debug_shared %PLATFORMSW% !PROJECT_FILE!
  !BUILD_TOOL! %USEENV% %EXTRASW% %ACTIONSW%%ACTION% %CONFIGSW%debug_shared %PLATFORMSW% !PROJECT_FILE!
  if ERRORLEVEL 1 exit /b 1
  echo. && echo. && echo.
)
if %RELEASE_SHARED%==1 (
  !BUILD_TOOL! %USEENV% %EXTRASW% %ACTIONSW%%ACTION% %CONFIGSW%release_shared %PLATFORMSW% !PROJECT_FILE!
  if ERRORLEVEL 1 exit /b 1
  echo. && echo. && echo.
)

echo.
echo ------------------------------------------------------------------------
echo ------------------------------------------------------------------------
echo ---- Done building [!PROJECT_FILE!]
echo ------------------------------------------------------------------------
echo ------------------------------------------------------------------------
echo.

exit /b

rem ////////////////
rem / build failed /
rem ////////////////

:buildfailed

echo.
echo.
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo XXX  BUILD FAILED. EXITING. XXX
echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
echo.
echo.
exit /b 1

:usage
echo Usage:
echo ------
echo buildwin ACTION [CONFIGURATION] [PLATFORM]
echo ACTION:        "build|rebuild|clean"
echo CONFIGURATION: "release|debug|both"
echo PLATFORM:      "Win32|x64"
echo.
echo Default is build all.

endlocal