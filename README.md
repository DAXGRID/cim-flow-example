# CIMFlow platform examples

Contains example scripts that showcases interactions with the CIM Flow platform.

## Examples using the PowerShell 7+

### Get

Downloads the file in the `Url` to the specified `OutputPath`.

```sh
pwsh ./get.ps1 -Url "https://files.customer_name.cimflow.net/output/2025_04_14_06_06_55_cim_output.zip" -Username -OutputPath "./" "my_username" -Password "mypassword"
```

### Upload

The example allows multiple files and also compresses the files for you.

```sh
pwsh ./upload.ps1 -Files /home/my_user/my_file1.xml,/home/my_user/my_file2.xml -Url "https://files.customer_name.cimflow.net/input" -Username "my_username" -Password "mypassword"
```

### Delete

Deletes the file in the specified `Url` path.

```sh
pwsh ./delete.ps1 -Url "https://files.customer_name.cimflow.net/my_file.zip" -Username "my_username" -Password "mypassword"
```


## Example using Bash

### Get

Downloads the file in the url to the specified output path.

```sh
./get.sh "https://files.customer_name.cimflow.net/output/2025_04_14_06_06_55_cim_output.zip" "./" "my_username" "mypassword"
```

### Upload

The example allows multiple files and also compresses the files for you.

```sh
./upload.sh "https://files.customer_name.cimflow.net/input" "my_username" "mypassword" /home/my_user/my_file1.xml,/home/my_user/my_file2.xml
```

### Delete

Deletes the file in the specified `Url` path.

```sh
./delete.sh "https://files.customer_name.cimflow.net/my_file.zip" "my_username" "mypassword"
```
