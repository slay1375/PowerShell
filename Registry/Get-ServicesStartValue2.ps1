<#
.Description
    - Queries list of services with a start value of 2 on local copmuter. Copmares local computers list to specific 
      remote machines and displays the difference on screen.
      
      Error Control:
            Value	Meaning
            0x00	If this driver can't be loaded or started ignore the problem and display no error.
            0x01	If the driver fails produce a warning but let bootup continue.
            0x02	Panic. If the current config is last known good continue, if not switch to last known good.
            0x03	Record the current startup as a failure. If this is last known good run diagnostic, if not 
                    switch to last known good and reboot.
       
       Start:
            Value	Start Type	Meaning
            0x00	Boot	    The kernel loaded will load this driver first as its needed to use the boot volume device.
            0x01	System	    This is loaded by the I/O subsystem.
            0x02	Autoload	The service is always loaded and run.
            0x03	Manual	    This service does not start automatically and must be manually started by the user.
            0x04	Disabled	The service is disabled and should not be started.
            
       Type:
            Value	Meaning
            0x01	Kernel-mode device driver.
            0x02	Kernel-mode device driver that implements the file system.
            0x04	Information used by the Network Adapter.
            0x10	A Win32 service that should be run as a stand-alone process.
            0x20	A Win32 service that can share address space with other services of the same type.
 
  .Notes  
    File Name      : Get-ServicesStartValue2.ps1
    Version        : v.1.0
    Author         : @PlayStation1; @TerrySmithMBA
    Prerequisite   : Windows PowerShell 5.0
    Created        : January 08, 2019
 
.Source
    - https://www.itprotoday.com/compute-engines/what-are-errorcontrol-start-and-type-values-under-services-subkeys
       
#>

$cred = Get-Credential

clear

$GoodImage = "AudioEndpointBuilder
Audiosrv​
BFE​
BrokerInfrastructure​
CDPSvc​
CDPUserSvc​
CDPUserSvc_126d48​
CldFlt​
CoreMessagingRegistrar​
CryptSvc​
DcomLaunch​
Dhcp​
DiagTrack​
Dnscache​
DoSvc​
DPS​
DusmSvc​
EventLog​
EventSystem​
FontCache​
gpsvc​
iphlpsvc​
LanmanServer​
LanmanWorkstation​
lltdio​
LSM​
luafv​
MapsBroker​
MMCSS​
mpssvc​
mrxsmb10​
MsLldp​
Ndu​
NlaSvc​
nsi​
OneSyncSvc​
OneSyncSvc_126d48​
PEAUTH​
Power​
ProfSvc​
RpcEptMapper​
RpcSs​
rspndr​
SamSs​
Schedule​
SecurityHealthService​
SENS​
SgrmBroker​
ShellHWDetection​
Spooler​
sppsvc​
storqosflt​
SysMain​
SystemEventsBroker​
tcpipreg​
Themes​
TrkWks​
UserManager​
UsoSvc​
wcifs​
Wcmsvc​
WinDefend​
Winmgmt​
WpnService​
WpnUserService​
WpnUserService_126d48​
wscsvc​
WSearch
"

#Baseline
$baseline = Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\* | ForEach-Object {if ($_.start -eq 2) {$_.pschildname}} | out-string
$babyList = $baseline.split("`n") | Where-Object {$GoodImage.split("`n") -notcontains $_} | out-string

$computerlist = "DESKTOP-H68FUIA"

foreach ($computer in $computerlist) {
    $remotebabylist = Invoke-Command -ComputerName $computer -Credential $cred -ScriptBlock { 

$GoodImage = "AudioEndpointBuilder
Audiosrv​
BFE​
BrokerInfrastructure​
CDPSvc​
CDPUserSvc​
CDPUserSvc_126d48​
CldFlt​
CoreMessagingRegistrar​
CryptSvc​
DcomLaunch​
Dhcp​
DiagTrack​
Dnscache​
DoSvc​
DPS​
DusmSvc​
EventLog​
EventSystem​
FontCache​
gpsvc​
iphlpsvc​
LanmanServer​
LanmanWorkstation​
lltdio​
LSM​
luafv​
MapsBroker​
MMCSS​
mpssvc​
mrxsmb10​
MsLldp​
Ndu​
NlaSvc​
nsi​
OneSyncSvc​
OneSyncSvc_126d48​
PEAUTH​
Power​
ProfSvc​
RpcEptMapper​
RpcSs​
rspndr​
SamSs​
Schedule​
SecurityHealthService​
SENS​
SgrmBroker​
ShellHWDetection​
Spooler​
sppsvc​
storqosflt​
SysMain​
SystemEventsBroker​
tcpipreg​
Themes​
TrkWks​
UserManager​
UsoSvc​
wcifs​
Wcmsvc​
WinDefend​
Winmgmt​
WpnService​
WpnUserService​
WpnUserService_126d48​
wscsvc​
WSearch
"

$baseline = Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\* | ForEach-Object {if ($_.start -eq 2) {$_.pschildname}} | out-string

$baseline.split("`n") | Where-Object {$GoodImage.split("`n") -notcontains $_} | out-string

    } 

    Write-Host "Computer Name: $computer" -ForegroundColor DarkYellow "`n"
    $Remotebabylist

    Write-Host "________________________________________`n"

    Write-Host "My Computer:" -ForegroundColor DarkYellow "`n"
    $babyList

    Write-Host "________________________________________`n"

    Write-Host "Differences:" -ForegroundColor DarkYellow "`n"
    if ($babyList.split("`n") | Where-Object {$Remotebabylist.split("`n") -notcontains $_}){
        $babyList.split("`n") | Where-Object {$Remotebabylist.split("`n") -notcontains $_}
    }
    else {
        Write-Host "No Differences" -ForegroundColor Green
    }
}
