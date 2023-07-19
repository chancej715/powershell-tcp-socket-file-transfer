# PowerShell TCP Socket File Transfer
Transfer files over a TCP socket via PowerShell. This script was inspired by [this](https://www.reddit.com/r/PowerShell/comments/yjhlv0/comment/iuorp5p/) Reddit comment.

# Usage
On the receiving host, you may start a Netcat listener which writes bytes received to a file:
```
nc -lp <port> > <file>
```

On the Windows host, source the script in a PowerShell session:
```powershell
. .\transfer.ps1
```

Next, call the `Transfer-File` function with the following parameters:
```powershell
Transfer-File -IP <ip> -Port <port> -File <file>
```
- `-IP` the IPv4 or IPv6 address of the receiving host.
- `-Port` the port number of the receiving host.
- `-File` the file to transfer.

# Example
There is a file named `archive.zip` on my Windows host that I would like to transfer to my Linux host. On my Linux host, I start a Netcat listener on TCP port `4444` which writes received bytes to a file called `archive.zip`:
```
nc -lp 4444 > archive.zip
```
In a PowerShell session on my Windows host, I first source the script:
```powershell
. .\transfer.ps1
```
Next I call the `Transfer-File` function with the IPv4 and port number of my Linux host, as well as the name of the file I want to transfer. 
```powershell
Transfer-File -IP 10.10.10.11 -Port 4444 -File archive.zip
```
The Netcat listener on my Linux host receives the bytes, writes them to the file `archive.zip`, and exits. The file is now on my Linux host.
