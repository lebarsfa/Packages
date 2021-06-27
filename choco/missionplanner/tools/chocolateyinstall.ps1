$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Get-Item $toolsDir\*.zip

$pp = Get-PackageParameters
$installDir = $toolsDir
# How to uninstall from custom location...?
#$installDir = Get-ToolsLocation
#if ($pp.InstallDir -or $pp.InstallationPath) { $InstallDir = $pp.InstallDir + $pp.InstallationPath }
Write-Host "Mission Planner is going to be installed in '$installDir\$env:ChocolateyPackageName'"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$installDir\$env:ChocolateyPackageName"
  file          = $fileLocation
}

Install-ChocolateyZipPackage @packageArgs

Remove-Item $toolsDir\*.zip -ea 0 -force

$MissionPlanner = $null

Get-ChildItem "$installDir\$env:ChocolateyPackageName" -Include "*.exe" -Recurse | ForEach-Object {
  if ($_.Name -eq "MissionPlanner.exe") {
    Set-Content -Value "" -LiteralPath "$($_.FullName).gui"
    $MissionPlanner = $_.FullName
  }
  else {
    Set-Content -Value "" -LiteralPath "$($_.FullName).ignore"
  }
}

Install-BinFile -UseStart -Name 'MissionPlanner' -Path "$installDir\$env:ChocolateyPackageName\MissionPlanner.exe"

if ($MissionPlanner) {
  # Because chocolatey targets 4.0, we are able to use 'Programs' in the 'GetFolderPath'
  $programs = [System.Environment]::GetFolderPath("Programs")
  Install-ChocolateyShortcut -shortcutFile "$programs\Mission Planner.lnk" -targetPath $MissionPlanner
} else {
  Write-Warning "Unable to find Mission Planner executable, skipping start menu shortcut creation!"
}
