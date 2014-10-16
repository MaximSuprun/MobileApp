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
			addViewListener(EventViewExplore.SHARE_TO_FACEBOOK,_handlerPublish)
			addViewListener(EventViewExplore.SHARE_TO_TWITTER,_handlerPublish)
			addViewListener(EventViewExplore.SHARE_TO_TUMBLR,_handlerPublish)
			addViewListener(EventViewExplore.SHARE_TO_PINTEREST,_handlerPublish)
			addViewListener(EventViewExplore.SHARE_TO_MAILRU,_handlerPublish)
			addViewListener(EventViewExplore.SHARE_TO_VK,_handlerPublish)
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
		private function _handlerPublish(event:EventViewExplore):void{
			var pImageInfo:VOImageInfo=VOImageInfo(event.payload);
			switch(event.type){
				case EventViewExplore.SHARE_TO_FACEBOOK:
					dispatch(new EventViewExplore(EventViewExplore.SHARE_TO_FACEBOOK,pImageInfo));
					break;
				case EventViewExplore.SHARE_TO_TWITTER:
					dispatch(new EventViewExplore(EventViewExplore.SHARE_TO_TWITTER,pImageInfo));
					break;
				case EventViewExplore.SHARE_TO_PINTEREST:
					dispatch(new EventViewExplore(EventViewExplore.SHARE_TO_PINTEREST,pImageInfo));
					break;
				case EventViewExplore.SHARE_TO_MAILRU:
					dispatch(new EventViewExplore(EventViewExplore.SHARE_TO_MAILRU,pImageInfo));
					break;
				case EventViewExplore.SHARE_TO_TUMBLR:
					dispatch(new EventViewExplore(EventViewExplore.SHARE_TO_TUMBLR,pImageInfo));
					break;
				case EventViewExplore.SHARE_TO_VK:
					dispatch(new EventViewExplore(EventViewExplore.SHARE_TO_VK,pImageInfo));
					break;
			}
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