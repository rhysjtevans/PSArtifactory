Function Remove-AFItem {
    param(
        # Parameter help description
        [Parameter()]
        [String]
        $Repository = (Get-AFContext).Repository,

        # Parameter help description
        [Parameter(Mandatory)]
        [String]
        $Uri
    )
    if($Repository -eq $null){
        throw "Reposiotry null. Configure using Set-AFContext -Repository 'RepositoryName' -APIUri ..."
    }
    $Uri = "/$Repository$Uri"
    Invoke-AFRequest -Path $Uri -Method Delete
}