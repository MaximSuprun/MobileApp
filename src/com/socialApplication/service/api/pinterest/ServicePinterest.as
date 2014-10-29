package com.socialApplication.service.api.pinterest{
	import com.razzmatazz.robotlegs.services.ServiceAbstract;
	import com.socialApplication.model.vo.VOImageInfo;
	import com.socialApplication.view.explore.common.PopUpWebView;
	
	import feathers.core.PopUpManager;
	
	import flash.display.Sprite;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	public class ServicePinterest extends ServiceAbstract implements IServicePinterestPostImage{
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
			_popUpWebView=new PopUpWebView();
			PopUpManager.addPopUp(_popUpWebView,true,false);
			_popUpWebView.loadUrl="http://www.pinterest.com/pin/create/button/?url=http%3A%2F%2Fwww.flickr.com%2Fphotos%2Fkentbrew%2F6851755809%2F&media="+_imageInfo.url+"&description="+_imageInfo.title;
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