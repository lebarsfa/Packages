$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/miurahr/aqtinstall/releases/download/v3.2.1/aqt_x86.exe'
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v3.2.1/aqt_x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url           = $url
  url64bit      = $url64
  checksum      = '1C7DFD92E2E8FC068A12EE4C1E79A5CE41FBE4F724753B8B85C57429A90FAFF8'
  checksumType  = 'sha256'
  checksum64    = 'F833F8240B0E741ABBEE376A443169E06F32D1A1B6EB9D6E62FF4A4A09277101'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
