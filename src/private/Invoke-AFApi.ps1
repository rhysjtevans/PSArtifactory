function Invoke-AFApi {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Path,

        [Parameter()]
        [ValidateSet('Delete', 'Get', 'Post', 'Put')]
        [string]
        $Method = 'Get',

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [hashtable]
        $Headers = @{},

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $Accept,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [HashTable]
        $Body,

        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]
        $ContentType = 'application/x-www-form-urlencoded',


        [Parameter()]
        [ValidateSet("RepoUri","APIUri")]
        [string]
        $Uri = "APIUri"
    )

    $FullUri = (Get-AFServer).$Uri + "/api"
    
    $IwrParams = @{
        Uri     = $FullUri + $Path
        Method  = $Method
        ContentType = $ContentType
    }

    
    $Cred = Get-AFCredential
    
    switch ($Cred.CredentialType) {
        "Basic" { 
            Write-Verbose "BASIC AUTH USED"
            $IwrParams += @{ Credential = $Cred.Credential } 
        }
        "AccessToken" {
            Write-Verbose "BEARER AUTH USED"
            $IwrParams += @{ 
                Headers = @{ Bearer = $Cred.Credential.GetNetworkCredential().Password}
            }
        }
    }
    if($Body){
        $IwrParams += @{ Body = $Body}
    }

    #$IwrParams | ConvertTo-Json -Depth 4
    try{
        Invoke-RestMethod @IwrParams
    }
    catch {
        $_.Exception | ConvertTo-Json -Depth 1
    }
    
    
    
}
