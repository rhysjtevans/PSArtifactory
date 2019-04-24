Function Get-AFSystemInfo{
    param()
    Invoke-AFApi -Path '/system'
}