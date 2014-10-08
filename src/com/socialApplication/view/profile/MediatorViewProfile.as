package com.socialApplication.view.profile{
	
	import com.socialApplication.model.vo.VOImageInfo;
	import com.socialApplication.model.vo.VOUserData;
	import com.socialApplication.service.getImageInfo.EventServiceGetImageInfo;
	import com.socialApplication.service.loadImage.EventServiceLoadImage;
	import com.socialApplication.view.createScreen.EventViewCreateScreen;
	
	import feathers.data.ListCollection;
	
	import org.robotlegs.starling.mvcs.Mediator;
	
	import starling.display.Image;
	import starling.textures.Texture;
	

	
	public class MediatorViewProfile extends Mediator{
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
		
		public function MediatorViewProfile()
		{
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
			addViewListener(EventViewProfile.AVATAR_LOAD,_handlerAvatarLoad);
			addViewListener(EventViewProfile.IMAGE_LOAD,_handlerImageLoad);
			addViewListener(EventViewProfile.IMAGE_SELECTED,_handlerImageSelected);
			addContextListener(EventServiceLoadImage.AVATAR_IMAGE_LOADED,_handlerAvatarLoaded);
			addContextListener(EventServiceGetImageInfo.RESULT,_handlerImageInfoLoaded);
			dispatch(new EventViewProfile(EventViewProfile.LOAD_USER_DATA,null, _setUserData));
		}
		override public function onRemove():void {
			super.onRemove();		
		}	
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		private function get _view():ViewProfile {
			return ViewProfile(viewComponent); 
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------	        
		
		private function _setUserData(pUserData:VOUserData):void{
			_view.userData=pUserData;
		}  
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerMenuClick(event:EventViewCreateScreen):void{
			dispatch(new EventViewCreateScreen(EventViewCreateScreen.MENU_SHOW));
		}
		
		private function _handlerAvatarLoad(event:EventViewProfile):void{
			var pUrl:String=String(event.payload);
			dispatch(new EventViewProfile(EventViewProfile.AVATAR_LOAD,pUrl));
		}
		
		private function _handlerImageSelected(event:EventViewProfile):void{
			var pVOImageInfo:VOImageInfo=VOImageInfo(event.payload);
			dispatch(new EventViewProfile(EventViewProfile.IMAGE_SELECTED,pVOImageInfo));
		}
		
		private function _handlerImageLoad(event:EventViewProfile):void{
			_view.popUpCreate();
			dispatch(new EventViewProfile(EventViewProfile.IMAGE_LOAD,event.payload));
		}
		
		private function _handlerImageInfoLoaded(event:EventServiceGetImageInfo):void{
			var pImageListCollection:ListCollection=ListCollection(event.payload);
			_view.imageListCollection=pImageListCollection;
		}
		
		private function _handlerAvatarLoaded(event:EventServiceLoadImage):void{
			var pImageAvatar:Image=new Image(Texture(event.payload));
			_view.avatar=pImageAvatar;
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