package com.socialApplication.view.introductionPanel{
	
	
	import com.socialApplication.common.Constants;
	import com.socialApplication.view.abstract.ViewAbstract;
	
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.PageIndicator;
	import feathers.data.ListCollection;
	import feathers.layout.HorizontalLayout;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	
	public class ViewIntroduction extends ViewAbstract{
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
		private var _labelSlogan:Label;
		private var _pageIndicator:PageIndicator;
		private var _buttonGetStarted:Button;
		private var _introductionSkin:Image;
		private var _dataProvider:ListCollection = new ListCollection();
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewIntroduction():void{
			
			
		}
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function activateContent():void{
			_buttonGetStarted = new Button();
			_buttonGetStarted.nameList.add(Constants.BUTTON_GET_START);
			_buttonGetStarted.setSize(300*scale,75*scale);
			_buttonGetStarted.addEventListener(Event.TRIGGERED,_handlerGetStart);
			
			footer = new ViewAbstract();
			footer.setSize(introductionSkin.width,150*scale);
			footer.backgroundSkin=new Quad(footer.width,footer.height,0x2f363b);
			footer.backgroundSkin.x=0;
			
			_buttonGetStarted.label = Constants.LABEL_INTRODUCTION_BUTTON;
			_buttonGetStarted.x=Constants.WIDTH/2*scale-_buttonGetStarted.width/2-(Constants.WIDTH*scale/2-footer.width/2);
			_buttonGetStarted.y=25*scale;	
			
			footer.addChild(_buttonGetStarted);
			footer.x=Starling.current.nativeStage.stageWidth/2 - footer.width/2;
			footer.y=700*scale;
			
			_pageIndicator=new PageIndicator();
			_pageIndicator.nameList.add(Constants.PAGE_INDICATOR_INTRO);
			_pageIndicator.addEventListener(Event.CHANGE, _handlerChangePageIndicator);
			_pageIndicator.direction = PageIndicator.DIRECTION_HORIZONTAL;
			_pageIndicator.gap = 5*scale;
			_pageIndicator.y=665*scale;
			_pageIndicator.x=Starling.current.nativeStage.stageWidth/2-60*scale;			
			addChild(_pageIndicator);
			
			_list=new List();
			_list.setSize(570*scale,400*scale);
			_list.x=Starling.current.nativeStage.stageWidth/2-_list.width/2;
			_list.y=270*scale;
			_list.nameList.add(Constants.LIST_INTRODUCTION);
			_list.snapScrollPositionsToPixels=true;
			_list.snapToPages = true;
			_list.scrollBarDisplayMode = List.SCROLL_BAR_DISPLAY_MODE_NONE;
			_list.horizontalScrollPolicy = List.SCROLL_POLICY_ON;	
			_list.addEventListener(Event.SCROLL, _handlerScrollList);
			_list.itemRendererName=(Constants.RENDERER_INTRODUCTION);
			
			
			var pListLayout:HorizontalLayout = new HorizontalLayout();
			pListLayout.verticalAlign = HorizontalLayout.VERTICAL_ALIGN_MIDDLE;
			_list.layout = pListLayout;
			
			addChild(_list);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------

		public function get logo():Image		{
			return _logo;
		}

		public function set logo(pLogo:Image):void		{
			if(pLogo && _logo != pLogo){
				_logo = pLogo;
				_logo.x = Starling.current.nativeStage.stageWidth/2 - _logo.width/2;
				_logo.y= 175*scale;
				addChild(_logo);
			}
		}

		public function set introductionSkin(pSkin:Image):void{
			if(pSkin){
				if (_introductionSkin != pSkin){
					_introductionSkin = pSkin;
					_introductionSkin.x = Starling.current.nativeStage.stageWidth/2 - _introductionSkin.width/2;
					_introductionSkin.y = 150*scale;
					addChild(_introductionSkin);
					
				}	
			}			
		}
		
		public function get  introductionSkin():Image{
			return _introductionSkin;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
	
		override protected function initialize():void{
			super.initialize();											
		}
	
		override protected function draw():void{
			super.draw();	
		}
		
	
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		private function _handlerScrollList(event:Event):void	{
			_pageIndicator.pageCount = _list.horizontalPageCount;
			_pageIndicator.selectedIndex = _list.horizontalPageIndex;
		}
		
		private function _handlerChangePageIndicator(event:Event):void{
			
			if(_pageIndicator.numChildren==_pageIndicator.selectedIndex+1){
				if(contains(footer)){
					return;
				}
				addChild(footer);
			}
			_list.scrollToPageIndex(_pageIndicator.selectedIndex, 0, _list.pageThrowDuration);
		}
		
		private function _handlerGetStart(event:Event):void{
			dispatchEvent(new EventViewIntroduction(EventViewIntroduction.CLICK_GET_STARTED));
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