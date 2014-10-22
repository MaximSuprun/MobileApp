package com.socialApplication.service.api.vk{
	import com.adobe.protocols.oauth2.OAuth2;
	import com.adobe.protocols.oauth2.event.GetAccessTokenEvent;
	import com.adobe.protocols.oauth2.grant.IGrantType;
	import com.adobe.protocols.oauth2.grant.ImplicitGrant;
	import com.razzmatazz.robotlegs.events.EventError;
	import com.socialApplication.common.Constants;
	import com.socialApplication.model.vo.VOImageInfo;
	import com.socialApplication.service.api.mailRu.my.MyApiNode;
	import com.socialApplication.view.explore.common.PopUpWebView;
	
	import feathers.core.PopUpManager;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.as3commons.logging.setup.LogSetupLevel;
	
	
	
	public class ServiceVK implements IServiceVKPostImage{
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
		private var _query:String;
		private var _urlLoader:URLLoader;
		private var _urlRequest:URLRequest;
		private var _userId:String;
		private var _accessToken:String;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ServiceVK()
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
			var pOauth:OAuth2=new OAuth2("https://oauth.vk.com/authorize","https://oauth.vk.com/blank",LogSetupLevel.ALL);
			var pGrant:IGrantType = new ImplicitGrant(_popUpWebView.stageWebView,Constants.VK_ID,"https://oauth.vk.com/blank","wall,photo");
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
				_userId=getAccessTokenEvent.response.user_id;
				_accessToken = getAccessTokenEvent.accessToken;
				_postToVk();
			}else{
				// fail :(
				trace("looser ");
			}
		} 
		
		private function _postToVk():void{
			
			_query=	"https://api.vk.com/method/wall.post?owner_id="+_userId+"&attachments=photo,"+_imageInfo.url+"&access_token="+_accessToken;
			_urlRequest=new URLRequest(_query);
			_urlLoader=new URLLoader  ;
			_urlLoader.addEventListener(Event.COMPLETE,_handlerCompleteUploaded);
			_urlLoader.addEventListener(ErrorEvent.ERROR,_handlerErrorUploaded);
			_urlLoader.load(_urlRequest);
		}
		
		private function _handlerCompleteUploaded(event:Event):void{			
			trace("complete upload to Vk.com");
		}
		private function _handlerErrorUploaded(event:ErrorEvent):void{			
			trace("Error Upload");
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