package com.socialApplication.service.loadImage{
	
	import com.razzmatazz.robotlegs.events.EventError;
	import com.socialApplication.common.Constants;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import org.robotlegs.starling.mvcs.Actor;
	
	import starling.textures.Texture;
		
	public class ServiceLoadImage extends Actor {
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
		protected static const LOADER_CONTEXT:LoaderContext = new LoaderContext(true);
		protected var loader:Loader;
		protected var texture:Texture;
	
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ServiceLoadImage()
		{
			super();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function load(url:String):void
		{
			if(this.loader){
				this.loader.unloadAndStop(true);
			}else{
				this.loader = new Loader();
				this.loader.contentLoaderInfo.addEventListener(Event.COMPLETE, handlerLoadedComplete);
				this.loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, handlerLoaderError);
				this.loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, handlerLoaderError);
			}
			this.loader.load(new URLRequest(url), LOADER_CONTEXT);
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
		
		protected function bitmapToTexture(pBitmap:Bitmap):void{
			var pSizeImage:Number;
			
			if(pBitmap.bitmapData.width<pBitmap.bitmapData.height){
				pSizeImage = pBitmap.bitmapData.width;
			}else{
				pSizeImage = pBitmap.bitmapData.height;
			}
			
			if(pSizeImage>Constants.MAX_TEXTURE_SIZE){
				pSizeImage=Constants.MAX_TEXTURE_SIZE
			}
			
			var pRectangleForGetPixels:Rectangle=new Rectangle((pBitmap.bitmapData.width-pSizeImage)/2,(pBitmap.bitmapData.height-pSizeImage)/2,pSizeImage,pSizeImage);
			var pBytesArrayLoaded:ByteArray = pBitmap.bitmapData.getPixels(pRectangleForGetPixels); 
			pBytesArrayLoaded.position = 0; 
			
			var pNewBitmapData:BitmapData=new BitmapData(pSizeImage,pSizeImage);
			var pRectangleForSetPixels:Rectangle=new Rectangle(0,0,pSizeImage,pSizeImage);
			pNewBitmapData.setPixels(pRectangleForSetPixels, pBytesArrayLoaded);
			
			texture=Texture.fromBitmapData(pNewBitmapData);
		}
		
	
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
		
		protected function handlerLoadedComplete(event:Event):void{
			bitmapToTexture(Bitmap(loader.content));
		}
		
		protected function handlerLoaderError(event:EventError):void{
			trace(event.type);
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