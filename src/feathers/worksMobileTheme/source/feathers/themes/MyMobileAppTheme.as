package feathers.worksMobileTheme.source.feathers.themes{
	
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class MyMobileAppTheme extends MetalWorksMobileTheme{
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
		[Embed(source="/../feathers/worksMobileTheme/assets/fonts/cooperblackstd.ttf",fontFamily="CooperBlackStd",fontWeight="normal",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_COOPER_BLACK:Class;
		
		protected static const FONT_COOPER:String="CooperBlackStd"
			
		private var _container:DisplayObjectContainer;
		
		protected var headerCooperElementFormat:ElementFormat;
		
		protected var buttonMenuSkinTextures:Texture;
		protected var buttonMenuDownSkinTextures:Texture;
		protected var buttonCreateSkinTextures:Texture;
		protected var buttonCreateDownSkinTextures:Texture;
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function MyMobileAppTheme(container:DisplayObjectContainer=null, scaleToDPI:Boolean=true)
		{
			super(container, scaleToDPI);
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
		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		// PRIVATE & PROTECTED METHODS 
		//
		//---------------------------------------------------------------------------------------------------------
		override protected function initializeRoot():void{
			super.initializeRoot();
			var backGroundImage:Image=new Image(atlas.getTexture("Background"));
			backGroundImage.width=this.root.stage.stageWidth;
			backGroundImage.height=this.root.stage.stageHeight;
			this.root.stage.addChildAt(backGroundImage,0);
		}
		
		override protected function initializeFonts():void{
			super.initializeFonts();
			
			this.cooperFontDescription=new FontDescription(FONT_COOPER);
			this.headerCooperElementFormat = new ElementFormat(this.cooperFontDescription, Math.round(24 * this.scale), LIGHT_TEXT_COLOR);
			
			this.largeCooperElementFormat = new ElementFormat(this.cooperFontDescription, 25 * this.scale, LIGHT_TEXT_COLOR);
			this.largestCooperElementFormat = new ElementFormat(this.cooperFontDescription,60 * this.scale, DARK_TEXT_COLOR);
			this.promptElementFormat = new ElementFormat(regularFontDescription, 30 * this.scale,DARK_TEXT_COLOR);
		}
		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  EVENT HANDLERS  
		// 
		//---------------------------------------------------------------------------------------------------------
		
		
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