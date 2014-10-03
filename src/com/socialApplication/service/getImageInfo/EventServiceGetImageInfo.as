package com.socialApplication.service.getImageInfo{	
	
	import starling.events.Event;	

	
	public class EventServiceGetImageInfo extends Event {
		
		public static var RESULT:String = "RESULT";
		 
		private var _payload:Object;
		
		public function get payload():Object{
			return _payload;
		}
		
		public function EventServiceGetImageInfo(type:String, pPayload:Object=null){
			super(type, false, false);
			this._payload = pPayload;
		}
		
	}
}