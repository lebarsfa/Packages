$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.2/aqt_x86.exe'
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.2/aqt_x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url           = $url
  url64bit      = $url64
  checksum      = '5246FF597B5C18D111BC26FA34F3AC1F5F6670BC6D4937868730355FDB5164A0'
  checksumType  = 'sha256'
  checksum64    = '613C9B6E4130CCFB2424F85E47DF1B6ABFB2DEA5EA6526EEBA856981B0E7B0FC'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
