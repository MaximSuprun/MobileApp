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
				_stageWebView.loadURL(_urlForStageWebView);
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
			_stageWebView.viewPort = new Rectangle(0, 85*scale, Starling.current.nativeStage.stageWidth, Starling.current.nativeStage.stageHeight*.75);
			
			_buttonCancel=new Button();
			_buttonCancel.nameList.add(Constants.BUTTON_LOGIN);
			_buttonCancel.addEventListener(Event.TRIGGERED,_handlerCancelButton)
			_buttonCancel.setSize(150,50);
			_buttonCancel.label=Constants.LABEL_CANCEL;
			addChild(_buttonCancel);
		}
		
		override protected function draw():void{
			_buttonCancel.x=(Starling.current.nativeStage.stageWidth-_buttonCancel.width)/2;
			_buttonCancel.y=Starling.current.nativeStage.stageHeight*.75+150*scale;
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