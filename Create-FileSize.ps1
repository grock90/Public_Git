<#
.Synopsis
   Use PowerShell to generate files of users specified size
.DESCRIPTION
   This script is used to create files of a specified size.  The files generated are saved to
   c:\builds.
.EXAMPLE
   The following examples will generate files of a specifid size: 

   Generate a 10KB file
   .\Create-FileSize.ps1 -size 10KB
   
   Generate a 10MB file
   .\Create-FileSize.ps1 -size 10MB

	Generates a 1GB file
	.\Create-FileSize.ps1 -size 1GB
#>

[CmdletBinding()]
param(
    [Parameter(Position=0, mandatory=$true)]
	$filesize    
)

$time = Get-Date

$filename = "myfile_" + $filesize + ".txt"
$file = new-object System.IO.FileStream C:\Build\$filename, Create, ReadWrite
$file.SetLength($filesize)
$file.Close()

Write-Host ("`nFile " + $filename + " was created in C:\Build")

