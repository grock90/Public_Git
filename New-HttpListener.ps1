[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true,
                ValueFromPipelineByPropertyName=$true,
                Position=0)]
    $Url,

    [Parameter(Mandatory=$true,
                ValueFromPipelineByPropertyName=$true,
                Position=0)]
    [array]$ResponseStatusCodes

)


if($Url.Substring(($Url.Length - 1)) -cnotmatch '/'){
    $Url = $Url + "/"
}
function Start-HttpListener($statusCode){
    Begin{
        Write-Host -ForegroundColor Green "Listening to: `n$Url`nResponseCode: $StatusCode `nPress Ctrl+C to quit."
        $HttpListener = New-Object System.Net.HttpListener 
        $HttpListener.Prefixes.Add("$Url")
        $HttpListener.Start()
    }
    Process{
        $Context = $HttpListener.GetContext()
        $Request = $Context.Request
        if($Request.HasEntityBody){     
            #Build submitted request
            Write-Host -ForegroundColor Green "`nSubmitted Body:"
            $Body = $Request.InputStream
            $encoding = $Request.ContentEncoding
            $reader = New-Object System.IO.StreamReader($Body,$encoding)
            $request = $reader.ReadToEnd()
            $requestBody = $request #| ConvertFrom-Json
            $requestBody
        }
    }
    End{
            #Build Response
            Write-Host -ForegroundColor Green "`nResponse:"
            $Response = $Context.Response
            $Response.StatusCode = $statusCode
            $StringBuilder = New-Object System.Text.StringBuilder
            $Payload = [PSCustomObject]@{ 
                Date = (Get-Date).DateTime
                Method = $Context.Request.HttpMethod
                Destination = $Context.Request.Url
                Status = $Response.StatusCode
                Description = $Response.StatusDescription
            }
            $ResponsePayload = $Payload | ConvertTo-Json
            $ResponsePayload
            [array]$byte = [System.Text.Encoding]::UTF8.GetBytes($ResponsePayload)
            $Response.ClearContent
            $Response.ClearHeader
            $Response.ContentType = 'application/json'
            $Response.KeepAlive = 1000
            $Response.OutputStream.Write($byte,0,$byte.Length)
            $Response.OutputStream.EndWrite
            $Response.Close()
            $HttpListener.Stop()
    }
 }

 $x = 0
$ResponseStatusCodes | % { 
    Write-Host -ForegroundColor Yellow "Session: $x"
    Start-HttpListener -statusCode $_    
    $x++
}
