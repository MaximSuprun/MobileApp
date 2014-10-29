package com.socialApplication.view.createScreen.common.footer{
	
	import com.socialApplication.common.Constants;
	import com.socialApplication.view.abstract.ViewAbstract;
	import com.socialApplication.view.createScreen.EventViewCreateScreen;
	
	import feathers.controls.List;
	import feathers.layout.HorizontalLayout;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	public class MyFooter extends ViewAbstract{
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
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function MyFooter()
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
			
			_list=new List();
			
			_list.x=20*scale;
			_list.y=50*scale;
			
			_list.nameList.add(Constants.LIST_SWIPE);
			_list.scrollBarDisplayMode = List.SCROLL_BAR_DISPLAY_MODE_NONE;
			_list.snapScrollPositionsToPixels=true;
			_list.horizontalScrollPolicy = List.SCROLL_POLICY_ON;
			_list.itemRendererType=ItemRendererFooterCreate;
						
			var pListLayout:HorizontalLayout = new HorizontalLayout();
			pListLayout.gap = 5*scale;
			
			_list.layout = pListLayout;
			
			_list.selectedIndex=-1;
			_list.addEventListener(Event.CHANGE,_handlerChangeList);
			
			addChild(_list);
			
		}
		override protected function draw():void{
			super.draw();
			
			backgroundSkin.width = Starling.current.nativeStage.stageWidth;
			backgroundSkin.x=Starling.current.nativeStage.stageWidth/2-backgroundSkin.width/2;
			
			_list.setSize(Starling.current.nativeStage.stageWidth-40*scale,220*scale);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerChangeList(event:Event):void{
			dispatchEvent(new EventViewCreateScreen(EventViewCreateScreen.CHANGE_NEW_IMAGES,_list.selectedItem));
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