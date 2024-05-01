$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.14/aqt_x86.exe'
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.14/aqt_x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url           = $url
  url64bit      = $url64
  checksum      = 'DD46AC8CFE32189367498BB4E20C5813D536D493D8A656FC01477435DC41DF01'
  checksumType  = 'sha256'
  checksum64    = '6C2D9DD85925B003B01990F781A7EAD30945610A9048755E1F87496FFF642DF6'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
