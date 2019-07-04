Function Get-AFContextPath {
    (Join-Path (Join-Path $HOME ".PSArtifactory") "context")
}