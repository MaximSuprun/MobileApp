package com.socialApplication.service.api.twitter{
	import com.socialApplication.common.Constants;
	import com.socialApplication.model.vo.VOImageInfo;
	import com.socialApplication.view.explore.EventViewExplore;
	import com.socialApplication.view.explore.common.PopUpWebView;
	
	import feathers.core.PopUpManager;
	
	import isle.susisu.twitter.Twitter;
	import isle.susisu.twitter.TwitterRequest;
	import isle.susisu.twitter.events.TwitterErrorEvent;
	import isle.susisu.twitter.events.TwitterRequestEvent;
	
	
	public class ServiceTwitter implements IServiceTwitterPostImage{
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
		private var _twitter:Twitter;
		private var _popUpWebView:PopUpWebView;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ServiceTwitter()
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
			_twitter=new Twitter(Constants.TWITTER_API_KEY,Constants.TWITTER_SECRET_KEY);
			var pRequestToken:TwitterRequest=_twitter.oauth_requestToken();
			pRequestToken.addEventListener(TwitterRequestEvent.COMPLETE,_handlerTwitterRequest);
		}
		
		private function _removePopUp():void{
			if(_popUpWebView != null){
				_popUpWebView.stageWebViewDispose();
				PopUpManager.removePopUp(_popUpWebView);
				_popUpWebView = null;
			}			
		}
		
		private function _oauth_accessToken(pPin:String):void{
			var pAccessToken:TwitterRequest = _twitter.oauth_accessToken(pPin);
			pAccessToken.addEventListener(TwitterRequestEvent.COMPLETE,_handlerAccessToken)
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerTwitterRequest(event:TwitterRequestEvent):void{
				_popUpWebView=new PopUpWebView();
				_popUpWebView.addEventListener(EventViewExplore.CLICK_OK_BUTTON,_handlerOkButton);
				PopUpManager.addPopUp(_popUpWebView,true,false);
				_popUpWebView.loadUrl=_twitter.getOAuthAuthorizeURL();
				_popUpWebView.isTwitter=true;
		}
		
		private function _handlerAccessToken(event:TwitterRequestEvent):void{
		/*	var pMedia:Array=[{"source":_imageInfo.url}];
					
			
			var pByteArray:ByteArray=new ByteArray();
			pByteArray.writeObject(pMedia);
			pByteArray.position=0;
			pByteArray.compress();*/
			
			var pRequest:TwitterRequest = _twitter.statuses_update(_imageInfo.url);			
			pRequest.addEventListener(TwitterErrorEvent.SERVER_ERROR,function(event:TwitterErrorEvent):void{trace(event.type);});
			pRequest.addEventListener(TwitterErrorEvent.CLIENT_ERROR,function(event:TwitterErrorEvent):void{trace(event.type);});
		}
		
		private function _handlerOkButton(event:EventViewExplore):void{
			var pPin:String = String(event.payload);
			_removePopUp();
			_oauth_accessToken(pPin);
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