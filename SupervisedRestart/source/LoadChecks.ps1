function LoadPreChecksFromXML
{
    Param(
    [Parameter(Mandatory)]
    [string] $xmlFile)
    Write-Verbose "Loading the config information from $xmlFile"
    [xml]$prechecks = Get-Content -Path $xmlFile
    return $prechecks.Prechecks
}

function LoadPostChecksFromXML($xmlFile)
{
    Write-Host "Loading the config information from $xmlFile"
    [xml]$prechecks = Get-Content -Path $xmlFile
    return $prechecks.PostChecks
}