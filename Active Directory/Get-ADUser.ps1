$Start = Get-Date -Day 01 -Month 01 -Year 2018 -Hour 00 

$End = Get-Date -Day 31 -Month 01 -Year 2018 -Hour 23 -Minute 59 

Get-ADUser -server "PlayStation1.example" -Filter * -Properties whenCreated | Where-Object { ($_.whenCreated -gt $Start) -and ($_.whenCreated -le $End) } | export-csv "test.csv"
