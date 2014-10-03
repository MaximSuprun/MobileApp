package com.razzmatazz.starling.utils.dynamicTextureAtlasGenerator {

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import starling.events.EventDispatcher;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	
	public class DynamicAtlasGenerator extends EventDispatcher {
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		public static const DIMENSION:Number = 2048;
		
		public static const GAP:Number = 2;
		
		public static const TIMER_ASYNC_DELAY:Number = 1000/30;
		public static const ASYNC_ITERATIONS_COUNT:Number = 30;

		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED VARIABLES
		//
		//---------------------------------------------------------------------------------------------------------
		private static var _timerAsync:Timer;
		private static var _asyncIterationMax:Number;
		private static var _asyncIterationCurrent:Number;

		private static var _canvas:Sprite;
		private static var _canvasBitmapData:BitmapData;
		private static var _atlas:TextureAtlas;
		private static var _xml:XML;
		private static var _assets:Vector.<VOAtlasGeneratorInputItemData>;
		private static var _backgroundColor:Number;
		private static var _x:Number;
		private static var _y:Number;
		private static var _heightMax:Number;
		private static var _callbackFunction:Function;
		
		private static var _result:Vector.<TextureAtlas>;

		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function DynamicAtlasGenerator(){
			super();
		}

		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		static public function fromDataVector(pAssets:Vector.<VOAtlasGeneratorInputItemData>, pCallbackFunction:Function, pBackgroundColor:Number):void {
			// Initialize async operation
			_callbackFunction = pCallbackFunction;
			_backgroundColor = pBackgroundColor;
			_assets = pAssets;
			_asyncIterationCurrent = 0;
			_asyncIterationMax = _assets.length;
			
			_result = new Vector.<TextureAtlas>();
			
			_atlasBaseRecreate();

			if(!_timerAsync){
				_timerAsync = new Timer(TIMER_ASYNC_DELAY);
			}
			_timerAsync.addEventListener(TimerEvent.TIMER, _handlerTimerTickChunkProcess, false, 0, true);
			_timerAsync.start();
					
		}
		
		private static function _atlasBaseRecreate():void{
			_x = GAP;
			_y = GAP;
			_heightMax = 0;
			
			if(_canvas){
				_canvas.removeChildren();
			} else {
				_canvas = new Sprite();
			}
			_xml = new XML(<TextureAtlas></TextureAtlas>);
			_xml.@imagePath = "atlas.png";

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
		private static function _xDodgeRequired(pBitmap:Bitmap):Boolean {
			var pValue:Boolean = false;
			if(_x+pBitmap.width > DIMENSION-GAP){
				pValue = true;
			}
			return pValue;
		}
		
		private static function _yDodgeRequired(pBitmap:Bitmap):Boolean {
			var pValue:Boolean = false;
			if(_y+pBitmap.height > DIMENSION-GAP){
				pValue = true;
			}
			return pValue;
		}
		
		private static function _processChunk(pIterationMax:Number):void {
			
			var pAtlas:TextureAtlas;
			
			while(_asyncIterationCurrent<pIterationMax){
				
				var pSubText:XML;
				
				var pData:VOAtlasGeneratorInputItemData = VOAtlasGeneratorInputItemData(_assets[_asyncIterationCurrent]);
				var pBitmap:Bitmap = new Bitmap(pData.bitmapData);
				
				
				if(_xDodgeRequired(pBitmap)){
					_x = GAP;
					_y += _heightMax+GAP;
					_heightMax = 0;
				}
				
				
				if(!_yDodgeRequired(pBitmap)){
					pBitmap.x = _x;
					pBitmap.y = _y;
					_x += pBitmap.width+GAP;
					_heightMax = Math.max(_heightMax, pBitmap.height);
					
					_canvas.addChild(pBitmap);
					
					pSubText = new XML(<SubTexture />); 
					pSubText.@name = pData.id;
					pSubText.@x = pBitmap.x;
					pSubText.@y = pBitmap.y;
					pSubText.@width = pBitmap.width;
					pSubText.@height = pBitmap.height;
					_xml.appendChild(pSubText);
					
					++_asyncIterationCurrent;
					
				} else {
					// We're out of the texture DIMENSION space
					pAtlas = _altlasDraw();
					_result.push(pAtlas);
					
					_atlasBaseRecreate();
					
				}
			}
			
			if(_asyncIterationCurrent === _asyncIterationMax){
				_timerAsync.stop();
				_timerAsync.removeEventListener(TimerEvent.TIMER, _handlerTimerTickChunkProcess, false);

				pAtlas = _altlasDraw();
				_result.push(pAtlas);

				_destroy();
				
				var pObjectResult:VOAtlasCollection = new VOAtlasCollection();
				pObjectResult.atlasCollection = _result;
				
				_callbackFunction(pObjectResult);
				
			}
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private static function _handlerTimerTickChunkProcess(event:TimerEvent):void {
			var pItertionMax:Number = _asyncIterationCurrent+ASYNC_ITERATIONS_COUNT;
			pItertionMax = Math.min(pItertionMax, _asyncIterationMax);
			_processChunk(pItertionMax);
		}
		
		private static function _altlasDraw():TextureAtlas{
			_canvasBitmapData = new BitmapData(_canvas.width, _canvas.height, true, _backgroundColor);
			_canvasBitmapData.draw(_canvas);
			var pTexture:Texture = Texture.fromBitmapData(_canvasBitmapData, false);
			_atlas = new TextureAtlas(pTexture, _xml);
			return _atlas;
		}
		
		/**
		 * Cleans data up 
		 * 
		 */
		private static function _destroy():void {
			_timerAsync.stop();
			_timerAsync.removeEventListener(TimerEvent.TIMER, _handlerTimerTickChunkProcess, false);

			var pAssetsLength:int = _assets.length;
			for (var i:int=0; i<pAssetsLength; ++i) {
				var pAsset:VOAtlasGeneratorInputItemData = VOAtlasGeneratorInputItemData(_assets[i]);
				pAsset.destroy();
			}
			
			_assets = null;
			_canvas.removeChildren();
			_canvasBitmapData.dispose();
			
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