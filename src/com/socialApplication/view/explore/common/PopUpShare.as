package com.socialApplication.view.explore.common{
	
	import com.socialApplication.common.Constants;
	import com.socialApplication.view.abstract.ViewAbstract;
	import com.socialApplication.view.explore.EventViewExplore;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.layout.AnchorLayoutData;
	import feathers.layout.TiledRowsLayout;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	public class PopUpShare extends ViewAbstract{
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
		private var _list:List;
		private var _buttonCancel:Button;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function PopUpShare(){
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
			
			_list = new List();
			_list.nameList.add(Constants.LIST_POP_UP);
			_list.addEventListener(Event.CHANGE,_handlerSelectedSocialNetwork);
			_list.scrollBarDisplayMode = List.SCROLL_BAR_DISPLAY_MODE_NONE;
			_list.itemRendererName=(Constants.RENDERER_INTRODUCTION);
			
			_buttonCancel = new Button();
			_buttonCancel.nameList.add(Constants.BUTTON_LOGIN);
			_buttonCancel.addEventListener(Event.TRIGGERED,_handlerButtonTriggered);
			_buttonCancel.label=Constants.LABEL_CANCEL;
			addChild(_buttonCancel);
			
			var pListLayout:TiledRowsLayout = new TiledRowsLayout();
			pListLayout.useSquareTiles = false;
			pListLayout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
			pListLayout.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
			pListLayout.padding = 20;
			pListLayout.gap = 20;
			_list.layout = pListLayout;
			
			
			var pListLayoutData:AnchorLayoutData = new AnchorLayoutData();
			pListLayoutData.top = 0;
			pListLayoutData.right = 0;
			pListLayoutData.bottom = 0;
			pListLayoutData.left = 0;
		
			_list.layoutData = pListLayoutData;
			
			addChild(_list);
		}
		
				
				
		override protected function draw():void{
			super.draw();
			
			
			_list.width=Starling.current.nativeStage.stageWidth;
			_list.height=650*scale;
			_list.x=(Starling.current.nativeStage.stageWidth-_list.width)/2;
			_list.y=85*scale;
			
			_buttonCancel.width=150;
			_buttonCancel.height=50;
			_buttonCancel.x=(Starling.current.nativeStage.stageWidth-_buttonCancel.width)/2;
			_buttonCancel.y=800*scale;

		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------

		private function _handlerButtonTriggered(event:Event):void{
			dispatchEvent(new EventViewExplore(EventViewExplore.CANCEL_POP_UP_SHARE));	
		}
		private function _handlerSelectedSocialNetwork(event:Event):void{
			dispatchEvent(new EventViewExplore(EventViewExplore.SHARE,_list.selectedItem));	
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