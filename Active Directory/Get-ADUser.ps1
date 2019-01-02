<#

Description:

  - Query Active Directory user accounts by a specific creation date and exports them to a .csv file.
  
Example:

  - An example is provided below querying users on the "PlayStation1.example" domain from 01JAN2018 - 31JAN2018.

#>

$Start = Get-Date -Day 01 -Month 01 -Year 2018 -Hour 00 

$End = Get-Date -Day 31 -Month 01 -Year 2018 -Hour 23 -Minute 59 

Get-ADUser -server "PlayStation1.example" -Filter * -Properties whenCreated | Where-Object { ($_.whenCreated -gt $Start) -and ($_.whenCreated -le $End) } | export-csv "Users.csv"
