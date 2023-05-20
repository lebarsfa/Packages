$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.6/aqt_x86_signed.exe'
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.6/aqt_x64_signed.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url           = $url
  url64bit      = $url64
  checksum      = 'DC675B64CACEAACAF2D2BD711FB7A005AB2BCF7F6A28702E52408965F65718EC'
  checksumType  = 'sha256'
  checksum64    = 'CA988C2AEDAED379D1672E95ED38F91BE5E803A5F2947B25C29E8B28FB2BD5C8'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
