$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.19/aqt_x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url64bit      = $url64
  checksum64    = 'EC430FF33F5E0D096FF8AAB4A8041390D7B3B88A905C1ECFDEE26BF87475AB67'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
