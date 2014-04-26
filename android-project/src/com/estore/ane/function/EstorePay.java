package com.estore.ane.function;

import android.content.Intent;
import android.os.Bundle;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.estore.ane.ShareContent;
import com.estore.lsms.tools.ApiParameter;

public class EstorePay implements FREFunction {

	public static final String PAY_RESULT = "pay-result";
	public static final String PAY_SUCCESS = "pay-success";
	public static final String PAY_FAIL = "pay-fail";
	public static final String PAY_CANCEL = "pay-cancel";
	@Override
	public FREObject call(FREContext arg0, FREObject[] arg1) {

		ShareContent.context = arg0;
				
		String APPCHARGEID;
		String CHANNELID;
		String CHARGENAME;
		int PRICETYPE;
		String PRICE;
		String REQUESTID;
		Boolean SCREENHORIZONTAL = false;
		
		//get Args
		try
		{
			APPCHARGEID = arg1[0].getAsString();
			CHANNELID = arg1[1].getAsString();
			CHARGENAME = arg1[2].getAsString();
			PRICETYPE = (arg1[3].getAsInt() == 1) ? 1: 0;
			PRICE = arg1[4].getAsString();
			REQUESTID = arg1[5].getAsString();
			SCREENHORIZONTAL = arg1[6].getAsBool();
			
		}
		catch(Exception e)
		{
			ShareContent.event("ARG_ERROR", "could not get from args");
			return null;
		}
		ShareContent.event("payment", APPCHARGEID + "," + CHANNELID + "," + CHARGENAME + "," + PRICE + "," + REQUESTID );
		Intent intent = new Intent();
        intent.setClass(ShareContent.context.getActivity(), CallBackReceiveActivity.class);

        Bundle bundle = new Bundle();
        //示例参数值	            
        bundle.putString(ApiParameter.APPCHARGEID, APPCHARGEID);
        bundle.putString(ApiParameter.CHANNELID, CHANNELID);
        bundle.putBoolean(ApiParameter.SCREENHORIZONTAL, SCREENHORIZONTAL);//进入竖屏XML"
        
        bundle.putString(ApiParameter.CHARGENAME, CHARGENAME);//计费点名称
        bundle.putInt(ApiParameter.PRICETYPE, PRICETYPE);//计费类型，0按次计费，1包月计费
        bundle.putString(ApiParameter.PRICE, PRICE);//价格             
        bundle.putString(ApiParameter.REQUESTID, REQUESTID);

        intent.putExtras(bundle);
//        ShareContent.context.getActivity().startActivityForResult(intent, 0);
        ShareContent.context.getActivity().startActivity(intent);
        return null;
	}

}
