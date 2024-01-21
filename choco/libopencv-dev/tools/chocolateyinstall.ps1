$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$pp = Get-PackageParameters
$installDir = $env:SystemDrive
if ($pp.InstallDir -or $pp.InstallationPath) { 
	$installDir = $pp.InstallDir + $pp.InstallationPath 
}
Write-Host "$CMakePackageName$CMakePackageVer is going to be installed in '$installDir'"

$root = Join-Path $installDir "$CMakePackageName$CMakePackageVer"
New-Item -ItemType Directory -Force -Path $root | Out-Null

if (!$pp['url']) { 
	$url = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.5.4.20220805/libopencv-dev.4.5.4_x86_mingw11_staticlib_Release.exe'
	$checksum = '7855B0393DF389855E126E712C51DAB8649F19BE0101579C753FBEDF108B0132'
	$url64 = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.5.4.20220805/libopencv-dev.4.5.4_x64_mingw11_staticlib_Release.exe'
	$checksum64 = '89C6BB0DE09BD86524947827B3ED88CBBDCAB63141AEE5F7FF273CFB416C0D22'
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

	$url = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.5.4.20220805/libopencv-dev.4.5.4_x86_mingw11_lib_Release.exe'
	$checksum = '1B991766F325A8E34A126AF87BB6DDE12467491DA34CE65AEF3D53F85CA00850'
	$url64 = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.5.4.20220805/libopencv-dev.4.5.4_x64_mingw11_lib_Release.exe'
	$checksum64 = '25DDC47CD16596C08BB158B13CF60CFDB7A7A200286ACA5870BB196C35877942'
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
