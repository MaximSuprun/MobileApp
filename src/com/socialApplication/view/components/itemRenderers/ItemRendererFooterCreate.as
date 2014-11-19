package com.socialApplication.view.components.itemRenderers{
	
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.core.FeathersControl;
	
	import flash.geom.Point;
	
	import starling.display.Image;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ItemRendererFooterCreate extends FeathersControl implements IListItemRenderer{
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
		private var _scale:Number;
		private var _accessoryText:Label;
		private var _rendererText:Function;
		private var _rendererAccessoryText:Function;
		private var _icon:Image;
		private var _touchID:int=-1;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ItemRendererFooterCreate(){
			
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function get scale():Number{
			return _scale;
		}
		
		public function set scale(pScale:Number):void{
			_scale = pScale;
		}
				
		
		public function get index():int	{
			return _index;
		}
		
		public function set index(value:int):void{
			if(_index == value){
				return;
			}
			_index = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		
		public function set rendererText(pRendererText:Function):void{
			_rendererText=pRendererText;
		}
	
		public function set rendererAccessoryText(pRendererText:Function):void{
			_rendererAccessoryText=pRendererText;
		}
		
		
		public function get owner():List{
			return _owner;
		}
		
		public function set owner(value:List):void{
			if(_owner == value){
				return;
			}
			_owner = value;
			invalidate(INVALIDATION_FLAG_DATA);
		}
		
		
		public function get data():Object{
			return _data;
		}
		
		public function set data(value:Object):void{
			if(_data == value){
				return;
			}
			_data = value;	
			
			invalidate(INVALIDATION_FLAG_DATA);
		}
		
		
		public function get isSelected():Boolean{
			return _isSelected;
		}
		
		public function set isSelected(value:Boolean):void{
			if(_isSelected == value){
				return;
			}
			_isSelected = value;
			invalidate(INVALIDATION_FLAG_SELECTED);
			dispatchEventWith(Event.CHANGE);
		}
		
		
		public function get padding():Number{
			return _padding;
		}
		
		public function set padding(value:Number):void{
			if(_padding == value){
				return;
			}
			_padding = value;
			invalidate(INVALIDATION_FLAG_LAYOUT);
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
			
			if(!_label){
				_label = new Label();
				_label.textRendererFactory=_rendererText;
				addChild(_label);
			}
			if(!_accessoryText){
				_accessoryText = new Label();
				_accessoryText.textRendererFactory=_rendererAccessoryText;
				addChild(_accessoryText);
			}
			
			addEventListener(TouchEvent.TOUCH,_handlerTouch);
			addEventListener( Event.REMOVED_FROM_STAGE,_handlerRemovedFromStage );
		}
		
		override protected function draw():void	{
			super.draw();
			
			const dataInvalid:Boolean = isInvalid(INVALIDATION_FLAG_DATA);
			
			if(dataInvalid){
			  commitData();
			}
			
			autoSizeIfNeeded();
			layoutChildren();
		}
		
		protected function autoSizeIfNeeded():Boolean{
			const needsWidth:Boolean = isNaN(explicitWidth);
			const needsHeight:Boolean = isNaN(explicitHeight);
			if(!needsWidth && !needsHeight){
				return false;
			}
			
					
			_label.width = explicitWidth - 2 * _padding*scale;
			_label.height = explicitHeight - 2 * _padding*scale;
			_label.validate();
			
			var newWidth:Number = explicitWidth;
			if(needsWidth){
				newWidth = _icon.width + 2 * _padding*scale;
			}
			var newHeight:Number = explicitHeight;
			if(needsHeight){	
				newHeight = _icon.height + 2 * _padding*scale;

			}
			
			return setSizeInternal(newWidth, newHeight, false);	
		}
		
		protected function commitData():void{
			if(_data){
				_label.text = _data.label;
				_accessoryText.text = _data.accessoryText;
				_icon = _data.texture;	
				if(this.contains(_icon)){
					return;
				}
				addChild(_icon)
			}else{
				_label.text = null;
				_accessoryText.text = null;
				_icon = null;			
			}
		}
		
		protected function layoutChildren():void{
			
			if(getChildIndex(_icon)>getChildIndex(_accessoryText)){
				swapChildren(_icon,_accessoryText);
			}
			
			_icon.x=_padding*scale;
			_icon.y=_padding*scale;
			
			_accessoryText.x=_icon.width/2-15*scale;
			_accessoryText.y=_icon.height/2;
		
			_label.y = _icon.height + _padding*scale;
			_label.width = actualWidth;
			_label.height = 30*scale;
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
