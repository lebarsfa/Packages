$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$pp = Get-PackageParameters
$packageDir = Join-Path "$toolsDir" ".." -Resolve
$installDir = $env:SystemDrive
if ($pp.InstallDir -or $pp.InstallationPath) { 
	$installDir = $pp.InstallDir + $pp.InstallationPath 
}
Write-Host "$CMakePackageName$CMakePackageVer is going to be uninstalled from '$installDir'"

$root = Join-Path $installDir "$CMakePackageName$CMakePackageVer"

$architectures = @('x86','x64','arm64')
$mingwNames = @('mingw') + (7..22 | ForEach-Object { "mingw$_" })
$vcNames    = @(8..22 | ForEach-Object { "vc$_" })
$runtimes = $mingwNames + $vcNames
if (Get-Command Uninstall-ChocolateyPath -ErrorAction SilentlyContinue -CommandType Function) {
    foreach ($arch in $architectures) {
        foreach ($runtime in $runtimes) {            
            Uninstall-ChocolateyPath "$root\$arch\$runtime\bin" -PathType 'Machine'
        }
    }
}
else {
    $newpath = [environment]::GetEnvironmentVariable("Path","Machine")
    foreach ($arch in $architectures) {
        foreach ($runtime in $runtimes) {            
            $newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\$arch\$runtime\bin" }) -join ';'
        }
    }
    [environment]::SetEnvironmentVariable("Path",$newpath,"Machine")
}

Remove-ItemProperty -Path $CMakeSystemRepositoryPath\$CMakePackageName -Name "$CMakePackageName$CMakePackageVer" -ErrorAction SilentlyContinue

if (Test-Path $root) {
    if ((Resolve-Path $root).Path -notcontains (Resolve-Path $packageDir).Path) {
        Remove-Item -Recurse -Force $root
    }
}
