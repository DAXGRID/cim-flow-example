param(
    [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
    [string[]] $Files,

    [Parameter(Mandatory = $true)]
    [string] $Url,

    [Parameter(Mandatory = $true)]
    [string] $Username,

    [Parameter(Mandatory = $true)]
    [string] $Password
)

# Check if the list is empty
if (-not $Files) {
    Write-Warning "No files were provided. No zip file will be created."
    return # Exit the script if no files are provided
}

$currentDate = Get-Date -AsUTC
$ZipFilePath = [System.IO.Path]::GetTempPath() + $currentDate.ToString("yyyy_MM_dd_HH_mm_ss") + "_cim.zip"

# Create the zip archive
try {
  Compress-Archive -Path $Files -DestinationPath $ZipFilePath -Force -ErrorAction Stop
  Write-Host "Successfully created zip archive: $ZipFilePath"
}
catch {
    Write-Error "Error creating zip archive: $($_.Exception.Message)"
}

# Upload the file
try {
    $credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, (ConvertTo-SecureString $Password -AsPlainText -Force)

    Write-Host "Uploading file '$ZipFilePath' to '$Url'."
    $response = Invoke-WebRequest -Uri $url -Method Post -Headers @{
        "Content-Type" = "multipart/form-data"
    } -Credential $credentials `
      -Form @{
          data = Get-Item -Path $ZipFilePath
      }

    Write-Host "Status Code: $($response.StatusCode)"
}
catch {
    Write-Error "Error: $_"
} finally {
    Write-Host "Removing temporary zip file '$ZipFilePath'."
    Remove-Item $ZipFilePath -Force -ErrorAction Stop
}
