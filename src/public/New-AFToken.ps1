Function New-AFToken{
    param(
        # Parameter help description
        [Parameter()]
        [String][Alias("AccessKey","UserName")]
        $Subject = ([Guid]::newGuid().Guid),

        # Parameter help description
        [Parameter()]
        [String]
        $ExpirySec = 3600,

        # Parameter help description
        [Parameter()]
        [switch]
        $Refreshable,

        # Parameter help description
        [Parameter()]
        [string[]]
        $GroupName = @("readers")
    )

    $Body = @{
        username = $Subject
        scope = "member-of-groups:$($GroupName -join ',')"
        expires_in = $ExpirySec
    }

    if($Refreshable) { $Body += @{ refreshable = $true} }
    
    Invoke-AFApi -Path '/security/token' -Method Post -Body $Body -ContentType 'application/x-www-form-urlencoded'
}