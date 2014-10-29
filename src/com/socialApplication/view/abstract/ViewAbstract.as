package com.socialApplication.view.abstract{
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	
	import feathers.controls.Header;
	import feathers.core.FeathersControl;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	
	public class ViewAbstract extends FeathersControl{
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
		protected var header:Header;
		protected var footer:ViewAbstract;
		protected var isActivated:Boolean = false;
		private var _scale:Number=1;
		private var _background:DisplayObject;
		private var _backgroundSkin:DisplayObject;
		private var _content:Sprite=new Sprite();
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ViewAbstract(){
			content.width=Starling.current.nativeStage.stageWidth;
			content.height=Starling.current.nativeStage.stageHeight;
			content.alpha=0;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function contentShow (pDuration:Number,pDelay:Number=0,pCompleteFunction:Function=null):void {			
			
			TweenMax.to(_content,pDuration,{alpha:1,delay:pDelay,  ease:Cubic.easeInOut, onComplete:pCompleteFunction});
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get scale():Number{
			return _scale;
		}

		public function set scale(pScale:Number):void{
			if(pScale && _scale!=pScale){
				_scale = pScale;
			}			
		}		
		
		public function get content():Sprite{
			return _content;
		}
		
		public function set backgroundSkin(pBackgroundSkin:DisplayObject):void{
			if(pBackgroundSkin && pBackgroundSkin != _backgroundSkin){
				_backgroundSkin=pBackgroundSkin
				_backgroundSkin.x=Starling.current.nativeStage.stageWidth/2-_backgroundSkin.width/2;
				addChildAt(_backgroundSkin,0);
			}
		}

		public function get backgroundSkin():DisplayObject{
			return _backgroundSkin;
		}

		public function set background(pBackground:DisplayObject):void{
			if(pBackground && pBackground != _background){
				_background=pBackground;
				_background.x=Starling.current.nativeStage.stageWidth/2-_background.width/2;
				addChild(_background);
			}
		}
		public function get background():DisplayObject{
			return _background;
		}

		
		public function activateContent():void{
			isActivated = true;
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function initialize():void{
			super.initialize();
			
			addChild(content);
			
			header=new Header();
			header.setSize(Starling.current.nativeStage.stageWidth,85*scale)			
		}
		
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
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