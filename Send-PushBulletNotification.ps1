Param(
    
    [Parameter(Mandatory=$true)]
    [string] $Message,

    [Parameter(Mandatory=$true)]
    [string] $Title,
    
    [Parameter(Mandatory=$false)]
    [string] $AccessToken = "YOUR_PUSHBULLET_TOKEN",
    
    [Parameter(Mandatory=$false)]
    [string] $EmailAddress = "YOUR EMAIL ADDRESS USED BY PUSHBULLERT"   
)

$Header = @{}
$Header.Add('Access-Token',"$AccessToken")
$Header.Add('Content-Type','application/json')

$Body = [PSCustomObject]@{  
        body = "$Message"
        title = "$Title"
        type = "note"
}
$Payload = $Body | ConvertTo-Json

$PushBulletMe = Invoke-RestMethod -Method Get -Uri "https://api.pushbullet.com/v2/users/me" -Headers $Header
if($PushBulletMe.email -eq "$EmailAddress"){
    Write-Host "Session is Active: Sending New Message"
    $PushNotification = Invoke-RestMethod -Method Post -Uri "https://api.pushbullet.com/v2/pushes" -Headers $Header -Body $Payload
    if($PushNotification.dismissed -ne $true){
        Write-Host "Message Sent : $Title "
    }
 }