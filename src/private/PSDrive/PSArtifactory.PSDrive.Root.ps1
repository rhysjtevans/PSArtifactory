class Root : SHiPSDirectory
{
    Root([string]$Name): base($Name)
    {
        $Credential = Get-AFCredential
        $Context = Get-AFContext
    }

    [object[]] GetChildItem()
    {
        return @(
            [RepositoryRoot]::new("Repositories"),
            [RepositoryRoot]::new("Users")
        )
    }
}


# class Root : SHiPSDirectory
# {
#     Root([string]$Name): base($Name){
        
#     }

#     [object[]] GetChildItem()
#     {
#         return @(Get-RootFolders)
#     }
# }
# Function Get-RootFolders(){
#     $RootFolders.Values
# }
# $Script:RootFolders = @(
#     Repositories = [Repositories]::new(),
#     Users = [Repositories]::new()
# )