package com.socialApplication.view.profile{
	
	
	import com.socialApplication.common.Constants;
	import com.socialApplication.model.vo.VOUserData;
	import com.socialApplication.view.abstract.ViewAbstract;
	import com.socialApplication.view.common.BusyIndicator;
	import com.socialApplication.view.createScreen.EventViewCreateScreen;
	import com.socialApplication.view.profile.common.ItemRendererProfileList;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.ScrollContainer;
	import feathers.controls.Scroller;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.events.FeathersEventType;
	import feathers.layout.TiledRowsLayout;
	import feathers.layout.VerticalLayout;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ViewProfile extends ViewAbstract{
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
		
		private var _photoBorder:DisplayObject;
		private var _photo:DisplayObject;
		private var	_buttonMenu:Button;
		private var _labelCountLike:Label;
		private var _labelCountComments:Label;
		private var _labelName:Label;
		private var _labelStatus:Label;
		private var _toggleButtonGrid:Button;
		private var _toggleButtonList:Button;
		private var _list:List;
		private var _rendererText:Function;
		private var _rendererTextStatus:Function;
		private var _userData:VOUserData;
		private var _imageInfoForLoad:Object={};
		private var _imageListCollections:ListCollection=new ListCollection();
		private var _viewContainer:ScrollContainer;
		private var _containerPopUp:BusyIndicator;
		private var isLoaded:Boolean=false;
		private var _touchID:int=-1;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewProfile():void{
			
		}
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------		
		public function addPreloader():void{
			
		}
		
		public function removePreloader():void{
			
		}


		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get imageListCollection():ListCollection{	return _imageListCollections;}
		public function set imageListCollection(value:ListCollection):void{
			_imageListCollections=value;	
			_list.dataProvider.addAllAt(_imageListCollections,_list.dataProvider.length);
			_popUpDelete();
			
			if(!_list.hasEventListener(Event.SCROLL)){
				_list.addEventListener(Event.SCROLL,_handlerContainerList);	
			}
			if(!_viewContainer.hasEventListener(Event.SCROLL)){
				_viewContainer.addEventListener(Event.SCROLL,_handlerContainerScroll);				
			}
			if(_imageListCollections.length<24){
				isLoaded=true;
				return;
			}
		}
		public function set photoBorder(pPhotoBorder:DisplayObject):void{
			if(pPhotoBorder){
				_photoBorder=pPhotoBorder;
			}			
		}
		public function get photoBorder():DisplayObject{return	_photoBorder;}
		public function set avatar(pPhoto:DisplayObject):void{
			if(pPhoto){
				_photo=pPhoto;
				_photo.scaleX=scale;
				_photo.scaleY=scale;	
				if(_photo.width>145*scale){
					_photo.width=145*scale;
				}
				if(_photo.height>145*scale){
					_photo.width=145*scale;
				}
				_photo.x=photoBorder.x+(photoBorder.width-_photo.width)/2;
				_photo.y=photoBorder.y+(photoBorder.height-_photo.height)/2;
				_viewContainer.addChild(_photo);
				
				if(_viewContainer.getChildIndex(_photo)>_viewContainer.getChildIndex(photoBorder)){
					_viewContainer.swapChildren(_photo,photoBorder)
				}
			}			
		}
		public function set userData(pUserData:VOUserData):void{
			if(pUserData){
				_userData = pUserData;
				_commitData();
			}			
		}
		
		public function set rendererText(pRendererText:Function):void{
			_rendererText=pRendererText;}
		
		public function set rendererTextStatus(pRendererText:Function):void{
			_rendererTextStatus=pRendererText;}
		
		public function popUpCreate():void{
			_containerPopUp=new BusyIndicator();
			PopUpManager.addPopUp(_containerPopUp);
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
	

		override protected function initialize():void{
			
			super.initialize();
			this.setSize(Constants.WIDTH*scale,Constants.HEIGHT*scale);
			removeChild(background);
			
			header.nameList.add(Constants.HEADER_PROFILE);
			addChild(header);			
			
			_viewContainer=new ScrollContainer();			
			_viewContainer.setSize(Starling.current.nativeStage.stageWidth,Starling.current.nativeStage.stageHeight-header.height);
			_viewContainer.horizontalScrollPolicy=Scroller.SCROLL_POLICY_OFF;
			_viewContainer.scrollBarDisplayMode = Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;
			addChild(_viewContainer);						

			_list=new List();
			_list.height=Starling.current.nativeStage.stageHeight-header.height;
			_list.dataProvider=new ListCollection();
			_list.snapScrollPositionsToPixels=true;
			_list.scrollBarDisplayMode = Scroller.SCROLL_BAR_DISPLAY_MODE_NONE;
			_list.verticalScrollPolicy=Scroller.SCROLL_POLICY_OFF;
			_list.horizontalScrollPolicy=Scroller.SCROLL_POLICY_OFF;
			_list.verticalScrollStep=67.5;
			_viewContainer.addChild(_list);		
			
			_buttonMenu=new Button();
			_buttonMenu.nameList.add(Constants.BUTTON_MENU);
			_buttonMenu.addEventListener(Event.TRIGGERED,_handlerButtonMenuClick);
			_buttonMenu.scaleX=scale;
			_buttonMenu.scaleY=scale;			
			header.leftItems = new <DisplayObject>[ _buttonMenu ];
			
			_toggleButtonGrid=new Button();
			_toggleButtonGrid.nameList.add(Constants.TOGGLE_BUTTON_GRID);
			_toggleButtonGrid.addEventListener(Event.TRIGGERED,_handlerChangeListLayout);
			_toggleButtonGrid.setSize(155,42);
			_toggleButtonGrid.scaleX=scale;	
			_toggleButtonGrid.scaleY=scale;	
			_toggleButtonGrid.isToggle=true;
			_toggleButtonGrid.isSelected=true;
			_viewContainer.addChild(_toggleButtonGrid);
		
			_toggleButtonList=new Button();
			_toggleButtonList.nameList.add(Constants.TOGGLE_BUTTON_LIST);
			_toggleButtonList.addEventListener(Event.TRIGGERED,_handlerChangeListLayout);
			_toggleButtonList.setSize(155,42);
			_toggleButtonList.scaleX=scale;	
			_toggleButtonList.scaleY=scale;	
			_toggleButtonList.isToggle=true;
			_toggleButtonList.isSelected=false;
			_viewContainer.addChild(_toggleButtonList);
			
			_labelCountLike = new Label();
			_labelCountLike.setSize(100*scale,100*scale)
			_labelCountLike.textRendererFactory=_rendererText;
			_viewContainer.addChild(_labelCountLike);
			
			
			_labelCountComments = new Label();
			_labelCountComments.setSize(100*scale,100*scale)
			_labelCountComments.textRendererFactory=_rendererText;
			_viewContainer.addChild(_labelCountComments);
			
			_labelName=new Label();
			_labelName.textRendererFactory=_rendererText;
			_labelName.setSize(Starling.current.nativeStage.stageWidth-325*scale,50*scale);
			_viewContainer.addChild(_labelName);
			
			
			_labelStatus=new Label();
			_labelStatus.textRendererFactory=_rendererTextStatus;
			_labelStatus.setSize(Starling.current.nativeStage.stageWidth-350*scale,200*scale);
			_viewContainer.addChild(_labelStatus);
				
		}
		
			
		override protected function draw():void{
			super.draw();
			_layout();
		}
		
		private function _commitData():void{
			_labelName.text	= _userData.description;	
			_labelStatus.text = _userData.status;
			_labelCountLike.text = _userData.countOfLikes;
			_labelCountComments.text = _userData.countOfComments;
			
			dispatchEvent(new  EventViewProfile(EventViewProfile.AVATAR_LOAD,_userData.avatar));
			
			_imageInfoForLoad.id=_userData.id;
			_imageInfoForLoad.token=_userData.token;
			_imageInfoForLoad.start=0;	
			
			dispatchEvent(new  EventViewProfile(EventViewProfile.IMAGE_LOAD,_imageInfoForLoad));
		}
		
		private function _layout():void{
			_viewContainer.y=header.height;
	
			
			background.width=Starling.current.nativeStage.stageWidth;
			background.x=Starling.current.nativeStage.stageWidth/2-background.width/2;
			_viewContainer.addChildAt(background,0);
			
			_photoBorder.x=15*scale;
			_photoBorder.y=40*scale;
			_viewContainer.addChild(_photoBorder);		
			
			_toggleButtonGrid.y=background.height+15*scale;
			_toggleButtonGrid.x=Starling.current.nativeStage.stageWidth/2-_toggleButtonGrid.width-_toggleButtonGrid.width/2;
			
			_toggleButtonList.y=background.height+15*scale;
			_toggleButtonList.x=Starling.current.nativeStage.stageWidth/2+_toggleButtonList.width/2;
			
			_labelCountLike.x=Starling.current.nativeStage.stageWidth-65*scale;
			_labelCountLike.y=40*scale;				
			
			_labelName.x=175*scale;
			_labelName.y=35*scale;			
			
			_labelStatus.x=175*scale;
			_labelStatus.y=25*scale+_labelName.height;
			
			_labelCountComments.x=Starling.current.nativeStage.stageWidth-65*scale;
			_labelCountComments.y=155*scale;
			
			_list.width=Starling.current.nativeStage.stageWidth;
			_list.y=Starling.current.nativeStage.stageHeight/2-135*scale;
			_listLayoutGrid();
			
		}
		
		private function _listLayoutGrid():void{
			var pTileLayout:TiledRowsLayout=new TiledRowsLayout();
			pTileLayout.gap=5*scale;
			pTileLayout.useVirtualLayout=true;
			pTileLayout.paddingLeft=5*scale;
			pTileLayout.paddingRight=5*scale;
			pTileLayout.tileHorizontalAlign=TiledRowsLayout.TILE_HORIZONTAL_ALIGN_CENTER;
			pTileLayout.horizontalAlign=TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
			
			
			_list.layout=pTileLayout;
			_list.itemRendererFactory = function():IListItemRenderer{
				var renderer:ItemRendererProfileList = new ItemRendererProfileList();
				var pSize : Number = Starling.current.nativeStage.stageWidth/3-20*scale;
				
				renderer.setSize(pSize,pSize);
				return renderer;
			};
		}
		
		private function _listLayoutList():void{
			var pVerticalLayout:VerticalLayout=new VerticalLayout();
			pVerticalLayout.gap=5*scale;
			pVerticalLayout.hasVariableItemDimensions=true;
			pVerticalLayout.typicalItemHeight=600;
			pVerticalLayout.useVirtualLayout=true;
			pVerticalLayout.paddingLeft=5*scale;
			pVerticalLayout.paddingRight=5*scale;
			pVerticalLayout.horizontalAlign=TiledRowsLayout.HORIZONTAL_ALIGN_CENTER;
			
			
			_list.layout=pVerticalLayout;
			_list.itemRendererFactory = function():IListItemRenderer{
				var renderer:ItemRendererProfileList = new ItemRendererProfileList();
				renderer.setSize(500*scale,500*scale);
				renderer.isBigFontSize=true;
				return renderer;
			};
		}
		
		private function _scrollContainerPositionSearch():void{
			
			if(_viewContainer.verticalScrollPosition<0){
				_viewContainer.verticalScrollPosition=0;	
				_viewContainer.stopScrolling();
			}
						
			if(_viewContainer.verticalScrollPosition>_list.y){
				_list.verticalScrollPolicy = Scroller.SCROLL_POLICY_ON;
			}
		}
		
		private function _scrollListPositionSearch():void{
				
			if(_list.minVerticalScrollPosition > _list.verticalScrollPosition){
				_viewContainer.verticalScrollPosition+=_list.verticalScrollPosition;					
				_list.verticalScrollPolicy = Scroller.SCROLL_POLICY_OFF;
			}				
				
			if(!isLoaded){
					
				if (_list.verticalScrollPosition > _list.maxVerticalScrollPosition){	
					_list.removeEventListener(Event.SCROLL,_handlerContainerList);
					_imageInfoForLoad.start+=Constants.COUNT_IMAGE;	
					dispatchEvent(new  EventViewProfile(EventViewProfile.IMAGE_LOAD,_imageInfoForLoad));
				}
			}		
				
			if(_viewContainer.verticalScrollPosition<=0){	
					
					_viewContainer.verticalScrollPosition+=_list.verticalScrollPosition;
						
					if(_list.verticalScrollPosition>_list.minVerticalScrollPosition||_list.verticalScrollPosition<_list.minVerticalScrollPosition){
						_list.verticalScrollPosition=_list.minVerticalScrollPosition;
						_list.stopScrolling();
					}
			}				
		}
		
		private function _buttonStateChange():void{
			_toggleButtonGrid.isSelected=false;
			_toggleButtonList.isSelected=false;
		}
		
		private function _popUpDelete():void{
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
		
		private function _handlerChangeListLayout(event:Event):void{
			switch(event.currentTarget){
				case _toggleButtonGrid:
						if(_toggleButtonGrid.isSelected){
							_toggleButtonGrid.isSelected=false;
							return;
						}else{
							_buttonStateChange();
							_listLayoutGrid();
						}
					break;
				
				case _toggleButtonList:
					if(_toggleButtonList.isSelected){
						_toggleButtonList.isSelected=false;
						return;
					}else{
						_buttonStateChange();
						_listLayoutList();
					}
					break;				
			}			
		}
		
		
		private function _handlerContainerScroll(event:Event):void{			
			_scrollContainerPositionSearch();				
		}
		
		private function _handlerContainerList(event:Event):void{
			_scrollListPositionSearch();			
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