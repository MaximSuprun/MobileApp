package com.socialApplication.view.components.itemRenderers{
	
	import com.socialApplication.common.Constants;
	
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	
	import flash.geom.Point;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ItemRendererSettingsList extends FeathersControl implements IListItemRenderer{
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
		protected var _label:Label;		
		protected var _index:int = -1;
		protected var _padding:Number = 0;
		protected var _owner:List;
		protected var _data:Object;
		protected var _isSelected:Boolean;
	
		private static const HELPER_POINT:Point = new Point();
		private var _topBackground:DisplayObject;
		private var _defaultBackground:DisplayObject;
		private var _bottomBackground:DisplayObject;
		private var _background:DisplayObject;
		private var _touchID:int=-1;
		private var _scale:Number;
		private var _rendererText:Function;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ItemRendererSettingsList(){
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get topBackground():DisplayObject{
			return _topBackground;
		}
		
		public function set topBackground(pBackground:DisplayObject):void{
			_topBackground = pBackground;
		}
		
		public function get background():DisplayObject{
			return _background;
		}
		
		public function set background(pBackground:DisplayObject):void{	
			_background = pBackground;
			addChildAt(_background,0);			
		}
		
		public function get defaultBackground():DisplayObject{
			return _defaultBackground;
		}
		
		public function set defaultBackground(pBackground:DisplayObject):void{
			_defaultBackground = pBackground;
		}
		public function get bottomBackground():DisplayObject{
			return _bottomBackground;
		}
		
		public function set bottomBackground(pBackground:DisplayObject):void{
			_bottomBackground = pBackground;
		}
		
		
		public function get scale():Number{
			return _scale;
		}
		
		public function set scale(pScale:Number):void{
			_scale = pScale;
		}
		
		
		public function get index():int	{
			return this._index;
		}
		
		public function set index(value:int):void{
			if(this._index == value){
				return;
			}
			this._index = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		
		public function get owner():List{
			return this._owner;
		}
		
		public function set owner(value:List):void{
			if(this._owner == value){
				return;
			}
			this._owner = value;
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		
		public function get data():Object{
			return this._data;
		}
		
		public function set data(value:Object):void{
			if(this._data == value){
				return;
			}
			this._data = value;	
			
			this.invalidate(INVALIDATION_FLAG_DATA);
		}
		
		
		public function get isSelected():Boolean{
			return this._isSelected;
		}
		
		public function set isSelected(value:Boolean):void{
			if(this._isSelected == value){
				return;
			}
			this._isSelected = value;
			this.invalidate(INVALIDATION_FLAG_SELECTED);
			this.dispatchEventWith(Event.CHANGE);
		}
		
		
		public function get padding():Number{
			return this._padding;
		}
		
		public function set padding(value:Number):void{
			if(this._padding == value){
				return;
			}
			this._padding = value;
			this.invalidate(INVALIDATION_FLAG_LAYOUT);
		}
		
		public function set rendererText(pRendererText:Function):void{
			_rendererText=pRendererText;
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
			
			if(!this._label){
				this._label = new Label();
				if(_rendererText!=null){
					_label.textRendererFactory=_rendererText;
				}
				this.addChild(_label);
			}
				
			addEventListener( TouchEvent.TOUCH,_handlerTouch);
			addEventListener( Event.REMOVED_FROM_STAGE,_handlerRemovedFromStage );
		}
		
		override protected function draw():void	{
			super.draw();
			const dataInvalid:Boolean = this.isInvalid(INVALIDATION_FLAG_DATA);
			const dataInvalidSelected:Boolean = this.isInvalid(INVALIDATION_FLAG_SELECTED);
						
			if(dataInvalid){
				this.commitData();
			}
			
			
			this.autoSizeIfNeeded();
			this.layoutChildren();
			
			this.width=400*scale;			
		}
		
		protected function autoSizeIfNeeded():Boolean{
			const needsWidth:Boolean = isNaN(this.explicitWidth);
			const needsHeight:Boolean = isNaN(this.explicitHeight);
			if(!needsWidth && !needsHeight){
				return false;
			}
			
			this._label.width = this.explicitWidth - 2 * this._padding;
			this._label.height = this.explicitHeight - 2 * this._padding;
			this._label.validate();
			
			var newWidth:Number = this.explicitWidth;
			if(needsWidth){
				newWidth = this._label.width + 2 * this._padding;
			}
			var newHeight:Number = this.explicitHeight;
			if(needsHeight){	
				newHeight = this._label.height + 2 * this._padding;

			}
			
			return this.setSizeInternal(newWidth, newHeight, false);	
		}
		
		protected function commitData():void{
			if(this._data){
				this._label.text = this._data.label;
				switch (_data.position){
					case Constants.TOP_POSITION_IN_LIST:
						background=topBackground;
						break;
					case Constants.DEFAULT_POSITION_IN_LIST:
						background=defaultBackground;
						break;
					case Constants.BOTTOM_POSITION_IN_LIST:
						background=bottomBackground;
						break;
				}
				
			}else{
				this._label.text = null;
			}
		}
		
		protected function layoutChildren():void{
			this._label.x = this._padding*scale;
			this._label.y = this._padding*scale;
			this._label.width = this.actualWidth - 2 * this._padding;
			this._label.height = this.actualHeight - 2 * this._padding;
			
			background.width=this.width;
			background.height=this.height;			
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
		
		private function _handlerRemovedFromStage( event:Event ):void{
			_touchID = -1;
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
