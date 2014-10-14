package com.socialApplication.view.explore.common{
	
	import com.socialApplication.common.Constants;
	import com.socialApplication.view.abstract.ViewAbstract;
	import com.socialApplication.view.explore.EventViewExplore;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.TextInput;
	import feathers.core.PopUpManager;
	
	import flash.geom.Rectangle;
	import flash.media.StageWebView;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	public class PopUpWebView extends ViewAbstract{
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
		private var _stageWebView:StageWebView;
		private var _buttonCancel:Button;
		private var _buttonOk:Button;
		private var _labelErrorMessage:Label;
		private var _inputFieldForPin:TextInput;
		
		private var _urlForStageWebView:String="";
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function PopUpWebView(){
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
		
		public function get stageWebView():StageWebView{return _stageWebView;}
		public function set loadUrl(pUrl:String):void{
			if(pUrl && pUrl != _urlForStageWebView){
				_urlForStageWebView=pUrl;
				stageWebView.loadURL(_urlForStageWebView);
			}
		}
		public function set isTwitter(pValue:Boolean):void{
			if(pValue){
				addChild(_inputFieldForPin);
				addChild(_buttonOk);
			}else{
				return;
			}
		}
		public function stageWebViewDispose():void{
			_stageWebView.dispose();
			_stageWebView=null;
			
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function initialize():void{
			_stageWebView=new StageWebView();
			_stageWebView.stage = Starling.current.nativeStage;
			_stageWebView.viewPort = new Rectangle(0, 85*scale, Starling.current.nativeStage.stageWidth, Starling.current.nativeStage.stageHeight*.7);
			
			_buttonCancel=new Button();
			_buttonCancel.nameList.add(Constants.BUTTON_LOGIN);
			_buttonCancel.addEventListener(Event.TRIGGERED,_handlerCancelButton)
			_buttonCancel.setSize(150*scale,50*scale);
			_buttonCancel.label=Constants.LABEL_CANCEL;
			addChild(_buttonCancel);
			
			_inputFieldForPin=new TextInput();
			_inputFieldForPin.nameList.add(Constants.INPUT_FIELD_REGISTER);
			_inputFieldForPin.setSize(150*scale,75*scale);
			_inputFieldForPin.prompt="Enter PIN";
			
			_buttonOk=new Button();
			_buttonOk.nameList.add(Constants.BUTTON_LOGIN);
			_buttonOk.addEventListener(Event.TRIGGERED,_handlerOkButton)
			_buttonOk.setSize(100*scale,75*scale);
			_buttonOk.label=Constants.LABEL_OK;
			
		}
		
		override protected function draw():void{
			_buttonCancel.x=(Starling.current.nativeStage.stageWidth-_buttonCancel.width)/2;
			_buttonCancel.y=Starling.current.nativeStage.stageHeight-100*scale;
			
			_inputFieldForPin.x=(Starling.current.nativeStage.stageWidth-_inputFieldForPin.width)/2-50;
			_inputFieldForPin.y=Starling.current.nativeStage.stageHeight*.8;
			
			_buttonOk.x=(Starling.current.nativeStage.stageWidth-_inputFieldForPin.width)/2+100*scale;
			_buttonOk.y= Starling.current.nativeStage.stageHeight*.8;
			
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerCancelButton(event:Event):void{
			stageWebViewDispose();
			PopUpManager.removePopUp(this);
		}
		private function _handlerOkButton(event:Event):void{
			var pPin:String = _inputFieldForPin.text;
			if( pPin != "" ){
				dispatchEvent(new EventViewExplore(EventViewExplore.CLICK_OK_BUTTON,pPin))
			}else{
				return;
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