<#
.Notes  
    File Name      : Get-Wrecked.ps1
    Version        : v.1.0
    Author         : @PlayStation1; @TerrySmithMBA
    Prerequisite   : Windows PowerShell 5.0
    Created        : January 14, 2019
#>

clear
$ProcessList = Get-WmiObject -Class Win32_Process

foreach ($Process in $ProcessList){
            
    $ParentProcessName =  (get-wmiobject -Class Win32_process | Where-Object {$_.processid -eq $Process.parentprocessid}).name
    $SID = ($Process).getownersid().SID
    $User = ($Process).getowner().user
    $Domain = ($Process).getowner().Domain
        
        if ($Process.ProcessName -eq "System Idle Process" -and($Process.ProcessId -ne "0" -or $Process.ParentProcessId -ne "0")){
                 #System Idle Process
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " System Idle process" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - System Idle Process should have a ProcessID of 0 and a ParentProcessID of 0.`n"
        }
        
        if ($Process.ProcessName -eq "System" -and ($Process.ProcessId -ne "4" -or $Process.ParentProcessId -ne "0")){
                 #System
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " System" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - System should have a ProcessID of 4 and a ParentProcessID of 0.`n"
        }
        
        if ($Process.ProcessName -eq "smss.exe" -and ($Process.ParentProcessId -ne "4")){
                 #smss.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " smss.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - smss.exe should have a ParentProcessID of 4.`n"
        }         

        if ($Process.ProcessName -eq "smss.exe" -and (($Process).getowner().user -ne "SYSTEM" -or ($Process).getowner().user -ne "NT AUTHORITY")){
                 #smss.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " smss.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - smss.exe should have a User of SYSTEM or NT AUTHORITY.`n"
        }

        if ($Process.ProcessName -eq "wininit.exe" -and ($ParentProcessName)){
                 
                 #wininit.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " wininit.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - wininit.exe should have no ParentProcessID.`n"
        }  
       
        if ($Process.ProcessName -eq "winlogon.exe" -and ($ParentProcessName)){
                 
                 #winlogon.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " winlogon.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - winlogon.exe should have no ParentProcessID.`n"
        } 

        if ($Process.ProcessName -eq "csrss.exe" -and ($ParentProcessName)){
                 
                 #csrss.exe
                 Write-Host "Potential threat found with process: " -ForegroundColor DarkYellow -NoNewline
                 Write-Host " csrss.exe" -ForegroundColor DarkYellow "`n"
                 Write-Host "     - csrss.exe should have no ParentProcessID.`n"
        } 
         
    ($Process | select ProcessName, ProcessID, @{n="ParentProcessName";e={ $ParentProcessName }}, ParentProcessID, Path, CommandLine, @{n="StartTime";e={ $_.ConvertToDateTime($Process.creationdate) }}, @{n="User";e={ $User }}, @{n="SID";e={ $SID }}, @{n="Domain";e={ $Domain }}  | Format-List | Out-String).trim()

    foreach ($establishedIP in (Get-NetTCPConnection | Where-Object {$_.owningprocess -eq $Process.processid -and $_.state -eq "Established"})){
        Write-Host "Established       : $($establishedIP.LocalAddress):$($establishedIP.LocalPort)  ===>  $($establishedIP.RemoteAddress):$($establishedIP.RemotePort)"
    } 
    
    foreach ($establishedIP in (Get-NetTCPConnection | Where-Object {$_.owningprocess -eq $Process.processid -and $_.state -eq "Listen"})){
        Write-Host "Listening         : $($establishedIP.LocalAddress):$($establishedIP.LocalPort)  ===>  $($establishedIP.RemoteAddress):$($establishedIP.RemotePort)"
    } 

    Write-Host "___________________________________________________________________________________________________________________________________`n"
}



