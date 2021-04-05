# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

# Ideally...
#cmd /c "refreshenv & pip install --only-binary :all: aqtinstall==$aqtVer & aqt install --outputdir $QtSDKRoot $QtSDKVer windows desktop win$MinGWArch`_mingw$MinGWMMVer -m qtcharts qtscript"

# If some py7zr pip dependencies fail...
# Would need also 7zip and git as package dependencies...
cmd /c "refreshenv & cd %TMP% & git -c advice.detachedHead=false clone --depth 1 -b v$aqtVer https://github.com/miurahr/aqtinstall"
((Get-Content -path "$env:TMP\aqtinstall\setup.cfg" -Raw) -replace "py7zr","#py7zr") | Set-Content -Path "$env:TMP\aqtinstall\setup.cfg"
((Get-Content -path "$env:TMP\aqtinstall\aqt\installer.py" -Raw) -replace "import py7zr","#import py7zr") | Set-Content -Path "$env:TMP\aqtinstall\aqt\installer.py"
cmd /c "refreshenv & pip install --only-binary :all: -e %TMP%\aqtinstall & aqt install -E 7z --outputdir $QtSDKRoot $QtSDKVer windows desktop win$MinGWArch`_mingw$MinGWMMVer -m qtcharts qtscript"

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
