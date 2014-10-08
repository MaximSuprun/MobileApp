package com.socialApplication.view.explore{
	
	import com.socialApplication.model.vo.VOImageInfo;
	import com.socialApplication.service.replaceAutorizationData.EventServiceReplaceData;
	import com.socialApplication.view.createScreen.EventViewCreateScreen;
	import com.socialApplication.view.main.EventViewMain;
	
	import org.robotlegs.starling.mvcs.Mediator;
	

	
	public class MediatorViewExplore extends Mediator{
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
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function MediatorViewExplore(){
			super();
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		override public function onRegister():void {
			super.onRegister();
			addViewListener(EventViewExplore.BACK_BUTTON_CLICK,_handlerBackButtonClick);
			addContextListener(EventViewMain.GET_IMAGE_INFO,_handlerGetImageInfo);
		}

		override public function onRemove():void {
			super.onRemove();		
		}	
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		private function get _view():ViewExplore {
			return ViewExplore(viewComponent); 
		}
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		private function _handlerBackButtonClick(event:EventViewExplore):void{
			dispatch(new EventViewExplore(EventViewExplore.BACK_BUTTON_CLICK));
		}
		private function _handlerGetImageInfo(event:EventViewMain):void{
			var pVOImageInfo:VOImageInfo=VOImageInfo(event.payload);
			_view.imageInfo=pVOImageInfo;
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