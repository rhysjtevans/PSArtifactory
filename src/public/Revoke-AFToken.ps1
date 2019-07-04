function Revoke-AFToken{
    param(
        # Parameter help description
        [Parameter(Mandatory)]
        [String]
        $Id
    )
    $Body = @{
        token_id = $Id
    }
    Invoke-AFApi -Path '/security/token/revoke' -Method Post -Body $Body
}