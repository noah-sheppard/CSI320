#get-content C:\xampp\apache\logs\access.log

#get-content C:\xampp\apache\logs\access.log -tail 5

#get-content C:\xampp\apache\logs\access.log | Select-String ' 404 ', ' 400 ' 

#get-content C:\xampp\apache\logs\access.log | Select-String ' 200 ' -notmatch

$A = get-childitem -Path C:\xampp\apache\logs\*.log | Select-String -Pattern 'error'

$A[-1..-4]

$notfounds = Get-Content -Path C:\xampp\apache\logs\access.log | Select-String ' 404 '

$regex = [regex] "\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}"

$ipsUnorganized = $regex.Matches($notfounds)

$ips = @()

for($i=0; $i -lt $ipsUnorganized.Count; $i++) {
    $ips += [PSCustomObject]@{ "IP" = $ipsUnorganized[$i].Value; }
}

$ips | Where-Object { $_.IP -ilike "10.*" } | Format-Table

$ipsoften = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoften | Group-Object { $_.IP }
$counts | Select-Object Count, Name
