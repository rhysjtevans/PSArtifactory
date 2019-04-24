function Get-AFCredential {
    [cmdletbinding()]
    param()
    

    Write-Verbose "The full key is not returned for security!"
    Write-Output $script:AFCredential
}