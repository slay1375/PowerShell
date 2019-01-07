$cred = Get-Credential

clear

$GoodImage = "3ware
ACPI
acpiex
ADP80XX
amdsata
amdsbs
amdxata
arcsas
atapi
b06bdrv
bfadfcoei
bfadi
bxfcoe
bxois
CLFS
CNG
Disk
ebdrv
EhStorClass
EhStorTcgDrv
elxfcoe
elxstor
FileInfo
FltMgr
Fs_Rec
HpSAMD
hwpolicy
iaStorAV
iaStorV
intelide
intelpep
isapnp
KSecDD
KSecPkg
LSI_SAS
LSI_SAS2i
LSI_SAS3i
LSI_SSS
megasas
megasas2i
megasr
mountmgr
msisadrv
Mup
mvumis
NDIS
nvraid
nvstor
partmgr
pci
pciide
pcmcia
pcw
pdc
percsas2i
percsas3i
ql2300i
ql40xx2i
qlfcoei
sacdrv
sbp2port
scmbus
SiSRaid2
SiSRaid4
spaceport
stexstor
storahci
storflt
stornvme
storufs
storvsc
Tcpip
vdrvroot
vmbus
volmgr
volmgrx
volsnap
volume
vsmraid
VSTXRAID
WdBoot
Wdf01000
WdFilter
WFPLWFS
WindowsTrustedRT
WindowsTrustedRTProxy
Wof
"

#Baseline
$baseline = Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\* | ForEach-Object {if ($_.start -eq 0) {$_.pschildname}} | out-string
$babyList = $baseline.split("`n") | Where-Object {$GoodImage.split("`n") -notcontains $_} | out-string

$computerlist = "DESKTOP-H68FUIA"

foreach ($computer in $computerlist) {
    $remotebabylist = Invoke-Command -ComputerName $computer -Credential $cred -ScriptBlock { 

$GoodImage = "3ware
ACPI
acpiex
ADP80XX
amdsata
amdsbs
amdxata
arcsas
atapi
b06bdrv
bfadfcoei
bfadi
bxfcoe
bxois
CLFS
CNG
Disk
ebdrv
EhStorClass
EhStorTcgDrv
elxfcoe
elxstor
FileInfo
FltMgr
Fs_Rec
HpSAMD
hwpolicy
iaStorAV
iaStorV
intelide
intelpep
isapnp
KSecDD
KSecPkg
LSI_SAS
LSI_SAS2i
LSI_SAS3i
LSI_SSS
megasas
megasas2i
megasr
mountmgr
msisadrv
Mup
mvumis
NDIS
nvraid
nvstor
partmgr
pci
pciide
pcmcia
pcw
pdc
percsas2i
percsas3i
ql2300i
ql40xx2i
qlfcoei
sacdrv
sbp2port
scmbus
SiSRaid2
SiSRaid4
spaceport
stexstor
storahci
storflt
stornvme
storufs
storvsc
Tcpip
vdrvroot
vmbus
volmgr
volmgrx
volsnap
volume
vsmraid
VSTXRAID
WdBoot
Wdf01000
WdFilter
WFPLWFS
WindowsTrustedRT
WindowsTrustedRTProxy
Wof
"

$baseline = Get-ItemProperty HKLM:\SYSTEM\CurrentControlSet\Services\* | ForEach-Object {if ($_.start -eq 0) {$_.pschildname}} | out-string

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
