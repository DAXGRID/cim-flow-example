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

# Stop the script when a cmdlet or a native command fails
$ErrorActionPreference = 'Stop'
$PSNativeCommandUseErrorActionPreference = $true

# Load dependencies
Add-Type -AssemblyName "System.Net.Http"

# Check if the list is empty
if (-not $Files) {
    Write-Warning "No files were provided. No zip file will be created."
    return # Exit the script if no files are provided
}

$currentDate = Get-Date
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
    $headers = @{
        "Content-Type" = "multipart/form-data"
    }

    $handler = New-Object System.Net.Http.HttpClientHandler
    $handler.Credentials = New-Object System.Net.NetworkCredential($Username, $Password)

    $client = New-Object System.Net.Http.HttpClient($handler)

    $fileStream = [System.IO.File]::OpenRead($ZipFilePath)

    $multipartContent = New-Object System.Net.Http.MultipartFormDataContent

    $fileContent = New-Object System.Net.Http.StreamContent($fileStream)
    $fileContent.Headers.ContentType = [System.Net.Http.Headers.MediaTypeHeaderValue]::Parse("text/plain")

    $multipartContent.Add($fileContent, "data", [System.IO.Path]::GetFileName($ZipFilePath))

    Write-Host "Uploading '$ZipFilePath' to '$Url'."
    $response = $client.PostAsync($Url, $multipartContent).GetAwaiter().GetResult()
    Write-Host "Status Code: $($response.StatusCode)"

    $fileStream.Close()

    Write-Host "Finished uploading '$ZipFilePath' to '$Url'."
}
catch {
    Write-Error "Error: $_"
} finally {
    Write-Host "Removing temporary zip file '$ZipFilePath'."
    Remove-Item $ZipFilePath -Force -ErrorAction Stop
}
