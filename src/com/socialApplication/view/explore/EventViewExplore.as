package com.socialApplication.view.explore{	
	import starling.events.Event;
	
	public class EventViewExplore extends Event {
		
		public static const BACK_BUTTON_CLICK:String="BACK_BUTTON_CLICK";
		public static const CANCEL_POP_UP_SHARE:String="CANCEL_POP_UP_SHARE";
		public static const CANCEL_POP_UP_WEB_VIEW:String="CANCEL_POP_UP_WEB_VIEW";
		public static const SHARE:String="SHARE";
		public static const SHARE_TO_FACEBOOK:String="SHARE_TO_FACEBOOK";
		public static const SHARE_TO_TWITTER:String="SHARE_TO_TWITTER";
		public static const SHARE_TO_PINTEREST:String="SHARE_TO_PINTEREST";
		public static const SHARE_TO_MAILRU:String="SHARE_TO_MAILRU";
		public static const SHARE_TO_TUMBLR:String="SHARE_TO_TUMBLR";
				
		
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