function VerifyXMLPreandPostXMLs
{
    Param(
    [Parameter(Mandatory)]
    [string] $folder,
    [Parameter(Mandatory)]
    [string] $folderPath)
    Write-Verbose "Attempting to verify $folder on path $folderPath"
    if((Test-Path -Path "$folderPath\$folder\PreChecks.xml" -PathType Leaf) -and (Test-Path -Path "$folderPath\$folder\PostChecks.xml" -PathType Leaf)){
        Write-Verbose "Path Found $folderPath\$folder"
        return $true
    }else{
        Write-Verbose "NO Path Found $folderPath\$folder"
        return $false
    }
}

function GetXMLHostFiles
{
    Param(
    [Parameter(Mandatory)]
    [string] $folderPath)

    $folders = Get-ChildItem $folderPath
    Write-Verbose "Found folders: $folders"
    $serverList = @()
    foreach($folder in $folders.Name){
        #$result = VerifyXMLPreandPostXMLs $folder
        if(VerifyXMLPreandPostXMLs $folder $folderPath)
        {
            $serverList += $folder
        }
    }
    return $serverList
}