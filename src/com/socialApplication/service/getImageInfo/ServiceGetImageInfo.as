package com.socialApplication.service.getImageInfo{
	import com.razzmatazz.net.EventNetwork;
	import com.razzmatazz.net.HTTPRequest;
	import com.razzmatazz.robotlegs.services.serviceHTTPAbstract.ServiceHTTPAbstract;
	import com.razzmatazz.valueObjects.error.VOError;
	import com.razzmatazz.valueObjects.log.VOLogMessage;
	import com.socialApplication.common.Constants;
	import com.socialApplication.model.vo.VOImageInfo;
	
	import feathers.data.ListCollection;
	
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class ServiceGetImageInfo extends ServiceHTTPAbstract implements IServiceGetImageInfo 	{
		
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
		private var _dataGetImage:VOGetImageInfo = new VOGetImageInfo();  
		private var _dataImageInfo:VOImageInfo;
		private var _dataGetImageResult:ListCollection;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ServiceGetImageInfo() 	{
			super();
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function load(pData:Object):void{
			
			this._dataGetImage.id = pData.id;	
			this._dataGetImage.token = pData.token;	
			this._dataGetImage.start = pData.start;	 
			this._dataGetImage.count = Constants.COUNT_IMAGE;	
			
			_dataGetImageResult = new ListCollection();
			
			_killRequest();
			_initRequest();
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
		override protected function _initRequest():void{
			_loadStartedHandler();						
			
			_requestURL = Constants.URL_SERVER_GET_IMAGE;						
			
			_urlRequest = new URLRequest(_requestURL);
			_urlRequest.method = URLRequestMethod.POST;																									
			
						
			var pDataRequest:URLVariables = new URLVariables();		
			pDataRequest.request = JSON.stringify(_dataGetImage);
			
			_urlRequest.data = pDataRequest;
			
			_httpRequest = new HTTPRequest(_urlRequest);
			_addLoaderEventListeners(_httpRequest);
			_httpRequest.load();
			
			var pDebug:VOLogMessage = new VOLogMessage(this, "ServiceLogin", _httpRequest);
			_logSend(pDebug);
			
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		/**
		 * overriding to handle 3 variants of response instead of two basic
		 * 
		 */
		override protected function _completeEventHandler(event:EventNetwork):void {
			var pDebug:VOLogMessage = new VOLogMessage(this, "_httpStatusEventHandler", event);
			_logSend(pDebug);
			
			event.stopImmediatePropagation();
			try{
				_result = _httpRequest.result;
				_parseResponse();
				if(_serviceResponseIsValid) {
					_successEventHandler();
				} else {
					_errorHandler();
				}
			} catch(error:Error) {
				_errorHandler();
			}
		}
		
		
		/***
		 * 1. Succsessfull test start: .swf embedded into html page text  
		 * 2. No test available now for this user: 
		 * 3. Error while logging in
		 * 
		 */
		override protected function _parseResponse():void{
			try{
				var pResponseJSON:Object = JSON.parse(_result.toString());
				
				
				try{
					if(pResponseJSON.response.code){
						_serviceResponseIsValid = false;
						
					}else{
						var pArrayLength:int=pResponseJSON.response.images.length;
						for (var i:int=0;i<pArrayLength;i++){
							_dataImageInfo=new VOImageInfo();
							_dataImageInfo.id =pResponseJSON.response.images[i].id;
							_dataImageInfo.age =pResponseJSON.response.images[i].age;
							_dataImageInfo.userName =pResponseJSON.response.images[i].username;
							_dataImageInfo.number_of_comments = pResponseJSON.response.images[i].number_of_comments;
							_dataImageInfo.number_of_likes = pResponseJSON.response.images[i].number_of_likes;
							_dataImageInfo.title = pResponseJSON.response.images[i].title;
							_dataImageInfo.url = pResponseJSON.response.images[i].url;
							_dataGetImageResult.push(_dataImageInfo);	
						}								
						_serviceResponseIsValid=true;
					}
				}catch(error:Error){
					_serviceResponseIsValid = true;
				}
				
			} catch (error:Error){
				_serviceResponseIsValid = false;
			}
		}
		
		
		override protected function _successEventHandler():void {
			var pDebug:VOLogMessage = new VOLogMessage(this, "ServiceLogin _successEventHandler", _result);
			_logSend(pDebug);
			
			_loadCompletedHandler();
			
			
			// Sending data to be stored in the Model			
			dispatch(new EventServiceGetImageInfo(EventServiceGetImageInfo.RESULT, _dataGetImageResult));
		}
		
		
		override protected function _errorHandler(pEvent:*=null):void {
			_loadCompletedHandler();
			
			var pErrorCode:String="";
			var pError:VOError = new VOError();
			if(_result){
				var pResponseJSON:Object = JSON.parse(_result.toString());
				
				if(String(pResponseJSON.response.message).length>0){
					pError.errorDescription = pResponseJSON.response.message;
					pError.errorCode = pResponseJSON.response.code	
				}
			}
			
			pError.isCritical = false;
			pError.debugObject = this;  
			_errorSend(pError);
			
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