# PowerShell TCP Socket File Transfer
Transfer files over a TCP socket via PowerShell. This program was inspired by [this](https://www.reddit.com/r/PowerShell/comments/yjhlv0/comment/iuorp5p/) Reddit comment.

# Usage
On the receiving host, you may start a Netcat listener which writes bytes received to a file:
```
nc -lp <port> > <file>
```

In the script, set the value of the `$file` variable to the path of the file to transfer.

Set the values of the `$ip` and `$port` variables to the IP address and port number of the receiving host. 

Upon execution, the script will establish a connection between the Windows host and the receiving host. It will read bytes from the specified file, and write them to the TCP socket. These bytes will then be received by the Netcat listener on the receiving host and written to a file.

# Example
On my Linux host, I setup a Netcat listener on TCP port `4444` which writes received bytes to a file called `data`:
```
nc -lp 4444 > data
```

On my Windows host, I made a file called `data` which contains `text`:
```powershell
echo text > data
```

In the script, I set the value of the `$file` variable to the path of the file I just created. I set the value of the `$ip` and `$port` variables to the IP address of my Linux host, and the port number that Netcat is listening on:
```powershell
$file="C:\Users\windows\script.ps1"
$ip="192.168.1.2"
$port="4444"
```

I executed the script on my Windows host:
```powershell
.\script.ps1
```

The Netcat listener on my Linux host receives the bytes, writes them to the file `data`, and exits. The file is now on my Linux host.
