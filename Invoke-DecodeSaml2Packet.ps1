<#
.Synopsis
   Decode a Saml2 encrypted packet to determine certificate value
.DESCRIPTION
   Given a Saml2 encoded packet, decode packet and expose the Signature and EncryptionMethod
.EXAMPLE
   Invoke-DecodeSame2Packet.ps1 -SamlResponse "SamlResponsePacketHere" -HttpCertSubject 'myTestCert'
#>

Param(
    [Parameter(Mandatory=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=0)]
    [ValidateNotNull]
    $SAMLResponse, 
    
    [Parameter(Mandatory=$true,
            ValueFromPipelineByPropertyName=$true,
            Position=1)]
    [ValidateNotNull]
    $HttpCertSubject
    
)

function Get-Base64DecodedResponse{
    
    [xml]$DecodedResponse = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($SAMLResponse))
     $DecodedResponse.Response
     Write-Host "Status: "  
     $DecodedResponse.Response.Status.StatusCode.Value
     Write-Host "`nSignatureMethod"
     $DecodedResponse.Response.Signature.SignedInfo.SignatureMethod
     Write-Host "`nEncryptionMethod"
     $DecodedResponse.Response.EncryptedAssertion.EncryptedData.EncryptionMethod
}