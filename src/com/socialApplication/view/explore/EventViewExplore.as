package com.socialApplication.view.explore{	
	import starling.events.Event;
	
	public class EventViewExplore extends Event {
		
		public static const BACK_BUTTON_CLICK:String="BACK_BUTTON_CLICK";
				
		
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		
		private var _functionCallback:Function;
		public function get functionCallback():Function {
			return _functionCallback;
		}	
		
		
		public function EventViewExplore(type:String, pPayload:Object=null,pFunctionCallback:Function = null) {
			super(type);
			this._payload = pPayload;
			this._functionCallback = pFunctionCallback;
		}	
		
	}
}