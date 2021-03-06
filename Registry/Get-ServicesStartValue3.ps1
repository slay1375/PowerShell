<#
.Description
    - Queries list of services with a start value of 3 on local copmuter. Copmares local computers list to specific 
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
    File Name      : Get-ServicesStartValue3.ps1
    Version        : v.1.0
    Author         : @PlayStation1; @TerrySmithMBA
    Prerequisite   : Windows PowerShell 5.0
    Created        : January 08, 2019
 
 .Source
    - https://www.itprotoday.com/compute-engines/what-are-errorcontrol-start-and-type-values-under-services-subkeys
       
#>

$cred = Get-Credential

clear

$GoodImage = "1394ohci
AcpiDev​
acpipagr​
AcpiPmi​
acpitime​
AJRouter​
ALG​
AmdK8​
AmdPPM​
AppID​
AppIDSvc​
Appinfo​
applockerfltr​
AppReadiness​
AppXSvc​
AsyncMac​
AxInstSV​
BcastDVRUserService​
BcastDVRUserService_126d48​
bcmfn2​
BDESVC​
bindflt​
BITS​
BluetoothUserService​
BluetoothUserService_126d48​
bowser​
Browser​
BTAGService​
BthAvctpSvc​
BthHFEnum​
BTHMODEM​
bthserv​
buttonconverter​
CAD​
camsvc​
CapImg​
CertPropSvc​
cht4vbd​
circlass​
ClipSVC​
CmBatt​
CompositeBus​
COMSysApp​
condrv​
defragsvc​
DeviceAssociationService​
DeviceInstall​
DevicePickerUserSvc​
DevicePickerUserSvc_126d48​
DevicesFlowUserSvc​
DevicesFlowUserSvc_126d48​
DevQueryBroker​
diagnosticshub.standardcollector.service​
diagsvc​
DmEnrollmentSvc​
dmvsc​
dmwappushservice​
dot3svc​
drmkaud​
DsmSvc​
DsSvc​
E1G60​
Eaphost​
EFS​
embeddedmode​
EntAppSvc​
ErrDev​
exfat​
fastfat​
Fax​
fdc​
fdPHost​
FDResPub​
fhsvc​
Filetrace​
flpydisk​
FrameServer​
FsDepends​
gencounter​
genericusbfn​
GPIOClx0101​
GraphicsPerfSvc​
HdAudAddService​
HDAudBus​
HidBatt​
HidBth​
hidi2c​
hidinterrupt​
HidIr​
hidserv​
HidUsb​
HTTP​
HvHost​
hvservice​
HwNClx0101​
hyperkbd​
HyperVideo​
i8042prt​
iagpio​
iai2c​
iaLPSS2i_GPIO2​
iaLPSS2i_GPIO2_BXT_P​
iaLPSS2i_I2C​
iaLPSS2i_I2C_BXT_P​
iaLPSSi_GPIO​
iaLPSSi_I2C​
ibbus​
icssvc​
IKEEXT​
IndirectKmd​
InstallService​
intelppm​
IpFilterDriver​
IPMIDRV​
IPNAT​
IPT​
IpxlatCfgSvc​
irda​
IRENUM​
irmon​
iScsiPrt​
kbdclass​
kbdhid​
kdnic​
KeyIso​
ksthunk​
KtmRm​
lfsvc​
LicenseManager​
lltdsvc​
lmhosts​
LxpSvc​
mausbhost​
mausbip​
MessagingService​
MessagingService_126d48​
mlx4_bus​
Modem​
monitor​
mouclass​
mouhid​
mpsdrv​
MRxDAV​
mrxsmb​
mrxsmb20​
MsBridge​
MSDTC​
msgpiowin32​
mshidkmdf​
mshidumdf​
MSiSCSI​
msiserver​
MSKSSRV​
MSPCLOCK​
MSPQM​
MsRPC​
MSTEE​
MTConfig​
NativeWifiP​
NaturalAuthentication​
NcaSvc​
NcbService​
NcdAutoSetup​
ndfltr​
NdisCap​
NdisImPlatform​
NdisTapi​
Ndisuio​
NdisVirtualBus​
NdisWan​
ndiswanlegacy​
ndproxy​
NetAdapterCx​
Netlogon​
Netman​
netprofm​
NetSetupSvc​
netvsc​
NgcCtnrSvc​
NgcSvc​
Ntfs​
nvdimm​
p2pimsvc​
p2psvc​
Parport​
PcaSvc​
PerfHost​
PhoneSvc​
PimIndexMaintenanceSvc​
PimIndexMaintenanceSvc_126d48​
pla​
PlugPlay​
pmem​
PNPMEM​
PNRPAutoReg​
PNRPsvc​
PolicyAgent​
PptpMiniport​
PrintNotify​
PrintWorkflowUserSvc​
PrintWorkflowUserSvc_126d48​
Processor​
PushToInstall​
QWAVE​
QWAVEdrv​
RasAcd​
RasAgileVpn​
RasAuto​
Rasl2tp​
RasMan​
RasPppoe​
RasSstp​
rdpbus​
RDPDR​
RdpVideoMiniport​
ReFS​
ReFSv1​
RetailDemo​
rhproxy​
RmSvc​
RpcLocator​
s3cap​
SCardSvr​
ScDeviceEnum​
scfilter​
SCPolicySvc​
sdbus​
SDFRd​
SDRSVC​
sdstor​
seclogon​
SEMgrSvc​
SensorDataService​
SensorService​
SensrSvc​
SerCx​
SerCx2​
Serenum​
Serial​
sermouse​
SessionEnv​
sfloppy​
SharedAccess​
SharedRealitySvc​
smphost​
SmsRouter​
SNMPTRAP​
SpatialGraphFilter​
SpbCx​
spectrum​
srv2​
srvnet​
SSDPSRV​
SstpSvc​
StateRepository​
stisvc​
StorSvc​
svsvc​
swenum​
swprv​
Synth3dVsc​
TabletInputService​
TapiSrv​
Tcpip6​
terminpt​
TermService​
TieringEngineService​
TimeBrokerSvc​
TokenBroker​
TPM​
TrustedInstaller​
TsUsbFlt​
TsUsbGD​
tunnel​
UASPStor​
UcmCx0101​
UcmTcpciCx0101​
UcmUcsi​
Ucx01000​
UdeCx​
UEFI​
Ufx01000​
UfxChipidea​
ufxsynopsys​
umbus​
UmPass​
UmRdpService​
UnistoreSvc​
UnistoreSvc_126d48​
upnphost​
UrsChipidea​
UrsCx01000​
UrsSynopsys​
usbccgp​
usbcir​
usbehci​
usbhub​
USBHUB3​
usbohci​
usbprint​
usbser​
USBSTOR​
usbuhci​
USBXHCI​
UserDataSvc​
UserDataSvc_126d48​
VacSvc​
VaultSvc​
vds​
VerifierExt​
vhdmp​
vhf​
VMBusHID​
vmgid​
vmicguestinterface​
vmicheartbeat​
vmickvpexchange​
vmicrdv​
vmicshutdown​
vmictimesync​
vmicvmsession​
vmicvss​
vpci​
VSS​
vwifibus​
W32Time​
WaaSMedicSvc​
WacomPen​
WalletService​
wanarp​
wanarpv6​
WarpJITSvc​
wbengine​
WbioSrvc​
wcncsvc​
wcnfs​
WdiServiceHost​
WdiSystemHost​
wdiwifi​
WdmCompanionFilter​
WdNisDrv​
WdNisSvc​
WebClient​
Wecsvc​
WEPHOSTSVC​
wercplsupport​
WerSvc​
WFDSConMgrSvc​
WiaRpc​
WIMMount​
WinHttpAutoProxySvc​
WinMad​
WinNat​
WinRM​
WINUSB​
WinVerbs​
wisvc​
WlanSvc​
wlidsvc​
wlpasvc​
WmiAcpi​
wmiApSrv​
WMPNetworkSvc​
workfolderssvc​
WpcMonSvc​
WPDBusEnum​
WpdUpFltr​
wuauserv​
WudfPf​
WUDFRd​
WwanSvc​
xbgm​
XblAuthManager​
XblGameSave​
xboxgip​
XboxGipSvc​
XboxNetApiSvc​
xinputhid
"

#Baseline
$baseline = Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\* | ForEach-Object {if ($_.start -eq 3) {$_.pschildname}} | out-string
$babyList = $baseline.split("`n") | Where-Object {$GoodImage.split("`n") -notcontains $_} | out-string

$computerlist = "DESKTOP-H68FUIA"

foreach ($computer in $computerlist) {
    $remotebabylist = Invoke-Command -ComputerName $computer -Credential $cred -ScriptBlock { 

$GoodImage = "1394ohci
AcpiDev​
acpipagr​
AcpiPmi​
acpitime​
AJRouter​
ALG​
AmdK8​
AmdPPM​
AppID​
AppIDSvc​
Appinfo​
applockerfltr​
AppReadiness​
AppXSvc​
AsyncMac​
AxInstSV​
BcastDVRUserService​
BcastDVRUserService_126d48​
bcmfn2​
BDESVC​
bindflt​
BITS​
BluetoothUserService​
BluetoothUserService_126d48​
bowser​
Browser​
BTAGService​
BthAvctpSvc​
BthHFEnum​
BTHMODEM​
bthserv​
buttonconverter​
CAD​
camsvc​
CapImg​
CertPropSvc​
cht4vbd​
circlass​
ClipSVC​
CmBatt​
CompositeBus​
COMSysApp​
condrv​
defragsvc​
DeviceAssociationService​
DeviceInstall​
DevicePickerUserSvc​
DevicePickerUserSvc_126d48​
DevicesFlowUserSvc​
DevicesFlowUserSvc_126d48​
DevQueryBroker​
diagnosticshub.standardcollector.service​
diagsvc​
DmEnrollmentSvc​
dmvsc​
dmwappushservice​
dot3svc​
drmkaud​
DsmSvc​
DsSvc​
E1G60​
Eaphost​
EFS​
embeddedmode​
EntAppSvc​
ErrDev​
exfat​
fastfat​
Fax​
fdc​
fdPHost​
FDResPub​
fhsvc​
Filetrace​
flpydisk​
FrameServer​
FsDepends​
gencounter​
genericusbfn​
GPIOClx0101​
GraphicsPerfSvc​
HdAudAddService​
HDAudBus​
HidBatt​
HidBth​
hidi2c​
hidinterrupt​
HidIr​
hidserv​
HidUsb​
HTTP​
HvHost​
hvservice​
HwNClx0101​
hyperkbd​
HyperVideo​
i8042prt​
iagpio​
iai2c​
iaLPSS2i_GPIO2​
iaLPSS2i_GPIO2_BXT_P​
iaLPSS2i_I2C​
iaLPSS2i_I2C_BXT_P​
iaLPSSi_GPIO​
iaLPSSi_I2C​
ibbus​
icssvc​
IKEEXT​
IndirectKmd​
InstallService​
intelppm​
IpFilterDriver​
IPMIDRV​
IPNAT​
IPT​
IpxlatCfgSvc​
irda​
IRENUM​
irmon​
iScsiPrt​
kbdclass​
kbdhid​
kdnic​
KeyIso​
ksthunk​
KtmRm​
lfsvc​
LicenseManager​
lltdsvc​
lmhosts​
LxpSvc​
mausbhost​
mausbip​
MessagingService​
MessagingService_126d48​
mlx4_bus​
Modem​
monitor​
mouclass​
mouhid​
mpsdrv​
MRxDAV​
mrxsmb​
mrxsmb20​
MsBridge​
MSDTC​
msgpiowin32​
mshidkmdf​
mshidumdf​
MSiSCSI​
msiserver​
MSKSSRV​
MSPCLOCK​
MSPQM​
MsRPC​
MSTEE​
MTConfig​
NativeWifiP​
NaturalAuthentication​
NcaSvc​
NcbService​
NcdAutoSetup​
ndfltr​
NdisCap​
NdisImPlatform​
NdisTapi​
Ndisuio​
NdisVirtualBus​
NdisWan​
ndiswanlegacy​
ndproxy​
NetAdapterCx​
Netlogon​
Netman​
netprofm​
NetSetupSvc​
netvsc​
NgcCtnrSvc​
NgcSvc​
Ntfs​
nvdimm​
p2pimsvc​
p2psvc​
Parport​
PcaSvc​
PerfHost​
PhoneSvc​
PimIndexMaintenanceSvc​
PimIndexMaintenanceSvc_126d48​
pla​
PlugPlay​
pmem​
PNPMEM​
PNRPAutoReg​
PNRPsvc​
PolicyAgent​
PptpMiniport​
PrintNotify​
PrintWorkflowUserSvc​
PrintWorkflowUserSvc_126d48​
Processor​
PushToInstall​
QWAVE​
QWAVEdrv​
RasAcd​
RasAgileVpn​
RasAuto​
Rasl2tp​
RasMan​
RasPppoe​
RasSstp​
rdpbus​
RDPDR​
RdpVideoMiniport​
ReFS​
ReFSv1​
RetailDemo​
rhproxy​
RmSvc​
RpcLocator​
s3cap​
SCardSvr​
ScDeviceEnum​
scfilter​
SCPolicySvc​
sdbus​
SDFRd​
SDRSVC​
sdstor​
seclogon​
SEMgrSvc​
SensorDataService​
SensorService​
SensrSvc​
SerCx​
SerCx2​
Serenum​
Serial​
sermouse​
SessionEnv​
sfloppy​
SharedAccess​
SharedRealitySvc​
smphost​
SmsRouter​
SNMPTRAP​
SpatialGraphFilter​
SpbCx​
spectrum​
srv2​
srvnet​
SSDPSRV​
SstpSvc​
StateRepository​
stisvc​
StorSvc​
svsvc​
swenum​
swprv​
Synth3dVsc​
TabletInputService​
TapiSrv​
Tcpip6​
terminpt​
TermService​
TieringEngineService​
TimeBrokerSvc​
TokenBroker​
TPM​
TrustedInstaller​
TsUsbFlt​
TsUsbGD​
tunnel​
UASPStor​
UcmCx0101​
UcmTcpciCx0101​
UcmUcsi​
Ucx01000​
UdeCx​
UEFI​
Ufx01000​
UfxChipidea​
ufxsynopsys​
umbus​
UmPass​
UmRdpService​
UnistoreSvc​
UnistoreSvc_126d48​
upnphost​
UrsChipidea​
UrsCx01000​
UrsSynopsys​
usbccgp​
usbcir​
usbehci​
usbhub​
USBHUB3​
usbohci​
usbprint​
usbser​
USBSTOR​
usbuhci​
USBXHCI​
UserDataSvc​
UserDataSvc_126d48​
VacSvc​
VaultSvc​
vds​
VerifierExt​
vhdmp​
vhf​
VMBusHID​
vmgid​
vmicguestinterface​
vmicheartbeat​
vmickvpexchange​
vmicrdv​
vmicshutdown​
vmictimesync​
vmicvmsession​
vmicvss​
vpci​
VSS​
vwifibus​
W32Time​
WaaSMedicSvc​
WacomPen​
WalletService​
wanarp​
wanarpv6​
WarpJITSvc​
wbengine​
WbioSrvc​
wcncsvc​
wcnfs​
WdiServiceHost​
WdiSystemHost​
wdiwifi​
WdmCompanionFilter​
WdNisDrv​
WdNisSvc​
WebClient​
Wecsvc​
WEPHOSTSVC​
wercplsupport​
WerSvc​
WFDSConMgrSvc​
WiaRpc​
WIMMount​
WinHttpAutoProxySvc​
WinMad​
WinNat​
WinRM​
WINUSB​
WinVerbs​
wisvc​
WlanSvc​
wlidsvc​
wlpasvc​
WmiAcpi​
wmiApSrv​
WMPNetworkSvc​
workfolderssvc​
WpcMonSvc​
WPDBusEnum​
WpdUpFltr​
wuauserv​
WudfPf​
WUDFRd​
WwanSvc​
xbgm​
XblAuthManager​
XblGameSave​
xboxgip​
XboxGipSvc​
XboxNetApiSvc​
xinputhid
"

$baseline = Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\* | ForEach-Object {if ($_.start -eq 3) {$_.pschildname}} | out-string

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
