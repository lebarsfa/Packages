# Some of these variables might not be used in links to simplify parsing of files...
if ((Get-ProcessorBits 32) -or $env:ChocolateyForceX86 -eq $true) { $arch = "x86" } else { $arch = "x64" }
$MinGWMVer = "11"
$OpenCVVer = "4.5.4"
$CMakeRegistryPath = "HKCU:\SOFTWARE\Kitware\CMake"
$CMakeSystemRepositoryPath = "HKLM:\SOFTWARE\Kitware\CMake\Packages"
$CMakePackageName = "OpenCV"
