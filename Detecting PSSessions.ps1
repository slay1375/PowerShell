<#
    .SYNOPSIS
        Identifys potential PSSessions that have successfully been established.

       THIS CODE IS MADE AVAILABLE AS IS, WITHOUT WARRANTY OF ANY KIND. THE ENTIRE 
    	RISK OF THE USE OR THE RESULTS FROM THE USE OF THIS CODE REMAINS WITH THE USER.

    .DESCRIPTION
        Finds Type 3 logons with a logon process name "NtLmSsp" which is associated with remote powershell sessions.
#>

Get-EventLog security | where-object {$_.eventid -eq "4624"} | select -expandproperty message | ForEach-Object {

if ($_ -like "*Logon Type:  3*" -and $_ -like "*Logon Process:  NtLmSsp*"){
    Write-Output $_
    }
}
