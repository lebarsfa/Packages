if ((Get-ProcessorBits 32) -or $env:ChocolateyForceX86 -eq $true) { $arch = "x86" } else { $arch = "x64" }
$MinGWMVer = "8"
$OpenCVVer = "4.2.0"
$CMakeRegistryPath = "HKCU:\SOFTWARE\Kitware\CMake"
$CMakeSystemRepositoryPath = "HKLM:\SOFTWARE\Kitware\CMake\Packages"
$CMakePackageName = "OpenCV"
