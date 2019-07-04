Function Clear-AFCredential {
    Remove-Item -Path (Get-AFCredentialPath) -Force
}