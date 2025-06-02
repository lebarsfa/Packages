$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/miurahr/aqtinstall/releases/download/v3.3.0/aqt_x86.exe'
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v3.3.0/aqt_x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url           = $url
  url64bit      = $url64
  checksum      = '372ED5C099F2E010284E9A69CCA0731B7DBF29BE41100588685C2CD1F917BC40'
  checksumType  = 'sha256'
  checksum64    = '4F74D4C95C464D238D7E17EC2D9B7F22A7C333F0F5270A62584E2B47FC765150'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
