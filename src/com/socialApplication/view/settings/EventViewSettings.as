package com.socialApplication.view.settings{	
	import starling.events.Event;
	
	public class EventViewSettings extends Event {
		
		public static const LOG_OUT_ITEM:String="LOG_OUT_ITEM";
		public static const LOG_OUT:String="LOG_OUT";
		public static const CLICK_OKEY:String="CLICK_OKEY";
		public static const CLICK_CANCEL:String="CLICK_CANCEL";
		public static const CHANGE_DATA_PASSWORD:String="CHANGE_DATA_PASSWORD";
		public static const CHANGE_DATA_LOGIN:String="CHANGE_DATA_LOGIN";
		public static const REPLACE_DATA_PASSWORD:String="REPLACE_DATA_PASSWORD";
		public static const REPLACE_DATA_LOGIN:String="REPLACE_DATA_LOGIN";
		
		
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		
		private var _functionCallback:Function;
		public function get functionCallback():Function {
			return _functionCallback;
		}	
		
		
		public function EventViewSettings(type:String, pPayload:Object=null,pFunctionCallback:Function = null) {
			super(type);
			this._payload = pPayload;
			this._functionCallback = pFunctionCallback;
		}	
		
	}
}