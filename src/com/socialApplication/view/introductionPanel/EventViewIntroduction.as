package com.socialApplication.view.introductionPanel{	
	import starling.events.Event;
	
	public class EventViewIntroduction extends Event {
		
	public static const GET_STARTED:String="GET_STARTED";
	public static const CLICK_GET_STARTED:String="CLICK_GET_STARTED";
		
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		
		private var _functionCallback:Function;
		public function get functionCallback():Function {
			return _functionCallback;
		}	
		
		
		public function EventViewIntroduction(type:String, pPayload:Object=null,pFunctionCallback:Function = null) {
			super(type);
			this._payload = pPayload;
			this._functionCallback = pFunctionCallback;
		}	
		
	}
}