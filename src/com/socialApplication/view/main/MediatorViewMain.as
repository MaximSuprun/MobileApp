package com.socialApplication.view.main{
	
	import com.socialApplication.model.EventModel;
	import com.socialApplication.model.vo.VOUserData;
	import com.socialApplication.view.createScreen.EventViewCreateScreen;
	import com.socialApplication.view.introductionPanel.EventViewIntroduction;
	import com.socialApplication.view.menu.EventViewMenu;
	import com.socialApplication.view.settings.EventViewSettings;
	
	import org.robotlegs.starling.mvcs.Mediator;
	

	
	public class MediatorViewMain extends Mediator{
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
		
		public function MediatorViewMain()
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
			addContextListener(EventViewIntroduction.GET_STARTED,_handlerGetStarted);
			addContextListener(EventModel.LOGIN_SUCCES,_handlerLoginSucces)
			addContextListener(EventViewCreateScreen.MENU_SHOW,_handlerShowMenu);
			addContextListener(EventViewMenu.CHANGE_SCREEN,_handlerChangeScreen);
			addContextListener(EventViewSettings.LOG_OUT,_handlerLogOut);
		}

		override public function onRemove():void {
			super.onRemove();		
		}	
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		private function get _view():ViewMain {
			return ViewMain(viewComponent); 
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
		private function _handlerGetStarted(event:EventViewIntroduction):void{
			_view.viewLoginAdd();
		}
		
		private function _handlerLoginSucces(event:EventModel):void{
			var pVOUserData:VOUserData=VOUserData(event.payload);
			_view.loginSuccess(pVOUserData);
		}
		
		private function _handlerShowMenu(event:EventViewCreateScreen):void{
			_view.showMenu();
		}
		
		private function _handlerChangeScreen(event:EventViewMenu):void{
			_view.showScreen(event.payload.screen);
		}
		private function _handlerLogOut(event:EventViewSettings):void{
			_view.viewLoginAdd();
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