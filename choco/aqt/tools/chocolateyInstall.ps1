$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v3.2.1/aqt_x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url64bit      = $url64
  checksum64    = 'F833F8240B0E741ABBEE376A443169E06F32D1A1B6EB9D6E62FF4A4A09277101'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
