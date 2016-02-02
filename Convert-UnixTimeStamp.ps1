<#
.Synopsis
   Converts a timestamp into a datetime value 
.DESCRIPTION
   When given a valid timestamp this tool will convert it
   to a human readable date time string. 
.EXAMPLE
   Convert-TimeStampToDateTime -Timestamp 1445031547
#>

[CmdletBinding()]
[OutputType([int])]
Param
(
    # Param1 help description
    [Parameter(Mandatory=$true,
                ValueFromPipelineByPropertyName=$true,
                Position=0)]
    [int]$Timestamp
)

function Convert-UnixDate($UnixTimeStamp){ 
    [datetime]$EpochTime = "1970-01-01 00:00:00"
    [timezone]::CurrentTimeZone.ToLocalTime($EpochTime).AddSeconds($UnixTimeStamp)
}

$ConvertedUnixTime = Convert-UnixDate -UnixTimeStamp $Timestamp 

Write-Host -BackgroundColor Green -ForegroundColor Black "Converted Unix Time: "   -Verbose
$ConvertedUnixTime
 
 