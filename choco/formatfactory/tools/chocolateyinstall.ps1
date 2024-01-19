$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

# 1. Download bundle
$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$(Join-Path $ENV:TEMP 'FFSetup.exe')"
  url           = 'https://web.archive.org/web/20220130214622/http://public.pcfreetime.com/FFSetup5.8.1.0.exe'
  checksum      = 'f9dfb78aed3a76d2b54571acc5a69b15c4c85f45ab791b5502a63ab189bcd98c'
  checksumType  = 'sha256'
}
$filePath = Get-ChocolateyWebFile @packageArgs

# 2. Extract bundle
$packageArgs = @{
  fileFullPath  = "$filePath"
  destination   = "$(Join-Path $ENV:TEMP 'FFSetup')"
}
$folderPath = Get-ChocolateyUnzip @packageArgs

# 3. Install silent
$packageArgs = @{
  packageName   = $packageName
  fileType      = 'exe'
  file          = "$(Join-Path $folderPath "Carrier.exe")"
  softwareName  = 'formatfactory*'
  silentArgs   = '/S'
  validExitCodes= @(0, 3010, 1641)
}
Install-ChocolateyInstallPackage @packageArgs
