$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

$pp = Get-PackageParameters
$installDir = $env:SystemDrive
if ($pp.InstallDir -or $pp.InstallationPath) { 
	$installDir = $pp.InstallDir + $pp.InstallationPath 
}
Write-Host "OpenCV$OpenCVVer is going to be uninstalled from '$installDir'"

$root = Join-Path $installDir "OpenCV$OpenCVVer"

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

if (Test-Path $CMakeRegistryPath) {
  if (Test-Path $CMakeSystemRepositoryPath\$CMakePackageName) {
      Remove-Item "$CMakeSystemRepositoryPath\$CMakePackageName"
  }
}

if (Test-Path $root) {
    Remove-Item -Recurse -Force $root
}
