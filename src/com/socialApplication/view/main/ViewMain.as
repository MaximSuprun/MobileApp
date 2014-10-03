package com.socialApplication.view.main{
	
	
	import com.socialApplication.common.Constants;
	import com.socialApplication.model.vo.VOUserData;
	import com.socialApplication.view.createScreen.ViewCreateScreen;
	import com.socialApplication.view.introductionPanel.ViewIntroduction;
	import com.socialApplication.view.login.ViewLogin;
	import com.socialApplication.view.menu.ViewMenu;
	import com.socialApplication.view.profile.ViewProfile;
	import com.socialApplication.view.settings.ViewSettings;
	
	import feathers.controls.Drawers;
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.worksMobileTheme.source.feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class ViewMain extends Sprite{
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
		private var _backgrounImage:Image;
		private var _themeApp:MetalWorksMobileTheme;
		private var _screenNavigator:ScreenNavigator;
	    private var _introductionScreen:ViewIntroduction;
		private var _loginScreen:ViewLogin;
		private var _createScreen:ViewCreateScreen;
		private var _transitionManager:ScreenSlidingStackTransitionManager;
		private var _drawers:Drawers;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ViewMain(){
			super();
			addEventListener(Event.ADDED_TO_STAGE,_handlerAddedToStage) 
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
    
		public function viewLoginAdd():void{
			if(_drawers.leftDrawer){
				_drawers.leftDrawer=null;
			}
			_screenNavigator.showScreen(Constants.ID_VIEW_LOGIN);
		}
		
		public function loginSuccess(pUserData:VOUserData):void{
			_screenNavigator.showScreen(Constants.ID_VIEW_PROFILE);
			
			var pLeftDrawer:ViewMenu = new ViewMenu();
			_drawers.leftDrawer = pLeftDrawer;	
		}

		public function showMenu():void{
			_drawers.toggleLeftDrawer(0.4);
		}
		
		public function showScreen(pScreen:String):void{
			
			if(_screenNavigator.activeScreenID==pScreen){
				return;
			}
			
			showMenu();
			_screenNavigator.clearScreen();
			_screenNavigator.showScreen(pScreen);
		}
	
		
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
			_themeApp=new MetalWorksMobileTheme();	
			
			// ТАК НЕЛЬЗЯ ДЕЛАТЬ БЛЕАТЬ!!!!!!!!!!!!!!!!!!!!!!! :)
			//this.x=-(_themeApp.difference/2);
			
			_screenNavigator=new ScreenNavigator();
			
			_screenNavigator.addScreen(Constants.ID_VIEW_INTRODUCTION,new ScreenNavigatorItem(ViewIntroduction));
			_screenNavigator.addScreen(Constants.ID_VIEW_LOGIN,new ScreenNavigatorItem(ViewLogin));
			_screenNavigator.addScreen(Constants.ID_VIEW_CREATE,new ScreenNavigatorItem(ViewCreateScreen));		
			_screenNavigator.addScreen(Constants.ID_VIEW_PROFILE,new ScreenNavigatorItem(ViewProfile));		
			_screenNavigator.addScreen(Constants.ID_VIEW_SETTINGS,new ScreenNavigatorItem(ViewSettings));		
			
			_transitionManager=new ScreenSlidingStackTransitionManager(_screenNavigator);
			_transitionManager.duration=0.4;
			addChild(_screenNavigator);
			
			_drawers=new Drawers();
			_drawers.content = _screenNavigator;
				
			addChild(_drawers);
			
			introAdd();
		}
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerAddedToStage(event:Event):void{
			_init();
		}
		
		private function introAdd():void{
			_screenNavigator.showScreen(Constants.ID_VIEW_INTRODUCTION);
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