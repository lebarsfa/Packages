# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

$pp = Get-PackageParameters

if (!$pp['modules']) { 
	$Modules = 'qtcharts qtscript'
}
else {
	$Modules = $pp['modules']
}

if (!$pp['base']) { 
	cmd /c "refreshenv & cd $env:TEMP & $env:ChocolateyInstall\bin\aqt.exe install-qt --outputdir $QtSDKRoot windows desktop $QtSDKVer win$MinGWArch`_mingw$MinGWMMVer -m $Modules" 
}
else { 
	$Base = $pp['base']
	# For offline install...
	# Before, set up qt5-default-5.15.2\online\qtsdkrepository\windows_x86\desktop\qt5_5152 folder with data from e.g. ftp://mirrors.dotsrc.org/.mirrors/qtproject/online/qtsdkrepository/windows_x86/desktop/qt5_5152 from a computer with the Internet.
	# On the computer to be installed and to be able to use the --base parameter of aqt install, which does not seem to accept directly local folders (firewall might need to be configured to temporarily allow TCP port 8000, e.g. netsh advfirewall firewall add rule name="Open Port 8000 TCP" dir=in action=allow protocol=TCP localport=8000) : start python -m http.server --directory qt5-default-5.15.2
	cmd /c "refreshenv & cd $env:TEMP & $env:ChocolateyInstall\bin\aqt.exe install-qt --base $Base --outputdir $QtSDKRoot windows desktop $QtSDKVer win$MinGWArch`_mingw$MinGWMMVer -m $Modules"
}

$QtVersionFileContent = @" 
<qtcreator>
 <data>
  <variable>QtVersion.0</variable>
  <valuemap type="QVariantMap">
   <value type="QString" key="QMakePath">$QtSDKMinGWPath\bin\qmake.exe</value>
   <value type="QString" key="QtVersion.Type">Qt4ProjectManager.QtVersion.Desktop</value>
  </valuemap>
 </data>
 <data>
  <variable>Version</variable>
  <value type="int">1</value>
 </data>
</qtcreator>
"@
New-Item -ItemType Directory -Force -Path "$env:APPDATA\QtProject\qtcreator"
Set-Content -Path "$env:APPDATA\QtProject\qtcreator\qtversion.xml" -Encoding ASCII -Value "$QtVersionFileContent"
