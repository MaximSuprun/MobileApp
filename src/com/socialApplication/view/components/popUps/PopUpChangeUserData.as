package com.socialApplication.view.components.popUps{
	
	import com.socialApplication.common.Constants;
	import com.socialApplication.view.abstract.ViewAbstract;
	import com.socialApplication.view.settings.EventViewSettings;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import feathers.core.PopUpManager;
	
	import flash.events.FocusEvent;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	public class PopUpChangeUserData extends ViewAbstract{
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
		private var _inputFieldNewData:TextInput;
		private var _labelMessage:Label;
		private var _buttonApply:Button;
		private var _buttonCancel:Button;
		private var _isPassword:Boolean=false;
		private var _messageText:String="";
		private var _promptText:String="";
		private var _newData:String="";
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function PopUpChangeUserData(){
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
		public function get newData():String{
			return _newData;
		}
		
		public function get messageText():String{
			return _messageText;
		}

		public function set messageText(pMessage:String):void{
			_messageText = pMessage;
			if(_labelMessage){
				_labelMessage.text=_messageText;
			}
		}
		public function get promptText():String	{
			return _promptText;
		}

		public function set promptText(pText:String):void{
			_promptText = pText;
		}
		public function get isPassword():Boolean{
			return _isPassword;
		}

		public function set isPassword(pIsPassword:Boolean):void{
			_isPassword = pIsPassword;
			_promptTextSet();
			_messageTextSet();
		}

				
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function initialize():void{
			super.initialize();
			
			_labelMessage=new Label();
			_labelMessage.nameList.add(Constants.LABEL_POP_UP);
			_labelMessage.text=messageText;
			addChild(_labelMessage);
			
			_buttonApply=new Button();
			_buttonApply.nameList.add(Constants.BUTTON_LOGIN);
			_buttonApply.addEventListener(Event.TRIGGERED,_handlerButtonTriggered);
			_buttonApply.label=Constants.LABEL_OK;
			addChild(_buttonApply);
			
			_buttonCancel=new Button();
			_buttonCancel.nameList.add(Constants.BUTTON_LOGIN);
			_buttonCancel.addEventListener(Event.TRIGGERED,_handlerButtonTriggered);
			_buttonCancel.label=Constants.LABEL_CANCEL;
			addChild(_buttonCancel);
			
			_inputFieldNewData=new TextInput();
			_inputFieldNewData.nameList.add(Constants.INPUT_FIELD_REGISTER);
			_inputFieldNewData.addEventListener(FocusEvent.FOCUS_IN,_handlerTextFocus);			
			_inputFieldNewData.addEventListener(FocusEvent.FOCUS_OUT,_handlerTextFocusOut);
			_inputFieldNewData.prompt=_promptText;
			_inputFieldNewData.displayAsPassword=isPassword;
			addChild(_inputFieldNewData);			
		}
		
		override protected function draw():void{
			super.draw();
				
			_layoutChildren();
		}
		
		private function _layoutChildren():void{
			background.y=Starling.current.nativeStage.stageHeight/2-background.height/2;
			
			_buttonApply.width=100*scale;
			_buttonApply.height=50*scale;
			_buttonApply.x=Starling.current.nativeStage.stageWidth/2-_buttonApply.width-_buttonApply.width/2;
			_buttonApply.y=Starling.current.nativeStage.stageHeight/2+75*scale;
			
			_buttonCancel.width=130*scale;
			_buttonCancel.height=50*scale;
			_buttonCancel.x=Starling.current.nativeStage.stageWidth/2+_buttonApply.width-_buttonCancel.width/2;
			_buttonCancel.y=Starling.current.nativeStage.stageHeight/2+75*scale;
			
			_inputFieldNewData.width=250*scale;
			_inputFieldNewData.height=75*scale;
			_inputFieldNewData.x=Starling.current.nativeStage.stageWidth/2-_inputFieldNewData.width/2;
			_inputFieldNewData.y=Starling.current.nativeStage.stageHeight/2-_inputFieldNewData.height/2;
			
			_labelMessage.width=300*scale;
			_labelMessage.height=150*scale;
			_labelMessage.x=Starling.current.nativeStage.stageWidth/2-_labelMessage.width/2;
			_labelMessage.y=350*scale;
		}
		
		private function _checkInputText():void{
			if(_inputFieldNewData.text == ""){
				_labelMessage.text=Constants.LABEL_NOT_VALID_DATA;
			}else{
				_newData=_inputFieldNewData.text;
				dispatchEvent(new EventViewSettings(EventViewSettings.CLICK_OKEY));
			}
		}
		private function _promptTextSet():void{
			if(_isPassword){
				promptText=Constants.PROMPT_CHANGE_USER_LOGIN;
			}else{
				promptText=Constants.PROMPT_CHANGE_USER_PASSWORD;
			}
		}
		
		private function _messageTextSet():void{
			if(_isPassword){
				messageText=Constants.CONFIRM_CHANGE_USER_PASSWORD;
			}else{
				messageText=Constants.CONFIRM_CHANGE_USER_LOGIN;
			}
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerButtonTriggered(event:Event):void{
			switch(event.currentTarget){
				case _buttonApply:
						_checkInputText();
					break;				
				case _buttonCancel:
						dispatchEvent(new EventViewSettings(EventViewSettings.CLICK_CANCEL));	
					break;
			}
		}
		
		private function _handlerTextFocus(event:Event):void{
			_inputFieldNewData.prompt=null;
		}
		
		private function _handlerTextFocusOut(event:Event):void{
			_promptTextSet();
			_inputFieldNewData.prompt=promptText;
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