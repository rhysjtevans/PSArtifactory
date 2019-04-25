Function Remove-AFItem {
    param(
        # Parameter help description
        [Parameter()]
        [String]
        $Repository = ($script:AFContext.Repository),

        # Parameter help description
        [Parameter(Mandatory)]
        [String]
        $Uri
    )
    if($Repository -eq $null){
        throw "Reposiotry null. Configure using Set-AFServer -Repository 'RepositoryName'"
    }
    $Uri = "/$Repository$Uri"
    Invoke-AFRequest -Path $Uri -Method Delete
}