package com.socialApplication.view.abstract{
	
	import feathers.controls.Header;
	import feathers.core.FeathersControl;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	
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
		private var _scale:Number=1;
		private var _background:DisplayObject;
		private var _backgroundSkin:DisplayObject;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ViewAbstract(){

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
		public function get scale():Number{
			return _scale;
		}

		public function set scale(pScale:Number):void{
			if(pScale && _scale!=pScale){
				_scale = pScale;
			}			
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

		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function initialize():void{
			super.initialize();
			
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