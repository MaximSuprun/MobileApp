package com.socialApplication.view.menu{
	
	import com.socialApplication.common.Constants;
	import com.socialApplication.view.abstract.ViewAbstract;
	import com.socialApplication.view.components.itemRenderers.ItemRendererMenuList;
	
	import feathers.controls.List;
	import feathers.data.ListCollection;
	import feathers.layout.VerticalLayout;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.events.Event;
	
	public class ViewMenu extends ViewAbstract{
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
		private var _logo:Image;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get logo():Image{
			return _logo;
		}
		
		public function set logo(pLogo:Image):void{
			if(pLogo && _logo != pLogo){
				_logo = pLogo;
				addChild(_logo);
			}
		}
		
		public function ViewMenu(){
			super();
						
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function activateContent():void{
			
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
			
			setSize(Starling.current.nativeStage.stageWidth-125*scale,Constants.HEIGHT*scale);	
						
			_list=new List();
			_list.nameList.add(Constants.LIST_MENU)
			_list.y=_logo.height;
			_list.setSize(this.width,Starling.current.nativeStage.stageHeight-_logo.height);
				
			
			var pListLayout:VerticalLayout = new VerticalLayout();
			_list.layout = pListLayout;
			_list.addEventListener(Event.CHANGE,_handlerChange);
			_list.itemRendererType=ItemRendererMenuList;
			
			
			
			_list.dataProvider=new ListCollection([{label:Constants.LABEL_VIEW_CREATE, screen:Constants.ID_VIEW_CREATE, isDarkBackground:true},
												   {label:Constants.LABEL_VIEW_PROFILE, screen:Constants.ID_VIEW_PROFILE, isDarkBackground:false},
												   {label:Constants.LABEL_VIEW_SETTINGS, screen:Constants.ID_VIEW_SETTINGS, isDarkBackground:true}]);
			
			addChild(_list);
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerChange(event:Event):void{			
			dispatchEvent(new EventViewMenu(EventViewMenu.CHANGE_SELECTED_ITEM,_list.selectedItem));			
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