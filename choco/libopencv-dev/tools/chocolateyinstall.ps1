$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

function Assert-SafeUrl {
	param(
		[string]$Url,
		[string]$AllowedPrefix
	)

	$isLocal    = Test-Path $Url -PathType Any -ErrorAction SilentlyContinue
	$isAllowed  = $Url.StartsWith($AllowedPrefix, [StringComparison]::OrdinalIgnoreCase)
	if (-not ($isLocal -or $isAllowed)) {
		throw "Invalid URL '$Url'. Must be a local path or start with '$AllowedPrefix'."
	}
}

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

$AllowedUrlPrefix = 'https://github.com/lebarsfa/Packages'

if (!$pp['url']) { 
	$url = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.13.0.20251227/libopencv-dev.4.13.0_x86_mingw13_staticlib_Release.exe'
	$checksum = 'EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE'
	$url64 = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.13.0.20251227/libopencv-dev.4.13.0_x64_mingw13_staticlib_Release.exe'
	$checksum64 = 'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF'
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

	$url = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.13.0.20251227/libopencv-dev.4.13.0_x86_mingw13_lib_Release.exe'
	$checksum = 'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC'
	$url64 = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.13.0.20251227/libopencv-dev.4.13.0_x64_mingw13_lib_Release.exe'
	$checksum64 = 'DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD'
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
	Assert-SafeUrl $url $AllowedUrlPrefix
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

	# Analyze url to guess what to add to Windows PATH or registry...
	$arch = "x64"
	if ($url -match "x86") {
		$arch = "x86"
	}
	elseif ($url -match "arm64") {
		$arch = "arm64"
	}
	$runtime = 'mingw'
	if ($url -match 'vc(\d{1,2})') {
		$ver = [int]$matches[1]
		if ($ver -ge 8 -and $ver -le 22) {
			$runtime = "vc$ver"
		}
	}
}

$cmakepathtoadd = "$root"
if ((!$pp['NoRegistry']) -and (Test-Path $cmakepathtoadd)) {
	New-Item "$CMakeSystemRepositoryPath\$CMakePackageName" -ItemType directory -Force
	New-ItemProperty -Name "$CMakePackageName$CMakePackageVer" -PropertyType String -Value $cmakepathtoadd -Path "$CMakeSystemRepositoryPath\$CMakePackageName" -Force
}
$pathtoadd = "$root\$arch\$runtime\bin"
if ((!$pp['NoPath']) -and (Test-Path $pathtoadd)) {
	Install-ChocolateyPath $pathtoadd -PathType 'Machine'
}

for ($i = 1; $i -le 99; $i++) {
	if ($pp['url'+$i]) {
		$url = $pp['url'+$i]
		$checksum = $pp['checksum'+$i]
		Assert-SafeUrl $url $AllowedUrlPrefix
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

		# Analyze url to guess what to add to Windows PATH or registry...
		$arch = "x64"
		if ($url -match "x86") {
			$arch = "x86"
		}
		elseif ($url -match "arm64") {
			$arch = "arm64"
		}
		$runtime = 'mingw'
		if ($url -match 'vc(\d{1,2})') {
			$ver = [int]$matches[1]
			if ($ver -ge 8 -and $ver -le 22) {
				$runtime = "vc$ver"
			}
		}

		$cmakepathtoadd = "$root"
		if ((!$pp['NoRegistry']) -and (Test-Path $cmakepathtoadd)) {
			New-Item "$CMakeSystemRepositoryPath\$CMakePackageName" -ItemType directory -Force
			New-ItemProperty -Name "$CMakePackageName$CMakePackageVer" -PropertyType String -Value $cmakepathtoadd -Path "$CMakeSystemRepositoryPath\$CMakePackageName" -Force
		}
		$pathtoadd = "$root\$arch\$runtime\bin"
		if ((!$pp['NoPath']) -and (Test-Path $pathtoadd)) {
			Install-ChocolateyPath $pathtoadd -PathType 'Machine'
		}
	}
}
