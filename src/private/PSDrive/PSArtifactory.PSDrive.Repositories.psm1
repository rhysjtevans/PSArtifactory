class Repositories : SHiPSDirectory
{
    Repositories([string]$Name): base($Name)
    {

    }

    [object[]] GetChildItem()
    {
        return @()
    }
}