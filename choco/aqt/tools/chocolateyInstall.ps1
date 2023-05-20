$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.5/aqt_x86_signed.exe'
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.5/aqt_x64_signed.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url           = $url
  url64bit      = $url64
  checksum      = 'EA4DB7B6126CF77B9173C94BA7A37F626D6A3A34DA277B353CD5F23950769FDC'
  checksumType  = 'sha256'
  checksum64    = 'CDD3E78461342256011E990AAEF51894E8076C50ADEC2752F4803210B0FF714D'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
