# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

cmd /c "refreshenv & pip install --only-binary :all: aqtinstall==$aqtVer & aqt install --outputdir $QtSDKRoot $QtSDKVer windows desktop win$MinGWArch`_mingw$MinGWMMVer -m qtcharts qtscript"

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
