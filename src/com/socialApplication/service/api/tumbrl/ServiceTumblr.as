package com.socialApplication.service.api.tumbrl{
	import com.razzmatazz.robotlegs.services.ServiceAbstract;
	import com.socialApplication.common.Constants;
	import com.socialApplication.model.vo.VOImageInfo;
	import com.socialApplication.service.api.EventServiceAPI;
	import com.socialApplication.view.explore.EventViewExplore;
	import com.socialApplication.view.components.popUps.PopUpWebView;
	
	import feathers.core.PopUpManager;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	
	import org.flaircode.oauth.IOAuth;
	import org.flaircode.oauth.OAuth;
	import org.iotashan.oauth.OAuthConsumer;
	import org.iotashan.oauth.OAuthRequest;
	import org.iotashan.oauth.OAuthSignatureMethod_HMAC_SHA1;
	import org.iotashan.oauth.OAuthToken;
	import org.iotashan.utils.OAuthUtil;
	
	public class ServiceTumblr extends ServiceAbstract implements IServiceTumblrPostImage{
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
		private var _requestToken:OAuthToken;
		private var _accessToken:OAuthToken;
		private var _oauth_verifier:String;
		private var _oauth:IOAuth;
		private var _userBlogName:String;
		
		private static const URL_AUTHORIZATION:String = "https://www.tumblr.com/oauth/authorize";
		private static const URL_REQUEST_TOKEN:String = "https://www.tumblr.com/oauth/request_token";
		private static const URL_ACCESS_TOKEN:String = "https://www.tumblr.com/oauth/access_token";
		private static const USER_INFO:String = "https://api.tumblr.com/v2/user/info";
		
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
			_oauth = new OAuth(Constants.TUMBLR_KEY, Constants.TUMBLR_SECRET_KEY);
			// get request token
			var pLoader:URLLoader = _oauth.getRequestToken(URL_REQUEST_TOKEN);
			pLoader.addEventListener(Event.COMPLETE, _handlerRequestToken);			
		}
		
		private function _removePopUp():void{
			if(_popUpWebView != null){
				_popUpWebView.stageWebViewDispose();
				PopUpManager.removePopUp(_popUpWebView);
				_popUpWebView = null;
			}			
		}
			
		private function _getUserInfo():void{
			var pOAuthRequest:OAuthRequest = new OAuthRequest(Constants.METHOD_GET,USER_INFO,null,new OAuthConsumer(Constants.TUMBLR_KEY,Constants.TUMBLR_SECRET_KEY),_accessToken);			
			var pLoader:URLLoader=new URLLoader();
			
			pLoader.addEventListener(Event.COMPLETE,_handlerCompleteLoadedUserInfo);
			pLoader.addEventListener(IOErrorEvent.IO_ERROR,_handlerErrorIO);
			
			var requestURL:String = pOAuthRequest.buildRequest(new OAuthSignatureMethod_HMAC_SHA1());			
			pLoader.load(new URLRequest(requestURL));
		}
		
		private function _getAccesToken():void{
			var pUrlLoader:URLLoader = _oauth.getAccessToken(URL_ACCESS_TOKEN,_requestToken,{"oauth_verifier":_oauth_verifier,"oauth_callback_confirmed":true});
			pUrlLoader.addEventListener(Event.COMPLETE, _handlerAccessToken);
		}
		
		private function _doPost():void{
			var pParams:Object = {};
			pParams.type= 'photo';
			pParams.source = _imageInfo.url;
			
			var pOauthRequest:OAuthRequest = new OAuthRequest( Constants.METHOD_POST, "http://api.tumblr.com/v2/blog/"+_userBlogName+".tumblr.com/post", pParams, new OAuthConsumer(Constants.TUMBLR_KEY,Constants.TUMBLR_SECRET_KEY),_accessToken);
			
			var pRequest:URLRequest = new URLRequest( pOauthRequest.buildRequest(new OAuthSignatureMethod_HMAC_SHA1()));
			pRequest.contentType = "application/x-www-form-urlencoded";
			pRequest.method = Constants.METHOD_POST;
			
			var pUrlVariables:URLVariables = new URLVariables();
			pUrlVariables.type = 'photo';
			pUrlVariables.source = _imageInfo.url;
			
			pRequest.data = pUrlVariables;
			var pLoader:URLLoader = new URLLoader();
			pLoader.addEventListener( Event.COMPLETE, _handlerCompletePost);
			pLoader.addEventListener( IOErrorEvent.IO_ERROR, _handlerErrorIO);
			pLoader.load(pRequest);
		}

		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerRequestToken(event:Event):void{	
			
			_requestToken = OAuthUtil.getTokenFromResponse(event.currentTarget.data as String);
			var request:URLRequest = _oauth.getAuthorizeRequest(URL_AUTHORIZATION, _requestToken.key);
			
			_popUpWebView=new PopUpWebView();
			_popUpWebView.addEventListener(EventViewExplore.STAGE_WEB_VIEW_COMPLETE, _handlerCompleteLoad);
			_popUpWebView.addEventListener(EventViewExplore.STAGE_WEB_VIEW_ERROR, _handlerloadError);
			_popUpWebView.addEventListener(EventViewExplore.STAGE_WEB_VIEW_LOCATION_CHANGE,_handlerLocationChange );
			PopUpManager.addPopUp(_popUpWebView,true,false);
			_popUpWebView.loadUrl=request.url;
		}
		private function _handlerAccessToken(event:Event):void{					
			_accessToken = OAuthUtil.getTokenFromResponse(event.currentTarget.data as String);
			_getUserInfo();
		}
				
		
		private function _handlerCompleteLoadedUserInfo(event:Event):void{
			var pResponseJSON:Object = JSON.parse(event.currentTarget.data.toString());
			_userBlogName = pResponseJSON.response.user.name;
			_doPost();
		}
		
		private function _handlerErrorIO(event:IOErrorEvent):void{
			trace("errorIO");
		}
				
		private function _handlerCompleteLoad(event:EventViewExplore):void{
			trace("loadedWebView");
		}
		private function _handlerloadError(event:EventViewExplore):void{
			trace("errorWebView");
		}
	
		private function _handlerLocationChange(event:EventViewExplore):void{
			
			var pResponseData:String=String(event.payload.location);
			
			if(pResponseData.search("oauth_verifier")!=-1){
				_oauth_verifier=pResponseData.substring(pResponseData.search("oauth_verifier=")+"oauth_verifier=".length,pResponseData.search("#"));
				_removePopUp();
				_getAccesToken();
			}
		}	
		
		private function _handlerCompletePost(event:Event):void{
			trace("Posting tu Tumblr complete");
			dispatch(new EventServiceAPI(EventServiceAPI.PUBLISH_COMPLETE));
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
		
		
