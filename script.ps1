$file="PATH"        # File to transfer
$ip="IP ADDRESS"    # IP of receiving host
$port="PORT"        # Port of receiving host

$TcpClient=New-Object System.Net.Sockets.TcpClient($ip, $port)
$Stream = $TcpClient.GetStream()
[byte[]]$buffer = New-Object byte[] 1024
$File = [System.IO.File]::OpenRead($file)

while ( $bytes = $File.Read($buffer,0,$buffer.count) ) {
    $Stream.Write($buffer,0,$bytes)
    Write-Host ($bytes)
}

$File.Close()
$Stream.Dispose()
$TcpClient.Dispose()