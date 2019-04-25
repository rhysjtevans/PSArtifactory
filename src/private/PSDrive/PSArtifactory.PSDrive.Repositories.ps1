class RepositoryRoot: SHiPSDirectory
{
    
    RepositoryRoot([String]$Name): base($Name) #Implies Root Folder
    {

    }
    
    [object[]] GetChildItem()
    {
        return (Get-AFRepository) | ForEach-Object { 
            [RepositoryFolder]::new($PSItem.Name,$PSItem.Name)
        }
    }
}



# class Repository : SHiPSDirectory
# {
#     [string]$Name
#     [string]$Uri

#     Repository([string]$Name, [String]$Uri): base($Name)
#     {
#         $this.Name = $Name
#         $this.Uri = $Uri
#     }

#     [object[]] GetChildItem()
#     {
#         return (Get-RepoItems)
#     }
# }

Function Get-RepoItems {
    foreach($Item in Get-AFChildItem -Path $this.Path){
        foreach($Child in $Item.children){
            # Write-Host "Processing $($PSItem | ConvertTo-Json -Compress)"
            $Name = $Child.uri.split("/")
            $Name = $Name[$Name.Count-1]
            # Write-Host "NAME: $Name"
            if($Child.folder -eq $true){
                [RepositoryFolder]::new($Name, $this.Path + $Child.uri, $this.Repository ,$Item.uri + $Child.uri)
            }else{
                # [RepositoryFolder]::new($Name, $this.Path + $PSItem.uri)
                [RepositoryItem]::new($Name, $this.Path + $Child.uri, $this.Repository, $Item.uri + $Child.uri)
            }
        }
    }
    
    
}


Class RepositoryFolder: SHiPSDirectory
{
    [String]$Path = ""
    [String]$Uri = ""
    [String]$Repository = ""

    RepositoryFolder([String]$Name, [String]$Repository): base($Name) #Implies Root Folder
    {
        $this.Repository = $Repository
    }
    RepositoryFolder([String]$Name, [String]$Path, [String]$Repository,[String]$Uri): base($Name) #Implies Root Folder
    {
        $this.Path = $Path
        $this.Uri = $Uri
        $this.Repository = $Repository
    }
    [object[]] GetChildItem()
    {
        return (Get-RepoItems)
    }
    # [object] GetContent(){
        
    # }
}

class RepositoryItem : SHiPSLeaf {
    
    [String]$Key
    [String]$Path
    [String]$Uri
    [String]$Repository = ""

    RepositoryItem([String]$Key,[String]$Path, [String]$Repository, [String]$Uri):base($Key)
    {
        $this.Key = $Key
        $this.Path = $Path
        $this.Uri = $Uri
        $this.Repository = $Repository
    }

}
