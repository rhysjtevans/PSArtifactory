function Get-AFToken {
    (Invoke-AFApi -Path '/security/token').tokens
}