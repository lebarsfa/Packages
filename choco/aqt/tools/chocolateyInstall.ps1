$ErrorActionPreference = 'Stop'; # stop on all errors
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'https://github.com/miurahr/aqtinstall/releases/download/v2.2.3/aqt_x86.exe'
$url64      = 'https://github.com/miurahr/aqtinstall/releases/download/v2.2.3/aqt_x64.exe'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileFullPath  = "$toolsDir\aqt.exe"
  url           = $url
  url64bit      = $url64
  checksum      = '6C6288EEACC022DD94B83842474B42F40F17C9A3A0A013098EF914E18A6E6CF6'
  checksumType  = 'sha256'
  checksum64    = 'AEF2B202B2D1A9A60ECC2E5DEC897BD318BE58CEDF6A6EBAFDFD5EB0B26A2C69'
  checksumType64= 'sha256'
  forceDownload = $true
}

Get-ChocolateyWebFile @packageArgs
