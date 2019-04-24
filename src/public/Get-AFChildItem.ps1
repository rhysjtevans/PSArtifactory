function Get-AFChildItem {
    param (
        # Parameter help description
        [Parameter()][ValidateNotNullOrEmpty()]
        [String]
        $Repository = ($script:AFServer.Repository),

        # Parameter help description
        [Parameter()]
        [Int32]
        $Depth = 1,

        # Parameter help description
        [Parameter()]
        [switch]
        $IncludeFolders,

        # Parameter help description
        [Parameter()]
        [String]
        $Path
    )
    $listFolders = 0
    if($IncludeFolders){$listFolders = 1}
    if($Path){
        $Uri = "/storage/$($Repository)$($Path)?list&includeRootPath=0&deep=1&depth=$Depth&mdTimestamps=1&listFolders=$listFolders"
    }else{
        $Uri = "/storage/$($Repository)?list&includeRootPath=0&deep=1&depth=$Depth&mdTimestamps=1&listFolders=$listFolders"
    }
    $Results = Invoke-AFApi -Path $Uri
    $Results.files
}