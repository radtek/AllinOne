; -- Languages.iss --
; Demonstrates a multilingual installation.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

#define AppName "开发环境包"
#define AppVersion "1.2"
#define FileVersion "1.0.2.078"
#define ExtraDescription "通用版"
#define CompanyName "福建瑞术信息科技有限公司"
#define Copyright "Copyright (C) 2019-2020"

[Setup]
AppName={#AppName}
AppId={{6409A38F-F29E-489D-AAE0-DCB7E77C0B03}
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

OutputBaseFilename=DevSetupV{#FileVersion}
OutputDir=.\output
; Uncomment the following line to disable the "Select Setup Language"
; dialog and have it rely solely on auto-detection.
;ShowLanguageDialog=no

[Languages]
Name: zh; MessagesFile: "compiler:Languages\ChineseSimplified.isl"

[Files]
;include files and library
Source: "..\include\*"; DestDir: "{app}\sdk\include\"; Flags: recursesubdirs;
Source: "..\lib\*.lib"; DestDir: "{app}\sdk\lib\"; Flags: recursesubdirs;

;Special XS SKF
Source: "..\bin\SKF_Library\001\*"; DestDir: "{sys}"; 
;SoFProvider folder
Source: "..\bin\SKF_Library\*"; DestDir: "{app}\SKF_Library\";  Flags: createallsubdirs recursesubdirs;
;BJCAClient
Source: "..\bin\extern\BJCAClient\*"; DestDir: "{pf}\BJCAClient\"; Flags: recursesubdirs;
;Driver
Source: "..\bin\extern\Driver\*"; DestDir: "{app}\Driver\"; 
;Flags: recursesubdirs;
Source: "..\bin\extern\CertTools\*"; DestDir: "{app}\CertTools\"; Flags: recursesubdirs;
Source: "..\bin\extern\redist\*"; DestDir: "{app}\redist\"; Flags: recursesubdirs;
Source: "..\bin\seals\*"; DestDir: "{app}\seals\"; Flags: recursesubdirs;
;Speicalist comment : These are must copy to {app} directory 
Source: "..\bin\seals\SKF_LG_NMG.dll"; DestDir: "{app}";
Source: "..\bin\seals\SKF_USBKeyAPI_Epoint.dll"; DestDir: "{app}";
Source: "..\bin\seals\StampManageSystem.dll"; DestDir: "{app}";
Source: "..\bin\seals\XSCipherService.dll"; DestDir: "{app}";
Source: "..\bin\seals\XSSealProviderLib.dll"; DestDir: "{app}";

Source: "..\bin\extern\GTHelper\*"; DestDir: "{pf}\GTHelper\"; Flags: recursesubdirs;
Source: "..\bin\extern\*.dll"; DestDir: "{app}";
Source: "..\bin\extern\clearlnk.bat"; DestDir: "{app}";

;Debug
;Architecture 2.0
Source: "..\bin\rsyncAgentd.exe"; DestDir: "{app}";
Source: "..\bin\RS_CertSafed.ocx"; DestDir: "{app}";
Source: "..\bin\RSAsyncd.ocx"; DestDir: "{app}";

;rsyncAgent
Source: "..\bin\rsyncDatad.dll"; DestDir: "{app}";
Source: "..\bin\rsyncFJCAd.dll"; DestDir: "{app}";
Source: "..\bin\rsyncSOFd.dll"; DestDir: "{app}";
Source: "..\bin\SoFProviderd.dll"; DestDir: "{app}";

;rsyncClient
Source: "..\bin\rsyncClientd.exe"; DestDir: "{app}"

;all
Source: "..\bin\CppUnitd.dll"; DestDir: "{app}"
Source: "..\bin\PocoCryptod.dll"; DestDir: "{app}";
Source: "..\bin\PocoDatad.dll"; DestDir: "{app}";
Source: "..\bin\PocoDataSQLited.dll"; DestDir: "{app}";
Source: "..\bin\PocoFoundationd.dll"; DestDir: "{app}"
Source: "..\bin\PocoJSONd.dll"; DestDir: "{app}";
Source: "..\bin\PocoNetd.dll"; DestDir: "{app}";
Source: "..\bin\PocoUtild.dll"; DestDir: "{app}";
Source: "..\bin\PocoXMLd.dll"; DestDir: "{app}";
Source: "..\bin\PocoEncodingsd.dll"; DestDir: "{app}";

;Relase
;Architecture 2.0
Source: "..\bin\rsyncAgent.exe"; DestDir: "{app}";
Source: "..\bin\rsyncAgent.properties"; DestDir: "{app}";
Source: "..\bin\RS_CertSafe.ocx"; DestDir: "{app}"; Flags: restartreplace regserver;
Source: "..\bin\RSAsync.ocx"; DestDir: "{app}"; Flags: restartreplace regserver;
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
Source: "..\db\syncQLite.db"; DestDir: "{app}";
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
Name: "{group}\{#AppName} {#AppVersion}"; Filename: "{app}\CertTools\index.html";
Name: "{commondesktop}\{#AppName} {#AppVersion}"; Filename: "{app}\CertTools\index.html";

[Tasks]
; The following task doesn't do anything and is only meant to show [CustomMessages] usage
Name: mytask; Description: "{#AppName} {#AppVersion}"

[Run]
Filename: "{app}\Driver\HSIC DriverSetup.exe";
Filename: "{app}\Driver\UKey20079_User_Silent_x64 _5.1.2019.9111_NoTool.exe";
Filename: "{app}\Driver\20549_User_Driver_SDKey_Silent_x86_x64_5.0.2019.9041.exe";
Filename: "{app}\Driver\NETCA_Crypto.exe"; Parameters:" /sp- /VERYSILENT /norestart ";
Filename: "{app}\Driver\NETCA_Devices(ES).exe"; Parameters:" /sp- /VERYSILENT /norestart ";
Filename: "{app}\Driver\USK218CSP(BJCA).exe"; Parameters:" /verysilent /suppressmsgboxes /norestart /DETACHEDMSG ";
;Filename: "{app}\Driver\GdcaSKFCSP_Setup.exe"; Parameters:" /verysilent /norestart  ";
;Filename: "{app}\Driver\SNCA_3000GM_xd.exe";
Filename: "{app}\Driver\ePass3003.exe"
;BJCA SealProvider Execute Env
;Filename: "{app}\Driver\CertAppEnv_Client.exe";
;
Filename: "{app}\clearlnk.bat";

Filename: "{app}\UKEYMonitor.exe"; Parameters: "/registerService /startup=automatic" ; Flags: runascurrentuser
Filename: "{sys}\sc.exe";Parameters:"start UKEYMonitor";

Filename: "{app}\rsyncAgent.exe"; Parameters: "/registerService /startup=automatic" ; Flags: runascurrentuser
Filename: "{app}\rsyncAgentd.exe"; Parameters: "/registerService /startup=automatic" ; Flags: runascurrentuser
Filename: "{sys}\sc.exe";Parameters:"start rsyncAgent";

Filename: "{app}\rsyncClient.exe"; Parameters: "/registerService /startup=automatic" ; Flags: runascurrentuser
Filename: "{app}\rsyncClientd.exe"; Parameters: "/registerService /startup=automatic" ; Flags: runascurrentuser

Filename: "{sys}\regsvr32.exe";Parameters:" /s ""{pf}\BJCAClient\CertAppEnvV2.14.4\Program\XTXAppCOM.dll"" ";

[UninstallRun]
Filename: "{sys}\regsvr32.exe";Parameters:"/u /s ""{pf}\BJCAClient\CertAppEnvV2.14.4\Program\XTXAppCOM.dll"" ";

Filename: "{app}\rsyncClient.exe"; Parameters: "/unregisterService " ; Flags: runascurrentuser
Filename: "{app}\rsyncClientd.exe"; Parameters: "/unregisterService " ; Flags: runascurrentuser

Filename: "{sys}\sc.exe";Parameters:"stop rsyncAgent";
Filename: "{app}\rsyncAgent.exe"; Parameters: "/unregisterService " ; Flags: runascurrentuser
Filename: "{app}\rsyncAgentd.exe"; Parameters: "/unregisterService " ; Flags: runascurrentuser

Filename: "{sys}\sc.exe";Parameters:"stop UKEYMonitor";
Filename: "{app}\UKEYMonitor.exe"; Parameters: "/unregisterService " ; Flags: runascurrentuser
[UninstallDelete]
Type:files; Name:"{app}\*.dll";
Type:files; Name:"{app}\*.exe";
Type:files; Name:"{app}\*.ocx";
Type:files; Name:"{app}\jdlog.log";
Type:filesandordirs; Name:"{app}\testTarget";
Type:filesandordirs; Name:"{app}\SKF_Library";
Type:filesandordirs; Name:"{app}\CertTools";

[Registry]
Root: HKLM; Subkey: "SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\DetectionTool"; ValueType:"string"; ValueName:"EpointMultiDevdll"; ValueData:"SKF_APP_HD.dll SKF_APP_HSIC.dll SKF_HT_NMG.dll SKF_LG_NMG.dll SNCA_3000GM_xd.dll SmartCTCAPI.dll EsSZCACspV2.dll ePass3K3GM_for_guocai.dll gm3k_for_bjca.dll USK2185_GM.dll ShuttleCsp11_3000GM.dll";Flags: uninsdeletekey

[Code]
function InitializeSetup(): boolean;
var
  ResultStr: String;
  ResultCode: Integer;
begin
  if RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{6409A38F-F29E-489D-AAE0-DCB7E77C0B03}_is1', 'UninstallString', ResultStr) then
    begin
      ResultStr := RemoveQuotes(ResultStr);
      Exec(ResultStr, '/silent', '', SW_HIDE, ewWaitUntilTerminated, ResultCode);
    end;
    result := true;
end;
