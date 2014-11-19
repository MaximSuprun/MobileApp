package com.socialApplication.view.login{
	
	
	import com.socialApplication.common.Constants;
	import com.socialApplication.view.abstract.ViewAbstract;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	
	import flash.events.FocusEvent;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	
	public class ViewLogin extends ViewAbstract{
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
		
		private var _inputFieldLogin:TextInput;
		private var _inputFieldPassword:TextInput;
		private var _buttonRegistration:Button;
		private var _buttonLogin:Button;
		private var _labelErrorMessage:Label;
		private var _logo:Image;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewLogin():void{
			
			
		}
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------		

		override public function activateContent():void{
			_inputFieldLogin=new TextInput();
			_inputFieldLogin.addEventListener(FocusEvent.FOCUS_IN,_handlerTextFocus);
			_inputFieldLogin.addEventListener(FocusEvent.FOCUS_OUT,_handlerTextFocusOut);
			_inputFieldLogin.nameList.add(Constants.INPUT_FIELD_REGISTER);
			_inputFieldLogin.prompt=Constants.PROMPT_INPUT_LOGIN;			
			_inputFieldLogin.setSize(int(300*scale),int(75*scale));		
			_inputFieldLogin.x= Starling.current.nativeStage.stageWidth/2- _inputFieldLogin.width/2; 
			_inputFieldLogin.y=450*scale;
			content.addChild(_inputFieldLogin);
			
			_inputFieldPassword=new TextInput();
			_inputFieldPassword.addEventListener(FocusEvent.FOCUS_IN,_handlerTextFocus);			
			_inputFieldPassword.addEventListener(FocusEvent.FOCUS_OUT,_handlerTextFocusOut);
			_inputFieldPassword.nameList.add(Constants.INPUT_FIELD_REGISTER);
			_inputFieldPassword.prompt=Constants.PROMPT_INPUT_PASSWORD;
			_inputFieldPassword.displayAsPassword=true;
			_inputFieldPassword.setSize(int(300*scale),int(75*scale));
			_inputFieldPassword.x= Starling.current.nativeStage.stageWidth/2-_inputFieldPassword.width/2;
			_inputFieldPassword.y=540*scale;
			content.addChild(_inputFieldPassword);
			
			_buttonLogin=new Button();
			_buttonLogin.addEventListener(Event.TRIGGERED,_handlerLoginButtonClick)
			_buttonLogin.nameList.add(Constants.BUTTON_LOGIN);
			_buttonLogin.setSize(int(300*scale),int(75*scale));
			_buttonLogin.x= Starling.current.nativeStage.stageWidth/2 - _buttonLogin.width/2;
			_buttonLogin.y=650*scale;
			_buttonLogin.label=Constants.PROMPT_INPUT_LOGIN;
			content.addChild(_buttonLogin);
			
			contentShow(1);
		}

		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------

		public function set logo(pLogo:Image):void{
			if(pLogo){
				if(_logo != pLogo){
					_logo = pLogo;
					_logo.x=Starling.current.nativeStage.stageWidth/2-_logo.width/2;
					_logo.y=150*scale;
					addChild(_logo);
				}
			}
		}
		
		public function errorMessegeAdd(pMassege:String):void{
			_labelErrorMessage=new Label();
			_labelErrorMessage.nameList.add(Constants.LABEL_ERROR);
			_labelErrorMessage.setSize(300,50);
			_labelErrorMessage.text=pMassege;
			_labelErrorMessage.x=(Starling.current.nativeStage.stageWidth-_labelErrorMessage.width)/2;
			_labelErrorMessage.y=350*scale;
			addChild(_labelErrorMessage);
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
	

		override protected function initialize():void{
			
			super.initialize();			
			this.setSize(Starling.current.nativeStage.stageWidth,Starling.current.nativeStage.stageHeight);		
		
		}
		
		override protected function draw():void{
			super.draw();
		
		}

		private function _outhorizationChek():void{
			if(_labelErrorMessage){
				removeChild(_labelErrorMessage);
			}
			if(_inputFieldLogin.text.length<=0||_inputFieldPassword.text.length<=0){			
				_labelErrorMessage=new Label();
				_labelErrorMessage.nameList.add(Constants.LABEL_ERROR);
				_labelErrorMessage.text=Constants.MESSAGE_ERROR_INPUT_DATA;	
				_labelErrorMessage.x=Starling.current.nativeStage.stageWidth/2-125*scale;
				_labelErrorMessage.y=350*scale;
				addChild(_labelErrorMessage);
				
			}else{
				var loginData:Object={};
				loginData.login=_inputFieldLogin.text;
				loginData.password=_inputFieldPassword.text;
				
				dispatchEvent(new EventViewLogin(EventViewLogin.LOGIN,loginData));					
			}
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _handlerLoginButtonClick(event:Event):void{
			_outhorizationChek()
		}
		
		private function _handlerTextFocus(event:Event):void{
			if(_labelErrorMessage){
				removeChild(_labelErrorMessage);
			}
			TextInput(event.currentTarget).prompt=null;
		}
		
		private function _handlerTextFocusOut(event:Event):void{
			switch (event.currentTarget){
				case _inputFieldPassword:					
					_inputFieldPassword.prompt=Constants.PROMPT_INPUT_PASSWORD;
					break;
				case _inputFieldLogin:
					_inputFieldLogin.prompt=Constants.PROMPT_INPUT_LOGIN;	
					break;
			}
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