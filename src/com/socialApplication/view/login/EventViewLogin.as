package com.socialApplication.view.login{	
	import starling.events.Event;
	
	public class EventViewLogin extends Event {
		
	public static const LOGIN:String="LOGIN";
	public static const LOGIN_DATA:String="LOGIN_DATA";
		
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		
		private var _functionCallback:Function;
		public function get functionCallback():Function {
			return _functionCallback;
		}	
		
		
		public function EventViewLogin(type:String, pPayload:Object=null,pFunctionCallback:Function = null) {
			super(type);
			this._payload = pPayload;
			this._functionCallback = pFunctionCallback;
		}	
		
	}
}