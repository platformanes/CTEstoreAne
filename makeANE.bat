rem @echo off
rem ת����ǰ�̷�
%~d0
rem �򿪵�ǰĿ¼
cd %~dp0
rem ��������JAR����·��
set SOURCEJAR=com.estore.ane.jar
set MainJar=estreane.jar
rem ������JAR����·��
set ExternalJar=CTEStoreSDKLocalSms2.0.2.jar
rem ������JAR������������
set packageName=com
rem swc�ļ���
set SWC=com.estore.ane.swc
echo =========== start make jar ==============
rem ������ʱĿ¼
md temp
rem ������ʱ�ļ�
rem copy %SOURCEJAR% %MainJar%
copy .\android-project\bin\%SOURCEJAR% .\temp\%MainJar% >nul
copy .\CTEStoreSDKLocalSms2.0.2\libs\%ExternalJar% .\temp\ >nul
cd temp
rem ��ѹ��������
jar -xf %ExternalJar%
rem �ϲ���JAR��
jar -uf %MainJar% %packageName% 
rem �ϲ�����������
rem jar -uf %MainJar% %packageName2%
rem ������ȥane����Ŀ¼
copy %MainJar% ..\ane-build-path\android-ARM >nul
cd ..
rd /s/q temp
echo =========== jar make over,start build ane ==============
copy .\actionscript\bin\%SWC% .\ane-build-path >nul
rem mkdir .\ane-build-path\android-ARM\libs
rem mkdir .\ane-build-path\android-ARM\libs\armeabi
rem mkdir .\ane-build-path\android-ARM\libs\armeabi-v7a
rem copy .\SDK1.2.2\libs\armeabi\libsmsiap.so .\ane-build-path\android-ARM\libs\armeabi >nul
rem copy .\SDK1.2.2\libs\armeabi\libsmsiap.so .\ane-build-path\android-ARM\libs\armeabi-v7a >nul
cd ane-build-path
jar -xf %SWC%
move catalog.xml .\android-ARM\ >nul
move library.swf .\android-ARM\ >nul
echo ===========building ane now ===========================
rem build ane
set FLEX_SDK=D:\AIR_3.9
set FLEX_SDK_BIN= %FLEX_SDK%\bin
set FLEX_LIBS=%FLEX_SDK%\frameworks\libs
java -jar "%FLEX_SDK%\lib\adt.jar" -package -target ane com.estore.ane extension.xml -swc *.swc -platform Android-ARM -C Android-ARM . 
move com.estore.ane ..\ >nul
cd ..
echo =========build complete==========
echo =========���apk��ʱ��ǵð�assetsĿ¼����Ķ���Ҳ�����ȥ�������������===
rem pause>nul