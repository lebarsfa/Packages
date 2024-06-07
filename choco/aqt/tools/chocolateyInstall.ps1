$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.15/aqt_x86.exe'
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.15/aqt_x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url           = $url
  url64bit      = $url64
  checksum      = '88DE3BCE1DF9F5BA5BFD443E16096CE999B0A306BDA9CD8EDED3C3118A09018E'
  checksumType  = 'sha256'
  checksum64    = 'F9E9ACC05975F2E70E4935ACE76B41882CDA4B53EB779C9BCF1D87A95029A6B0'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
