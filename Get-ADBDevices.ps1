function Get-ADBDevices{
    #this will query for active and connected droid devices
    
    $adbDevices = adb devices 
    $strToTrim = "   device" 
    $Devices = @()
    foreach ($item in $adbDevices){$Devices = $Devices +$item.TrimEnd($strToTrim)}
    #exclude item
     

}
Get-ADBDevices
