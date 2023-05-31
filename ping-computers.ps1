# Generate a random subnet
$subnet = "172.18.0." -f (Get-Random -Minimum 1 -Maximum 255)

# Iterate through IP addresses in the subnet range
for ($i = 1; $i -le 255; $i++) {
    $computerName = $subnet + $i.ToString()
    Write-Host $computerName

    # Test network connectivity
    $pingResult = Test-Connection -ComputerName $computerName -Count 1 -Quiet

    # If the computer is reachable, display its name
    if ($pingResult) {
        Write-Host "Computer found: $computerName"
    }
}