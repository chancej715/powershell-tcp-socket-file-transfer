<#
.SYNOPSIS
    Write bytes of a file to a stream.
.DESCRIPTION
    This PowerShell script establishes a TCP connection with a designated host and subsequently retrieves the associated network stream. Next, it reads the bytes of a file into a buffer and writes the buffer to the network stream.
.PARAMETER IP
    IPv4 or IPv6 address of receiving host.
.PARAMETER Port
    Port number of receiving host.
.PARAMETER File
    File to transfer.
.EXAMPLE
    PS> Transfer-File -IP 10.10.10.11 -Port 4444 -File archive.zip 
.LINK
    https://github.com/chancej715/powershell-tcp-socket-file-transfer
.NOTES
    Author: Chance Johnson (@chancej715)
#>

function Transfer-File
{
    param (
        [parameter(mandatory)][string]$IP,
        [parameter(mandatory)][ValidateRange(1, 65535)][int]$Port,
        [parameter(mandatory)][string]$File
    )
    
    # Read file
    [byte[]]$buffer = New-Object byte[] 1024
    $FileStream = [System.IO.File]::OpenRead($File)

    # Open socket
    $TcpClient=New-Object System.Net.Sockets.TcpClient($IP, $Port)
    $Stream = $TcpClient.GetStream()

    # Write file to network stream
    Write-Host "Writing file to network stream..."
    while ( $bytes = $FileStream.Read($buffer,0,$buffer.count) ) {
        $Stream.Write($buffer,0,$bytes)
    }

    Write-Host "Done."
    $FileStream.Close()
    $Stream.Dispose()
    $TcpClient.Dispose()
}