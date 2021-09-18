if ((Get-ProcessorBits 32) -or $env:ChocolateyForceX86 -eq $true) { $MinGWArch = "x86" } else { $MinGWArch = "x64" }
$MinGWMVer = "8"
$VSVer = "15"
$OpenCVVer = "4.2.0"
$CMakeRegistryPath = "HKCU:\SOFTWARE\Kitware\CMake"
$CMakeSystemRepositoryPath = "HKLM:\SOFTWARE\Kitware\CMake\Packages"
$CMakePackageName = "OpenCV"
