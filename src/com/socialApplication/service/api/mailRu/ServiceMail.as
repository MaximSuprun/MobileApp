package com.socialApplication.service.api.mailRu{
	import com.adobe.protocols.oauth2.OAuth2;
	import com.adobe.protocols.oauth2.OAuth2Const;
	import com.adobe.protocols.oauth2.event.GetAccessTokenEvent;
	import com.adobe.protocols.oauth2.grant.AuthorizationCodeGrant;
	import com.adobe.protocols.oauth2.grant.IGrantType;
	import com.socialApplication.common.Constants;
	import com.socialApplication.model.vo.VOImageInfo;
	import com.socialApplication.service.api.mailRu.my.MyApiNode;
	import com.socialApplication.view.explore.common.PopUpWebView;
	
	import feathers.core.PopUpManager;
	
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
			
		
		/*	_mail=new MyApiNode(vid,Constants.MAILRU_ID,Constants.MAILRU_PRIVATE_KEY,session_key,'XML');
			var uids:Array = new Array;
			uids.push(vid);
			_query=_mail.streamPublish(_imageInfo.title,_imageInfo.userName,_imageInfo.url);			
			_urlRequest=new URLRequest(_query);
			_urlLoader=new URLLoader  ;
			_urlLoader.addEventListener(Event.COMPLETE,_handlerPublishComplite);
			_urlLoader.load(_urlRequest);*/
			_popUpWebView=new PopUpWebView();
			PopUpManager.addPopUp(_popUpWebView,true,false);
			//_popUpWebView.loadUrl="https://connect.mail.ru/oauth/authorize?client_id="+Constants.MAILRU_ID+"&response_type=token&redirect_uri=http%3A%2F%2Fconnect.mail.ru%2Foauth%2Fsuccess.html";
			var pOauth:OAuth2=new OAuth2("https://connect.mail.ru/oauth/authorize","https://connect.mail.ru/oauth/authorize",LogSetupLevel.ALL);
			var grant:IGrantType = new AuthorizationCodeGrant(_popUpWebView.stageWebView,Constants.MAILRU_ID.toString(),Constants.MAILRU_SECRET_KEY,"https://connect.mail.ru/oauth/token");
			pOauth.addEventListener(GetAccessTokenEvent.TYPE, onGetAccessToken);
			pOauth.getAccessToken(grant);
		}
		private function _removePopUp():void{
			if(_popUpWebView != null){
				_popUpWebView.stageWebViewDispose();
				PopUpManager.removePopUp(_popUpWebView);
				_popUpWebView = null;
			}			
		}
		
		
		private function onGetAccessToken(getAccessTokenEvent:GetAccessTokenEvent):void	{
			
			if (getAccessTokenEvent.errorCode == null && getAccessTokenEvent.errorMessage == null){
				// success!
				trace("Your access token value is: " + getAccessTokenEvent.accessToken);
			}else{
				// fail :(
				trace("looser ");
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