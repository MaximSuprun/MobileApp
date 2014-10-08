package com.socialApplication.view.profile{	
	import starling.events.Event;
	
	public class EventViewProfile extends Event {
		
		public static const LOAD_USER_DATA:String="LOAD_USER_DATA";
		public static const AVATAR_LOAD:String="AVATAR_LOAD";
		public static const IMAGE_LOAD:String="IMAGE_LOAD";
		public static const IMAGE_SELECTED:String="IMAGE_SELECTED";
		
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		
		private var _functionCallback:Function;
		public function get functionCallback():Function {
			return _functionCallback;
		}	
		
		
		public function EventViewProfile(type:String, pPayload:Object=null,pFunctionCallback:Function = null) {
			super(type);
			this._payload = pPayload;
			this._functionCallback = pFunctionCallback;
		}	
		
	}
}