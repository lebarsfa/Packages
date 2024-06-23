$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.16/aqt_x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url64bit      = $url64
  checksum64    = 'A7476870125C0CAEB0E61CD62FB0E029D014FACDAE512D94997F3AC60778E9C9'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
