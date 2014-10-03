package com.socialApplication.service.singin{	
	
	import starling.events.Event;	

	
	public class EventServiceSingin extends Event {
		
		public static var RESULT:String = "RESULT";
		 
		private var _payload:Object;
		
		public function get payload():Object{
			return _payload;
		}
		
		public function EventServiceSingin(type:String, pPayload:Object=null){
			super(type, false, false);
			this._payload = pPayload;
		}
		
	}
}