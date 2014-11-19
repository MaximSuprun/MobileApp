package com.socialApplication.view.settings{
	
	import com.socialApplication.service.replaceAutorizationData.EventServiceReplaceData;
	import com.socialApplication.view.createScreen.EventViewCreateScreen;
	
	import org.robotlegs.starling.mvcs.Mediator;
	

	
	public class MediatorViewSettings extends Mediator{
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
		
		public function MediatorViewSettings()
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
			addViewListener(EventViewSettings.LOG_OUT_ITEM,_handlerChangeScreen);
			addViewListener(EventViewSettings.CHANGE_DATA_LOGIN,_handlerChangeLogin);
			addViewListener(EventViewSettings.CHANGE_DATA_PASSWORD,_handlerChangePassword);
			addContextListener(EventServiceReplaceData.DATA_REPLACE,_handlerReplaceData);
		}

		override public function onRemove():void {
			super.onRemove();		
			removeViewListener(EventViewCreateScreen.MENU_CLICK,_handlerMenuClick);
			removeViewListener(EventViewSettings.LOG_OUT_ITEM,_handlerChangeScreen);
			removeViewListener(EventViewSettings.CHANGE_DATA_LOGIN,_handlerChangeLogin);
			removeViewListener(EventViewSettings.CHANGE_DATA_PASSWORD,_handlerChangePassword);
			removeContextListener(EventServiceReplaceData.DATA_REPLACE,_handlerReplaceData);
		}	
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		private function get _view():ViewSettings {
			return ViewSettings(viewComponent); 
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerMenuClick(event:EventViewCreateScreen):void{
			dispatch(new EventViewCreateScreen(EventViewCreateScreen.MENU_SHOW));
		}
		
		private function _handlerChangeScreen(event:EventViewSettings):void{
			dispatch(new EventViewSettings(EventViewSettings.LOG_OUT));
		}
		private function _handlerChangeLogin(event:EventViewSettings):void{
			dispatch(new EventViewSettings(EventViewSettings.REPLACE_DATA_LOGIN,event.payload));
		}
		private function _handlerChangePassword(event:EventViewSettings):void{
			dispatch(new EventViewSettings(EventViewSettings.REPLACE_DATA_PASSWORD,event.payload));
		}
		private function _handlerReplaceData(event:EventServiceReplaceData):void{
			_view.messageSuccess();
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