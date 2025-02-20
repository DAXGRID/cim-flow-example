# CIMFlow platform examples

Contains example scripts that showcases interactions with the CIM Flow platform.

## How to upload to the CimFlow platform

### Example using the PowerShell 5+ script to zip and upload files with automatic naming of zip file. (Windows)

```sh
powershell.exe -executionpolicy bypass -file .\upload.ps1 -Files /home/my_user/my_file.xml -Url "https://files.customer_name.cimflow.net/input" -Username "my_username" -Password "mypassword"
```

### Example using the PowerShell 7+ script to zip and upload files with automatic naming of zip file. (Windows and Linux)

```sh
pwsh ./upload.ps1 -Files /home/my_user/my_file.xml -Url "https://files.customer_name.cimflow.net/input" -Username "my_username" -Password "mypassword"
```
