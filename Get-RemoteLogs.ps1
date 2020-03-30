#Uncomment the below line to import a computer list from a text file
$computers = get-content $psscriptroot\Dep_files\computers.txt
#uncomment the below line to import a computer list from an OU, note that you will need rsat installed for this to work
#$computers = (get-adcomputer -filter * -searchbase "OU=Computers,DC=Mcbaldwin,DC=net").DNSHostName
#$Lcomputers = get-content $psscriptroot\Dep_files\LinuxComputers.txt
$events = Get-Content $PSScriptRoot\Dep_files\eventids.txt
$date = Get-Date -Format dd-MMM-yy

#checks if variable has a value
Function WindowsLogFetch{
if ($computers){
foreach ($comp in $computers){
    write-host "Pulling logs from $comp" -foregroundcolor green
    Get-EventLog -computername $comp -LogName Security | where-object {$events -contains $_.EventID } | select-object EventID,MachineName,index,EntryType,Message,Source,TimeGenerated | Export-csv -Path "$psscriptroot\$date.csv" -Append

}
} else {
    write-host "No computers were fetched, please ensure the text file path or computer OU is uncommented and properly identified" -foregroundcolor red

}
}



function LinuxLogFetch{

    if ($Lcomputers){
        write-host "would now pull logs from linux"
    }
    
}

WindowsLogFetch
#LinuxLogFetch