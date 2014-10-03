package com.socialApplication.service.loadImage.photoAndDevice{
	import com.socialApplication.service.loadImage.EventServiceLoadImage;
	import com.socialApplication.service.loadImage.ServiceLoadImage;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MediaEvent;
	import flash.media.CameraRoll;
	import flash.media.CameraUI;
	import flash.media.MediaPromise;
	import flash.media.MediaType;
	
	public class ServiceLoadFromDeviceAndCamera extends ServiceLoadImage  implements IServiceLoadFromDeviceAndCamera{
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
		private var _camera:CameraUI;
		private var _mediaSource:CameraRoll;
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function ServiceLoadFromDeviceAndCamera()
		{
			super();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function takePhoto():void{
			if (CameraUI.isSupported){
				_camera = new CameraUI();
				_camera.addEventListener(MediaEvent.COMPLETE, _handlerCameraComplete);
				_camera.launch(MediaType.IMAGE);
			} else {
				trace("CameraUI not supported");
			}
		}
		
		public function addFromDevice():void{
			if( CameraRoll.supportsBrowseForImage )
			{
				trace( "Browsing for image..." );
				_mediaSource = new CameraRoll();
				_mediaSource.addEventListener( MediaEvent.SELECT, imageSelected );
				_mediaSource.addEventListener( flash.events.Event.CANCEL, browseCanceled );
				_mediaSource.browseForImage();
			}
			else
			{
				trace( "Browsing in camera roll is not supported.");
			}
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
		override protected function bitmapToTexture(pBitmap:Bitmap):void{
			super.bitmapToTexture(pBitmap);
			dispatch(new EventServiceLoadImage(EventServiceLoadImage.CAMERA_OR_DEVICE_IMAGE_LOADED,texture));
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function imageSelected( event:MediaEvent ):void
		{
			trace( "Image selected..." );
			
			var imagePromise:MediaPromise = event.data;
			
			loader = new Loader();
			if( imagePromise.isAsync ){
				loader.contentLoaderInfo.addEventListener( Event.COMPLETE, handlerLoadedComplete )
				loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, handlerLoaderError )
				loader.loadFilePromise( imagePromise );				
			}else{
				trace( "Synchronous media promise." );
				loader.loadFilePromise( imagePromise );
				bitmapToTexture(Bitmap(loader.content));
			}
			
		}
		private function browseCanceled( event:Event ):void{
			trace( "Image browse canceled." );
		}
		
		
		private function _handlerCameraComplete(event:MediaEvent):void{
			var pContent:MediaPromise = event.data;
			load(pContent.file.url)
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