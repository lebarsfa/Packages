$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

if (Test-Path $QtSDKMinGWPath) {
    Remove-Item -Recurse -Force $QtSDKMinGWPath
}
