$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#$url        = 'https://github.com/miurahr/aqtinstall/releases/download/v$env:ChocolateyPackageVersion/aqt_x86.exe'
$url        = 'https://github.com/lebarsfa/aqtinstall/releases/download/master/aqt_x86.exe'
#$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v$env:ChocolateyPackageVersion/aqt_x64.exe'
$url64      = 'https://github.com/lebarsfa/aqtinstall/releases/download/master/aqt_x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url           = $url
  url64bit      = $url64
  checksum      = '249b4c978b6c3ea6a2d2bdb3ab2d4f537689000a77af0360e48f6d58dc31da02'
  checksumType  = 'sha256'
  checksum64    = 'a741098fcf2d57a5607b461fded3dd808690b721e676354f633512d5e89af482'
  checksumType64= 'sha256'
  forceDownload = True
}

Get-ChocolateyWebFile @packageArgs
