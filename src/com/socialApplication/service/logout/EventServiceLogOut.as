package com.socialApplication.service.logout{	
	
	import starling.events.Event;	

	
	public class EventServiceLogOut extends Event {
		
		public static var RESULT:String = "RESULT";
		 
		private var _payload:Object;
		
		public function get payload():Object{
			return _payload;
		}
		
		public function EventServiceLogOut(type:String, pPayload:Object=null){
			super(type, false, false);
			this._payload = pPayload;
		}
		
	}
}