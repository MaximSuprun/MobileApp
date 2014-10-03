package com{
	
	import com.socialApplication.controller.CommandChekInputedData;
	import com.socialApplication.controller.CommandCreatePhoto;
	import com.socialApplication.controller.CommandDataInputed;
	import com.socialApplication.controller.CommandFromServerImageInfoLoad;
	import com.socialApplication.controller.CommandLoadAvatar;
	import com.socialApplication.controller.CommandLoadGalleryDevice;
	import com.socialApplication.controller.CommandLogOut;
	import com.socialApplication.controller.CommandReplaceAutorizationData;
	import com.socialApplication.controller.CommandSetAutorizationData;
	import com.socialApplication.controller.CommandSetUserData;
	import com.socialApplication.controller.CommandStartup;
	import com.socialApplication.controller.CommandUserDataLoaded;
	import com.socialApplication.model.EventModel;
	import com.socialApplication.model.IModel;
	import com.socialApplication.model.Model;
	import com.socialApplication.service.getImageInfo.IServiceGetImageInfo;
	import com.socialApplication.service.getImageInfo.ServiceGetImageInfo;
	import com.socialApplication.service.loadImage.avatar.IServiceLoadAvatar;
	import com.socialApplication.service.loadImage.avatar.ServiceLoadAvatar;
	import com.socialApplication.service.loadImage.photoAndDevice.IServiceLoadFromDeviceAndCamera;
	import com.socialApplication.service.loadImage.photoAndDevice.ServiceLoadFromDeviceAndCamera;
	import com.socialApplication.service.logout.IServiceLogOut;
	import com.socialApplication.service.logout.ServiceLogOut;
	import com.socialApplication.service.replaceAutorizationData.IServiceReplaceData;
	import com.socialApplication.service.replaceAutorizationData.ServiceReplaceData;
	import com.socialApplication.service.singin.EventServiceSingin;
	import com.socialApplication.service.singin.IServiceSingin;
	import com.socialApplication.service.singin.ServiceSingin;
	import com.socialApplication.view.createScreen.EventViewCreateScreen;
	import com.socialApplication.view.createScreen.MediatorViewCreateScreen;
	import com.socialApplication.view.createScreen.ViewCreateScreen;
	import com.socialApplication.view.introductionPanel.MediatorViewIntroduction;
	import com.socialApplication.view.introductionPanel.ViewIntroduction;
	import com.socialApplication.view.login.EventViewLogin;
	import com.socialApplication.view.login.MediatorViewLogin;
	import com.socialApplication.view.login.ViewLogin;
	import com.socialApplication.view.main.MediatorViewMain;
	import com.socialApplication.view.main.ViewMain;
	import com.socialApplication.view.menu.MediatorViewMenu;
	import com.socialApplication.view.menu.ViewMenu;
	import com.socialApplication.view.profile.EventViewProfile;
	import com.socialApplication.view.profile.MediatorViewProfile;
	import com.socialApplication.view.profile.ViewProfile;
	import com.socialApplication.view.settings.EventViewSettings;
	import com.socialApplication.view.settings.MediatorViewSettings;
	import com.socialApplication.view.settings.ViewSettings;
	
	import org.robotlegs.starling.base.ContextEventType;
	import org.robotlegs.starling.mvcs.Context;
	
	import starling.display.DisplayObjectContainer;
	
	public class ContextSocialApplication extends Context{
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
		
		public function ContextSocialApplication(contextView:DisplayObjectContainer=null, autoStartup:Boolean=true)
		{
			super(contextView, autoStartup);
			//test Git
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function startup():void{
		
			//service				

			// map View		

			mediatorMap.mapView(ViewMain, MediatorViewMain);
			mediatorMap.mapView(ViewIntroduction, MediatorViewIntroduction);
			mediatorMap.mapView(ViewLogin, MediatorViewLogin);
			mediatorMap.mapView(ViewCreateScreen, MediatorViewCreateScreen);
			mediatorMap.mapView(ViewProfile, MediatorViewProfile);
			mediatorMap.mapView(ViewMenu, MediatorViewMenu);
			mediatorMap.mapView(ViewSettings, MediatorViewSettings);
						
			// Command
			commandMap.mapEvent(ContextEventType.STARTUP_COMPLETE,CommandStartup);
						
			commandMap.mapEvent(EventModel.DATA_INPUTED,CommandChekInputedData,EventModel);
			commandMap.mapEvent(EventModel.REPLACE_LOGIN,CommandReplaceAutorizationData,EventModel);
			commandMap.mapEvent(EventModel.REPLACE_PASSWORD,CommandReplaceAutorizationData,EventModel);
			
			commandMap.mapEvent(EventViewLogin.LOGIN_DATA,CommandDataInputed,EventViewLogin);
			
			commandMap.mapEvent(EventServiceSingin.RESULT,CommandUserDataLoaded,EventServiceSingin);
			
			commandMap.mapEvent(EventViewProfile.LOAD_USER_DATA,CommandSetUserData,EventViewProfile);
			commandMap.mapEvent(EventViewProfile.AVATAR_LOAD,CommandLoadAvatar,EventViewProfile);
			commandMap.mapEvent(EventViewProfile.IMAGE_LOAD,CommandFromServerImageInfoLoad,EventViewProfile);
			
			commandMap.mapEvent(EventViewCreateScreen.ADD_IMAGE_FROM_DEVICE,CommandLoadGalleryDevice,EventViewCreateScreen);
			commandMap.mapEvent(EventViewCreateScreen.CREATE_PHOTO,CommandCreatePhoto,EventViewCreateScreen);
			
			commandMap.mapEvent(EventViewSettings.REPLACE_DATA_LOGIN,CommandSetAutorizationData,EventViewSettings);
			commandMap.mapEvent(EventViewSettings.REPLACE_DATA_PASSWORD,CommandSetAutorizationData,EventViewSettings);
			commandMap.mapEvent(EventViewSettings.LOG_OUT,CommandLogOut,EventViewSettings);
			
			// Command service
			
			
			
			//Command Result
			
			
			
			// Model
			injector.mapSingletonOf(IModel, Model);
			injector.mapSingletonOf(IServiceReplaceData, ServiceReplaceData);
			injector.mapSingletonOf(IServiceLoadAvatar, ServiceLoadAvatar);
			injector.mapSingletonOf(IServiceLogOut, ServiceLogOut);
			injector.mapSingletonOf(IServiceLoadFromDeviceAndCamera, ServiceLoadFromDeviceAndCamera);
			injector.mapSingletonOf(IServiceSingin, ServiceSingin);
			injector.mapSingletonOf(IServiceGetImageInfo, ServiceGetImageInfo);
			
			super.startup();
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