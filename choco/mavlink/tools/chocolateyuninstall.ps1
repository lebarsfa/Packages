$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

if (Test-Path $CMakeRegistryPath) {
  if (Test-Path $CMakeSystemRepositoryPath\$CMakePackageName) {
      Remove-Item "$CMakeSystemRepositoryPath\$CMakePackageName"
  }
}

[environment]::SetEnvironmentVariable("MAVLINK_SDK_DIR",$null,"Machine")
