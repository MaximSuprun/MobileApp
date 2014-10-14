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
		private var _accessToken:String=""
		private var _imageInfo:VOImageInfo;
		
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
			_imageInfo=pImageInfo;
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
				_accessToken=response.accessToken;
				_postToWall()
				
			} else {
				_login();				
			}
		}
		
		private function _loginCallBack(success:Object, fail:Object):void{
			if (success){
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
			FacebookMobile.login(_loginCallBack, Starling.current.nativeStage, ["email","read_stream","publish_stream","publish_actions"],_popUpWebView.stageWebView);
		}
		
		private function _postToWall():void{
			var params:Object = {};
			
			params.message = _imageInfo.title;		
			params.picture = _imageInfo.url;		
			params.access_token = _accessToken;
			
			FacebookMobile.api("/me/feed", _postCallback, params, "POST");
		}
		
		private function _postCallback(success:Object, fail:Object):void{
			if (success){
				trace("post succes");
			}else{
				trace("post Failed");
			}
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