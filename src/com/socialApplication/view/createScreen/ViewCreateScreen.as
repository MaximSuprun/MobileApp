package com.socialApplication.view.createScreen{
	
	
	import com.socialApplication.common.Constants;
	import com.socialApplication.view.abstract.ViewAbstract;
	import com.socialApplication.view.createScreen.common.CreatePopUp;
	import com.socialApplication.view.createScreen.common.footer.MyFooter;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.ScrollText;
	import feathers.core.PopUpManager;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class ViewCreateScreen extends ViewAbstract{
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
		private var _buttonCreate:Button;
		private var _list:List;
		private var _selectedItemImage:Image;
		private var _textSelectedItem:Label;
		private var _containerPopUp:CreatePopUp;
		private var _rendererText:Function;
			
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
    
		public function ViewCreateScreen():void{
			
		}
	
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function imageLoadedAdd(pTexture:Texture):void{
			_itemFieldCreate(pTexture);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function set rendererText(pRendererText:Function):void{
			_rendererText=pRendererText;
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
	

		override protected function initialize():void{
			
				
			super.initialize();		
			
			background.y=200*scale;
							
			header.nameList.add(Constants.HEADER_CREATE_PANEL);
			addChild(header);
			
			
			_buttonMenu=new Button();
			_buttonMenu.nameList.add(Constants.BUTTON_MENU);
			_buttonMenu.scaleX=scale;
			_buttonMenu.scaleY=scale;
			_buttonMenu.addEventListener(starling.events.Event.TRIGGERED,_handlerButtonMenuClick);
			header.leftItems = new <DisplayObject>[ _buttonMenu ];
			
			_buttonCreate=new Button();
			_buttonCreate.addEventListener(starling.events.Event.TRIGGERED,_handlerButtonCreateClick);
			_buttonCreate.nameList.add(Constants.BUTTON_CREATE);
			_buttonCreate.scaleX=scale;
			_buttonCreate.scaleY=scale;
			header.rightItems = new <DisplayObject>[ _buttonCreate ];
			
			
			footer=new MyFooter();
			footer.y=Starling.current.nativeStage.stageHeight-210*scale;
			footer.addEventListener(EventViewCreateScreen.CHANGE_NEW_IMAGES,_handlerChangeListItem);
			addChild(footer);
			
		}
				
		override protected function draw():void{
			super.draw();			
		}
		
		private function _itemFieldCreate(pTexture:Texture,pText:String=""):void{
			
			if(contains(background)){
				removeChild(background);
			}
			if(contains(_selectedItemImage)){
				if(_selectedItemImage.texture == pTexture){
					return;
				}else{
					removeChild(_selectedItemImage);
				}
			}
			if (contains(_textSelectedItem)){
				if(_textSelectedItem.text == pText){
					return;
				}else{
					removeChild(_textSelectedItem);
				}
			}
			
			_selectedItemImage=new Image(Texture(pTexture));
			_selectedItemImage.width=512*scale;
			_selectedItemImage.height=512*scale;
			_selectedItemImage.x=Starling.current.nativeStage.stageWidth/2-_selectedItemImage.width/2;
			_selectedItemImage.y=125*scale;
			addChild(_selectedItemImage);
			
			if(pText != ""){
				_textSelectedItem=new Label();
				var pPading:Number=35*scale;
				_textSelectedItem.textRendererFactory=_rendererText;
				_textSelectedItem.width=_selectedItemImage.width-2*pPading;
				_textSelectedItem.height=_selectedItemImage.height-2*pPading;
				_textSelectedItem.x=_selectedItemImage.x+pPading;
				_textSelectedItem.y=_selectedItemImage.y+pPading;
				_textSelectedItem.text=pText;
				addChild(_textSelectedItem);
			}
			
		}
		
		private function _containerPopUpAdd():CreatePopUp{		
			_containerPopUp=new CreatePopUp();
			_containerPopUp.addEventListener(EventViewCreateScreen.ADD_FROM_DEVICE,_handlerAddFromDevice);
			_containerPopUp.addEventListener(EventViewCreateScreen.TAKE_PHOTO_CLICK,_handlerTakePhoto);
			_containerPopUp.addEventListener(EventViewCreateScreen.CLICK_CANCEL,_handlerClickCancel);
			
			return _containerPopUp;
		}
		
		private function _removePopUp():void{
			_containerPopUp.removeEventListener(EventViewCreateScreen.ADD_FROM_DEVICE,_handlerAddFromDevice);
			_containerPopUp.removeEventListener(EventViewCreateScreen.TAKE_PHOTO_CLICK,_handlerTakePhoto);
			_containerPopUp.removeEventListener(EventViewCreateScreen.CLICK_CANCEL,_handlerClickCancel);
			PopUpManager.removePopUp(_containerPopUp);
		}
			
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _handlerButtonMenuClick(event:Event):void{
			dispatchEvent(new EventViewCreateScreen(EventViewCreateScreen.MENU_CLICK));		
		}
		
		private function _handlerButtonCreateClick(event:Event):void{
			PopUpManager.addPopUp(_containerPopUpAdd(),true,false);
		}
		
		private function _handlerChangeListItem(event:EventViewCreateScreen):void{
				_itemFieldCreate(Texture(event.payload.texture_big),String(event.payload.text));			
			
		}
		private function _handlerTakePhoto(event:EventViewCreateScreen):void{
			_removePopUp();
			dispatchEvent(new EventViewCreateScreen(EventViewCreateScreen.TAKE_PHOTO_CLICK));
		}
	
		private function _handlerAddFromDevice(event:EventViewCreateScreen):void{
			_removePopUp();
			dispatchEvent(new EventViewCreateScreen(EventViewCreateScreen.ADD_FROM_DEVICE));			
		}
		private function _handlerClickCancel(event:EventViewCreateScreen):void{
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