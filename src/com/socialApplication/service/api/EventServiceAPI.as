package com.socialApplication.service.api{	
	
	import starling.events.Event;	

	
	public class EventServiceAPI extends Event {
		
		public static var PUBLISH_COMPLETE:String = "PUBLISH_COMPLETE";
		 
		private var _payload:Object;
		
		public function get payload():Object{
			return _payload;
		}
		
		public function EventServiceAPI(type:String, pPayload:Object=null){
			super(type, false, false);
			this._payload = pPayload;
		}
		
	}
}