$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v3.1.18/aqt_x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url64bit      = $url64
  checksum64    = '33F454060DF94C59DEDD9227C2B7D4A737986D309159A65491AD4AD27BD348C4'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
