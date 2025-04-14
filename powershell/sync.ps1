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

    $response = Invoke-WebRequest -Uri "$($Url)?json" -Method Get -Credential $credentials

    $myJson = ConvertFrom-Json $response

    foreach ($item in $myJson)
    {
        if (!(Test-Path "$($OutputPath)/$($item.name)" -PathType Leaf))
        {
            & "$PSScriptRoot\get.ps1" -Url "$($Url)/$($item.name)" -OutputPath $OutputPath -Username $Username -Password "$Password"
        }
    }

    Write-Host "Finished sync."
}
catch {
    Write-Error "Error: $_"
    throw $_
}