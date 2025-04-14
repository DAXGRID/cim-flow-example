param(
    [Parameter(Mandatory = $true)]
    [string] $Url,

    [Parameter(Mandatory = $true)]
    [string] $OutputPath,

    [Parameter(Mandatory = $true)]
    [string] $Username,

    [Parameter(Mandatory = $true)]
    [string] $Password
)

try {
    $credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, (ConvertTo-SecureString $Password -AsPlainText -Force)

    Write-Host "Getting the file in path '$Url'."

    $response = Invoke-WebRequest -Uri $url -Method Get -Credential $credentials -OutFile $OutputPath 

    Write-Host "Finished download file to $OutPutPath"
}
catch {
    Write-Error "Error: $_"
    throw $_
}