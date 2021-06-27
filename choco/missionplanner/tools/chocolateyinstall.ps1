$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Get-Item $toolsDir\*.zip

$pp = Get-PackageParameters
$installDir = $toolsDir
if ($pp.InstallDir -or $pp.InstallationPath ) { $InstallDir = $pp.InstallDir + $pp.InstallationPath }
Write-Host "Mission Planner is going to be installed in '$installDir'"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = "$toolsDir\$env:ChocolateyPackageName"
  file          = $fileLocation
}

Install-ChocolateyZipPackage @packageArgs

Remove-Item $toolsDir\*.zip -ea 0 -force

$MissionPlanner = $null

Get-ChildItem $packageArgs.unzipLocation -Include "*.exe" -Recurse | ForEach-Object {
  if ($_.Name -eq "MissionPlanner.exe") {
    Set-Content -Value "" -LiteralPath "$($_.FullName).gui"
    $MissionPlanner = $_.FullName
  }
  else {
    Set-Content -Value "" -LiteralPath "$($_.FullName).ignore"
  }
}

if ($MissionPlanner) {
  # Because chocolatey targets 4.0, we are able to use 'Programs' in the 'GetFolderPath'
  $programs = [System.Environment]::GetFolderPath("Programs")
  Install-ChocolateyShortcut -shortcutFile "$programs\Mission Planner.lnk" -targetPath $MissionPlanner
} else {
  Write-Warning "Unable to find Mission Planner executable, skipping start menu shortcut creation!"
}
