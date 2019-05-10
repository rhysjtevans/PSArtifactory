Function New-KubeConf{
    param(
        [Parameter(Mandatory)]
        [String]
        $ClusterName,
        
        [Parameter(Mandatory)]
        [String]
        $Server,
        
        [Parameter(Mandatory)]
        [String[]]
        $Namespace,

        [Parameter(Mandatory)]
        [String]
        $CACert,

        [Parameter(Mandatory)]
        [String]
        $Token
    )
    
    $CredId = [Guid]::NewGuid().guid
    & kubectl config set-credentials $CredId --token=$Token
    
    foreach($ns in $Namespace){
        $ContextName = "$($ClusterName)://$ns"
        Write-Verbose "Creating $ContextName"
        & kubectl config set clusters.$($ContextName).certificate-authority-data $CACert
        & kubectl config set-cluster $ContextName --server=$Server
        & kubectl config set-context $ContextName --cluster=$ContextName --user=$CredId --namespace $ns
    }
}
