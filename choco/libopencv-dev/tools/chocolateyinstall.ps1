﻿$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$pp = Get-PackageParameters
$packageDir = Join-Path "$toolsDir" ".." -Resolve
$installDir = $env:SystemDrive
if ($pp.InstallDir -or $pp.InstallationPath) { 
	$installDir = $pp.InstallDir + $pp.InstallationPath 
}
Write-Host "$CMakePackageName$CMakePackageVer is going to be installed in '$installDir'"

$root = Join-Path $installDir "$CMakePackageName$CMakePackageVer"
New-Item -ItemType Directory -Force -Path $root | Out-Null

if (!$pp['url']) { 
	$url = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.9.0.20240121/libopencv-dev.4.9.0_x86_mingw11_staticlib_Release.exe'
	$checksum = '212DF572DA0195973F7EB35D77E9D078908BA2A57907B909353831EF7B238B6F'
	$url64 = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.9.0.20240121/libopencv-dev.4.9.0_x64_mingw11_staticlib_Release.exe'
	$checksum64 = 'CE89788ED2BE471454E72F8A98FA24B5520F33B804EEBB5C7022CD0EAE33D251'
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
	else {
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

	$url = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.9.0.20240121/libopencv-dev.4.9.0_x86_mingw11_lib_Release.exe'
	$checksum = 'BB489603FCABD01689EC74A329D6A43BEADEA0AB165EA27EAFE01054C3187351'
	$url64 = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.9.0.20240121/libopencv-dev.4.9.0_x64_mingw11_lib_Release.exe'
	$checksum64 = '7F2522ECDB312143D95E545A99A4AF11024B58C6A7D7F3F871DE3878EA50A309'
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
	else {
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
else {
	$url = $pp['url']
	$checksum = $pp['checksum']
	$packageArgs = @{
		packageName   = $env:ChocolateyPackageName
		unzipLocation = "$root"
		url           = $url
		url64bit      = $url
		checksum      = $checksum
		checksumType  = 'sha256'
		checksum64    = $checksum
		checksumType64= 'sha256'
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
	New-ItemProperty -Name "$CMakePackageName$CMakePackageVer" -PropertyType String -Value "$root" -Path "$CMakeSystemRepositoryPath\$CMakePackageName" -Force
}
$pathtoadd = "$root\$arch\$runtime\bin"
if (!($pp['NoPath']) -and !([environment]::GetEnvironmentVariable("Path","Machine") -match [regex]::escape($pathtoadd))) {
	$newpath = [environment]::GetEnvironmentVariable("Path","Machine") + ";$pathtoadd"
	[environment]::SetEnvironmentVariable("Path",$newpath,"Machine")
}

for ($i = 1; $i -le 99; $i++) {
	if ($pp['url'+$i]) {
		$url = $pp['url'+$i]
		$checksum = $pp['checksum'+$i]
		$packageArgs = @{
			packageName   = $env:ChocolateyPackageName
			unzipLocation = "$root"
			url           = $url
			url64bit      = $url
			checksum      = $checksum
			checksumType  = 'sha256'
			checksum64    = $checksum
			checksumType64= 'sha256'
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

		if (!$pp['NoRegistry']) {
			New-Item "$CMakeSystemRepositoryPath\$CMakePackageName" -ItemType directory -Force
			New-ItemProperty -Name "$CMakePackageName$CMakePackageVer" -PropertyType String -Value "$root" -Path "$CMakeSystemRepositoryPath\$CMakePackageName" -Force
		}
		$pathtoadd = "$root\$arch\$runtime\bin"
		if (!($pp['NoPath']) -and !([environment]::GetEnvironmentVariable("Path","Machine") -match [regex]::escape($pathtoadd))) {
			$newpath = [environment]::GetEnvironmentVariable("Path","Machine") + ";$pathtoadd"
			[environment]::SetEnvironmentVariable("Path",$newpath,"Machine")
		}
	}
}
