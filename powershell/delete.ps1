param(
    [Parameter(Mandatory = $true)]
    [string] $Url,

    [Parameter(Mandatory = $true)]
    [string] $Username,

    [Parameter(Mandatory = $true)]
    [string] $Password
)

try {
    $credentials = New-Object System.Management.Automation.PSCredential -ArgumentList $Username, (ConvertTo-SecureString $Password -AsPlainText -Force)

    Write-Host "Deleteing file in path '$Url'."

    $response = Invoke-WebRequest -Uri $url -Method Delete -Credential $credentials

    Write-Host "Status Code: $($response.StatusCode)"
}
catch {
    Write-Error "Error: $_"
    throw $_
}