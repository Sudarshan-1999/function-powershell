# Define the network subnet range
$subnet = "172.18.0."

# Iterate through IP addresses in the subnet range
for ($i = 1; $i -le 255; $i++) {
    $computerName = $subnet + $i.ToString()
    
    # Test network connectivity
    $connection = Test-NetConnection -ComputerName $computerName -Port 445
    
    # If connection is successful, get shared folders
    if ($connection.TcpTestSucceeded) {
        Write-Host ("Shared folders on {0}:" -f $computerName)
        
        $shares = Get-WmiObject -Class Win32_Share -ComputerName $computerName -ErrorAction SilentlyContinue
        if ($shares) {
            foreach ($share in $shares) {
                Write-Host "  $($share.Name) - $($share.Path)"
            }
        } else {
            Write-Host "  No shared folders found."
        }
        
        Write-Host
    }
}
