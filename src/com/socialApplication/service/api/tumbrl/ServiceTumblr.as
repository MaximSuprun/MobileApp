package com.socialApplication.service.api.tumbrl{
	import com.socialApplication.common.Constants;
	import com.socialApplication.model.vo.VOImageInfo;
	import com.socialApplication.view.explore.common.PopUpWebView;
	
	import feathers.core.PopUpManager;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.flaircode.oauth.IOAuth;
	import org.flaircode.oauth.OAuth;
	import org.flaircode.oauth.OAuthLoader;
	import org.iotashan.oauth.OAuthToken;
	import org.iotashan.utils.OAuthUtil;
	
	public class ServiceTumblr implements IServiceTumblrPostImage{
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
		private var _imageInfo:VOImageInfo;
		private var _popUpWebView:PopUpWebView;
		private var _aPhotoUploader:URLLoader;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ServiceTumblr()
		{
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function postImage(pImageInfo:VOImageInfo):void{
			if(pImageInfo){
				_imageInfo=pImageInfo;
				_init();
			}
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
			var oauth:IOAuth = new OAuth(Constants.TUMBLR_KEY, Constants.TUMBLR_SECRET_KEY);
			
			// get request token
			var loader:URLLoader = oauth.getRequestToken("http://www.tumblr.com/oauth/request_token");
			loader.addEventListener(Event.COMPLETE, requestTokenHandler);
			var requestToken:OAuthToken;
			var accessToken:OAuthToken;
			
			function requestTokenHandler(e:Event):void
			{
				requestToken = OAuthUtil.getTokenFromResponse(e.currentTarget.data as String);
				var request:URLRequest = oauth.getAuthorizeRequest("http://www.tumblr.com/oauth/authorize", requestToken.key);
				// opens website where user has to login on Twitter and gets 6 digit pin code
				_popUpWebView=new PopUpWebView();
				PopUpManager.addPopUp(_popUpWebView,true,false);
				_popUpWebView.loadUrl=request.url;

			}
			
			function getAccessToken(pin:int):void
			{
				var loader:URLLoader = oauth.getAccessToken("http://www.tumblr.com/oauth/access_token", requestToken,null);
				loader.addEventListener(Event.COMPLETE, accessTokenHandler);
			}
			
			function accessTokenHandler(e:Event):void
			{
				accessToken = OAuthUtil.getTokenFromResponse(e.currentTarget.data as String);
				// TODO store accessToken.key and accessToken.secret in EncryptedLocalStorage for all further requests
			
			}
		}

		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerCompleteUploaded(event:Event):void{
			trace("complete");
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
		
		
