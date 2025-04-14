# CIMFlow platform examples

Contains example scripts that showcases interactions with the CIM Flow platform.

## Examples using the PowerShell 7+

### Upload

The example allows multiple files and also compresses the files for you.

```sh
pwsh ./upload.ps1 -Files /home/my_user/my_file1.xml,/home/my_user/my_file2.xml -Url "https://files.customer_name.cimflow.net/input" -Username "my_username" -Password "mypassword"
```

### Delete

```sh
pwsh ./delete.ps1 -Url "https://files.customer_name.cimflow.net/my_file.zip" -Username "my_username" -Password "mypassword"
```
