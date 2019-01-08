<#
.Synopsis:
    - Identifys potential PSSessions that have successfully been established.
        
.Description:
    - Finds Type 3 logons with a logon process name "NtLmSsp" which is associated with remote powershell sessions.

.Notes  
    File Name      : Detect-PSSessions.ps1
    Version        : v.1.0
    Author         : @PlayStation1
    Prerequisite   : Windows PowerShell 5.0
    Created        : January 08, 2019

#>

Get-EventLog security | where-object {$_.eventid -eq "4624"} | select -expandproperty message | ForEach-Object {

if ($_ -like "*Logon Type:  3*" -and $_ -like "*Logon Process:  NtLmSsp*"){
    Write-Output $_
    }
}
