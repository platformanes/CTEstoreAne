rem @echo off
rem 转到当前盘符
%~d0
rem 打开当前目录
cd %~dp0
rem 你做的主JAR包的路径
set SOURCEJAR=com.estore.ane.jar
set MainJar=estreane.jar
rem 第三方JAR包的路径
set ExternalJar=CTEStoreSDKLocalSms2.0.2.jar
rem 第三方JAR包顶级包名称
set packageName=com
rem swc文件名
set SWC=com.estore.ane.swc
echo =========== start make jar ==============
rem 创建临时目录
md temp
rem 拷贝临时文件
rem copy %SOURCEJAR% %MainJar%
copy .\android-project\bin\%SOURCEJAR% .\temp\%MainJar% >nul
copy .\CTEStoreSDKLocalSms2.0.2\libs\%ExternalJar% .\temp\ >nul
cd temp
rem 解压第三方包
jar -xf %ExternalJar%
rem 合并主JAR包
jar -uf %MainJar% %packageName% 
rem 合并其他顶级包
rem jar -uf %MainJar% %packageName2%
rem 拷贝过去ane构建目录
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
echo =========打包apk的时候记得把assets目录里面的东西也打包进去，点任意键结束===
rem pause>nul