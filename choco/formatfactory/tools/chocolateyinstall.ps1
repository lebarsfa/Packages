
$ErrorActionPreference = 'Stop';

$packageName= 'formatfactory'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url        = 'http://public.pcfreetime.com/FFSetup4.10.5.0.exe'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE'
  url           = $url
  softwareName  = 'formatfactory*'
  checksum      = '32a1b3a2d5bd7ccc39ad753f990eb17b1fa3cdf31c194caff46c1965c75bf0a8'
  checksumType  = 'sha256'
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs










    








