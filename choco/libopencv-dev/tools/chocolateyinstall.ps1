$ErrorActionPreference = 'Stop'; # Stop on all errors.

# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$pp = Get-PackageParameters
$installDir = $env:SystemDrive
if ($pp.InstallDir -or $pp.InstallationPath) { 
	$installDir = $pp.InstallDir + $pp.InstallationPath 
}
Write-Host "OpenCV$OpenCVVer is going to be installed in '$installDir'"

$root = Join-Path $installDir "OpenCV$OpenCVVer"
New-Item -ItemType Directory -Force -Path $root | Out-Null

if (!$pp['url']) { 
	$url = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.6.0.20230510/libopencv-dev.4.6.0_x86_mingw11_staticlib_Release.exe'
	$checksum = 'D399EA8897F73B7F0F9693F5B9C60CE83C22E96ABD79BF03D1A2C77E0ED59957'
	$url64 = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.6.0.20230510/libopencv-dev.4.6.0_x64_mingw11_staticlib_Release.exe'
	$checksum64 = 'E4055BF4D3FF337153B9F1D3E29085BBE04DE04834E0C5D05E0F76D08797F37A'
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

	$url = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.6.0.20230510/libopencv-dev.4.6.0_x86_mingw11_lib_Release.exe'
	$checksum = '8870642B6943B182ED7769CE5FAC2E8D3FF673BE17C3312C581586C7D376B381'
	$url64 = 'https://github.com/lebarsfa/Packages/releases/download/libopencv-dev.4.6.0.20230510/libopencv-dev.4.6.0_x64_mingw11_lib_Release.exe'
	$checksum64 = '193970D261B98505E579E227B1F2451B956ED7F5C65D4C6AA359FEF6626C7370'
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
	#$checksum = $pp['sha256']
	$packageArgs = @{
		packageName   = $env:ChocolateyPackageName
		unzipLocation = "$root"
		url           = $url
		#checksum      = $checksum
		#checksumType  = 'sha256'
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
	New-ItemProperty -Name "CMakePackageDir" -PropertyType String -Value "$root" -Path "$CMakeSystemRepositoryPath\$CMakePackageName" -Force
}
$pathtoadd = "$root\$arch\$runtime\bin"
if (!($pp['NoPath']) -and !([environment]::GetEnvironmentVariable("Path","Machine") -match [regex]::escape($pathtoadd))) {
	$newpath = [environment]::GetEnvironmentVariable("Path","Machine") + ";$pathtoadd"
	[environment]::SetEnvironmentVariable("Path",$newpath,"Machine")
}

for ($i = 1; $i -le 99; $i++) {
	if ($pp['url'+$i]) {
		$url = $pp['url'+$i]
		#$checksum = $pp['sha256']
		$packageArgs = @{
			packageName   = $env:ChocolateyPackageName
			unzipLocation = "$root"
			url           = $url
			#checksum      = $checksum
			#checksumType  = 'sha256'
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
			New-ItemProperty -Name "CMakePackageDir" -PropertyType String -Value "$root" -Path "$CMakeSystemRepositoryPath\$CMakePackageName" -Force
		}
		$pathtoadd = "$root\$arch\$runtime\bin"
		if (!($pp['NoPath']) -and !([environment]::GetEnvironmentVariable("Path","Machine") -match [regex]::escape($pathtoadd))) {
			$newpath = [environment]::GetEnvironmentVariable("Path","Machine") + ";$pathtoadd"
			[environment]::SetEnvironmentVariable("Path",$newpath,"Machine")
		}
	}
}
