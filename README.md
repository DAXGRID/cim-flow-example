# CIMFlow platform examples

Contains example scripts that showcases interactions with the CIM Flow platform.

## Examples using the PowerShell 7+

### Get

Downloads the file in the `Url` to the specified `OutputPath`.

```sh
pwsh ./get.ps1 -Url "https://files.customer_name.cimflow.net/output/2025_04_14_06_06_55_cim_output.zip" -Username -OutputPath "./" "my_username" -Password "my_password"
```

### Upload

The example allows multiple files and also compresses the files for you.

```sh
pwsh ./upload.ps1 -Files /home/my_user/my_file1.xml,/home/my_user/my_file2.xml -Url "https://files.customer_name.cimflow.net/input" -Username "my_username" -Password "my_password"
```

### Delete

Deletes the file in the specified `Url` path.

```sh
pwsh ./delete.ps1 -Url "https://files.customer_name.cimflow.net/output/2025_04_14_06_06_55_cim_output.zip" -Username "my_username" -Password "my_password"
```

### Sync

Example showcases syncing a whole to your local file-system. It only downloads the files if they do not already exist locally.

```
pwsh ./sync.ps1 -Url "https://files.customer_name.cimflow.net/output" -OutputPath "./my_output_folder" -Username "my-username" -Password "my_password"
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
./upload.sh "https://files.customer_name.cimflow.net/input" "my_username" "my_password" /home/my_user/my_file1.xml,/home/my_user/my_file2.xml
```

### Delete

Deletes the file in the specified `Url` path.

```sh
./delete.sh "https://files.customer_name.cimflow.net/output/2025_04_14_06_06_55_cim_output.zip" "my_username" "my_password"
```

### Sync

Example showcases syncing a whole to your local file-system. It only downloads the files if they do not already exist locally.

```
./sync.sh "https://files.customer_name.cimflow.net/output" "./my_output_folder" "my_username" "my_password"
```
