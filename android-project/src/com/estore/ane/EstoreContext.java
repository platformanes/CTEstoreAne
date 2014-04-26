package com.estore.ane;

import java.util.HashMap;
import java.util.Map;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.estore.ane.function.EstorePay;

public class EstoreContext extends FREContext {
	
	private static final String ESTORE_PAY = "estore-pay";//与java端中Map里的key一致
	@Override
	public void dispose() {

	}

	@Override
	public Map<String, FREFunction> getFunctions() {
		// TODO Auto-generated method stub
		Map<String, FREFunction> map = new HashMap<String, FREFunction>();
		//映射
		map.put(ESTORE_PAY, new EstorePay());
		return map;
	}

}
