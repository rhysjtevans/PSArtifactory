Function Get-AFFile{
    param(
        # Parameter help description
        [Parameter(Mandatory)]
        [String]
        $AFPath,

        # Parameter help description
        [Parameter(Mandatory)]
        [String]
        $LocalPath
    )
    Invoke-AFRequest -OutFile $LocalPath -Path $AFPath
}