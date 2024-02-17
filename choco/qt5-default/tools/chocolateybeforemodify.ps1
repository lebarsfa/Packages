$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

$newpath = [environment]::GetEnvironmentVariable("Path","Machine")
$newpath = ($newpath.Split(';') | Where-Object { $_ -ne "$QtSDKMinGWPath\bin" }) -join ';'
[environment]::SetEnvironmentVariable("Path",$newpath,"Machine")

try {
    Get-ItemProperty -Path "$CMakeSystemRepositoryPath\Qt" | Select-Object -ExpandProperty "qt$QtSDKMVer`_$QtSDKMMPVer`_win$MinGWArch`_mingw$MinGWMMVer" -ErrorAction Stop | Out-Null
    Remove-ItemProperty -Path "$CMakeSystemRepositoryPath\Qt" -Name "qt$QtSDKMVer`_$QtSDKMMPVer`_win$MinGWArch`_mingw$MinGWMMVer"
}
catch {

}
try {
    Get-ItemProperty -Path $CMakeSystemRepositoryPath\$CMakePackageName | Select-Object -ExpandProperty "qt$QtSDKMVer`_$QtSDKMMPVer`_win$MinGWArch`_mingw$MinGWMMVer" -ErrorAction Stop | Out-Null
    Remove-ItemProperty -Path $CMakeSystemRepositoryPath\$CMakePackageName -Name "qt$QtSDKMVer`_$QtSDKMMPVer`_win$MinGWArch`_mingw$MinGWMMVer"
}
catch {

}

if (Test-Path $QtSDKMinGWPath) {
    Remove-Item -Recurse -Force $QtSDKMinGWPath
}
