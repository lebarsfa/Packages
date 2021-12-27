
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
  checksum      = 'C135ED6D5A787840884E0D2E63A9DC8512D854AF0D3442DBE1EAF0EB015044D6'
  checksumType  = 'sha256'
  silentArgs   = '/S'
}

Install-ChocolateyPackage @packageArgs










    








