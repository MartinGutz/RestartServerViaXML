function LoadPreChecksFromXML
{
    Param(
    [Parameter(Mandatory)]
    [string] $xmlFile)
    Write-Verbose "Loading the config information from $xmlFile"
    [xml]$prechecks = Get-Content -Path $xmlFile
    Write-Verbose "Found Prechecks: $($prechecks.Prechecks)"
    return $prechecks.Prechecks
}

function LoadPostChecksFromXML
{
    Param(
    [Parameter(Mandatory)]
    [string] $xmlFile)
    Write-Verbose "Loading the config information from $xmlFile"
    [xml]$prechecks = Get-Content -Path $xmlFile
    Write-Verbose "Found Prechecks: $($prechecks.PostChecks)"
    return $prechecks.PostChecks
}