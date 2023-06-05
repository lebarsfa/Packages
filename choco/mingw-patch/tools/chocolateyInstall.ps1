
$pp = Get-PackageParameters
if (!$pp.InstallDir) { $pp.InstallDir = Join-Path "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)" "..\..\mingw\tools\install" | Resolve-Path }

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

