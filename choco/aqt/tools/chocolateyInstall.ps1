$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.21/aqt_x86.exe'
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.21/aqt_x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url           = $url
  url64bit      = $url64
  checksum      = 'B79465E771A78A76A8967C4BC49AC93210E25D6EAD58B929A57100B3C6DA71DF'
  checksumType  = 'sha256'
  checksum64    = 'DA834E08268F3FFBB4C3E1C3E8A3EF8885D446E96E48DD35780A8D73E4A9E4ED'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
