package com.socialApplication.view.profile.common{
	
	import com.socialApplication.view.abstract.ViewAbstract;
	
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ItemRendererProfileList extends ViewAbstract implements IListItemRenderer{
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
		protected var _labelNumberOfLikes:Label;		
		protected var _labelNumberOfComments:Label;		
		protected var _index:int = -1;
		protected var _padding:Number = 0;
		protected var _owner:List;
		protected var _data:Object;
		protected var _isSelected:Boolean;
	
		private static const HELPER_POINT:Point = new Point();
		private var _touchID:int=-1;
		private var _imageUrl:String="";
		private var _scale:Number;
		private var _backgroundInfoPanel:DisplayObject;
		private var _rendererText:Function;
		private var _imageLoader:ImageLoader;
		private var _isBigFontSize:Boolean=false;
		

		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ItemRendererProfileList(){
			
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
				
		public function set isBigFontSize(pValue:Boolean):void{
			_isBigFontSize=pValue;
		}
		public function get isBigFontSize():Boolean{return _isBigFontSize;}
				
		
		public function get index():int	{return this._index;}		
		public function set index(value:int):void{
			if(this._index == value){
				return;
			}
			this._index = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		
		public function get owner():List{return this._owner;}		
		public function set owner(value:List):void{
			//if(this._owner == value){return;}
			this._owner = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		
		public function get data():Object{	return _data;}		
		public function set data(value:Object):void{
			if(this._data == value){return;}
			this._data = value;	
			
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		
		public function get isSelected():Boolean{return this._isSelected;}		
		public function set isSelected(value:Boolean):void{
			if(this._isSelected == value){return;}
			this._isSelected = value;
			this.invalidate(INVALIDATION_FLAG_SELECTED);
			this.dispatchEventWith(starling.events.Event.CHANGE);
		}
		
		
		public function get padding():Number{return this._padding;}		
		public function set padding(value:Number):void{
			if(this._padding == value){
				return;
			}
			this._padding = value;
			this.invalidate(INVALIDATION_FLAG_LAYOUT);
		}
		
		
		public function get backgroundInfoPanel():DisplayObject{return _backgroundInfoPanel;}	
		public function set backgroundInfoPanel(pBackground:DisplayObject):void{
			if(pBackground){
				_backgroundInfoPanel=pBackground;
			}
		}
		
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
			
			if(!this._labelNumberOfLikes){
				this._labelNumberOfLikes = new Label();
				if(_rendererText!=null){
					_labelNumberOfLikes.textRendererFactory=_rendererText;
				}
				
			}
			if(!this._labelNumberOfComments){
				this._labelNumberOfComments = new Label();
				if(_rendererText!=null){
					_labelNumberOfComments.textRendererFactory=_rendererText;
				}
			}
			
			addEventListener( TouchEvent.TOUCH,_handlerTouch);
			addEventListener( starling.events.Event.REMOVED_FROM_STAGE,_handlerRemovedFromStage );
		}
		
		override protected function draw():void	{
			super.draw();
			const dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			
			if(dataInvalid){
				this.commitData();
			}
			this.layoutChildren();
		}
		
		
		protected function commitData():void{
			if(this._data){
				
				_labelNumberOfLikes.text = _data.number_of_likes;
				_labelNumberOfComments.text = _data.number_of_comments;
				_imageUrl = _data.url;
				
				if(!_imageLoader){
					_imageLoaderCreate()
				} else {
					_imageLoader.dispose();
					removeChild(_imageLoader);
					_imageLoader=null;
					_imageLoaderCreate()					
				}		
				
			}else{
				this._labelNumberOfLikes.text = null;
				this._labelNumberOfComments.text = null;
				this._imageUrl = null;
			}
		}
		
		protected function layoutChildren():void{		
			backgroundInfoPanel.width=this.width-this.width*0.045;
			backgroundInfoPanel.height=this.height*0.175;
			backgroundInfoPanel.x=(this.width-backgroundInfoPanel.width)/2;
			backgroundInfoPanel.y=this.height-backgroundInfoPanel.height-this.height*0.02;
			
			_labelNumberOfLikes.height=backgroundInfoPanel.height;
			_labelNumberOfLikes.x=this.width*0.55;
			_labelNumberOfLikes.y=backgroundInfoPanel.y;
			
			_labelNumberOfComments.height=backgroundInfoPanel.height;
			_labelNumberOfComments.x=this.width*0.25;
			_labelNumberOfComments.y=backgroundInfoPanel.y;
			
			if(isBigFontSize){
				_labelNumberOfLikes.y+=10*scale;
				_labelNumberOfComments.y+=10*scale;
			}
		}
		private function _imageLoaderCreate():void{
			_imageLoader=new ImageLoader();
			_imageLoader.addEventListener(Event.COMPLETE,_handlerItemImageLoadeded);
			_imageLoader.source=_imageUrl;
			_imageLoader.width=this.width;
			_imageLoader.height=this.height;
			content.addChild(_imageLoader);
		}
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerTouch(event:TouchEvent):void
		{
			if( !_isEnabled ){
				_touchID = -1;
				return;
			}
			
			if(_touchID >= 0 ){
				
				var touch:Touch = event.getTouch( this, null, _touchID );
				if( !touch ){
					return;
				}
				
				if( touch.phase == TouchPhase.ENDED )
				{
					touch.getLocation( stage, HELPER_POINT );
					var isInBounds:Boolean = contains( stage.hitTest( HELPER_POINT, true ) );
					if( isInBounds ){
						isSelected = true;
					}
					
					_touchID = -1;
				}
				return;
			}else{
				
				touch = event.getTouch( this, TouchPhase.BEGAN );
				if( !touch ){
					
					return;
				}
				
				_touchID = touch.id;
			}
		}
		
		private function _handlerRemovedFromStage( event:starling.events.Event):void{
			_touchID = -1;
		}
		private function _handlerItemImageLoadeded( event:starling.events.Event):void{
			content.addChild(_backgroundInfoPanel);			
			content.addChild(_labelNumberOfLikes);
			content.addChild(_labelNumberOfComments);
			isInvalid(INVALIDATION_FLAG_DATA);
			contentShow(1);
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