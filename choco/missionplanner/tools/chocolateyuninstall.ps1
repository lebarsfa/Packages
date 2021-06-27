$ErrorActionPreference = 'Stop'

Uninstall-BinFile -Name MissionPlanner

# Remove the start menu shortcut
$startMenu = [System.Environment]::GetFolderPath('Programs')
if (Test-Path "$startMenu\Mission Planner.lnk") {
  Remove-Item -Force "$startMenu\Mission Planner.lnk"
}
