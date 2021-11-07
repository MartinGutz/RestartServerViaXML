Describe "Check on the XML files" {
    BeforeAll {
        . .\source\VerifyHostXMLs.ps1
        $testPath = "TestDrive:\XMLFiles"
        New-Item -Path $testPath -Name "SERVERNAME" -ItemType "directory"
        Set-Content -Path "$testPath\SERVERNAME\Prechecks.xml" -Value 'test' 
        Set-Content -Path "$testPath\SERVERNAME\PostChecks.xml" -Value 'test' 
        New-Item -Path $testPath -Name "SERVERNAME2" -ItemType "directory"
        Set-Content -Path "$testPath\SERVERNAME2\PostChecks.xml" -Value 'test' 
    }

    It 'XML file should exist' {
        ".\config\SAMPLESERVER\PreChecks.xml" | Should -Exist 
        ".\config\SAMPLESERVER\PostChecks.xml" | Should -Exist 
    }

    It 'Verify Function returns Server names' {
        $serverNames = GetXMLHostFiles $testPath -Verbose
        Write-Host "ServerName: $serverNames"
        $serverNames | Should -Contain 'SERVERNAME'
    }

    It 'Verify Function does not find ServerName 2' {
        $serverNames = GetXMLHostFiles $testPath -Verbose
        Write-Host "ServerName: $serverNames"
        $serverNames | Should -Not -Contain 'SERVERNAME2'
    }
}