package com.socialApplication.service.api{
	import com.facebook.graph.FacebookMobile;
	import com.socialApplication.common.Constants;
	
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
		public function postImage():void{
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
			}else{
				trace("Login Failed");
			}
		}
		
		private function _login():void{
			var pWindiwLoginFacebook:StageWebView=new StageWebView();
			
			if(pWindiwLoginFacebook==null){
				pWindiwLoginFacebook = new StageWebView();
				pWindiwLoginFacebook.stage = Starling.current.nativeStage;
			}
			pWindiwLoginFacebook.viewPort = new Rectangle(0, 50, Starling.current.nativeStage.stageWidth, Starling.current.nativeStage.stageHeight/2);//for cancel fblogin button
			FacebookMobile.login(_loginCallBack, Starling.current.nativeStage, ["publish_stream"],pWindiwLoginFacebook);
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