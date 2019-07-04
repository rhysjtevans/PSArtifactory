function Get-AFChildItem {
    param (

        # Parameter help description
        [Parameter(Mandatory)]
        [String]
        $SourcePath,

        # Parameter help description
        [Parameter(Mandatory)]
        [String]
        $TargetPath,

        # Parameter help description
        [Parameter()]
        [Switch]
        $DryRun,

        # Parameter help description
        [Parameter()]
        [Int]
        $SuppressLayouts=1,

        # Parameter help description
        [Parameter()]
        [Switch]
        $FailFast
    )
    $Path = "/api/copy/$SourcePath?to=/$TargetPath"
    Invoke-AFApi -Path $Path -Method "POST"
}