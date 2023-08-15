$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.7/aqt_x86_signed.exe'
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.7/aqt_x64_signed.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url           = $url
  url64bit      = $url64
  checksum      = '35E9F6C61EEA0F1296C043D1DEDB81DA9C6097535263BCCFD69905E006E9CEE0'
  checksumType  = 'sha256'
  checksum64    = 'D40E0FDD01ECCE7BBB6E973288785413AEFCA8BABCCFCAF7A4E1056E7A4AB091'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
