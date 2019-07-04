Function Get-AFCredential {
    [cmdletbinding()]
    param()

    # Write-Verbose "The full key is not returned for security!"
    # Write-Host $script:AFCredential.Credential.GetNetworkCredential().Password
    # if(-not $script:AFCredential){
    #     throw "No credentials found! Try running Set-AFCredential"
    # }else{
    #     Write-Verbose "Found Credentials of type $($script:AFCredential.CredentialType)"
    # }
    $Credential = Get-Content -Raw -Path (Get-AFCredentialPath) | ConvertFrom-Json
    
    $SecPassword = ConvertTo-SecureString $Credential.Credential.Password -AsPlainText -Force
    $PSCred = New-Object System.Management.Automation.PsCredential($Credential.Credential.Username, $SecPassword)
    $Credential.Credential = $PSCred
    $Credential
}