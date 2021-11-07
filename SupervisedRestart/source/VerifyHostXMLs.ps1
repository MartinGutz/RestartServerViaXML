function VerifyXMLPreandPostXMLs($folder, $folderPath)
{
    #Write-Host "Attempting to verify $folder on path $folderPath"
    if((Test-Path -Path "$folderPath\$folder\PreChecks.xml" -PathType Leaf) -and (Test-Path -Path "$folderPath\$folder\PostChecks.xml" -PathType Leaf)){
        #Write-Host "Path Found $folderPath\$folder"
        return $true
    }else{
        #Write-Host "NO Path Found $folderPath\$folder"
        return $false
    }
}

function GetXMLHostFiles($folderPath)
{
    $folders = Get-ChildItem $folderPath

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