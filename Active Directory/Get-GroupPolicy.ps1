<#

.Description:
  - Querys modified Group Policys by a specific date and exports them to a .csv file.
  
.Example:
  - An example is provided below querying Group Policys that were modified from 01JAN2018 - 31JAN2018.

.Notes  
    File Name      : Get-GroupPolicy.ps1
    Version        : v.1.0
    Author         : @PlayStation1
    Prerequisite   : Windows PowerShell 5.0
    Created        : January 08, 2019

#>

$Start = Get-Date -Day 01 -Month 01 -Year 2018 -Hour 00

$End = Get-Date -Day 31 -Month 01 -Year 2018 -Hour 23 -Minute 59

Get-GPO -all | Where-Object { ($_.ModificationTime -gt $Start) -and ($_.ModificationTime -le $End) } | export-csv "ModifiedGPOs.csv"
