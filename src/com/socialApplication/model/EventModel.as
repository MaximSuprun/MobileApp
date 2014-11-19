package com.socialApplication.model{	
	import starling.events.Event;

	public class EventModel extends Event {
		
		
		public static const LOGIN_SUCCES :String = "LOGIN_SUCCES";
		public static const LOGIN_ERROR :String = "LOGIN_ERROR";
		public static const AUTHORIZATION_DATA_INPUTED :String = "AUTHORIZATION_DATA_INPUTED";
		public static const REPLACE_LOGIN :String = "REPLACE_LOGIN";
		public static const REPLACE_PASSWORD :String = "REPLACE_PASSWORD";
		
		
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		public function EventModel(type:String, pPayload:Object=null) {
			super(type,false,pPayload);
			this._payload = pPayload;
		}	
		
	}
}