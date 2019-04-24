Write-Host "Building from '$PSScriptRoot'" -ForegroundColor Yellow
$BuildPath = Join-Path $PSScriptRoot "build"
$SourcePath = Join-Path $PSScriptRoot "src"
$SourceModuleManifestPath = Join-Path $SourcePath "PSArtifactory.psd1"
$DestModuleManifestPath = Join-Path $BuildPath "PSArtifactory.psd1"


if(-not (Test-Path -Path $BuildPath)){
    Write-Output "Creating build directory '$BuildPath'"
    $null = New-Item -ItemType Directory -Path $PSScriptRoot -Name "build" -Force | Out-Null

}

$PSModulePath = Join-Path $BuildPath "PSArtifactory.psm1"
if(Test-Path $PSModulePath){
    Remove-Item -Path $PSModulePath
    # $null = New-Item -Path $BuildPath -Name "PSArtifactory.psm1" | Out-Null
}

if(Test-Path  (Join-Path $SourcePath "PSArtifactory.psm1")){
    Get-Content -Raw -Path (Join-Path $SourcePath "PSArtifactory.psm1") | Out-File -Path (Join-Path $BuildPath "PSArtifactory.psm1")
}

$ScriptPath = @(
    (Join-Path $SourcePath "public")
    (Join-Path $SourcePath "private")
)

Get-ChildItem -Path $ScriptPath -Filter '*.ps1' -Recurse | ForEach-Object {
    Get-Content -Raw -Path $PSItem.FullName | out-File -Append $PSModulePath
}

# .______     _______. _______  .______       __  ____    ____  _______ 
# |   _  \   /       ||       \ |   _  \     |  | \   \  /   / |   ____|
# |  |_)  | |   (----`|  .--.  ||  |_)  |    |  |  \   \/   /  |  |__   
# |   ___/   \   \    |  |  |  ||      /     |  |   \      /   |   __|  
# |  |   .----)   |   |  '--'  ||  |\  \----.|  |    \    /    |  |____ 
# | _|   |_______/    |_______/ | _| `._____||__|     \__/     |_______|
                                                                      







# .______     _______. _______  
# |   _  \   /       ||       \ 
# |  |_)  | |   (----`|  .--.  |
# |   ___/   \   \    |  |  |  |
# |  |   .----)   |   |  '--'  |
# | _|   |_______/    |_______/ 

$FunctionsToExport = (Get-ChildItem -Path (Join-Path $SourcePath "public") -Filter '*.ps1' -Recurse).BaseName
Copy-Item -Path $SourceModuleManifestPath -Destination $BuildPath -Force
$ModuleManifest = Test-ModuleManifest -Path $SourceModuleManifestPath


$Version = [Version]::new($ModuleManifest.Version.Major,$ModuleManifest.Version.Minor, $ModuleManifest.Version.Build + 1)

Update-ModuleManifest -Path $DestModuleManifestPath -FunctionsToExport $FunctionsToExport -ModuleVersion $Version 
Update-ModuleManifest -Path $SourceModuleManifestPath -ModuleVersion $Version 
