package com.socialApplication.service.api.tumbrl{
	import com.razzmatazz.robotlegs.events.EventError;
	import com.socialApplication.common.Constants;
	import com.socialApplication.model.vo.VOImageInfo;
	import com.socialApplication.view.explore.EventViewExplore;
	import com.socialApplication.view.explore.common.PopUpWebView;
	
	import feathers.core.PopUpManager;
	
	import flash.errors.IOError;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	
	import org.flaircode.oauth.IOAuth;
	import org.flaircode.oauth.OAuth;
	import org.iotashan.oauth.OAuthRequest;
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
		private var _requestToken:OAuthToken;
		private var _accessToken:OAuthToken;
		private var _oauth:IOAuth;
		
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
			var loader:URLLoader = _oauth.getRequestToken("https://www.tumblr.com/oauth/request_token");
			loader.addEventListener(Event.COMPLETE, _handlerRequestToken);
			
		}
		
		private function _removePopUp():void{
			if(_popUpWebView != null){
				_popUpWebView.stageWebViewDispose();
				PopUpManager.removePopUp(_popUpWebView);
				_popUpWebView = null;
			}			
		}
			
		private function _getUserInfo():void{
			var pLoader:URLLoader=new URLLoader();
			var pRequest:URLRequest=_oauth.buildRequest(OAuthRequest.HTTP_MEHTOD_GET,"http://api.tumblr.com/v2/user/info",_requestToken);
			pRequest.method=URLRequestMethod.POST;
			pLoader.load(pRequest);
			trace(pRequest.url);
			pLoader.addEventListener(Event.COMPLETE,_handlerCompleteLoadedUserInfo);
			pLoader.addEventListener(EventError.ERROR,_handlerErrorLoadedUserInfo);
			pLoader.addEventListener(IOErrorEvent.IO_ERROR,_handlerErrorIOLoadedUserInfo);
			pLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,_handlerErrorSecurityLoadedUserInfo);
		}

		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerRequestToken(e:Event):void{					
			_requestToken = OAuthUtil.getTokenFromResponse(e.currentTarget.data as String);
			var request:URLRequest = _oauth.getAuthorizeRequest("https://www.tumblr.com/oauth/authorize", _requestToken.key);
			
			_popUpWebView=new PopUpWebView();
			_popUpWebView.addEventListener(EventViewExplore.STAGE_WEB_VIEW_COMPLETE, _handlerCompleteLoad);
			_popUpWebView.addEventListener(EventViewExplore.STAGE_WEB_VIEW_ERROR, _handlerloadError);
			_popUpWebView.addEventListener(EventViewExplore.STAGE_WEB_VIEW_LOCATION_CHANGE,_handlerLocationChange );
			_popUpWebView.addEventListener(EventViewExplore.STAGE_WEB_VIEW_LOCATION_CHANGING,_handlerLocationChanging );
			PopUpManager.addPopUp(_popUpWebView,true,false);3
			_popUpWebView.loadUrl=request.url;
		}
				
		private function _handlerCompleteLoadedUserInfo(event:Event):void{
			trace("complete");
		}
		private function _handlerErrorLoadedUserInfo(event:EventError):void{
			trace("error");
		}
		private function _handlerErrorIOLoadedUserInfo(event:IOErrorEvent):void{
			trace("error");
		}
		private function _handlerErrorSecurityLoadedUserInfo(event:SecurityErrorEvent):void{
			trace("error");
		}
				
		private function _handlerCompleteLoad(event:EventViewExplore):void{
			trace("loadedWebView");
		}
		private function _handlerloadError(event:EventViewExplore):void{
			trace("errorWebView");
		}
		private function _handlerLocationChanging(event:EventViewExplore):void{
			trace("location change:" + event.payload.location);
		}
		private function _handlerLocationChange(event:EventViewExplore):void{
			trace("location changing: " + event.payload.location);
			if(String(event.payload.location).search("oauth_verifier")!=-1){
				_removePopUp();
				_getUserInfo();
			}
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
		
		
