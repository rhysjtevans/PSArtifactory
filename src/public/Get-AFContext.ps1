function Get-AFContext {
    Get-Content -Raw -Path (Get-AFContextPath) | ConvertFrom-Json
}