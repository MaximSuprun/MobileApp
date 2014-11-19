package com.socialApplication.view.components.popUps{
	
	import com.socialApplication.common.Constants;
	import com.socialApplication.view.abstract.ViewAbstract;
	import com.socialApplication.view.createScreen.EventViewCreateScreen;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.core.PopUpManager;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	public class CreatePopUp extends ViewAbstract{
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
		private var _buttonCreatePhoto:Button;
		private var _buttonChooseFile:Button;
		private var _buttonCancel:Button;
		private var _labelMessage:Label;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function CreatePopUp()
		{
			super();
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
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function initialize():void{
			super.initialize();
			
			_labelMessage=new Label();
			_labelMessage.setSize(400*scale,50*scale);
			_labelMessage.nameList.add(Constants.LABEL_POP_UP);
			_labelMessage.text=Constants.TITLE_CREATE_POP_UP;
			addChild(_labelMessage);
			
			_buttonCreatePhoto=new Button();
			_buttonCreatePhoto.setSize(225*scale,50*scale);
			_buttonCreatePhoto.nameList.add(Constants.BUTTON_LOGIN);
			_buttonCreatePhoto.addEventListener(Event.TRIGGERED,_handlerButtonTriggered);
			_buttonCreatePhoto.label=Constants.LABEL_TAKE_PHOTO;
			addChild(_buttonCreatePhoto);
			
			_buttonChooseFile=new Button();
			_buttonChooseFile.setSize(225*scale,50*scale);
			_buttonChooseFile.nameList.add(Constants.BUTTON_LOGIN);
			_buttonChooseFile.addEventListener(Event.TRIGGERED,_handlerButtonTriggered);
			_buttonChooseFile.label=Constants.LABEL_FROM_DEVICE;
			addChild(_buttonChooseFile);
			
			_buttonCancel=new Button();
			_buttonCancel.setSize(225*scale,50*scale);
			_buttonCancel.nameList.add(Constants.BUTTON_LOGIN);
			_buttonCancel.addEventListener(Event.TRIGGERED,_handlerButtonTriggered);
			_buttonCancel.label=Constants.LABEL_CANCEL;
			addChild(_buttonCancel);
			
		}
		
		override protected function draw():void{
			super.draw();
			
			_labelMessage.x=Starling.current.nativeStage.stageWidth/2-_labelMessage.width/2;
			_labelMessage.y=350*scale;
			
			_buttonChooseFile.x=Starling.current.nativeStage.stageWidth/2 -_buttonChooseFile.width/2;
			_buttonChooseFile.y=Starling.current.nativeStage.stageHeight/2-75*scale;
			
			_buttonCreatePhoto.x=Starling.current.nativeStage.stageWidth/2 -_buttonCreatePhoto.width/2;
			_buttonCreatePhoto.y=Starling.current.nativeStage.stageHeight/2-12.5*scale;

			_buttonCancel.x=Starling.current.nativeStage.stageWidth/2-_buttonCancel.width/2;
			_buttonCancel.y=Starling.current.nativeStage.stageHeight/2+50*scale;
			
			background.height=300*scale;
			background.width=400*scale;
			background.y=(Starling.current.nativeStage.stageHeight-background.height)/2;
			background.x=(Starling.current.nativeStage.stageWidth-background.width)/2;
		}
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerButtonTriggered(event:Event):void{
			switch (event.currentTarget){
				case _buttonCreatePhoto:
					dispatchEvent(new EventViewCreateScreen(EventViewCreateScreen.TAKE_PHOTO_CLICK));
					break;
				case _buttonChooseFile:
					dispatchEvent(new EventViewCreateScreen(EventViewCreateScreen.ADD_FROM_DEVICE));
					break;
				case _buttonCancel:
					dispatchEvent(new EventViewCreateScreen(EventViewCreateScreen.CLICK_CANCEL));
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