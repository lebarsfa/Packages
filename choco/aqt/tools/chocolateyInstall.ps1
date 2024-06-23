$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.16/aqt_x86.exe'
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.16/aqt_x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url           = $url
  url64bit      = $url64
  checksum      = 'F1F6B97D358121E1A43AD8DAC9CB71A4DB6ED04A1DEC8E0DFDBCC56507F93B8C'
  checksumType  = 'sha256'
  checksum64    = 'A7476870125C0CAEB0E61CD62FB0E029D014FACDAE512D94997F3AC60778E9C9'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
