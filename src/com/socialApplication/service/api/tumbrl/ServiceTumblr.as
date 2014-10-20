package com.socialApplication.service.api.tumbrl{
	import com.adobe.protocols.oauth2.OAuth2;
	import com.socialApplication.common.Constants;
	import com.socialApplication.model.vo.VOImageInfo;
	import com.socialApplication.view.explore.EventViewExplore;
	import com.socialApplication.view.explore.common.PopUpWebView;
	
	import feathers.core.PopUpManager;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import org.flaircode.oauth.IOAuth;
	import org.flaircode.oauth.OAuth;
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
			_popUpWebView.addEventListener(EventViewExplore.STAGE_WEB_VIEW_LOCATION_CHANGE, _handlerLocationChange);
			_popUpWebView.addEventListener(EventViewExplore.STAGE_WEB_VIEW_LOCATION_CHANGING, _handlerLocationChanging);
			PopUpManager.addPopUp(_popUpWebView,true,false);
			_popUpWebView.loadUrl=request.url;
		}
				
		private function _handlerCompleteUploaded(event:Event):void{
			trace("complete");
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
		
		
