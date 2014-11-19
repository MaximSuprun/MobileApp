package com.socialApplication.service.api.facebook{
	import com.facebook.graph.FacebookMobile;
	import com.razzmatazz.robotlegs.services.ServiceAbstract;
	import com.socialApplication.common.Constants;
	import com.socialApplication.model.vo.VOImageInfo;
	import com.socialApplication.service.api.EventServiceAPI;
	import com.socialApplication.view.components.popUps.PopUpWebView;
	
	import feathers.core.PopUpManager;
	
	import starling.core.Starling;	
	
	
	public class ServiceFacebook extends ServiceAbstract implements IServiceFacebookPostImage{
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
		private var _accessToken:String = "";
		private var _imageInfo:VOImageInfo;
		
		private static const FB_WALL:String = "/me/feed";
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
			var pParamsToFacebook:Object = {};
			
			pParamsToFacebook.message = _imageInfo.title;		
			pParamsToFacebook.picture = _imageInfo.url;		
			pParamsToFacebook.access_token = _accessToken;
			
			FacebookMobile.api(FB_WALL, _postCallback, pParamsToFacebook,Constants.METHOD_POST );
		}
		
		private function _postCallback(success:Object, fail:Object):void{
			if (success){
				dispatch(new EventServiceAPI(EventServiceAPI.PUBLISH_COMPLETE));
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