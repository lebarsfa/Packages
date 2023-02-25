$ErrorActionPreference = 'Stop'

$pp = Get-PackageParameters
# To match .msi (which cannot be easily automated due to prompts related to drivers) default install location
if ((Get-ProcessorBits 32) -or $env:ChocolateyForceX86 -eq $true) { $installDir = ${env:ProgramFiles} } else { $installDir = ${env:ProgramFiles(x86)} }
if ($pp.InstallDir -or $pp.InstallationPath) { 
	$installDir = $pp.InstallDir + $pp.InstallationPath 
}
Write-Host "Mission Planner is going to be uninstalled from '$installDir'"

$root = Join-Path $installDir "Mission Planner"

# Remove the start menu shortcut
$startMenu = [System.Environment]::GetFolderPath('Programs')
if (Test-Path "$startMenu\Mission Planner.lnk") {
  Remove-Item -Force "$startMenu\Mission Planner.lnk"
}

Uninstall-BinFile -Name MissionPlanner

if (Test-Path $root) {
    Remove-Item -Recurse -Force $root
}
