package com.socialApplication.view.explore{
	
	
	import com.socialApplication.common.Constants;
	import com.socialApplication.model.vo.VOImageInfo;
	import com.socialApplication.view.abstract.ViewAbstract;
	import com.socialApplication.view.explore.common.PopUpShare;
	
	import feathers.controls.Button;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.core.PopUpManager;
	
	import flash.sampler.NewObjectSample;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Quad;
	import starling.events.Event;
	
	public class ViewExplore extends ViewAbstract{
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
		private var _buttonBack:Button;
		private var _buttonShare:Button;
		
		private var _image:DisplayObject;
		private var _iconLike:DisplayObject;
		private var _iconClock:DisplayObject;
		private var popUpContainer:DisplayObject;
		private var _imageLoader:ImageLoader;
		
		private var _labelNumberOfLike:Label;
		private var _labelName:Label;
		private var _labelTime:Label;
		
		private var _imageInfo:VOImageInfo;
		private var _rendererText:Function;
		private var _popUpShare:PopUpShare;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function ViewExplore():void{
			
			
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
		public function set image(pImage:DisplayObject):void{
			if(pImage && pImage!=_image){
				_image=pImage;
				addChild(_image);
			}
		}
		public function get image():DisplayObject{return _image};
	
		public function set imageInfo(pImageInfo:VOImageInfo):void{
			if(pImageInfo){
				_imageInfo=pImageInfo;
				_setData();
			}
		}		
		public function get imageInfo():VOImageInfo{return _imageInfo};
		
		
		public function set iconLike(pIconLike:DisplayObject):void{
			if(pIconLike && pIconLike!=_iconLike){
				_iconLike=pIconLike;
			}
		}
		public function get iconLike():DisplayObject{return _iconLike};
		
		public function set iconClock(pIconClock:DisplayObject):void{
			if(pIconClock && pIconClock!=_iconClock){
				_iconClock=pIconClock;
			}
		}
		public function get iconClock():DisplayObject{return _iconClock};
		
		public function set rendererText(pRendererText:Function):void{
			_rendererText=pRendererText;
		}
		public function get rendererText():Function{
			return _rendererText;
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function initialize():void{
			super.initialize();
			
			header.nameList.add(Constants.HEADER_EXPLORE);
			addChild(header);
			
			_buttonBack=new Button();
			_buttonBack.nameList.add(Constants.BUTTON_BACK);
			_buttonBack.scaleX=scale;
			_buttonBack.scaleY=scale;
			_buttonBack.addEventListener(Event.TRIGGERED,_handlerButtonClick);
			header.leftItems = new <DisplayObject>[ _buttonBack ];
		
			_buttonShare=new Button();
			_buttonShare.nameList.add(Constants.BUTTON_SHARE);
			_buttonShare.scaleX=scale;
			_buttonShare.scaleY=scale;
			_buttonShare.addEventListener(Event.TRIGGERED,_handlerButtonClick);	
			
			_labelName=new Label();
			_labelNumberOfLike=new Label();
			_labelTime=new Label();
			
			_popUpShare=new PopUpShare();
			_popUpShare.addEventListener(EventViewExplore.CLICK_CANCEL,_handlerClickPopUpCancel);
			_popUpShare.addEventListener(EventViewExplore.SHARE,_handlerShare);
			
			if(rendererText != null){
				_labelName.textRendererFactory=rendererText;
				_labelNumberOfLike.textRendererFactory=rendererText;
				_labelTime.textRendererFactory=rendererText;
			}
			
		}
		
		override protected function draw():void{
			super.draw();					
								
		}
		
		private function _setData():void{
			if(!_imageLoader){
				_imageLoader = new ImageLoader();
				_imageLoader.addEventListener(Event.COMPLETE,_handlerImageLoadCompete);
				_imageLoader.source = imageInfo.url;
				image = _imageLoader;
			}
			_labelNumberOfLike.text = imageInfo.number_of_likes + " that like";
			_labelName.text = imageInfo.userName;
			_labelTime.text = imageInfo.age;
		}
		
		private function _layout():void{
			background.x=(Starling.current.nativeStage.stageWidth-background.width)/2;;
			background.y=(Starling.current.nativeStage.stageHeight-background.height)/2;
			
			image.width=512*scale;
			image.height=512*scale
			image.x=(Starling.current.nativeStage.stageWidth-image.width)/2;
			image.y=(Starling.current.nativeStage.stageHeight-image.height)/2;
			
			iconLike.x=image.x+iconLike.width/2;
			iconLike.y=image.y+image.height+5*scale;
			addChild(iconLike);
			_labelNumberOfLike.x=iconLike.x+iconLike.width+5*scale;
			_labelNumberOfLike.y=iconLike.y;
			addChild(_labelNumberOfLike);
			
			_labelName.x=iconLike.x;
			_labelName.y=200*scale;
			addChild(_labelName);
			
			iconClock.x=image.x+image.width-60*scale;
			iconClock.y=_labelName.y;
			addChild(iconClock);
			_labelTime.x=iconClock.x+iconClock.width+5*scale;;
			_labelTime.y=iconClock.y;	
			addChild(_labelTime);
			
			_buttonShare.width=50*scale;		
			_buttonShare.height=25*scale;		
			_buttonShare.x=515*scale;
			_buttonShare.y=iconLike.y;		
			addChild(_buttonShare);
		}
		private function _popUpCreate():void{
			PopUpManager.addPopUp(_popUpShare,true,false);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
	
		private function _handlerButtonClick(event:Event):void{
			switch(event.currentTarget){
				case _buttonShare:
					_popUpCreate();
					break;
				case _buttonBack:
					dispatchEvent(new EventViewExplore(EventViewExplore.BACK_BUTTON_CLICK));		
					break;
			}
		}
		private function _handlerShare(event:EventViewExplore):void{
			var pShareTo:String=event.payload.label;
			switch(pShareTo){
				case Constants.FACEBOOK:
					trace("Facebook");
					dispatchEvent(new EventViewExplore(EventViewExplore.SHARE_TO_FACEBOOK,imageInfo));
					break;
				case Constants.TWITTER:
					trace("Twitter");
					dispatchEvent(new EventViewExplore(EventViewExplore.SHARE_TO_TWITTER,imageInfo));
					break;
				case Constants.PINTEREST:
					trace("Pinterest");
					dispatchEvent(new EventViewExplore(EventViewExplore.SHARE_TO_PINTEREST,imageInfo));
					break;
				case Constants.MAILRU:
					trace("Mail.ru");
					dispatchEvent(new EventViewExplore(EventViewExplore.SHARE_TO_MAILRU,imageInfo));
					break;
				case Constants.TUMBLR:
					trace("Tumblr");
					dispatchEvent(new EventViewExplore(EventViewExplore.SHARE_TO_TUMBLR,imageInfo));
					break;
			}
		}
		
		private function _handlerImageLoadCompete(event:Event):void{
			_layout();
		}
		private function _handlerClickPopUpCancel(event:EventViewExplore):void{
			PopUpManager.removePopUp(_popUpShare);
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