package{
	
	import com.socialApplication.view.ViewSocialApplication;
	
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import starling.core.Starling;

	
	
	[SWF(width='640',height="960",frameRate='60')]
	public class MobileApp extends Sprite{
		
		[Embed(source="/./feathers/worksMobileTheme/assets/icons/16.png")]
		protected static const ICON_16:Class;		
		
		[Embed(source="/./feathers/worksMobileTheme/assets/icons/29.png")]
		protected static const ICON_29:Class;	
		
		[Embed(source="/./feathers/worksMobileTheme/assets/icons/32.png")]
		protected static const ICON_32:Class;	
		
		[Embed(source="/./feathers/worksMobileTheme/assets/icons/36.png")]
		protected static const ICON_36:Class;	
		
		[Embed(source="/./feathers/worksMobileTheme/assets/icons/48.png")]
		protected static const ICON_48:Class;	
		
		[Embed(source="/./feathers/worksMobileTheme/assets/icons/57.png")]
		protected static const ICON_57:Class;	
		
		[Embed(source="/./feathers/worksMobileTheme/assets/icons/72.png")]
		protected static const ICON_72:Class;	
		
		[Embed(source="/./feathers/worksMobileTheme/assets/icons/114.png")]
		protected static const ICON_114:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/icons/128.png")]
		protected static const ICON_128:Class;	
		
		[Embed(source="/./feathers/worksMobileTheme/assets/icons/512.png")]
		protected static const ICON_512:Class;	
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		private var _starling:Starling;
		private var _viewQPrint:ViewSocialApplication;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function MobileApp(){
		 	stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			addEventListener(Event.ADDED_TO_STAGE,_handlerAddedToStage,false,0,true);
			stage.addEventListener(Event.RESIZE, _handlerStageResize, false, int.MAX_VALUE, true);
		}
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		private function _init():void{
			_starling=new Starling(ViewSocialApplication,stage);
			_starling.showStats=true;
			_starling.start();		
		}
		

		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerAddedToStage(event:Event):void{			
			_init()
		}
		
		private function _handlerStageResize(event:Event):void
		{
			this._starling.stage.stageWidth = this.stage.stageWidth;
			this._starling.stage.stageHeight = this.stage.stageHeight;
			
			const viewPort:Rectangle = this._starling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			try
			{
				this._starling.viewPort = viewPort;
			}
			catch(error:Error) {}
			//this._starling.showStatsAt(HAlign.LEFT, VAlign.BOTTOM);
		}

		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  HELPERS  
		// 
		//--------------------------------------------------------------------------------------------------------- 
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  END CLASS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		
	}
}