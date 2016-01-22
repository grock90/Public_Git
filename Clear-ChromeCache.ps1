function Clear-ChromeCache{ 
    Stop-Process -Name chrome -ErrorAction Ignore
    Stop-Process -Name chromedriver -ErrorAction Ignore
    Start-Sleep -Milliseconds 500
    $Items = @('Application Cache',
                     'Cache*',
                     'Cookies',
                     'History',
                     'Login Data',
                     'Top Sites',
                     'Visited Links',
                     'Web Data')
    $Folder = "$env:LOCALAPPDATA\Google\Chrome\User Data\Default" 
    $Items | % { 
        $FilePath = Join-Path -Path $Folder -ChildPath $_
        if((Test-Path -Path "$FilePath")){
            Remove-Item "$FilePath" -Recurse -Force
        }
    }
}

Clear-ChromeCache