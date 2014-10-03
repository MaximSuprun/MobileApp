package com.socialApplication.view.settings{
	
	
	import com.socialApplication.common.Constants;
	import com.socialApplication.view.abstract.ViewAbstract;
	import com.socialApplication.view.createScreen.EventViewCreateScreen;
	import com.socialApplication.view.settings.common.ItemRendererSettingsList;
	import com.socialApplication.view.settings.common.PopUpChangeUserData;
	
	import feathers.controls.Button;
	import feathers.controls.List;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	
	public class ViewSettings extends ViewAbstract{
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
		private var _buttonMenu:Button;
		private var _logoListName:Image;
		private var _list:List;
		private var _containerPopUp:PopUpChangeUserData;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewSettings():void{
			
			
		}
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------		

		public function get logoListName():Image{
			return _logoListName;
		}
		
		public function set logoListName(pLogo:Image):void{
			if(pLogo && _logoListName != pLogo){
				_logoListName = pLogo;
				_logoListName.y=125*scale;
				addChild(_logoListName);
			}
		}
		
		public function messageSuccess():void{
			_removePopUp();			
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
		override protected function initialize():void{
			super.initialize();
			
			header.nameList.add(Constants.HEADER_SETTINGS);
			addChild(header);
			
			_buttonMenu=new Button();
			_buttonMenu.nameList.add(Constants.BUTTON_MENU);
			_buttonMenu.scaleX=scale;
			_buttonMenu.scaleY=scale;
			_buttonMenu.addEventListener(Event.TRIGGERED,_handlerButtonMenuClick);
			header.leftItems = new <DisplayObject>[ _buttonMenu ];
			
			_list=new List();
			_list.addEventListener(Event.CHANGE,_handlerChange);
			_list.width=400*scale;
			_list.dataProvider=new ListCollection([	{label:Constants.LABEL_CHANGE_USER_LOGIN,position:Constants.TOP_POSITION_IN_LIST},
													{label:Constants.LABEL_CHANGE_USER_PASSWORD,position:Constants.DEFAULT_POSITION_IN_LIST},
													{label:Constants.LABEL_LOG_OUT,position:Constants.BOTTOM_POSITION_IN_LIST}]);
			_list.y=175*scale;			
			_list.x=(Starling.current.nativeStage.stageWidth-_list.width)/2;
			_list.itemRendererType = ItemRendererSettingsList;
			
			
			var listLayout:VerticalLayout = new VerticalLayout();
			_list.layout = listLayout;
			
			addChild(_list);			
			
		}
		
		override protected function draw():void{
			super.draw();		
			_logoListName.x=_list.x;
		}
		
		private function _handlerButtonMenuClick(event:Event):void{
			dispatchEvent(new EventViewCreateScreen(EventViewCreateScreen.MENU_CLICK));		
		}
		
		
		private function _containerPopUpAdd(pIsPassword:Boolean):PopUpChangeUserData{		
			_containerPopUp=new PopUpChangeUserData();
			_containerPopUp.addEventListener(EventViewSettings.CLICK_OKEY,_handlerButtonOk);
			_containerPopUp.addEventListener(EventViewSettings.CLICK_CANCEL,_handlerButtonCancel);
			_containerPopUp.isPassword=pIsPassword;
			
			return _containerPopUp;
		}

		private function _removePopUp():void{
			_containerPopUp.removeEventListener(EventViewSettings.CLICK_OKEY,_handlerButtonOk);
			_containerPopUp.removeEventListener(EventViewSettings.CLICK_CANCEL,_handlerButtonCancel);
			PopUpManager.removePopUp(_containerPopUp);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerChange(event:Event):void{			
			switch(_list.selectedItem.label){
				case Constants.LABEL_LOG_OUT:
					dispatchEvent(new EventViewSettings(EventViewSettings.LOG_OUT_ITEM));
					break;
				case Constants.LABEL_CHANGE_USER_LOGIN:
					PopUpManager.addPopUp(_containerPopUpAdd(false),true,false);
					break;
				case Constants.LABEL_CHANGE_USER_PASSWORD:	
					PopUpManager.addPopUp(_containerPopUpAdd(true),true,false);
					break;
			}
		}
		private function _handlerButtonOk(event:EventViewSettings):void{			
			if(_containerPopUp.isPassword){
				dispatchEvent(new EventViewSettings(EventViewSettings.CHANGE_DATA_PASSWORD,_containerPopUp.newData));
			}else{
				dispatchEvent(new EventViewSettings(EventViewSettings.CHANGE_DATA_LOGIN,_containerPopUp.newData));
			}
		}
		private function _handlerButtonCancel(event:EventViewSettings):void{			
			_removePopUp();
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