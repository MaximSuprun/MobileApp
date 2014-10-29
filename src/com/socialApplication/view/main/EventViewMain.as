package com.socialApplication.view.main{	
	import starling.events.Event;
	
	public class EventViewMain extends Event {
		
		public static const CHANGE_SELECTED_ITEM:String = "CHANGE_SELECTED_ITEM";
		public static const CHANGE_SCREEN:String="CHANGE_SCREEN";
		public static const SHOW_SELECTED_SCREEN:String="SHOW_SELECTED_SCREEN";
		public static const GET_IMAGE_INFO:String="GET_IMAGE_INFO";
		public static const TRANSITION_COMPLETE:String="TRANSITION_COMPLETE";
		
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		
		private var _functionCallback:Function;
		public function get functionCallback():Function {
			return _functionCallback;
		}	
		
		
		public function EventViewMain(type:String, pPayload:Object=null,pFunctionCallback:Function = null) {
			super(type);
			this._payload = pPayload;
			this._functionCallback = pFunctionCallback;
		}	
		
	}
}