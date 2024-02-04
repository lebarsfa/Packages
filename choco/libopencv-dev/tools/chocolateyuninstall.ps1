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

$newpath = [environment]::GetEnvironmentVariable("Path","Machine")
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x86\mingw\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x64\mingw\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x86\vc8\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x64\vc8\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x86\vc9\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x64\vc9\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x86\vc10\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x64\vc10\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x86\vc11\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x64\vc11\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x86\vc12\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x64\vc12\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x86\vc14\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x64\vc14\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x86\vc15\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x64\vc15\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x86\vc16\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x64\vc16\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x86\vc17\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x64\vc17\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x86\vc18\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$root\x64\vc18\bin" }) -join ';'
[environment]::SetEnvironmentVariable("Path",$newpath,"Machine")

try {
    Get-ItemProperty -Path $CMakeSystemRepositoryPath\$CMakePackageName | Select-Object -ExpandProperty $CMakePackageName$CMakePackageVer -ErrorAction Stop | Out-Null
    Remove-ItemProperty -Path $CMakeSystemRepositoryPath\$CMakePackageName -Name $CMakePackageName$CMakePackageVer
}
catch {

}

if (Test-Path $root) {
    if ((Resolve-Path $root).Path -notcontains (Resolve-Path $packageDir).Path) {
        Remove-Item -Recurse -Force $root
    }
}
