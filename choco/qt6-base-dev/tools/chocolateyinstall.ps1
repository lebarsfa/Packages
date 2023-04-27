# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

$pp = Get-PackageParameters

if (!$pp['modules']) { 
	# qtscript missing in the 6.2.4 binaries...?
	$Modules = 'qtcharts'
	#$Modules = 'qtcharts qtscript'
}
else {
	$Modules = $pp['modules']
}

if (!$pp['base']) { 
	cmd /c "refreshenv & cd $env:TEMP & $env:ChocolateyInstall\bin\aqt.exe install-qt --outputdir $QtSDKRoot windows desktop $QtSDKVer win$MinGWArch`_mingw -m $Modules" 
	#cmd /c "refreshenv & cd $env:TEMP & $env:ChocolateyInstall\bin\aqt.exe install-qt --outputdir $QtSDKRoot windows desktop $QtSDKVer win$MinGWArch`_mingw$MinGWMMVer -m $Modules" 
}
else { 
	$Base = $pp['base']
	# For offline install...
	# Before, set up qt6-base-dev-6.2.4\online\qtsdkrepository\windows_x86\desktop\qt6_624 folder with data from e.g. ftp://mirrors.dotsrc.org/.mirrors/qtproject/online/qtsdkrepository/windows_x86/desktop/qt6_624 from a computer with the Internet.
	# On the computer to be installed and to be able to use the --base parameter of aqt install, which does not seem to accept directly local folders (firewall might need to be configured to temporarily allow TCP port 8000, e.g. netsh advfirewall firewall add rule name="Open Port 8000 TCP" dir=in action=allow protocol=TCP localport=8000) : start python -m http.server --directory qt6-base-dev-6.2.4
	# Unknown MinGW version for the 6.2.4 binaries...?
	cmd /c "refreshenv & cd $env:TEMP & $env:ChocolateyInstall\bin\aqt.exe install-qt --base $Base --outputdir $QtSDKRoot windows desktop $QtSDKVer win$MinGWArch`_mingw -m $Modules"
	#cmd /c "refreshenv & cd $env:TEMP & $env:ChocolateyInstall\bin\aqt.exe install-qt --base $Base --outputdir $QtSDKRoot windows desktop $QtSDKVer win$MinGWArch`_mingw$MinGWMMVer -m $Modules"
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

$ToolchainsFileContent = @" 
<qtcreator>
 <data>
  <variable>ToolChain.0</variable>
  <valuemap type="QVariantMap">
   <value type="QString" key="ProjectExplorer.GccToolChain.OriginalTargetTriple">x86_64-w64-mingw32</value>
   <value type="QString" key="ProjectExplorer.GccToolChain.Path">$env:ChocolateyInstall\bin\g++.exe</value>
   <valuelist type="QVariantList" key="ProjectExplorer.GccToolChain.PlatformCodeGenFlags"/>
   <valuelist type="QVariantList" key="ProjectExplorer.GccToolChain.PlatformLinkerFlags"/>
   <valuelist type="QVariantList" key="ProjectExplorer.GccToolChain.SupportedAbis">
    <value type="QString">x86-windows-msys-pe-64bit</value>
   </valuelist>
   <value type="QString" key="ProjectExplorer.GccToolChain.TargetAbi">x86-windows-msys-pe-64bit</value>
   <value type="bool" key="ProjectExplorer.ToolChain.Autodetect">false</value>
   <value type="QString" key="ProjectExplorer.ToolChain.DetectionSource"></value>
   <value type="QString" key="ProjectExplorer.ToolChain.DisplayName">MinGW (C++, x86 64bit in $env:ChocolateyInstall\bin)</value>
   <value type="QString" key="ProjectExplorer.ToolChain.Id">ProjectExplorer.ToolChain.Mingw:{7f425a76-bae0-4a73-8aa3-fc4bef1d217c}</value>
   <value type="int" key="ProjectExplorer.ToolChain.Language">2</value>
   <value type="QString" key="ProjectExplorer.ToolChain.LanguageV2">Cxx</value>
  </valuemap>
 </data>
 <data>
  <variable>ToolChain.1</variable>
  <valuemap type="QVariantMap">
   <value type="QString" key="ProjectExplorer.GccToolChain.OriginalTargetTriple">x86_64-w64-mingw32</value>
   <value type="QString" key="ProjectExplorer.GccToolChain.Path">$env:ChocolateyInstall\bin\gcc.exe</value>
   <valuelist type="QVariantList" key="ProjectExplorer.GccToolChain.PlatformCodeGenFlags"/>
   <valuelist type="QVariantList" key="ProjectExplorer.GccToolChain.PlatformLinkerFlags"/>
   <valuelist type="QVariantList" key="ProjectExplorer.GccToolChain.SupportedAbis">
    <value type="QString">x86-windows-msys-pe-64bit</value>
   </valuelist>
   <value type="QString" key="ProjectExplorer.GccToolChain.TargetAbi">x86-windows-msys-pe-64bit</value>
   <value type="bool" key="ProjectExplorer.ToolChain.Autodetect">false</value>
   <value type="QString" key="ProjectExplorer.ToolChain.DetectionSource"></value>
   <value type="QString" key="ProjectExplorer.ToolChain.DisplayName">MinGW (C, x86 64bit in $env:ChocolateyInstall\bin)</value>
   <value type="QString" key="ProjectExplorer.ToolChain.Id">ProjectExplorer.ToolChain.Mingw:{861bbca0-b1cf-4137-956e-58b51be68206}</value>
   <value type="int" key="ProjectExplorer.ToolChain.Language">1</value>
   <value type="QString" key="ProjectExplorer.ToolChain.LanguageV2">C</value>
  </valuemap>
 </data>
 <data>
  <variable>ToolChain.Count</variable>
  <value type="int">2</value>
 </data>
 <data>
  <variable>Version</variable>
  <value type="int">1</value>
 </data>
</qtcreator>
"@
New-Item -ItemType Directory -Force -Path "$env:APPDATA\QtProject\qtcreator"
Set-Content -Path "$env:APPDATA\QtProject\qtcreator\toolchains.xml" -Encoding ASCII -Value "$ToolchainsFileContent"
