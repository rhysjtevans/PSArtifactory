Function Ping-AFServer{
    param()
    if((Invoke-RestMethod -Method Get -Uri ($script:AFUri + '/system/ping')) -like "ok"){
        Write-Output $true
    }else {
        Write-Output $false
    }
}