package com.socialApplication.view.createScreen{
	
	import com.socialApplication.service.loadImage.EventServiceLoadImage;
	
	import org.robotlegs.starling.mvcs.Mediator;
	
	import starling.textures.Texture;
	

	
	public class MediatorViewCreateScreen extends Mediator{
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
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function MediatorViewCreateScreen(){
			super();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function onRegister():void {
			super.onRegister();
			addViewListener(EventViewCreateScreen.MENU_CLICK,_handlerMenuClick);
			addViewListener(EventViewCreateScreen.TAKE_PHOTO_CLICK,_handlerTakePhotoClick);
			addViewListener(EventViewCreateScreen.ADD_FROM_DEVICE,_handlerAddFromDeviceClick);
			addContextListener(EventServiceLoadImage.CAMERA_OR_DEVICE_IMAGE_LOADED,_handlerImageLoaded);
			
		}

		override public function onRemove():void {
			super.onRemove();		
		}	
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		private function get _view():ViewCreateScreen {
			return ViewCreateScreen(viewComponent); 
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		private function _handlerMenuClick(event:EventViewCreateScreen):void{
			dispatch(new EventViewCreateScreen(EventViewCreateScreen.MENU_SHOW));
		}
		private function _handlerTakePhotoClick(event:EventViewCreateScreen):void{
			dispatch(new EventViewCreateScreen(EventViewCreateScreen.CREATE_PHOTO));
		}
		private function _handlerAddFromDeviceClick(event:EventViewCreateScreen):void{
			dispatch(new EventViewCreateScreen(EventViewCreateScreen.ADD_IMAGE_FROM_DEVICE));
		}
		private function _handlerImageLoaded(event:EventServiceLoadImage):void{
			_view.imageLoadedAdd(Texture(event.payload));
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