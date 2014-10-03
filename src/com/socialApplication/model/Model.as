package com.socialApplication.model{
	import com.socialApplication.model.vo.VOLocalLoginData;
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
		private var _voLoginData:VOLocalLoginData;
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
				_voLoginData=new VOLocalLoginData();
				_voLoginData.login=pValue.login;	
				_voLoginData.password=pValue.password;	
				dispatch(new EventModel(EventModel.DATA_INPUTED,_voLoginData));
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
			if(_voLoginData.login != pValue && pValue != ""){
			_voLoginData.login=pValue;
			dispatch(new EventModel(EventModel.REPLACE_LOGIN,_voLoginData.login));
			}
		}
		
		public function set newDataPassword(pValue:String):void{
			if(_voLoginData.password != pValue && pValue != ""){
				_voLoginData.password=pValue;
				dispatch(new EventModel(EventModel.REPLACE_PASSWORD,_voLoginData.password));
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