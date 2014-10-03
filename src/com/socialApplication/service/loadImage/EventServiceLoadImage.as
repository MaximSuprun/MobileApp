package com.socialApplication.service.loadImage{	
	import starling.events.Event;
	
	public class EventServiceLoadImage extends Event {
		
		public static const IMAGE_TEXTURE_LOADED :String = "IMAGE_TEXTURE_LOADED";
		public static const CAMERA_OR_DEVICE_IMAGE_LOADED :String = "CAMERA_OR_DEVICE_IMAGE_LOADED";
		public static const AVATAR_IMAGE_LOADED :String = "AVATAR_IMAGE_LOADED";
			
		private var _payload:Object;
		public function get payload():Object {
			return _payload;
		}
		
		
		private var _functionCallback:Function;
		public function get functionCallback():Function {
			return _functionCallback;
		}	
		
		
		public function EventServiceLoadImage(type:String, pPayload:Object=null,pFunctionCallback:Function = null) {
			super(type);
			this._payload = pPayload;
			this._functionCallback = pFunctionCallback;
		}	
		
	}
}