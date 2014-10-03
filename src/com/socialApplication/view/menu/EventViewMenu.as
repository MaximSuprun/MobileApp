package com.socialApplication.view.menu{	
	import starling.events.Event;
	
	public class EventViewMenu extends Event {
		
		public static const CHANGE_SELECTED_ITEM:String = "CHANGE_SELECTED_ITEM";
		public static const CHANGE_SCREEN:String="CHANGE_SCREEN";
		
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		
		private var _functionCallback:Function;
		public function get functionCallback():Function {
			return _functionCallback;
		}	
		
		
		public function EventViewMenu(type:String, pPayload:Object=null,pFunctionCallback:Function = null) {
			super(type);
			this._payload = pPayload;
			this._functionCallback = pFunctionCallback;
		}	
		
	}
}