$GetThumbPrints = (Get-ChildItem Cert:\LocalMachine\My)
foreach($thumbP in $GetThumbPrints){
    $thumbP.Archived
    $thumbP.FriendlyName
    $thumbP.Name
    $thumbP.Certificates
    $thumbP.Handle
    $thumbP.Issuer
    $thumbP.IssuerName
    $thumbP.Certificates
}