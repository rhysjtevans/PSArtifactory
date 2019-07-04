Function Ping-AFServer{
    [cmdletbinding()]
    param()
    $TargetUri = $script:AFContext.APIUri + '/system/ping'
    Write-Verbose "Pinging $TargetUri"

    if((Invoke-WebRequest -Method Get -Uri $TargetUri) -like "ok"){
        Write-Output $true
    }else {
        Write-Output $false
    }
}