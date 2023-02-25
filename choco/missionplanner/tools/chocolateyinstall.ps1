﻿$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$pp = Get-PackageParameters
# To match .msi (which cannot be easily automated due to prompts related to drivers) default install location
if ((Get-ProcessorBits 32) -or $env:ChocolateyForceX86 -eq $true) { $installDir = ${env:ProgramFiles} } else { $installDir = ${env:ProgramFiles(x86)} }
if ($pp.InstallDir -or $pp.InstallationPath) { 
	$installDir = $pp.InstallDir + $pp.InstallationPath 
}
Write-Host "Mission Planner is going to be installed in '$installDir'"

$root = Join-Path $installDir "Mission Planner"
New-Item -ItemType Directory -Force -Path $root | Out-Null

$url = 'http://firmware.ardupilot.org/Tools/MissionPlanner/MissionPlanner-1.3.79.zip'
$checksum = 'F7C20B87B2046BC3AEB1D1050CDBCB1BDC79F1A38D6CE7392CCFB545E21E94D3'
$packageArgs = @{
	packageName   = $env:ChocolateyPackageName
	unzipLocation = "$root"
	url           = $url
	checksum      = $checksum
	checksumType  = 'sha256'
}
Install-ChocolateyZipPackage @packageArgs

$MissionPlanner = $null

Get-ChildItem $root -Include "*.exe" -Recurse | ForEach-Object {
  if ($_.Name -eq "MissionPlanner.exe") {
    Set-Content -Value "" -LiteralPath "$($_.FullName).gui"
    $MissionPlanner = $_.FullName
  }
  else {
    Set-Content -Value "" -LiteralPath "$($_.FullName).ignore"
  }
}

Install-BinFile -UseStart -Name 'MissionPlanner' -Path "$root\MissionPlanner.exe"

if ($MissionPlanner) {
  # Because chocolatey targets 4.0, we are able to use 'Programs' in the 'GetFolderPath'
  $programs = [System.Environment]::GetFolderPath("Programs")
  Install-ChocolateyShortcut -shortcutFile "$programs\Mission Planner.lnk" -targetPath $MissionPlanner
} else {
  Write-Warning "Unable to find Mission Planner executable, skipping start menu shortcut creation!"
}
