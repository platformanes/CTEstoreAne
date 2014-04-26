CTEstoreAne
===========

电信天翼空间接入

编译时需要打包CTEStoreSDKLocalSms2.0.2里面assets目录里面的文件进程序目录内,并且修改ctestore_appconfig.xml文件里面的内容

最后在Main.xml里面加入
```
<activity 
	android:name="com.estore.ane.function.CallBackReceiveActivity"
	android:label="@string/app_name"
	android:exported="true"
	android:theme="@android:style/Theme.Translucent"></activity>
<activity
	android:name="com.estore.ui.CTEStoreSDKActivity"
	android:label="@string/app_name"
	android:exported="true"></activity>
```

使用时调用
```
EstoreExtension.getInstance().pay(计费点ID, 渠道号(4位数值), 计费点名称, 价格, 透传后端字段);
```
