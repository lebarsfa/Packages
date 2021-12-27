# Source variables which are shared between install and uninstall.
. $PSScriptRoot\sharedVars.ps1

# Should use https://github.com/miurahr/aqtinstall/releases/download/v$aqtVer/aqt.exe to avoid python dependencies (v2.0.5 checksum : BDDAFA831044CE3EE414BCD302D8B3C2). But only in 64 bit...?
#cmd /c "refreshenv & aqt install-qt --outputdir $QtSDKRoot $QtSDKVer windows desktop win$MinGWArch`_mingw$MinGWMMVer -m qtcharts qtscript"
# For offline install, with $BaseRoot that should be set from a parameter...
#cmd /c "refreshenv & aqt install-qt --base $BaseRoot --outputdir $QtSDKRoot $QtSDKVer windows desktop win$MinGWArch`_mingw$MinGWMMVer -m qtcharts qtscript"

# Should put in %TEMP% aqtinstall.log instead of in current directory (what happens if current directory is read-only?)...?

# Ideally...
#cmd /c "refreshenv & pip install --only-binary :all: aqtinstall==$aqtVer & aqt install --outputdir $QtSDKRoot $QtSDKVer windows desktop win$MinGWArch`_mingw$MinGWMMVer -m qtcharts qtscript"

# If some py7zr pip dependencies fail...
# Would need also 7zip...
cmd /c "refreshenv & pip install --only-binary :all: requests==$requestsVer packaging texttable & pip install --only-binary :all: --no-deps aqtinstall==$aqtVer & aqt install -E 7z --outputdir $QtSDKRoot $QtSDKVer windows desktop win$MinGWArch`_mingw$MinGWMMVer -m qtcharts qtscript"

# For offline install...
# Before, need to set up qt5-default-5.15.2\online\qtsdkrepository\windows_x86\desktop\qt5_5152 folder with data from e.g. ftp://mirrors.dotsrc.org/.mirrors/qtproject/online/qtsdkrepository/windows_x86/desktop/qt5_5152 and run from the computer with the Internet : python -m pip download --only-binary :all: -r requirements.txt
# Need to run before (firewall might need to be configured to temporarily allow TCP port 8000, e.g. netsh advfirewall firewall add rule name="Open Port 8000 TCP" dir=in action=allow protocol=TCP localport=8000) : start python -m http.server --directory qt5-default-5.15.2
#cmd /c "refreshenv & python -m pip install --only-binary :all: --no-index --find-links qt5-default-5.15.2 -r qt5-default-5.15.2\requirements.txt & pip install --only-binary :all: requests==$requestsVer packaging texttable & pip install --only-binary :all: --no-deps aqtinstall==$aqtVer & aqt install -E 7z --base http://127.0.0.1:8000/ --outputdir $QtSDKRoot $QtSDKVer windows desktop win$MinGWArch`_mingw$MinGWMMVer -m qtcharts qtscript"

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
