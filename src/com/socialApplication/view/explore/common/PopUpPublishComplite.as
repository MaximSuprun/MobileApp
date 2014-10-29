package com.socialApplication.view.explore.common{
	
	import com.socialApplication.common.Constants;
	import com.socialApplication.view.abstract.ViewAbstract;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.core.PopUpManager;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	public class PopUpPublishComplite extends ViewAbstract{
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
		private var _labelMessageComplete:Label;
		private var _buttonRemovePopUp:Button;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function PopUpPublishComplite()
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
			
			_labelMessageComplete=new Label();
			_labelMessageComplete.nameList.add(Constants.LABEL_POP_UP);
			_labelMessageComplete.width=300*scale;
			_labelMessageComplete.height=150*scale;
			_labelMessageComplete.text=Constants.PUBLISH_COMPLETE;
			_labelMessageComplete.x=Starling.current.nativeStage.stageWidth/2-_labelMessageComplete.width/2;
			_labelMessageComplete.y=400*scale;
			addChild(_labelMessageComplete);
			
			_buttonRemovePopUp=new Button();
			_buttonRemovePopUp.nameList.add(Constants.BUTTON_LOGIN);
			_buttonRemovePopUp.addEventListener(Event.TRIGGERED,_handlerButtonTriggered);
			_buttonRemovePopUp.label=Constants.LABEL_OK;
			_buttonRemovePopUp.width=100*scale;
			_buttonRemovePopUp.height=50*scale;
			_buttonRemovePopUp.x=(Starling.current.nativeStage.stageWidth-_buttonRemovePopUp.width)/2;
			_buttonRemovePopUp.y=Starling.current.nativeStage.stageHeight/2+75*scale;
			addChild(_buttonRemovePopUp);
		}
		
		override protected function draw():void{
			background.y=Starling.current.nativeStage.stageHeight/2-background.height/2;
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerButtonTriggered(event:Event):void{
			PopUpManager.removePopUp(this);
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