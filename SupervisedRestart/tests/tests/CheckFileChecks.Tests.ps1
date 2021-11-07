Describe "File and Format Checks" {
    BeforeAll {
        . .\source\LoadChecks.ps1
        . .\source\actions\action-StopService.ps1
        . .\source\actions\action-CheckLog.ps1
        $checks = LoadPreChecksFromXML ".\config\SAMPLESERVER\PreChecks.xml" -Verbose
        Write-Host $checks
        $postChecks = LoadPostChecksFromXML ".\config\SAMPLESERVER\PostChecks.xml" -Verbose
    }

    It 'XML file should exist' {
        ".\config\SAMPLESERVER\PreChecks.xml" | Should -Exist 
    }

    It 'XML Loading should Run' {
        LoadPreChecksFromXML ".\config\SAMPLESERVER\PreChecks.xml" -Verbose
    }
     
    It 'CheckTypes should include StopService' {
        $services = LoadPreChecksFromXML ".\config\SAMPLESERVER\PreChecks.xml" -Verbose
        $services.Precheck.CheckType | Should -Contain 'StopService'
    }
     
    It 'Run the Stop Service for Each Service' {
        Write-Host "Prechecks: $checks "
        foreach($precheck in $checks.Precheck){
            if ($precheck.CheckType -eq 'StopService'){
                StopThisService $precheck.Name "SERVERNAME"
            }
        }
    }

    It 'CheckTypes should include SendEmail' {
        $services = LoadPreChecksFromXML ".\config\SAMPLESERVER\PreChecks.xml" -Verbose
        $services.Precheck.CheckType | Should -Contain 'SendEmail'
    }
    
    It 'PostCheck should contain Start Service' {
        $postChecks.PostCheck.CheckType | Should -Contain 'StartService'
    }

    It 'PostCheck should contain Check Log' {
        Write-Host "PostChecks: $postChecks "
        foreach($postCheck in $postChecks.Postcheck){
            if ($postCheck.CheckType -eq 'CheckLog'){
                CheckThelog $postCheck.LogLocation $postCheck.LogLine "SERVERNAME"
            }
        }
    }

}