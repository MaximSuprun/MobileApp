package com.socialApplication.service.replaceAutorizationData{	
	import starling.events.Event;
	
	public class EventServiceReplaceData extends Event {
		
		public static const DATA_REPLACE :String = "DATA_REPLACED";
		
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		
		private var _functionCallback:Function;
		public function get functionCallback():Function {
			return _functionCallback;
		}	
		
		
		public function EventServiceReplaceData(type:String, pPayload:Object=null,pFunctionCallback:Function = null) {
			super(type);
			this._payload = pPayload;
			this._functionCallback = pFunctionCallback;
		}	
		
	}
}