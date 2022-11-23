$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

if (Test-Path "$env:SystemDrive\OpenCV$OpenCVVer") {
    Remove-Item -Recurse -Force "$env:SystemDrive\OpenCV$OpenCVVer"
}

if (Test-Path $CMakeRegistryPath) {
  if (Test-Path $CMakeSystemRepositoryPath\$CMakePackageName) {
      Remove-Item "$CMakeSystemRepositoryPath\$CMakePackageName"
  }
}

$newpath = [environment]::GetEnvironmentVariable("Path","Machine")
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x86\mingw\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x64\mingw\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x86\vc8\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x64\vc8\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x86\vc9\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x64\vc9\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x86\vc10\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x64\vc10\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x86\vc11\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x64\vc11\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x86\vc12\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x64\vc12\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x86\vc14\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x64\vc14\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x86\vc15\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x64\vc15\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x86\vc16\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x64\vc16\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x86\vc17\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x64\vc17\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x86\vc18\bin" }) -join ';'
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$env:SystemDrive\OpenCV$OpenCVVer\x64\vc18\bin" }) -join ';'
[environment]::SetEnvironmentVariable("Path",$newpath,"Machine")
