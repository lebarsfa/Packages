
$pp = Get-PackageParameters
if (!$pp.InstallDir) { $pp.InstallDir = Join-Path "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)" "..\..\mingw\tools\install" }
$packageArgs = @{
	packageName   = $env:ChocolateyPackageName
	unzipLocation = $pp.InstallDir
	fileType      = 'zip'
	url           = 'https://github.com/brechtsanders/winlibs_mingw/releases/download/11.2.0-12.0.1-9.0.0-r1/winlibs-i686-posix-dwarf-gcc-11.2.0-mingw-w64-9.0.0-r1.7z'
	url64bit      = 'https://github.com/brechtsanders/winlibs_mingw/releases/download/11.2.0-12.0.1-9.0.0-r1/winlibs-x86_64-posix-seh-gcc-11.2.0-mingw-w64-9.0.0-r1.7z'
	checksum      = 'c0d6c0f2603f9eaac61374c6c59bdd1e1b13a77d2a4cb095517a7de5fbccb119'
	checksumType  = 'sha256'
	checksum64    = '0e23b675ecd3e3edef6ad054582812d47568899cd277cb49910f8d06bd948a86'
	checksumType64= 'sha256'

}

New-Item -ItemType Directory -Force -Path $pp.InstallDir | Out-Null
Install-ChocolateyZipPackage @packageArgs

# New gdb, etc.
$packageArgs = @{
	packageName   = $env:ChocolateyPackageName
	unzipLocation = $pp.InstallDir
	fileType      = 'zip'
	url           = 'https://github.com/cristianadam/mingw-builds/releases/download/v11.2.0-rev4/i686-11.2.0-release-posix-dwarf-rt_v9-rev4.7z'
	url64bit      = 'https://github.com/cristianadam/mingw-builds/releases/download/v11.2.0-rev4/x86_64-11.2.0-release-posix-seh-rt_v9-rev4.7z'
	checksum      = '99E50AF83581938AD972AFA0D94A4B6BE97CAEC75969F80EB190C3EE7875984E'
	checksumType  = 'sha256'
	checksum64    = '01AFEE61056D30480C7758B043F667814B724181A21B1465DA3E98D1551BFA4F'
	checksumType64= 'sha256'

}

Install-ChocolateyZipPackage @packageArgs

$("mingw32", "mingw64") | ForEach {
  $bin = (Join-Path $pp.InstallDir (Join-Path $_ "bin"))
  Write-Output "Testing path: $bin"
  If (Test-Path $bin) {
    Install-ChocolateyPath $bin
  }
}

