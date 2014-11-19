package com.socialApplication.model{
	import com.socialApplication.model.vo.VOAuthorizationData;
	import com.socialApplication.model.vo.VOUserData;
	
	import org.robotlegs.starling.mvcs.Actor;
	
	public class Model extends Actor implements IModel{
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
		private var _voAuthorizationData:VOAuthorizationData;
		private var _voUserData:VOUserData;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function Model(){
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function set inputedData(pValue:Object):void{
			if(pValue){
				_voAuthorizationData=new VOAuthorizationData();
				_voAuthorizationData.login=pValue.login;	
				_voAuthorizationData.password=pValue.password;	
				dispatch(new EventModel(EventModel.AUTHORIZATION_DATA_INPUTED,_voAuthorizationData));
			}
		}
	
		public function set userData(pValue:VOUserData):void{
			if(pValue){
				_voUserData=pValue;
				dispatch(new EventModel(EventModel.LOGIN_SUCCES));				
			}			
		}
		
		public function get userData():VOUserData{
			return _voUserData;			
		}
		
		public function set newDataLogin(pValue:String):void{
			if(_voAuthorizationData.login != pValue && pValue != ""){
			_voAuthorizationData.login=pValue;
			dispatch(new EventModel(EventModel.REPLACE_LOGIN,_voAuthorizationData.login));
			}
		}
		
		public function set newDataPassword(pValue:String):void{
			if(_voAuthorizationData.password != pValue && pValue != ""){
				_voAuthorizationData.password=pValue;
				dispatch(new EventModel(EventModel.REPLACE_PASSWORD,_voAuthorizationData.password));
			}
		}
			
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		
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