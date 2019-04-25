function Get-AFChildItem {
    param (
        # Parameter help description
        [Parameter()][ValidateNotNullOrEmpty()]
        [String]
        $Repository = (Get-AFContext).Repository,

        # Parameter help description
        [Parameter()]
        [Int32]
        $Depth = 10,

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
        $Uri = "/storage/$($Repository)$($Path)" #?includeRootPath=0&deep=0&depth=$Depth&mdTimestamps=1&listFolders=$listFolders"
    }else{
        $Uri = "/storage/$($Repository)" #?includeRootPath=0&deep=0&depth=$Depth&mdTimestamps=1&listFolders=$listFolders"
    }
    Invoke-AFApi -Path $Uri
    # $Results  
    # $Results
}