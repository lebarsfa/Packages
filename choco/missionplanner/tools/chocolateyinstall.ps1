$ErrorActionPreference = 'Stop'

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$fileLocation = Get-Item $toolsDir\*.msi

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType       = 'MSI'
  file           = $fileLocation
  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes= @(0, 3010, 1641)
  softwareName   = 'Mission Planner*'
}

Install-ChocolateyInstallPackage @packageArgs

Remove-Item $toolsDir\*.msi -ea 0 -force

$installLocation = Get-AppInstallLocation $packageArgs.softwareName
if (!$installLocation) { Write-Warning "Can't find Mission Planner install location"; return }
Write-Host "Mission Planner installed to '$installLocation'"

Install-BinFile 'MissionPlanner' $installLocation\MissionPlanner.exe
