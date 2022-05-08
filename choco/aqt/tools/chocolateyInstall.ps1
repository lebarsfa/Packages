$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = "https://github.com/miurahr/aqtinstall/releases/download/v$env:ChocolateyPackageVersion/aqt_x86.exe"
$url64      = "https://github.com/miurahr/aqtinstall/releases/download/v$env:ChocolateyPackageVersion/aqt_x64.exe"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url           = $url
  url64bit      = $url64
  checksum      = 'B980985CFEB1CEFEF1D2EBAB91AE4E648873A27FAE8831DEFF8144661480C56A'
  checksumType  = 'sha256'
  checksum64    = 'B0AD07FE8FD2C094425449F3053598959E467833DADF509DA948571259510078'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
