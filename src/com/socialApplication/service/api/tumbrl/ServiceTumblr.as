package com.socialApplication.service.api.tumbrl{
	import com.adobe.protocols.oauth2.OAuth2;
	import com.adobe.protocols.oauth2.event.GetAccessTokenEvent;
	import com.adobe.protocols.oauth2.grant.IGrantType;
	import com.adobe.protocols.oauth2.grant.ImplicitGrant;
	import com.socialApplication.common.Constants;
	import com.socialApplication.model.vo.VOImageInfo;
	import com.socialApplication.view.explore.EventViewExplore;
	import com.socialApplication.view.explore.common.PopUpWebView;
	
	import feathers.core.PopUpManager;
	
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.ByteArray;
	
	import isle.susisu.twitter.Twitter;
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.events.TwitterErrorEvent;
	import isle.susisu.twitter.events.TwitterRequestEvent;
	
	import org.as3commons.logging.setup.LogSetupLevel;
	
	import starling.events.Event;
	
	
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
			_popUpWebView=new PopUpWebView();
			PopUpManager.addPopUp(_popUpWebView,true,false);
			var pOauth:OAuth2=new OAuth2("http://www.tumblr.com/oauth/authorize","https://http://www.tumblr.com/oauth/access_token",LogSetupLevel.ALL);
			var pGrant:IGrantType = new ImplicitGrant(_popUpWebView.stageWebView,"RFeLGlS6VYXXkHj2X4oUDZp4Rscd0OgTd6OzFTSgfQljIL7f0s","https://oauth.vk.com/blank");
			pOauth.addEventListener(GetAccessTokenEvent.TYPE, onGetAccessToken);
			pOauth.getAccessToken(pGrant);
		}
		private function _removePopUp():void{
			if(_popUpWebView != null){
				_popUpWebView.stageWebViewDispose();
				PopUpManager.removePopUp(_popUpWebView);
				_popUpWebView = null;
			}			
		}
		
		
		private function onGetAccessToken(getAccessTokenEvent:GetAccessTokenEvent):void	{
			
			_removePopUp();
			
			if (getAccessTokenEvent.errorCode == null && getAccessTokenEvent.errorMessage == null){
				// success!
				trace("Your access token value is: " + getAccessTokenEvent.accessToken);
				/*_vid=getAccessTokenEvent.response.x_mailru_vid;
				_accessToken = getAccessTokenEvent.accessToken;*/
				//_postToMail();
			}else{
				// fail :(
				trace("looser ");
			}
		} 
		
		/*private function _postToMail():void{
			var pApi:MyApiNode=new MyApiNode(_vid,Constants.MAILRU_ID,Constants.MAILRU_PRIVATE_KEY,_accessToken);
			_query=pApi.photosUpload("_myphoto",_imageInfo.url,_imageInfo.title);
			_urlRequest=new URLRequest(_query);
			_urlLoader=new URLLoader  ;
			_urlLoader.addEventListener(Event.COMPLETE,_handlerCompleteUploaded);
			_urlLoader.load(_urlRequest);
		}*/
		
		private function _handlerCompleteUploaded(event:Event):void{
			trace("complete upload to Mail.ru");
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