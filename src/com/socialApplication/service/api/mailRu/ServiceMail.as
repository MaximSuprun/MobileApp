package com.socialApplication.service.api.mailRu{
	import com.adobe.protocols.oauth2.OAuth2;
	import com.adobe.protocols.oauth2.event.GetAccessTokenEvent;
	import com.adobe.protocols.oauth2.grant.IGrantType;
	import com.adobe.protocols.oauth2.grant.ImplicitGrant;
	import com.socialApplication.common.Constants;
	import com.socialApplication.model.vo.VOImageInfo;
	import com.socialApplication.service.api.mailRu.my.MyApiNode;
	import com.socialApplication.view.explore.common.PopUpWebView;
	
	import feathers.core.PopUpManager;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import org.as3commons.logging.setup.LogSetupLevel;
	
	
	
	public class ServiceMail implements IServiceMailPostImage{
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
		private var _mail:MyApiNode;
		private var _query:String;
		private var _urlLoader:URLLoader;
		private var _urlRequest:URLRequest;
		private var _vid:String;
		private var _accessToken:String;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ServiceMail()
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
			var pOauth:OAuth2=new OAuth2("https://connect.mail.ru/oauth/authorize","https://connect.mail.ru/oauth/succes",LogSetupLevel.ALL);
			var pGrant:IGrantType = new ImplicitGrant(_popUpWebView.stageWebView,Constants.MAILRU_ID.toString(),"https://connect.mail.ru/oauth/success","photos");
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
				_vid=getAccessTokenEvent.response.x_mailru_vid;
				_accessToken = getAccessTokenEvent.accessToken;
				_postToMail();
			}else{
				// fail :(
				trace("looser ");
			}
		} 
		
		private function _postToMail():void{
			var pApi:MyApiNode=new MyApiNode(_vid,Constants.MAILRU_ID,Constants.MAILRU_PRIVATE_KEY,_accessToken);
			_query=pApi.photosUpload("_myphoto",_imageInfo.url,_imageInfo.title);
			_urlRequest=new URLRequest(_query);
			_urlLoader=new URLLoader  ;
			_urlLoader.addEventListener(Event.COMPLETE,_handlerCompleteUploaded);
			_urlLoader.load(_urlRequest);
		}
		
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