package com.socialApplication.service.api.pinterest{
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
	
	import starling.events.Event;
	
	
	public class ServicePinterest implements IServicePinterestPostImage{
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
		
		public function ServicePinterest()
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
			
		}
		
		/*public function doPost(token:OAuthToken,screenName:String, txt:String):void{
			var paramsO:Object = new Object();
			paramsO['type'] = 'photo';
			paramsO['source'] = _imageInfo.url;
			
			var oauthRequest:OAuthRequest = new OAuthRequest( "POST", "http://api.tumblr.com/v2/blog/"+screenName+".tumblr.com/post", paramsO, consumer, token );
			
			var request:URLRequest = new URLRequest( oauthRequest.buildRequest( signature, OAuthRequest.RESULT_TYPE_URL_STRING ) );
			request.contentType = "application/x-www-form-urlencoded";
			request.method = "POST";
			
			var variables:URLVariables = new URLVariables();
			variables.type = 'photo';
			variables.source = _imageInfo.url;
			
			request.data = variables;
			var loader:URLLoader = new URLLoader();
			
			loader.addEventListener( Event.COMPLETE, postHandler);
			loader.addEventListener( IOErrorEvent.IO_ERROR, postError);
			loader.load(request);*/
				
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