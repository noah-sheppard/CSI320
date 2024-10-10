
$Menu = "Please select an option:`n"
$Menu += "1) Last 10 apache log`n"
$Menu += "2) Last 10 failed logins`n"
$Menu += "3) At risk users`n"
$Menu += "4) Open Chrome and go to Champlain Website`n"
$Menu += "5) Exit Menu`n"


$whileRunning = $true

while($whileRunning) {

    Write-Host $Menu | Out-String
    $selection = Read-Host

    if($selection -eq 1) {

        $apache = ApacheLogs
        Write-Output ($apache | Select -Last 10 | Format-Table | Out-String)

    } elseif($selection -eq 2) {

        $timeSince = Read-Host -Prompt "Enter amount of days to search back."
        $loginsFailed = getFailedLogins $timeSince

        Write-Output ($loginsFailed | Select -Last 10 | Format-Table | Out-String)

    } elseif($selection -eq 3) {
        
        $timeSince = Read-Host -Prompt "Enter amount of days to search back."
        $riskyUsers = getAtRiskUsers $timeSince
        
        Write-Output ($riskyUsers | Format-Table | Out-String) 

    } elseif($selection -eq 4) {
        startChrome

    } elseif($selection -eq 5) {
        Write-Host "Closing Menu" | Out-String
        $whileRunning = $false

        exit

    } else {
    
        Write-Host "Input selected does not exist" | Out-String
    }
}
