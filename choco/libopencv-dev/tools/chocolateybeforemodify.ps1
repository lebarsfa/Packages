$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

if (Test-Path "C:\OpenCV$OpenCVVer") {
    Remove-Item -Recurse -Force "C:\OpenCV$OpenCVVer"
}

if (Test-Path $CMakeRegistryPath) {
  if (Test-Path $CMakeSystemRepositoryPath) {
      Remove-Item "$CMakeSystemRepositoryPath\$CMakePackageName"
  }
}

$newpath = [environment]::GetEnvironmentVariable("Path","Machine")
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "C:\OpenCV$OpenCVVer\$MinGWArch\mingw\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "C:\OpenCV$OpenCVVer\x86\vc$VSVer\bin" }) -join ';'
[environment]::SetEnvironmentVariable("Path",$newpath,"Machine")
