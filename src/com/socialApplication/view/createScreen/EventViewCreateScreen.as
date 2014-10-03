package com.socialApplication.view.createScreen{	
	import starling.events.Event;
	
	public class EventViewCreateScreen extends Event {
		
	public static const MENU_CLICK:String = "MENU_CLICK";
	public static const MENU_SHOW:String = "MENU_SHOW";
	public static const CHANGE_NEW_IMAGES:String = "CHANGE_NEW_IMAGES";
	public static const TAKE_PHOTO_CLICK:String = "TAKE_PHOTO_CLICK";
	public static const ADD_FROM_DEVICE:String = "ADD_FROM_DEVICE";
	public static const CREATE_PHOTO:String = "CREATE_PHOTO";
	public static const CLICK_CANCEL:String = "CLICK_CANCEL";	
	public static const ADD_IMAGE_FROM_DEVICE:String = "ADD_IMAGE_FROM_DEVICE";
		
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		
		private var _functionCallback:Function;
		public function get functionCallback():Function {
			return _functionCallback;
		}	
		
		
		public function EventViewCreateScreen(type:String, pPayload:Object=null,pFunctionCallback:Function = null) {
			super(type);
			this._payload = pPayload;
			this._functionCallback = pFunctionCallback;
		}	
		
	}
}