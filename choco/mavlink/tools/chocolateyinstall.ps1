$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Get-Item $toolsDir\*.zip

$pp = Get-PackageParameters
$installDir = $toolsDir

New-Item "$CMakeSystemRepositoryPath\$CMakePackageName" -ItemType directory -Force
New-ItemProperty -Name "CMakePackageDir" -PropertyType String -Value "$env:ChocolateyPackageFolder\share\cmake" -Path "$CMakeSystemRepositoryPath\$CMakePackageName" -Force

$newpath = "$installDir"
[environment]::SetEnvironmentVariable("MAVLINK_SDK_DIR",$newpath,"Machine")
