$destination = 'c:\opt\ros\melodic\x64'

$ErrorActionPreference = 'Stop'; # Stop on all errors.

$packageName = $env:ChocolateyPackageName.replace('ros-melodic-','')

if (Test-Path $destination\share\$packageName) {
    Remove-Item -Recurse -Force $destination\share\$packageName
}
if (Test-Path $destination\share\gennodejs\ros\$packageName) {
    Remove-Item -Recurse -Force $destination\share\gennodejs\ros\$packageName
}
if (Test-Path $destination\share\common-lisp\ros\$packageName) {
    Remove-Item -Recurse -Force $destination\share\common-lisp\ros\$packageName
}
if (Test-Path $destination\share\roseus\ros\$packageName) {
    Remove-Item -Recurse -Force $destination\share\roseus\ros\$packageName
}
if (Test-Path $destination\lib\site-packages\$packageName) {
    Remove-Item -Recurse -Force $destination\lib\site-packages\$packageName
}
if (Test-Path $destination\lib\pkgconfig\$packageName.pc) {
    Remove-Item -Recurse -Force $destination\lib\pkgconfig\$packageName.pc
}
if (Test-Path $destination\lib\$packageName.lib) {
    Remove-Item -Recurse -Force $destination\lib\$packageName.lib
}
if (Test-Path $destination\bin\$packageName.dll) {
    Remove-Item -Recurse -Force $destination\bin\$packageName.dll
}
if (Test-Path $destination\include\$packageName) {
    Remove-Item -Recurse -Force $destination\include\$packageName
}
