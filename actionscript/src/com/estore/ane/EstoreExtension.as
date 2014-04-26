package com.estore.ane 
{ 
	import flash.events.EventDispatcher;
	import flash.events.StatusEvent;
	import flash.external.ExtensionContext;
	
	/**
	 * 
	 * @author CZQ
	 * 
	 */	
	public class EstoreExtension extends EventDispatcher 
	{ 
		private static const ESTORE_PAY:String = "estore-pay";//与java端中Map里的key一致
		
		private static const EXTENSION_ID:String = "com.estore.ane";//与extension.xml中的id标签一致
		private var extContext:ExtensionContext;
		
		
		private static var _instance:EstoreExtension; 
		public function EstoreExtension()
		{
			if(extContext == null) {
				extContext = ExtensionContext.createExtensionContext(EXTENSION_ID, "");
				extContext.addEventListener(StatusEvent.STATUS, statusHandler);
			}
		} 
		
		/**
		 * 获取实例
		 * @return DLExtension 单例
		 */
		public static function getInstance():EstoreExtension
		{
			if(_instance == null) 
				_instance = new EstoreExtension();
			return _instance;
		}
		
		/**
		 * 转抛事件
		 * @param event 事件
		 */
		private function statusHandler(event:StatusEvent):void
		{
			dispatchEvent(event);
		}
		
		public function pay(APPCHARGEID:String, CHANNELID:String, CHARGENAME:String, PRICE:String, REQUESTID:String, PRICETYPE:int = 0, SCREENHORIZONTAL:Boolean = false):void{
			if(extContext ){
				extContext.call(ESTORE_PAY, APPCHARGEID, CHANNELID, CHARGENAME, PRICETYPE, PRICE, REQUESTID, SCREENHORIZONTAL);
			}
		}
	} 
}