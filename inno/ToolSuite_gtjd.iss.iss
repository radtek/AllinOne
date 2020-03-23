; -- Languages.iss --
; Demonstrates a multilingual installation.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

#define AppName "统一安全认证客户端"
#define AppVersion "2.0"
#define FileVersion "2.0.6.076"
#define ExtraDescription "手机签定制"
#define CompanyName "福建瑞术信息科技有限公司"
#define Copyright "Copyright (C) 2019-2020"

[Setup]
AppName={#AppName}
AppId={{D773AD72-9454-4684-96A7-89E478625FB6}
AppVerName={#AppName,AppVersion}
AppPublisher={#CompanyName}
AppCopyright={#Copyright} {#CompanyName} All Rights Reserved.
WizardStyle=modern
DefaultDirName={pf}\{#AppName} {#AppVersion}
DefaultGroupName={#AppName} {#AppVersion}
UninstallDisplayIcon={app}\MyProg.exe
UninstallDisplayName={#AppName} {#AppVersion}
VersionInfoDescription={#ExtraDescription}
VersionInfoVersion={#FileVersion}

OutputBaseFilename=SafeCertSetupV{#FileVersion}
OutputDir=.\output
; Uncomment the following line to disable the "Select Setup Language"
; dialog and have it rely solely on auto-detection.
;ShowLanguageDialog=no

[Languages]
Name: zh; MessagesFile: "compiler:Languages\ChineseSimplified.isl"

[Dirs]
Name: "{app}\testTarget"; Flags: uninsalwaysuninstall;

[Files]
;Driver
;Source: "..\bin\extern\Driver\*"; DestDir: "{app}\Driver\"; Flags: recursesubdirs;
Source: "..\bin\extern\CertTools\*"; DestDir: "{app}\CertTools\"; Flags: recursesubdirs;
Source: "..\bin\extern\redist\*"; DestDir: "{app}\redist\"; Flags: recursesubdirs;
Source: "..\bin\extern\GTHelper\*"; DestDir: "{pf}\GTHelper\"; Flags: recursesubdirs;
Source: "..\bin\seals\StampManageSystem.dll"; DestDir: "{app}";
Source: "..\bin\extern\*.dll"; DestDir: "{app}";
Source: "..\bin\extern\clearlnk.bat"; DestDir: "{app}";

;updater
Source: "..\bin\updater.exe"; DestDir: "{app}";
Source: "..\bin\settings.ini"; DestDir: "{app}";
Source: "..\bin\lng\*"; DestDir: "{app}\lng"; Flags: recursesubdirs;

;Architecture 2.0
Source: "..\bin\rsyncAgent.exe"; DestDir: "{app}";
Source: "..\bin\rsyncAgent_gtjd.properties"; DestDir: "{app}"; DestName:"rsyncAgent.properties";
Source: "..\bin\RS_CertSafe.ocx"; DestDir: "{app}"; Flags: restartreplace regserver
Source: "..\bin\RSAsync.ocx"; DestDir: "{app}"; Flags: restartreplace regserver
Source: "..\bin\Language.ini"; DestDir: "{app}";
;rsyncAgent
Source: "..\bin\rsyncData.dll"; DestDir: "{app}";
Source: "..\bin\rsyncFJCA.dll"; DestDir: "{app}";
Source: "..\bin\rsyncSOF.dll"; DestDir: "{app}";
Source: "..\bin\SoFProvider.dll"; DestDir: "{app}";
Source: "..\bin\config.ini"; DestDir: "{app}";
;config
Source: "..\bin\config\*"; DestDir: "{app}\config\"; Flags: recursesubdirs;

;rsyncClient
Source: "..\bin\rsyncClient.exe"; DestDir: "{app}"
Source: "..\bin\rsyncClient.properties"; DestDir: "{app}";
;Source: "..\db\syncQLite.db"; DestDir: "{app}";
Source: "..\bin\QZSyncWorker.json"; DestDir: "{app}";
Source: "..\bin\CASignature.xml"; DestDir: "{app}";

;UKEYMonitor
Source: "..\bin\UKEYMonitor.exe"; DestDir: "{app}";
Source: "..\bin\UKEYMonitor.properties"; DestDir: "{app}";
Source: "..\bin\devicelist.json"; DestDir: "{app}";
;all
Source: "..\bin\CppUnit.dll"; DestDir: "{app}"
Source: "..\bin\PocoCrypto.dll"; DestDir: "{app}";
Source: "..\bin\PocoData.dll"; DestDir: "{app}";
Source: "..\bin\PocoDataSQLite.dll"; DestDir: "{app}";
Source: "..\bin\PocoFoundation.dll"; DestDir: "{app}"
Source: "..\bin\PocoJSON.dll"; DestDir: "{app}";
Source: "..\bin\PocoNetXP.dll"; DestDir: "{app}"; DestName:"PocoNet.dll";
Source: "..\bin\PocoUtil.dll"; DestDir: "{app}";
Source: "..\bin\PocoXML.dll"; DestDir: "{app}";
Source: "..\bin\PocoEncodings.dll"; DestDir: "{app}";

;PocoCrypto OPENSSL
Source: "..\bin\openssl.exe"; DestDir: "{app}";
Source: "..\bin\libcrypto-1_1.dll"; DestDir: "{app}";
Source: "..\bin\libssl-1_1.dll"; DestDir: "{app}";

;MQTT
Source: "..\bin\paho-mqtt3a.dll"; DestDir: "{app}";
Source: "..\bin\paho-mqtt3as.dll"; DestDir: "{app}";

;lua engine
Source: "..\bin\lua53.dll"; DestDir: "{app}";

[Icons]
Name: "{group}\{cm:UninstallProgram,{#AppName}}"; Filename: "{uninstallexe}";


[Run]
;
Filename: "{app}\clearlnk.bat"; Flags:runhidden

Filename: "{app}\UKEYMonitor.exe"; Parameters: "/registerService /startup=automatic" ; Flags: runascurrentuser ignoreversion
Filename: "{sys}\sc.exe";Parameters:"start UKEYMonitor"; Flags:runhidden

Filename: "{app}\rsyncAgent.exe"; Parameters: "/registerService /startup=automatic" ; Flags: runascurrentuser ignoreversion
Filename: "{sys}\sc.exe";Parameters:"start rsyncAgent"; Flags:runhidden

Filename: "{app}\rsyncClient.exe"; Parameters: "/registerService /startup=manual" ; Flags: runascurrentuser ignoreversion
;Filename: "{sys}\sc.exe";Parameters:"start rsyncClient"; Flags:runhidden

Filename: "{sys}\regsvr32.exe";Parameters:" /s ""{app}\RS_CertSafe.ocx"" ";
Filename: "{sys}\regsvr32.exe";Parameters:" /s ""{app}\RSAsync.ocx"" ";

[UninstallRun]
Filename: "{sys}\regsvr32.exe";Parameters:"/u /s ""{app}\RSAsync.ocx"" "
Filename: "{sys}\regsvr32.exe";Parameters:"/u /s ""{app}\RS_CertSafe.ocx"" "

;Filename: "{sys}\sc.exe";Parameters:"stop rsyncClient"; Flags:runhidden
Filename: "{app}\rsyncClient.exe"; Parameters: "/unregisterService " ; Flags: runascurrentuser ignoreversion

Filename: "{sys}\sc.exe";Parameters:"stop UKEYMonitor"; Flags:runhidden
Filename: "{app}\UKEYMonitor.exe"; Parameters: "/unregisterService " ; Flags: runascurrentuser ignoreversion

Filename: "{sys}\sc.exe";Parameters:"stop rsyncAgent"; Flags:runhidden
Filename: "{app}\rsyncAgent.exe"; Parameters: "/unregisterService " ; Flags: runascurrentuser ignoreversion

[UninstallDelete]
Type:files; Name:"{app}\*.dll";
Type:files; Name:"{app}\*.exe";
Type:files; Name:"{app}\*.ocx";
Type:files; Name:"{app}\jdlog.log";
Type:filesandordirs; Name:"{app}\testTarget";
Type:filesandordirs; Name:"{app}\SKF_Library";

[Code]
function InitializeSetup(): boolean;
var
  ResultStr: String;
  ResultCode: Integer;
begin
  if RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{D773AD72-9454-4684-96A7-89E478625FB6}_is1', 'UninstallString', ResultStr) then
    begin
      ResultStr := RemoveQuotes(ResultStr);
      Exec(ResultStr, '/silent', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    end;
    result := true;
end;
