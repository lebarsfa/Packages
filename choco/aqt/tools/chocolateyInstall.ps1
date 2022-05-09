$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/miurahr/aqtinstall/releases/download/v2.1.0/aqt_x86.exe'
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v2.1.0/aqt_x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url           = $url
  url64bit      = $url64
  checksum      = 'D0A4418D5B598CE159E61DEF143C5410A330CE567B54B37DFC6D7FFF7F43FB55'
  checksumType  = 'sha256'
  checksum64    = 'E73F28FF0E6AFC9C935BB24CDE7E4D110ADC4AA3EF454F619B29FF73EF9F6153'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
