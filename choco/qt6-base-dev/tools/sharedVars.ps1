if ((Get-ProcessorBits 32) -or $env:ChocolateyForceX86 -eq $true) { $MinGWArch = "32" } else { $MinGWArch = "64" }
$MinGWMMVer = "112"
$QtSDKVer = "6.4.2"
$QtSDKMVer = "6"
$QtSDKMMPVer = "642"
$QtSDKRoot = "C:\Qt"
$QtSDKPath = "$QtSDKRoot\$QtSDKVer"
# Unknown MinGW version for the 6.4.2 binaries...?
$QtSDKMinGWPath = "$QtSDKRoot\$QtSDKVer\mingw_$MinGWArch"
#$QtSDKMinGWPath = "$QtSDKRoot\$QtSDKVer\mingw$MinGWMMVer`_$MinGWArch"
$CMakeRegistryPath = "HKCU:\SOFTWARE\Kitware\CMake"
$CMakeSystemRepositoryPath = "HKLM:\SOFTWARE\Kitware\CMake\Packages"
$CMakePackageName = "Qt$QtSDKMVer"
