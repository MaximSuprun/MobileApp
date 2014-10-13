package com.socialApplication.service.api.facebook{
	import com.facebook.graph.FacebookMobile;
	import com.socialApplication.common.Constants;
	import com.socialApplication.model.vo.VOImageInfo;
	import com.socialApplication.view.explore.common.PopUpWebView;
	
	import feathers.core.PopUpManager;
	
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	
	import starling.core.Starling;
	
	public class ServiceFacebook implements IServiceFacebookPostImage{
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
		private var _popUpWebView:PopUpWebView;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ServiceFacebook()
		{
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function postImage(pImageInfo:VOImageInfo):void{
			_init();
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
			FacebookMobile.init(Constants.FACEBOOK_API_ID,_initCallBack);
		}
		protected function _initCallBack(response:Object, fail:Object):void {
			if (response) {
				trace("Logged In");
			} else {
				trace("Show login window");
				_login();				
			}
		}
		
		private function _loginCallBack(success:Object, fail:Object):void{
			if (success){
				trace("Logged In");
				if(_popUpWebView != null){
					PopUpManager.removePopUp(_popUpWebView);
					_popUpWebView = null;
				}
			}else{
				trace("Login Failed");
			}
		}
		
		private function _login():void{	
			
			_popUpWebView=new PopUpWebView();
			PopUpManager.addPopUp(_popUpWebView,true,false);
			FacebookMobile.login(_loginCallBack, Starling.current.nativeStage, ["publish_stream"],_popUpWebView.stageWebView);
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