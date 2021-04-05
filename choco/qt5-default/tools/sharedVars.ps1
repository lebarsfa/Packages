if ((Get-ProcessorBits 32) -or $env:ChocolateyForceX86 -eq $true) { $MinGWArch = "32" } else { $MinGWArch = "64" }
$MinGWMMVer = "81"
$aqtVer = "1.1.4"
$QtSDKVer = "5.15.2"
$QtSDKRoot = "C:\Qt"
$QtSDKPath = "$QtSDKRoot\$QtSDKVer"
$QtSDKMinGWPath = "$QtSDKRoot\$QtSDKVer\mingw$MinGWMMVer`_$MinGWArch"
