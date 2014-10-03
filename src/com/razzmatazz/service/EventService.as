package com.razzmatazz.service {
	import starling.events.Event;
	
	
	
	public class EventService extends Event {
		
		public var argument:Object;
		
		public static var SUCCESS:String = "SUCCESS";
		public static var STATUS:String = "STATUS";
		public static var ERROR:String = "ERROR";
		
		
		public function EventService(type:String, bubbles:Boolean=false, cancelable:Boolean=false){
			super(type, bubbles, cancelable);
		}
		
		/*override public function clone():Event {
			return new EventService(type, bubbles, cancelable)
		}*/
	}
}