Function Get-AFCredentialPath {
    
    (Join-Path (Join-Path $HOME ".PSArtifactory") "credential")

}