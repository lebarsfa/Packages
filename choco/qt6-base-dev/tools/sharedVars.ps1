if ((Get-ProcessorBits 32) -or $env:ChocolateyForceX86 -eq $true) { $MinGWArch = "32" } else { $MinGWArch = "64" }
$MinGWMMVer = "112"
$QtSDKVer = "6.2.4"
$QtSDKRoot = "C:\Qt"
$QtSDKPath = "$QtSDKRoot\$QtSDKVer"
# Unknown MinGW version for the 6.2.4 binaries...?
$QtSDKMinGWPath = "$QtSDKRoot\$QtSDKVer\mingw_$MinGWArch"
#$QtSDKMinGWPath = "$QtSDKRoot\$QtSDKVer\mingw$MinGWMMVer`_$MinGWArch"
