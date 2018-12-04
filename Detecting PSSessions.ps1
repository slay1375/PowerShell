Get-EventLog security | where-object {$_.eventid -eq "4624"} | select -expandproperty message | ForEach-Object {

if ($_ -like "*Logon Type:  3*" -and $_ -like "*Logon Process:  NtLmSsp*"){
    Write-Output $_
    }
}