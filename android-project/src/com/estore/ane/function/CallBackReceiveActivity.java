package com.estore.ane.function;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.estore.ane.ShareContent;
import com.estore.lsms.tools.ApiParameter;

public class CallBackReceiveActivity extends Activity {
	
	protected String appchargeid;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
//    	this.setTheme(R.style.Theme_NoDisplay);
		//构建界面
		super.onCreate(savedInstanceState);
		
		Bundle bundle = this.getIntent().getExtras();
		Intent intent = new Intent();
		intent.setClass(CallBackReceiveActivity.this, com.estore.ui.CTEStoreSDKActivity.class);
		Log.d("android only", "4s");
		Log.d("bundle",bundle.toString());
		Log.d("android only", "3s");
		appchargeid = bundle.getString(ApiParameter.APPCHARGEID);
		Log.d("android only", "2s");
		intent.putExtras(bundle);
		Log.d("android only", "1s");
		startActivityForResult(intent, 0);
		Log.d("android only", "s7");
    }
    
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    	ShareContent.event("payment", "6");
        Bundle bdl = data.getExtras();
        int payResultCode = bdl.getInt(ApiParameter.RESULTCODE);

        if (ApiParameter.CTESTORE_SENDSUCCESS == payResultCode){
        	//支付短信发送成功       	
        	ShareContent.event(EstorePay.PAY_SUCCESS, "" + appchargeid);
        }else if (ApiParameter.CTESTORE_USERCANCEL == payResultCode){
        	//用户主动取消
        	ShareContent.event(EstorePay.PAY_FAIL, "" + ApiParameter.CTESTORE_USERCANCEL);
        }else{
        	//失败
        	ShareContent.event(EstorePay.PAY_CANCEL, "" + ApiParameter.CTESTORE_SENDFAILED);
        }
        this.finish();
    }
}
