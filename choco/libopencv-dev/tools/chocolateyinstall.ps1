$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Get-Item $toolsDir\*.zip

$pp = Get-PackageParameters
$installDir = "C:"
# How to uninstall from custom location...?
#$installDir = Get-ToolsLocation
#if ($pp.InstallDir -or $pp.InstallationPath) { $InstallDir = $pp.InstallDir + $pp.InstallationPath }
Write-Host "OpenCV$OpenCVVer is going to be installed in '$installDir'"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$installDir"
  file          = $fileLocation
}

Install-ChocolateyZipPackage @packageArgs

Remove-Item $toolsDir\*.zip -ea 0 -force

New-Item "$CMakeSystemRepositoryPath\$CMakePackageName" -ItemType directory -Force
New-ItemProperty -Name "CMakePackageDir" -PropertyType String -Value "$installDir\OpenCV$OpenCVVer" -Path "$CMakeSystemRepositoryPath\$CMakePackageName" -Force

# Package parameter to specify a version of Visual Studio...?
$newpath = [environment]::GetEnvironmentVariable("Path","Machine") + ";$installDir\OpenCV$OpenCVVer\$MinGWArch\mingw\bin;$installDir\OpenCV$OpenCVVer\x86\vc$VSVer\bin"
[environment]::SetEnvironmentVariable("Path",$newpath,"Machine")
