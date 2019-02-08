<#
.Notes  
    File Name      : Get-Wrecked.ps1
    Version        : v.1.0
    Author         : @PlayStation1; @TerrySmithMBA
    Prerequisite   : Windows PowerShell 5.0
    Created        : January 14, 2019
<#
<#

Process ID: 
    Is a number used by an operating system to uniquely identify a process.

Parent Process ID: 
    Is a number used by an operating system to uniquely identify a process that has spawned another process.

Parent Process Name: 
    The name associated to a Parent ID.

Count: 


User:

    
Path:





System Idle Process: 
    - Process ID, Parent Process ID
System: 
    - Process ID, Parent Process ID
smss.exe:
    - Parent ID, User, Path
wininit.exe:
    - Parent Process Name, Count, User, Path
winlogon.exe:
    - Parent Process Name, User, Path
csrss.exe:
    - Parent Process Name, User, Path
svchost.exe:
    - Parent Process Name, Path
services.exe:
    - Parent Process Name, Count, User, Path
lsass.exe:
    - Parent Process Name, Count, User Path
RuntimeBroker.exe
    - Parent Process Name, Path

#> 

clear

$ProcessList = Get-WmiObject -Class Win32_Process

foreach ($Process in $ProcessList){

    $ParentProcessName =  (get-wmiobject -Class Win32_process | Where-Object {$_.processid -eq $Process.parentprocessid}).name
    $SID = ($Process).getownersid().SID
    $User = ($Process).getowner().user
    $Domain = ($Process).getowner().Domain
    $Path = $Process | select path
    $Wininit = Get-Process | Where-Object {$_.Name -eq "wininit"}
    $services = Get-Process | Where-Object {$_.Name -eq "services"}
    $lsass = Get-Process | Where-Object {$_.Name -eq "lsass"}
       
        if ($Process.ProcessName -eq "System Idle Process" -and ($Process.ProcessId -ne "0" -or $Process.ParentProcessId -ne "0")){

                 #System Idle Process: Process ID = 0 Parent Process = 0
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " System Idle process" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - System Idle Process should have a ProcessID of 0 and a ParentProcessID of 0.`n"
        }
#___________________________________________________________________________________________________________________________________________
        
        if ($Process.ProcessName -eq "System" -and ($Process.ProcessId -ne "4" -or $Process.ParentProcessId -ne "0")){

                 #System: Process ID = 4 Parent Process = 0
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " System" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - System should have a ProcessID of 4 and a ParentProcessID of 0.`n"
        }
#___________________________________________________________________________________________________________________________________________

        if ($Process.ProcessName -eq "smss.exe" -and ($Process.ParentProcessId -ne "4")){

                 #smss.exe: Parent Process = 4
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " smss.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - smss.exe should have a ParentProcessID of 4.`n"
        }         

        if ($Process.ProcessName -eq "smss.exe" -and ($User -ne "SYSTEM")){

                 #smss.exe: User Account = SYSTEM or NT AUTHORITY
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " smss.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - smss.exe should have a User of SYSTEM or NT AUTHORITY.`n"
        }

        if ($Process.ProcessName -eq "smss.exe" -and ($Path.ToString()) -and ($Path -ne "C:\WINDOWS\system32\smss.exe")){    

                 #smss.exe: Path = C:\windows\system32\smss.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " smss.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - smss.exe should should be located in C:\windows\system32\smss.exe.`n"
        }
#___________________________________________________________________________________________________________________________________________

        if ($Process.ProcessName -eq "wininit.exe" -and ($ParentProcessName)){

                 #wininit.exe: Parent Process = Created by an instance of smss.exe that exits, so tools usually do not provide the parent process name.
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " wininit.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - wininit.exe should have no Parent Process.`n"
        } 

        if ($Process.ProcessName -eq "wininit.exe" -and ($Wininit.count -gt 1)){

                 #wininit.exe: Count = 1
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " wininit.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - There should only be one instance of wininit.exe running.`n"
        }  

        if ($Process.ProcessName -eq "wininit.exe" -and ($User -ne "SYSTEM")){

                 #wininit.exe: User Account = SYSTEM or NT AUTHORITY
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " wininit.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - wininit.exe should have a User of SYSTEM or NT AUTHORITY.`n"
        }

        if ($Process.ProcessName -eq "wininit.exe" -and ($Path.ToString()) -and ($Path -ne "C:\windows\system32\wininit.exe")){    

                 #wininit.exe: Path = C:\windows\system32\wininit.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " smss.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - wininit.exe should should be located in C:\windows\system32\wininit.exe.`n"
        }
#___________________________________________________________________________________________________________________________________________

        if ($Process.ProcessName -eq "winlogon.exe" -and ($ParentProcessName)){

                 #winlogon.exe: Parent Process = Created by an instance of smss.exe that exits, so tools usually do not provide the parent process name.
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " winlogon.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - winlogon.exe should have no Parent Process.`n"
        } 

        if ($Process.ProcessName -eq "winlogon.exe" -and ($User -ne "SYSTEM")){

                 #winlogon.exe: User Account = SYSTEM or NT AUTHORITY
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " winlogon.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - winlogon.exe should have a User of SYSTEM or NT AUTHORITY.`n"
        }

        if ($Process.ProcessName -eq "winlogon.exe" -and ($Path.ToString()) -and ($Path -ne "C:\WINDOWS\system32\winlogon.exe")){   

                 #wininit.exe: Path = C:\windows\system32\winlogon.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " winlogon.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - winlogon.exe should should be located in C:\windows\system32\winlogon.exe.`n"
        }
#___________________________________________________________________________________________________________________________________________

        if ($Process.ProcessName -eq "csrss.exe" -and ($ParentProcessName)){

                 #csrss.exe: Parent Process = Created by an instance of smss.exe that exits, so tools usually do not provide the parent process name.
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " csrss.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - csrss.exe should have no Parent Process.`n"
        }

        if ($Process.ProcessName -eq "csrss.exe" -and ($User -ne "SYSTEM")){

                 #csrss.exe: User Account = SYSTEM or NT AUTHORITY
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " csrss.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - csrss.exe should have a User of SYSTEM or NT AUTHORITY.`n"
        } 

        if ($Process.ProcessName -eq "csrss.exe" -and ($Path.ToString()) -and ($Path -ne "C:\windows\system32\csrss.exe")){ 

                 #csrss.exe: Path = C:\windows\system32\csrss.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " csrss.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - csrss.exe should should be located in C:\windows\system32\csrss.exe.`n"
        }
#___________________________________________________________________________________________________________________________________________

        if ($Process.ProcessName -eq "svchost.exe" -and ($ParentProcessName -ne "services.exe")){

                 #svchost.exe: Parent Process = services.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " svchost.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - svchost.exe should have a Parent Process named services.exe.`n"
        }

        if ($Process.ProcessName -eq "svchost.exe" -and ($Path.ToString()) -and ($Path -ne "C:\windows\system32\svchost.exe")){    

                 #svchost.exe: Path = C:\windows\system32\svchost.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " svchost.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - svchost.exe should should be located in C:\windows\system32\svchost.exe.`n"
        }
#___________________________________________________________________________________________________________________________________________

        if ($Process.ProcessName -eq "services.exe" -and ($ParentProcessName -ne "wininit.exe")){

                 #services.exe: Parent Process = wininit.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " services.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - services.exe should have a Parent Process named wininit.exe.'n"
        }

        if ($Process.ProcessName -eq "services.exe" -and ($services.count -gt 1)){

                 #services.exe: Count = 1
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " services.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - There should only be one instance of services.exe running.`n"
        }

        if ($Process.ProcessName -eq "services.exe" -and ($User -ne "SYSTEM")){

                 #services.exe: User Account = SYSTEM or NT AUTHORITY
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " services.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - services.exe should have a User of SYSTEM or NT AUTHORITY.`n"
        } 

        if ($Process.ProcessName -eq "services.exe" -and ($Path.ToString()) -and ($Path -ne "C:\windows\system32\services.exe")){    

                 #services.exe: Path = C:\windows\system32\services.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " services.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - services.exe should should be located in C:\windows\system32\services.exe.`n"
        }
#___________________________________________________________________________________________________________________________________________
        
        if ($Process.ProcessName -eq "lsass.exe" -and ($ParentProcessName -ne "wininit.exe")){

                 #lsass.exe: Parent Process = wininit.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " lsass.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - lsass.exe should have a Parent Process named wininit.exe.'n"
        }

        if ($Process.ProcessName -eq "lsass.exe" -and ($lsass.count -gt 1)){

                 #lsass.exe: Count = 1
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " lsass.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - There should only be one instance of lsass.exe running.`n"
        }

        if ($Process.ProcessName -eq "lsass.exe" -and ($User -ne "SYSTEM")){

                 #lsass.exe: User Account = SYSTEM or NT AUTHORITY
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " lsass.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - lsass.exe should have a User of SYSTEM or NT AUTHORITY.`n"
        } 

        if ($Process.ProcessName -eq "lsass.exe" -and ($Path.ToString()) -and ($Path -ne "C:\windows\system32\lsass.exe")){    

                 #lsass.exe: Path = C:\windows\system32\lsass.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " lsass.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - services.exe should should be located in C:\windows\system32\lsass.exe.`n"
        }
#___________________________________________________________________________________________________________________________________________

        if ($Process.ProcessName -eq "RuntimeBroker.exe" -and ($ParentProcessName -ne "svchost.exe")){

                 #RuntimeBroker.exe: Parent Process = svchost.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " RuntimeBroker.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - RuntimeBroker.exe should have a Parent Process named svchost.exe.'n"
        }

        if ($Process.ProcessName -eq "RuntimeBroker.exe" -and ($Path.ToString()) -and ($Path -ne "C:\windows\system32\RuntimeBroker.exe")){    

                 #RuntimeBroker.exe: Path = C:\windows\system32\RuntimeBroker.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " RuntimeBroker.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - RuntimeBroker.exe should should be located in C:\windows\system32\RuntimeBroker.exe.`n"
        }

    ($Process | select ProcessName, ProcessID, @{n="ParentProcessName";e={ $ParentProcessName }}, ParentProcessID, Path, CommandLine, @{n="StartTime";e={ $_.ConvertToDateTime($Process.creationdate) }}, @{n="User";e={ $User }}, @{n="SID";e={ $SID }}, @{n="Domain";e={$Domain }}  | Format-List | Out-String).trim()


    foreach ($establishedIP in (Get-NetTCPConnection | Where-Object {$_.owningprocess -eq $Process.processid -and $_.state -eq "Established"})){
        Write-Host "Established       : $($establishedIP.LocalAddress):$($establishedIP.LocalPort)  ===>  $($establishedIP.RemoteAddress):$($establishedIP.RemotePort)"
    } 


    foreach ($establishedIP in (Get-NetTCPConnection | Where-Object {$_.owningprocess -eq $Process.processid -and $_.state -eq "Listen"})){
        Write-Host "Listening         : $($establishedIP.LocalAddress):$($establishedIP.LocalPort)  ===>  $($establishedIP.RemoteAddress):$($establishedIP.RemotePort)"
    } 

    Write-Host "___________________________________________________________________________________________________________________________________`n"

}
