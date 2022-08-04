$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$pp = Get-PackageParameters
$installDir = "C:"
# How to uninstall from custom location...?
#$installDir = Get-ToolsLocation
#if ($pp.InstallDir -or $pp.InstallationPath) { $InstallDir = $pp.InstallDir + $pp.InstallationPath }
Write-Host "OpenCV$OpenCVVer is going to be installed in '$installDir'"

$root = Join-Path "$installDir" "OpenCV$OpenCVVer"
New-Item -ItemType Directory -Force -Path $root | Out-Null

if (!$pp['url']) { 
	$url = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.2.0.20220804/libopencv-dev.4.2.0_x86_mingw8_staticlib_Release.exe'
	$checksum = '5694AE83B3137DB89353849B857D2DAE06225B62AFC6F32FB380575713CC2CB7'
	$url64 = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.2.0.20220804/libopencv-dev.4.2.0_x64_mingw8_staticlib_Release.exe'
	$checksum64 = 'F7809F5D15194E23F1D0BE6630D52CD966B0D3FF97743E541E94762F8D257801'
	if ($pp['32and64']) {
		$packageArgs = @{
			packageName   = $env:ChocolateyPackageName
			unzipLocation = "$root"
			url           = $url
			checksum      = $checksum
			checksumType  = 'sha256'
		}
		Install-ChocolateyZipPackage @packageArgs
		$packageArgs = @{
			packageName   = $env:ChocolateyPackageName
			unzipLocation = "$root"
			url64bit      = $url64
			checksum64    = $checksum64
			checksumType64= 'sha256'
		}
		Install-ChocolateyZipPackage @packageArgs
	}
	else
	{
		$packageArgs = @{
			packageName   = $env:ChocolateyPackageName
			unzipLocation = "$root"
			url           = $url
			url64bit      = $url64
			checksum      = $checksum
			checksumType  = 'sha256'
			checksum64    = $checksum64
			checksumType64= 'sha256'
		}
		Install-ChocolateyZipPackage @packageArgs
	}

	$url = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.2.0.20220804/libopencv-dev.4.2.0_x86_mingw8_lib_Release.exe'
	$checksum = 'CC7E2565F765AE327759AE8C4282C1447C05AF37F64433D9E4823CD756EE4C6C'
	$url64 = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.2.0.20220804/libopencv-dev.4.2.0_x64_mingw8_lib_Release.exe'
	$checksum64 = 'B37BEC2FEEEC5327DA2E44DD7C7577E86802FAE39F5778E6766B2F65AF690BFE'
	if ($pp['32and64']) {
		$packageArgs = @{
			packageName   = $env:ChocolateyPackageName
			unzipLocation = "$root"
			url           = $url
			checksum      = $checksum
			checksumType  = 'sha256'
		}
		Install-ChocolateyZipPackage @packageArgs
		$packageArgs = @{
			packageName   = $env:ChocolateyPackageName
			unzipLocation = "$root"
			url64bit      = $url64
			checksum64    = $checksum64
			checksumType64= 'sha256'
		}
		Install-ChocolateyZipPackage @packageArgs
	}
	else
	{
		$packageArgs = @{
			packageName   = $env:ChocolateyPackageName
			unzipLocation = "$root"
			url           = $url
			url64bit      = $url64
			checksum      = $checksum
			checksumType  = 'sha256'
			checksum64    = $checksum64
			checksumType64= 'sha256'
		}
		Install-ChocolateyZipPackage @packageArgs
	}

	$runtime = "mingw"
}
else
{
	$url = $pp['url']
	$checksum = $pp['sha256']
	$packageArgs = @{
		packageName   = $env:ChocolateyPackageName
		unzipLocation = "$root"
		url           = $url
		checksum      = $checksum
		checksumType  = 'sha256'
	}
	Install-ChocolateyZipPackage @packageArgs

	# Analyze url to guess what to add to Windows PATH...
	if ($url -match "x86") {
		$arch = "x86"
	}
	else {
		$arch = "x64"
	}
	if ($url -match "vc8") {
		$runtime = "vc8"
	}
	if ($url -match "vc9") {
		$runtime = "vc9"
	}
	elseif ($url -match "vc10") {
		$runtime = "vc10"
	}
	elseif ($url -match "vc11") {
		$runtime = "vc11"
	}
	elseif ($url -match "vc12") {
		$runtime = "vc12"
	}
	elseif ($url -match "vc14") {
		$runtime = "vc14"
	}
	elseif ($url -match "vc15") {
		$runtime = "vc15"
	}
	elseif ($url -match "vc16") {
		$runtime = "vc16"
	}
	elseif ($url -match "vc17") {
		$runtime = "vc17"
	}
	elseif ($url -match "vc18") {
		$runtime = "vc18"
	}
	else {
		$runtime = "mingw"
	}
}

if (!$pp['NoRegistry']) {
	New-Item "$CMakeSystemRepositoryPath\$CMakePackageName" -ItemType directory -Force
	New-ItemProperty -Name "CMakePackageDir" -PropertyType String -Value "$installDir\OpenCV$OpenCVVer" -Path "$CMakeSystemRepositoryPath\$CMakePackageName" -Force
}
$pathtoadd = "$installDir\OpenCV$OpenCVVer\$arch\$runtime\bin"
if (!($pp['NoPath']) -and !([environment]::GetEnvironmentVariable("Path","Machine") -match [regex]::escape($pathtoadd))) {
	$newpath = [environment]::GetEnvironmentVariable("Path","Machine") + ";$pathtoadd"
	[environment]::SetEnvironmentVariable("Path",$newpath,"Machine")
}
