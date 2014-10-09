/*
 Copyright (c) 2012 Josh Tynjala

 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:

 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 */
package feathers.worksMobileTheme.source.feathers.themes
{
	import com.socialApplication.common.Constants;
	import com.socialApplication.view.common.BusyIndicator;
	import com.socialApplication.view.createScreen.ViewCreateScreen;
	import com.socialApplication.view.createScreen.common.CreatePopUp;
	import com.socialApplication.view.createScreen.common.footer.ItemRendererFooterCreate;
	import com.socialApplication.view.createScreen.common.footer.MyFooter;
	import com.socialApplication.view.explore.ViewExplore;
	import com.socialApplication.view.explore.common.PopUpShare;
	import com.socialApplication.view.introductionPanel.ViewIntroduction;
	import com.socialApplication.view.login.ViewLogin;
	import com.socialApplication.view.menu.ViewMenu;
	import com.socialApplication.view.menu.common.ItemRendererMenuList;
	import com.socialApplication.view.profile.ViewProfile;
	import com.socialApplication.view.profile.common.ItemRendererProfileList;
	import com.socialApplication.view.settings.ViewSettings;
	import com.socialApplication.view.settings.common.ItemRendererSettingsList;
	import com.socialApplication.view.settings.common.PopUpChangeUserData;
	
	import feathers.controls.Alert;
	import feathers.controls.Button;
	import feathers.controls.ButtonGroup;
	import feathers.controls.Callout;
	import feathers.controls.Check;
	import feathers.controls.GroupedList;
	import feathers.controls.Header;
	import feathers.controls.ImageLoader;
	import feathers.controls.Label;
	import feathers.controls.List;
	import feathers.controls.NumericStepper;
	import feathers.controls.PageIndicator;
	import feathers.controls.Panel;
	import feathers.controls.PanelScreen;
	import feathers.controls.PickerList;
	import feathers.controls.ProgressBar;
	import feathers.controls.Radio;
	import feathers.controls.Screen;
	import feathers.controls.ScrollContainer;
	import feathers.controls.ScrollScreen;
	import feathers.controls.ScrollText;
	import feathers.controls.SimpleScrollBar;
	import feathers.controls.Slider;
	import feathers.controls.TabBar;
	import feathers.controls.TextInput;
	import feathers.controls.ToggleSwitch;
	import feathers.controls.popups.CalloutPopUpContentManager;
	import feathers.controls.popups.VerticalCenteredPopUpContentManager;
	import feathers.controls.renderers.BaseDefaultItemRenderer;
	import feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
	import feathers.controls.renderers.DefaultGroupedListItemRenderer;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.text.StageTextTextEditor;
	import feathers.controls.text.TextBlockTextRenderer;
	import feathers.controls.text.TextFieldTextEditor;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.DisplayListWatcher;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import feathers.core.PopUpManager;
	import feathers.data.ListCollection;
	import feathers.display.Scale3Image;
	import feathers.display.Scale9Image;
	import feathers.display.TiledImage;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.VerticalLayout;
	import feathers.skins.SmartDisplayObjectStateValueSelector;
	import feathers.skins.StandardIcons;
	import feathers.system.DeviceCapabilities;
	import feathers.textures.Scale3Textures;
	import feathers.textures.Scale9Textures;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.errors.IllegalOperationError;
	import flash.geom.Rectangle;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.FontPosture;
	import flash.text.engine.FontWeight;
	import flash.text.engine.RenderingMode;
	import flash.utils.getQualifiedClassName;
	
	import flashx.textLayout.formats.TextAlign;
	
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.DisplayObjectContainer;
	import starling.display.Image;
	import starling.display.Quad;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;

	[Event(name="complete",type="starling.events.Event")]

	/**
	 * The "Metal Works" theme for mobile Feathers apps.
	 *
	 * <p>This version of the theme requires loading assets at runtime. To use
	 * embedded assets, see <code>MetalWorksMobileTheme</code> instead.</p>
	 *
	 * <p>To use this theme, the following files must be included when packaging
	 * your app:</p>
	 * <ul>
	 *     <li>images/metalworks.png</li>
	 *     <li>images/metalworks.xml</li>
	 * </ul>
	 *
	 * @see http://wiki.starling-framework.org/feathers/theme-assets
	 */
	public class MetalWorksMobileThemeWithAssetManager extends DisplayListWatcher
	{
		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/SourceSansPro-Regular.ttf",fontFamily="SourceSansPro",fontWeight="normal",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_SANS_PRO_REGULAR:Class;

		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/SourceSansPro-Semibold.ttf",fontFamily="SourceSanFsPro",fontWeight="bold",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_SANS_PRO_SEMIBOLD:Class;

		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/SourceSansPro-Semibold.ttf",fontFamily="SourceSansPro",fontWeight="bold",unicodeRange="U+0030-U+0039",mimeType="application/x-font",embedAsCFF="false")]
		protected static const SOURCE_SANS_PRO_SEMIBOLD_NUMBERS:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/cooperblackstd.ttf",fontFamily="CooperBlackStd",fontWeight="normal",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_COOPER_BLACK:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/TrajanPro-Regular.ttf",fontFamily="TrajanPro",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_TRAJAN_PRO:Class;
				
		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/AmericanTypewriter.ttf",fontFamily="AmericanTypewriter",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_AMERICAN_TYPE_WRITER:Class;
				
		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/Comic Sans MS.ttf",fontFamily="ComicSansMS",fontWeight="normal",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_COMIC_SANS_MS:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/helvetica.ttf",fontFamily="Helvetica",mimeType="application/x-font")]
		protected static const SOURCE_HELVETICA:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/Calibri.ttf",fontFamily="Calibri",fontWeight="normal",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_CALIBRI:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/Calibri Bold.ttf",fontFamily="Calibri",fontWeight="bold",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_CALIBRI_BOLD:Class;

		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/Calibri Italic.ttf",fontFamily="Calibri",fontStyle="italic",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_CALIBRI_ITALIC:Class;

		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/FranklinGothicSSiBook.ttf",fontFamily="FranklinGothic",fontWeight="bold",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_FRANKLIN_GOTHIC:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/CenturyGothic.ttf",fontFamily="CenturyGothic",fontWeight="bold",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_CENTURY_GOTHIC:Class;
		//
		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/Avenir 95 Black.ttf",fontFamily="Avenir",fontWeight="normal",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_AVENIR:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/Georgia.ttf",fontFamily="Georgia",fontWeight="normal",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_GEORGIA:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/fonts/noteworthy-webfont.ttf",fontFamily="Noteworthy",fontWeight="bold",mimeType="application/x-font",embedAsCFF="true")]
		protected static const SOURCE_NOTEWORTHLY:Class;
		
		

		
		[Embed(source="/./feathers/worksMobileTheme/assets/images/theme_real_big.png")]
		protected static const THEME_REAL:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/images/theme_fancy_sparkling_roses_big.png")]
		protected static const THEME_FANCY_SPARKLING_ROSES:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/images/theme_gradient_big.png")]
		protected static const THEME_GRADIENT:Class;	

		[Embed(source="/./feathers/worksMobileTheme/assets/images/theme_gryngy_ice_fire_big.png")]
		protected static const THEME_GRYNGY_ICE_FIRE:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/images/theme_gryngy_blood_ice_big.png")]
		protected static const THEME_GRYNGY_BLOOD_ICE:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/images/theme_organic_big.png")]
		protected static const THEME_ORGANIC:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/images/theme_plain_digital_screen_big.png")]
		protected static const THEME_PLAIN_DIGITAL_SCREEN:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/images/theme_plain_sea_weed_big.png")]
		protected static const THEME_PLAIN_SEA_WEED:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/images/theme_plain_whipped_iceCream_big.png")]
		protected static const THEME_PLAIN_WHIPPED_ICECREAM:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/images/theme-fancy_chocolate_big.png")]
		protected static const THEME_FANCY_CHOCOLATE:Class;
		
		[Embed(source="/./feathers/worksMobileTheme/assets/images/theme-fancy_loranga_lights_big.png")]
		protected static const THEME_FANCY_LORANGA_LIGHTS:Class;
	

	

		protected static const FONT_NAME:String = "SourceSansPro";
		protected static const FONT_COOPER:String="CooperBlackStd"
			

		protected static const PRIMARY_BACKGROUND_COLOR:uint = 0x336699;
		protected static const LIGHT_TEXT_COLOR:uint = 0xe5e5e5;
		protected static const DARK_TEXT_COLOR:uint = 0x1a1816;
		protected static const SELECTED_TEXT_COLOR:uint = 0xff9900;
		protected static const DISABLED_TEXT_COLOR:uint = 0x8a8a8a;
		protected static const DARK_DISABLED_TEXT_COLOR:uint = 0x383430;
		protected static const LIST_BACKGROUND_COLOR:uint = 0x383430;
		protected static const TAB_BACKGROUND_COLOR:uint = 0x1a1816;
		protected static const TAB_DISABLED_BACKGROUND_COLOR:uint = 0x292624;
		protected static const GROUPED_LIST_HEADER_BACKGROUND_COLOR:uint = 0x2e2a26;
		protected static const GROUPED_LIST_FOOTER_BACKGROUND_COLOR:uint = 0x2e2a26;
		protected static const MODAL_OVERLAY_COLOR:uint = 0x29241e;
		protected static const MODAL_OVERLAY_ALPHA:Number = 0.8;

		protected static const ORIGINAL_DPI_IPHONE_RETINA:int = 326;
		protected static const ORIGINAL_DPI_IPAD_RETINA:int = 264;

		protected static const DEFAULT_SCALE9_GRID:Rectangle = new Rectangle(5, 5, 22, 22);
		protected static const BUTTON_SCALE9_GRID:Rectangle = new Rectangle(5, 5, 50, 50);
		protected static const BUTTON_SELECTED_SCALE9_GRID:Rectangle = new Rectangle(8, 8, 44, 44);
		protected static const BACK_BUTTON_SCALE3_REGION1:Number = 24;
		protected static const BACK_BUTTON_SCALE3_REGION2:Number = 6;
		protected static const FORWARD_BUTTON_SCALE3_REGION1:Number = 6;
		protected static const FORWARD_BUTTON_SCALE3_REGION2:Number = 6;
		protected static const ITEM_RENDERER_SCALE9_GRID:Rectangle = new Rectangle(13, 0, 2, 82);
		protected static const INSET_ITEM_RENDERER_FIRST_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 70);
		protected static const INSET_ITEM_RENDERER_LAST_SCALE9_GRID:Rectangle = new Rectangle(13, 0, 3, 75);
		protected static const INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID:Rectangle = new Rectangle(13, 13, 3, 62);
		protected static const TAB_SCALE9_GRID:Rectangle = new Rectangle(19, 19, 50, 50);
		protected static const SCROLL_BAR_THUMB_REGION1:int = 5;
		protected static const SCROLL_BAR_THUMB_REGION2:int = 14;

		protected static const ATLAS_NAME:String = "metalworks";

		protected static const THEME_NAME_PICKER_LIST_ITEM_RENDERER:String = "metal-works-mobile-picker-list-item-renderer";
		protected static const THEME_NAME_ALERT_BUTTON_GROUP_BUTTON:String = "metal-works_mobile-alert-button-group-button";

		protected static const THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB:String = "metal-works-mobile-horizontal-simple-scroll-bar-thumb";
		protected static const THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB:String = "metal-works-mobile-vertical-simple-scroll-bar-thumb";

		protected static const THEME_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK:String = "metal-works-mobile-horizontal-slider-minimum-track";
		protected static const THEME_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK:String = "metal-works-mobile-horizontal-slider-maximum-track";

		protected static const THEME_NAME_VERTICAL_SLIDER_MINIMUM_TRACK:String = "metal-works-mobile-vertical-slider-minimum-track";
		protected static const THEME_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK:String = "metal-works-mobile-vertical-slider-maximum-track";
		
		
		protected static function textRendererFactory():TextBlockTextRenderer
		{
			return new TextBlockTextRenderer();
		}

		protected static function textEditorFactory():StageTextTextEditor
		{
			return new StageTextTextEditor();
		}

		protected static function stepperTextEditorFactory():TextFieldTextEditor
		{
			return new TextFieldTextEditor();
		}

		protected static function popUpOverlayFactory():DisplayObject
		{
			const quad:Quad = new Quad(100, 100, MODAL_OVERLAY_COLOR);
			quad.alpha = MODAL_OVERLAY_ALPHA;
			return quad;
		}

		public function MetalWorksMobileThemeWithAssetManager(assets:Object = null, assetManager:AssetManager = null, container:DisplayObjectContainer = null, scaleToDPI:Boolean = true)
		{
			if(!container)
			{
				container = Starling.current.stage;				
			}
			super(container);
			this._scaleToDPI = scaleToDPI;
			this.processSource(assets, assetManager);
		}

		protected var _originalDPI:int;

		public function get originalDPI():int
		{
			return this._originalDPI;
		}

		protected var _scaleToDPI:Boolean;

		public function get scaleToDPI():Boolean
		{
			return this._scaleToDPI;
		}

		/**
		 * A subclass may embed the theme's assets and override this setter to
		 * return the class that creates the bitmap used for the texture atlas.
		 */
		protected function get atlasImageClass():Class
		{
			return null;
		}

		/**
		 * A subclass may embed the theme's assets and override this setter to
		 * return the class that creates the XML used for the texture atlas.
		 */
		protected function get atlasXMLClass():Class
		{
			return null;
		}

		protected var assetManager:AssetManager;

		protected var scale:Number = 1;

		protected var regularFontDescription:FontDescription;
		protected var boldFontDescription:FontDescription;
		
		protected var cooperFontDescription:FontDescription;
		protected var largeCooperElementFormat:ElementFormat;
		protected var largestCooperElementFormat:ElementFormat;
		protected var promptElementFormat:ElementFormat;

		protected var scrollTextTextFormat:TextFormat;
		protected var lightUICenteredTextFormat:TextFormat;

		protected var headerElementFormat:ElementFormat;
		protected var headerCooperElementFormat:ElementFormat;

		protected var darkUIElementFormat:ElementFormat;
		protected var lightUIElementFormat:ElementFormat;
		protected var selectedUIElementFormat:ElementFormat;
		protected var lightUIDisabledElementFormat:ElementFormat;
		protected var darkUIDisabledElementFormat:ElementFormat;

		protected var largeUIDarkElementFormat:ElementFormat;
		protected var largeUILightElementFormat:ElementFormat;
		protected var largeUISelectedElementFormat:ElementFormat;
		protected var largeUIDarkDisabledElementFormat:ElementFormat;
		protected var largeUILightDisabledElementFormat:ElementFormat;

		protected var largeDarkElementFormat:ElementFormat;
		protected var largeLightElementFormat:ElementFormat;
		protected var largeDisabledElementFormat:ElementFormat;

		protected var darkElementFormat:ElementFormat;
		protected var lightElementFormat:ElementFormat;
		protected var disabledElementFormat:ElementFormat;

		protected var smallLightElementFormat:ElementFormat;
		protected var smallDisabledElementFormat:ElementFormat;

		protected var atlas:TextureAtlas;
		protected var atlasTexture:Texture;
		protected var headerBackgroundSkinTexture:Texture;
		protected var backgroundSkinTextures:Scale9Textures;
		protected var backgroundLightSkinTextures:Scale9Textures;
		protected var backgroundInsetSkinTextures:Scale9Textures;
		protected var backgroundDisabledSkinTextures:Scale9Textures;
		protected var backgroundFocusedSkinTextures:Scale9Textures;
		protected var backgroundLightFocusedSkinTextures:Scale9Textures;
		protected var buttonUpSkinTextures:Scale9Textures;
		protected var buttonDownSkinTextures:Scale9Textures;	
		protected var buttonMenuSkinTextures:Texture;
		protected var buttonMenuDownSkinTextures:Texture;
		protected var buttonCategoriesSkinTextures:Texture;
		protected var buttonCategoriesDownSkinTextures:Texture;
		protected var buttonCreateSkinTextures:Texture;
		protected var buttonCreateDownSkinTextures:Texture;
		protected var buttonDisabledSkinTextures:Scale9Textures;
		protected var buttonSelectedUpSkinTextures:Scale9Textures;
		protected var buttonSelectedDisabledSkinTextures:Scale9Textures;
		protected var buttonCallToActionUpSkinTextures:Scale9Textures;
		protected var buttonCallToActionDownSkinTextures:Scale9Textures;
		protected var buttonDangerUpSkinTextures:Scale9Textures;
		protected var buttonDangerDownSkinTextures:Scale9Textures;
		protected var buttonGetStartUpSkinTextures:Scale9Textures;
		protected var buttonGetStartDownSkinTextures:Scale9Textures;
		protected var buttonGetStartDisabledSkinTextures:Scale9Textures;
		protected var buttonRegistrationDownSkinTextures:Texture;
		protected var buttonRegistrationUpSkinTextures:Texture;
		protected var buttonBackUpSkinTextures:Scale3Textures;
		protected var buttonBackDownSkinTextures:Scale3Textures;
		protected var buttonBackDisabledSkinTextures:Scale3Textures;
		protected var buttonForwardUpSkinTextures:Scale3Textures;
		protected var buttonForwardDownSkinTextures:Scale3Textures;
		protected var buttonForwardDisabledSkinTextures:Scale3Textures;
		protected var pickerListButtonIconTexture:Texture;
		protected var tabDownSkinTextures:Scale9Textures;
		protected var tabSelectedSkinTextures:Scale9Textures;
		protected var tabSelectedDisabledSkinTextures:Scale9Textures;
		protected var pickerListItemSelectedIconTexture:Texture;
		protected var radioUpIconTexture:Texture;
		protected var radioDownIconTexture:Texture;
		protected var radioDisabledIconTexture:Texture;
		protected var radioSelectedUpIconTexture:Texture;
		protected var radioSelectedDownIconTexture:Texture;
		protected var radioSelectedDisabledIconTexture:Texture;
		protected var checkUpIconTexture:Texture;
		protected var checkDownIconTexture:Texture;
		protected var checkDisabledIconTexture:Texture;
		protected var checkSelectedUpIconTexture:Texture;
		protected var checkSelectedDownIconTexture:Texture;
		protected var checkSelectedDisabledIconTexture:Texture;
		protected var pageIndicatorNormalSkinTexture:Texture;
		protected var pageIndicatorSelectedSkinTexture:Texture;
		protected var itemRendererUpSkinTextures:Scale9Textures;
		protected var itemRendererSelectedSkinTextures:Scale9Textures;
		protected var insetItemRendererFirstUpSkinTextures:Scale9Textures;
		protected var insetItemRendererFirstSelectedSkinTextures:Scale9Textures;
		protected var insetItemRendererLastUpSkinTextures:Scale9Textures;
		protected var insetItemRendererLastSelectedSkinTextures:Scale9Textures;
		protected var insetItemRendererSingleUpSkinTextures:Scale9Textures;
		protected var insetItemRendererSingleSelectedSkinTextures:Scale9Textures;
		protected var backgroundPopUpSkinTextures:Scale9Textures;
		protected var calloutTopArrowSkinTexture:Texture;
		protected var calloutRightArrowSkinTexture:Texture;
		protected var calloutBottomArrowSkinTexture:Texture;
		protected var calloutLeftArrowSkinTexture:Texture;
		protected var verticalScrollBarThumbSkinTextures:Scale3Textures;
		protected var horizontalScrollBarThumbSkinTextures:Scale3Textures;
		protected var searchIconTexture:Texture;
		
		protected var buttonBackSkin:Texture;
		protected var buttonShareSkin:Texture;
		protected var buttonToggleGrigUpSkin:Texture;
		protected var buttonToggleGrigDownSkin:Texture;
		protected var buttonTogglelistUpSkin:Texture;
		protected var buttonToggleListDownSkin:Texture;
		
		public var difference:Number=0;
		
		override public function dispose():void
		{
			if(this.root)
			{
				this.root.removeEventListener(Event.ADDED_TO_STAGE, root_addedToStageHandler);
			}
			if(this.atlas)
			{
				this.atlas.dispose();
				this.atlas = null;
				//no need to dispose the atlas texture because the atlas will do that
				this.atlasTexture = null;
			}
			if(this.assetManager)
			{
				this.assetManager.removeTextureAtlas(ATLAS_NAME);
			}
			super.dispose();
		}

		protected function initializeRoot():void
		{
			if(this.root != this.root.stage)
			{
				return;
			}

			this.root.stage.color = PRIMARY_BACKGROUND_COLOR;
			Starling.current.nativeStage.color = PRIMARY_BACKGROUND_COLOR;
					
		}

		protected function atlasTexture_onRestore():void
		{
			var AtlasImageClass:Class = this.atlasImageClass;
			var atlasBitmapData:BitmapData = Bitmap(new AtlasImageClass()).bitmapData;
			this.atlasTexture.root.uploadBitmapData(atlasBitmapData);
			atlasBitmapData.dispose();
		}

		protected function assetManager_onProgress(progress:Number):void
		{
			if(progress < 1)
			{
				return;
			}
			this.initialize();
			this.dispatchEventWith(Event.COMPLETE);
		}

		protected function processSource(assets:Object, assetManager:AssetManager):void
		{
			if(assets)
			{
				this.assetManager = assetManager;
				if(!this.assetManager)
				{
					this.assetManager = new AssetManager(Starling.contentScaleFactor);
				}
				//add a trailing slash, if needed
				if(assets is String)
				{
					var assetsDirectoryName:String = assets as String;
					if(assetsDirectoryName.lastIndexOf("/") != assetsDirectoryName.length - 1)
					{
						assets = assetsDirectoryName + "/";
					}
					this.assetManager.enqueue(assets + "images/metalworks.xml");
					this.assetManager.enqueue(assets + "images/metalworks.png");
				}
				else if(getQualifiedClassName(assets) == "flash.filesystem::File" && assets["isDirectory"])
				{
					this.assetManager.enqueue(assets["resolvePath"]("images/metalworks.xml"));
					this.assetManager.enqueue(assets["resolvePath"]("images/metalworks.png"));
				}
				else
				{
					this.assetManager.enqueue(assets);
				}
				this.assetManager.loadQueue(assetManager_onProgress);
			}
			else
			{
				var AtlasImageClass:Class = this.atlasImageClass;
				var AtlasXMLType:Class = this.atlasXMLClass;
				if(AtlasImageClass && AtlasXMLType)
				{
					var atlasBitmapData:BitmapData = Bitmap(new AtlasImageClass()).bitmapData;
					this.atlasTexture = Texture.fromBitmapData(atlasBitmapData, false);
					this.atlasTexture.root.onRestore = this.atlasTexture_onRestore;
					atlasBitmapData.dispose();
					this.atlas = new TextureAtlas(atlasTexture, XML(new AtlasXMLType()));
					this.initialize();
					this.dispatchEventWith(Event.COMPLETE);
				}
				else
				{
					throw new Error("Asset path or embedded assets not found. Theme not loaded.")
				}
			}
		}

		protected function initialize():void
		{
			if(!this.atlas)
			{
				if(this.assetManager)
				{
					this.atlas = this.assetManager.getTextureAtlas(ATLAS_NAME);					
				}
				else
				{
					throw new IllegalOperationError("Atlas not loaded.");
				}
			}
			
			
			this.initializeScale();
			this.initializeFonts();
			this.initializeTextures();
			this.initializeGlobals();

			if(this.root.stage)
			{
				this.initializeRoot();
			}
			else
			{
				this.root.addEventListener(Event.ADDED_TO_STAGE, root_addedToStageHandler);
			}

			this.setInitializers();
		}

		protected function initializeGlobals():void
		{
			FeathersControl.defaultTextRendererFactory = textRendererFactory;
			FeathersControl.defaultTextEditorFactory = textEditorFactory;

			PopUpManager.overlayFactory = popUpOverlayFactory;
			Callout.stagePaddingTop = Callout.stagePaddingRight = Callout.stagePaddingBottom =
				Callout.stagePaddingLeft = 16 * this.scale;
		}

		protected function initializeScale():void
		{
			/*var scaledDPI:int = DeviceCapabilities.dpi/Starling.contentScaleFactor;
			
			this._originalDPI = scaledDPI;
			if(this._scaleToDPI)
			{
				if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
				{
					this._originalDPI = ORIGINAL_DPI_IPAD_RETINA;
				}
				else
				{
					this._originalDPI = ORIGINAL_DPI_IPHONE_RETINA;
				}
			}
			
			this.scale = scaledDPI/_originalDPI;*/
			
			var pScaleX:Number = Starling.current.nativeStage.stageWidth/Constants.WIDTH;
			var pScaleY:Number = Starling.current.nativeStage.stageHeight/Constants.HEIGHT;

			if (pScaleX < pScaleY){
				this.scale=pScaleY;
				difference = Constants.WIDTH*scale-Starling.current.nativeStage.stageWidth;	
			}else{
				this.scale = pScaleX;
			}
			
			
		}

		protected function initializeFonts():void
		{
			//these are for components that don't use FTE
			this.scrollTextTextFormat = new TextFormat("_sans", 24 * this.scale, LIGHT_TEXT_COLOR);
			this.lightUICenteredTextFormat = new TextFormat(FONT_NAME, 24 * this.scale, LIGHT_TEXT_COLOR, true, null, null, null, null, TextFormatAlign.CENTER);

			this.regularFontDescription = new FontDescription(FONT_NAME, FontWeight.NORMAL, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
			this.boldFontDescription = new FontDescription(FONT_NAME, FontWeight.BOLD, FontPosture.NORMAL, FontLookup.EMBEDDED_CFF, RenderingMode.CFF, CFFHinting.NONE);
			this.cooperFontDescription=new FontDescription(FONT_COOPER);

			this.headerElementFormat = new ElementFormat(this.boldFontDescription, Math.round(36 * this.scale), LIGHT_TEXT_COLOR);
			this.headerCooperElementFormat = new ElementFormat(this.cooperFontDescription, Math.round(24 * this.scale), LIGHT_TEXT_COLOR);

			this.darkUIElementFormat = new ElementFormat(this.boldFontDescription, 24 * this.scale, DARK_TEXT_COLOR);
			this.lightUIElementFormat = new ElementFormat(this.boldFontDescription, 24 * this.scale, LIGHT_TEXT_COLOR);
			this.selectedUIElementFormat = new ElementFormat(this.boldFontDescription, 24 * this.scale, SELECTED_TEXT_COLOR);
			this.lightUIDisabledElementFormat = new ElementFormat(this.boldFontDescription, 24 * this.scale, DISABLED_TEXT_COLOR);
			this.darkUIDisabledElementFormat = new ElementFormat(this.boldFontDescription, 24 * this.scale, DARK_DISABLED_TEXT_COLOR);

			this.largeUIDarkElementFormat = new ElementFormat(this.boldFontDescription, 28 * this.scale, DARK_TEXT_COLOR);
			this.largeUILightElementFormat = new ElementFormat(this.boldFontDescription, 28 * this.scale, LIGHT_TEXT_COLOR);
			this.largeUISelectedElementFormat = new ElementFormat(this.boldFontDescription, 28 * this.scale, SELECTED_TEXT_COLOR);
			this.largeUIDarkDisabledElementFormat = new ElementFormat(this.boldFontDescription, 28 * this.scale, DARK_DISABLED_TEXT_COLOR);
			this.largeUILightDisabledElementFormat = new ElementFormat(this.boldFontDescription, 28 * this.scale, DISABLED_TEXT_COLOR);

			this.darkElementFormat = new ElementFormat(this.regularFontDescription, 24 * this.scale, DARK_TEXT_COLOR);
			this.lightElementFormat = new ElementFormat(this.regularFontDescription, 24 * this.scale, LIGHT_TEXT_COLOR);
			this.disabledElementFormat = new ElementFormat(this.regularFontDescription, 24 * this.scale, DISABLED_TEXT_COLOR);

			this.smallLightElementFormat = new ElementFormat(this.regularFontDescription, 18 * this.scale, LIGHT_TEXT_COLOR);
			this.smallDisabledElementFormat = new ElementFormat(this.regularFontDescription, 18 * this.scale, DISABLED_TEXT_COLOR);

			this.largeDarkElementFormat = new ElementFormat(this.regularFontDescription, 28 * this.scale, DARK_TEXT_COLOR);
			this.largeLightElementFormat = new ElementFormat(this.regularFontDescription, 28 * this.scale, LIGHT_TEXT_COLOR);
			this.largeDisabledElementFormat = new ElementFormat(this.regularFontDescription, 28 * this.scale, DISABLED_TEXT_COLOR);
			
			this.largeCooperElementFormat = new ElementFormat(this.cooperFontDescription, 25 * this.scale, LIGHT_TEXT_COLOR);
			this.largestCooperElementFormat = new ElementFormat(this.cooperFontDescription,60 * this.scale, DARK_TEXT_COLOR);
			this.promptElementFormat = new ElementFormat(regularFontDescription, 30 * this.scale,DARK_TEXT_COLOR);
		}

		protected function initializeTextures():void
		{
			const backgroundSkinTexture:Texture = this.atlas.getTexture("background-skin");
			const backgroundInsetSkinTexture:Texture = this.atlas.getTexture("background-inset-skin");
			const backgroundDownSkinTexture:Texture = this.atlas.getTexture("background-down-skin");
			const backgroundDisabledSkinTexture:Texture = this.atlas.getTexture("background-disabled-skin");
			const backgroundFocusedSkinTexture:Texture = this.atlas.getTexture("background-focused-skin");
			const backgroundPopUpSkinTexture:Texture = this.atlas.getTexture("background-popup-skin");
		

			this.backgroundSkinTextures = new Scale9Textures(backgroundSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundInsetSkinTextures = new Scale9Textures(backgroundInsetSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundDisabledSkinTextures = new Scale9Textures(backgroundDisabledSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundFocusedSkinTextures = new Scale9Textures(backgroundFocusedSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundPopUpSkinTextures = new Scale9Textures(backgroundPopUpSkinTexture, DEFAULT_SCALE9_GRID);
			this.backgroundLightFocusedSkinTextures = new Scale9Textures(this.atlas.getTexture("light_background-skin"), DEFAULT_SCALE9_GRID);
			this.backgroundLightSkinTextures = new Scale9Textures(this.atlas.getTexture("light_background-focused-skin"), DEFAULT_SCALE9_GRID);

			this.buttonUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonDownSkinTextures = new Scale9Textures(this.atlas.getTexture("button-down-skin"), BUTTON_SCALE9_GRID);
			this.buttonDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("button-disabled-skin"), BUTTON_SCALE9_GRID);
			this.buttonSelectedUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-selected-up-skin"), BUTTON_SELECTED_SCALE9_GRID);
			this.buttonSelectedDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("button-selected-disabled-skin"), BUTTON_SELECTED_SCALE9_GRID);
			this.buttonCallToActionUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-call-to-action-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonCallToActionDownSkinTextures = new Scale9Textures(this.atlas.getTexture("button-call-to-action-down-skin"), BUTTON_SCALE9_GRID);
			this.buttonDangerUpSkinTextures = new Scale9Textures(this.atlas.getTexture("button-danger-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonDangerDownSkinTextures = new Scale9Textures(this.atlas.getTexture("button-danger-down-skin"), BUTTON_SCALE9_GRID);
			this.buttonBackUpSkinTextures = new Scale3Textures(this.atlas.getTexture("button-back-up-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
			this.buttonBackDownSkinTextures = new Scale3Textures(this.atlas.getTexture("button-back-down-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
			this.buttonBackDisabledSkinTextures = new Scale3Textures(this.atlas.getTexture("button-back-disabled-skin"), BACK_BUTTON_SCALE3_REGION1, BACK_BUTTON_SCALE3_REGION2);
			this.buttonForwardUpSkinTextures = new Scale3Textures(this.atlas.getTexture("button-forward-up-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);
			this.buttonForwardDownSkinTextures = new Scale3Textures(this.atlas.getTexture("button-forward-down-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);
			this.buttonForwardDisabledSkinTextures = new Scale3Textures(this.atlas.getTexture("button-forward-disabled-skin"), FORWARD_BUTTON_SCALE3_REGION1, FORWARD_BUTTON_SCALE3_REGION2);
			this.buttonGetStartUpSkinTextures = new Scale9Textures(this.atlas.getTexture("get-started-up-skin"), BUTTON_SCALE9_GRID);
			this.buttonGetStartDownSkinTextures = new Scale9Textures(this.atlas.getTexture("get-started-down-skin"), BUTTON_SCALE9_GRID);
			this.buttonGetStartDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("get-started-disabled-skin"), BUTTON_SCALE9_GRID);
			this.buttonRegistrationUpSkinTextures = atlas.getTexture("button-register-up-skin");
			this.buttonRegistrationDownSkinTextures = atlas.getTexture("button-register-down-skin");
			buttonMenuSkinTextures = atlas.getTexture("button-menu-up-skin");
			buttonMenuDownSkinTextures = atlas.getTexture("button-menu-down-skin");
			buttonCategoriesSkinTextures = atlas.getTexture("button-categories-up-skin");
			buttonCategoriesDownSkinTextures = atlas.getTexture("button-categories-down-skin");
			buttonCreateSkinTextures = atlas.getTexture("button-create-up-skin");
			buttonCreateDownSkinTextures = atlas.getTexture("button-create-down-skin");
			buttonBackSkin = atlas.getTexture("button-back-skin");
			buttonShareSkin = atlas.getTexture("button-share-skin");
			buttonToggleGrigUpSkin = atlas.getTexture("button-grid-up-skin");
			buttonToggleGrigDownSkin = atlas.getTexture("button-grid-down-skin");
			buttonTogglelistUpSkin = atlas.getTexture("button-list-up-skin");
			buttonToggleListDownSkin = atlas.getTexture("button-list-down-skin");
			

			this.tabDownSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-down-skin"), TAB_SCALE9_GRID);
			this.tabSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-selected-skin"), TAB_SCALE9_GRID);
			this.tabSelectedDisabledSkinTextures = new Scale9Textures(this.atlas.getTexture("tab-selected-disabled-skin"), TAB_SCALE9_GRID);

			this.pickerListButtonIconTexture = this.atlas.getTexture("picker-list-icon");
			this.pickerListItemSelectedIconTexture = this.atlas.getTexture("picker-list-item-selected-icon");

			this.radioUpIconTexture = backgroundSkinTexture;
			this.radioDownIconTexture = backgroundDownSkinTexture;
			this.radioDisabledIconTexture = backgroundDisabledSkinTexture;
			this.radioSelectedUpIconTexture = this.atlas.getTexture("radio-selected-up-icon");
			this.radioSelectedDownIconTexture = this.atlas.getTexture("radio-selected-down-icon");
			this.radioSelectedDisabledIconTexture = this.atlas.getTexture("radio-selected-disabled-icon");

			this.checkUpIconTexture = backgroundSkinTexture;
			this.checkDownIconTexture = backgroundDownSkinTexture;
			this.checkDisabledIconTexture = backgroundDisabledSkinTexture;
			this.checkSelectedUpIconTexture = this.atlas.getTexture("check-selected-up-icon");
			this.checkSelectedDownIconTexture = this.atlas.getTexture("check-selected-down-icon");
			this.checkSelectedDisabledIconTexture = this.atlas.getTexture("check-selected-disabled-icon");

			this.pageIndicatorSelectedSkinTexture = this.atlas.getTexture("page-indicator-selected-skin");
			this.pageIndicatorNormalSkinTexture = this.atlas.getTexture("page-indicator-normal-skin");

			this.searchIconTexture = this.atlas.getTexture("search-icon");

			/*this.itemRendererUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-item-up-skin"), ITEM_RENDERER_SCALE9_GRID);
			this.itemRendererSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-item-selected-skin"), ITEM_RENDERER_SCALE9_GRID);
			this.insetItemRendererFirstUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-first-up-skin"), INSET_ITEM_RENDERER_FIRST_SCALE9_GRID);
			this.insetItemRendererFirstSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-first-selected-skin"), INSET_ITEM_RENDERER_FIRST_SCALE9_GRID);
			this.insetItemRendererLastUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-last-up-skin"), INSET_ITEM_RENDERER_LAST_SCALE9_GRID);
			this.insetItemRendererLastSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-last-selected-skin"), INSET_ITEM_RENDERER_LAST_SCALE9_GRID);
			this.insetItemRendererSingleUpSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-single-up-skin"), INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID);
			this.insetItemRendererSingleSelectedSkinTextures = new Scale9Textures(this.atlas.getTexture("list-inset-item-single-selected-skin"), INSET_ITEM_RENDERER_SINGLE_SCALE9_GRID);*/

			this.headerBackgroundSkinTexture = this.atlas.getTexture("header-background-skin");

			this.calloutTopArrowSkinTexture = this.atlas.getTexture("callout-arrow-top-skin");
			this.calloutRightArrowSkinTexture = this.atlas.getTexture("callout-arrow-right-skin");
			this.calloutBottomArrowSkinTexture = this.atlas.getTexture("callout-arrow-bottom-skin");
			this.calloutLeftArrowSkinTexture = this.atlas.getTexture("callout-arrow-left-skin");

			this.horizontalScrollBarThumbSkinTextures = new Scale3Textures(this.atlas.getTexture("horizontal-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_HORIZONTAL);
			this.verticalScrollBarThumbSkinTextures = new Scale3Textures(this.atlas.getTexture("vertical-scroll-bar-thumb-skin"), SCROLL_BAR_THUMB_REGION1, SCROLL_BAR_THUMB_REGION2, Scale3Textures.DIRECTION_VERTICAL);

			StandardIcons.listDrillDownAccessoryTexture = this.atlas.getTexture("list-accessory-drill-down-icon");
		}

		protected function setInitializers():void
		{
			//screens
			this.setInitializerForClassAndSubclasses(Screen, screenInitializer);
			this.setInitializerForClassAndSubclasses(PanelScreen, panelScreenInitializer);
			this.setInitializerForClassAndSubclasses(ScrollScreen, scrollScreenInitializer);
			

			//alert
			this.setInitializerForClass(Alert, alertInitializer);
			this.setInitializerForClass(ButtonGroup, alertButtonGroupInitializer, Alert.DEFAULT_CHILD_NAME_BUTTON_GROUP);
			this.setInitializerForClass(Button, alertButtonGroupButtonInitializer, THEME_NAME_ALERT_BUTTON_GROUP_BUTTON);
			this.setInitializerForClass(Header, headerWithoutBackgroundInitializer, Alert.DEFAULT_CHILD_NAME_HEADER);
			this.setInitializerForClass(TextBlockTextRenderer, alertMessageInitializer, Alert.DEFAULT_CHILD_NAME_MESSAGE);

			//button
			this.setInitializerForClass(Button, buttonInitializer);
			this.setInitializerForClass(Button, callToActionButtonInitializer, Button.ALTERNATE_NAME_CALL_TO_ACTION_BUTTON);
			this.setInitializerForClass(Button, quietButtonInitializer, Button.ALTERNATE_NAME_QUIET_BUTTON);
			this.setInitializerForClass(Button, dangerButtonInitializer, Button.ALTERNATE_NAME_DANGER_BUTTON);
			this.setInitializerForClass(Button, backButtonInitializer, Button.ALTERNATE_NAME_BACK_BUTTON);
			this.setInitializerForClass(Button, forwardButtonInitializer, Button.ALTERNATE_NAME_FORWARD_BUTTON);
			this.setInitializerForClass(Button, getStartButtonInitializer, Constants.BUTTON_GET_START);
			this.setInitializerForClass(Button, getLoginButtonInitializer,  Constants.BUTTON_LOGIN);
			this.setInitializerForClass(Button, createButtonInitializer,  Constants.BUTTON_CREATE);
			this.setInitializerForClass(Button, menuButtonInitializer,  Constants.BUTTON_MENU);
			this.setInitializerForClass(Button, categoriesButtonInitializer,  Constants.BUTTON_CATEGORIES);
			this.setInitializerForClass(Button, gridToggleButtonInitializer,  Constants.TOGGLE_BUTTON_GRID);
			this.setInitializerForClass(Button, listToggleButtonInitializer,  Constants.TOGGLE_BUTTON_LIST);
			this.setInitializerForClass(Button, backExploreButtonInitializer,  Constants.BUTTON_BACK);
			this.setInitializerForClass(Button,shareButtonInitializer,  Constants.BUTTON_SHARE);

			//button group
			this.setInitializerForClass(ButtonGroup, buttonGroupInitializer);
			this.setInitializerForClass(Button, buttonGroupButtonInitializer, ButtonGroup.DEFAULT_CHILD_NAME_BUTTON);

			//callout
			this.setInitializerForClass(Callout, calloutInitializer);

			//check
			this.setInitializerForClass(Check, checkInitializer);

			//grouped list (see also: item renderers)
			this.setInitializerForClass(GroupedList, groupedListInitializer);
			this.setInitializerForClass(GroupedList, insetGroupedListInitializer, GroupedList.ALTERNATE_NAME_INSET_GROUPED_LIST);

			//header
			this.setInitializerForClass(Header, headerInitializer);
			this.setInitializerForClass(Header, headerCreateInitializer, Constants.HEADER_CREATE_PANEL);
			this.setInitializerForClass(Header, headerProfileInitializer, Constants.HEADER_PROFILE);
			this.setInitializerForClass(Header, headerSettingsInitializer, Constants.HEADER_SETTINGS);
			this.setInitializerForClass(Header, headerExploreInitializer, Constants.HEADER_EXPLORE);

			//header and footer renderers for grouped list
			this.setInitializerForClass(DefaultGroupedListHeaderOrFooterRenderer, headerRendererInitializer);
			this.setInitializerForClass(DefaultGroupedListHeaderOrFooterRenderer, footerRendererInitializer, GroupedList.DEFAULT_CHILD_NAME_FOOTER_RENDERER);
			this.setInitializerForClass(DefaultGroupedListHeaderOrFooterRenderer, insetHeaderRendererInitializer, GroupedList.ALTERNATE_CHILD_NAME_INSET_HEADER_RENDERER);
			this.setInitializerForClass(DefaultGroupedListHeaderOrFooterRenderer, insetFooterRendererInitializer, GroupedList.ALTERNATE_CHILD_NAME_INSET_FOOTER_RENDERER);

			//item renderers for lists
			this.setInitializerForClass(DefaultListItemRenderer, itemRendererInitializer);
			this.setInitializerForClass(DefaultListItemRenderer, itemRendererIntroductionInitializer, Constants.RENDERER_INTRODUCTION);
			this.setInitializerForClass(ItemRendererFooterCreate, itemRendererCreateFooterInitializer);
			this.setInitializerForClass(ItemRendererMenuList, itemRendererMenuInitializer);
			this.setInitializerForClass(ItemRendererProfileList, itemRendererProfileListInitializer);
			this.setInitializerForClass(ItemRendererSettingsList, itemRendererSettingsInitializer);
			
			//the picker list has a custom item renderer name defined by the theme
			this.setInitializerForClass(DefaultListItemRenderer, pickerListItemRendererInitializer, THEME_NAME_PICKER_LIST_ITEM_RENDERER);
			this.setInitializerForClass(DefaultGroupedListItemRenderer, itemRendererInitializer);
			this.setInitializerForClass(TextBlockTextRenderer, itemRendererAccessoryLabelInitializer, BaseDefaultItemRenderer.DEFAULT_CHILD_NAME_ACCESSORY_LABEL);
			this.setInitializerForClass(TextBlockTextRenderer, itemRendererIconLabelInitializer, BaseDefaultItemRenderer.DEFAULT_CHILD_NAME_ICON_LABEL);
			this.setInitializerForClass(DefaultGroupedListItemRenderer, insetMiddleItemRendererInitializer, GroupedList.ALTERNATE_CHILD_NAME_INSET_ITEM_RENDERER);
			this.setInitializerForClass(DefaultGroupedListItemRenderer, insetFirstItemRendererInitializer, GroupedList.ALTERNATE_CHILD_NAME_INSET_FIRST_ITEM_RENDERER);
			this.setInitializerForClass(DefaultGroupedListItemRenderer, insetLastItemRendererInitializer, GroupedList.ALTERNATE_CHILD_NAME_INSET_LAST_ITEM_RENDERER);
			this.setInitializerForClass(DefaultGroupedListItemRenderer, insetSingleItemRendererInitializer, GroupedList.ALTERNATE_CHILD_NAME_INSET_SINGLE_ITEM_RENDERER);

			//labels
			this.setInitializerForClass(Label, labelInitializer);
			this.setInitializerForClass(Label, labelErrorInitializer, Constants.LABEL_ERROR);
			this.setInitializerForClass(Label, labelPopUpInitializer, Constants.LABEL_POP_UP);
			this.setInitializerForClass(Label, headingLabelInitializer, Label.ALTERNATE_NAME_HEADING);
			this.setInitializerForClass(Label, detailLabelInitializer, Label.ALTERNATE_NAME_DETAIL);

			//list (see also: item renderers)
			this.setInitializerForClass(List, listInitializer);
			this.setInitializerForClass(List, listIntroductionInitializer, Constants.LIST_INTRODUCTION);
			this.setInitializerForClass(List, listCreateInitializer, Constants.LIST_SWIPE);
			this.setInitializerForClass(List, listMenuInitializer, Constants.LIST_MENU);
			this.setInitializerForClass(List, listPopUpShareInitializer, Constants.LIST_POP_UP);
			

			//numeric stepper
			this.setInitializerForClass(NumericStepper, numericStepperInitializer);
			this.setInitializerForClass(TextInput, numericStepperTextInputInitializer, NumericStepper.DEFAULT_CHILD_NAME_TEXT_INPUT);

			//page indicator
			this.setInitializerForClass(PageIndicator, pageIndicatorInitializer);
			this.setInitializerForClass(PageIndicator, pageIndicatorIntroInitializer, Constants.PAGE_INDICATOR_INTRO);

			//panel
			this.setInitializerForClass(Panel, panelInitializer);
			this.setInitializerForClass(Header, headerWithoutBackgroundInitializer, Panel.DEFAULT_CHILD_NAME_HEADER);

			//picker list (see also: list and item renderers)
			this.setInitializerForClass(PickerList, pickerListInitializer);
			this.setInitializerForClass(Button, pickerListButtonInitializer, PickerList.DEFAULT_CHILD_NAME_BUTTON);

			//progress bar
			this.setInitializerForClass(ProgressBar, progressBarInitializer);

			//radio
			this.setInitializerForClass(Radio, radioInitializer);

			//scroll container
			//we don't need an initializer for the ScrollContainer class without
			//a name because it has no background skin and the scroll bars have
			//separate initializers
			this.setInitializerForClass(ScrollContainer, scrollContainerToolbarInitializer, ScrollContainer.ALTERNATE_NAME_TOOLBAR);
			
			//View
			this.setInitializerForClass(ViewIntroduction, ViewIntroductionInitializer);
			this.setInitializerForClass(ViewLogin, ViewRegistrationInitializer);
			this.setInitializerForClass(ViewCreateScreen, ViewCreateInitializer);
			this.setInitializerForClass(MyFooter, myFooterInitializer);
			this.setInitializerForClass(ViewMenu, ViewLeftDrawerInitializer);
			this.setInitializerForClass(ViewProfile, ViewProfileInitializer);
			this.setInitializerForClass(ViewSettings, ViewSettingsInitializer);
			this.setInitializerForClass(PopUpChangeUserData, popUpInitializer);
			this.setInitializerForClass(CreatePopUp, CreatePopUpInitializer);
			this.setInitializerForClass(PopUpShare, PopUpShareInitializer);
			this.setInitializerForClass(ViewExplore, ViewExploreInitializer);
			this.setInitializerForClass(BusyIndicator, BusyIndicatorInitializer);
			
			

			//scroll text
			this.setInitializerForClass(ScrollText, scrollTextInitializer);

			//simple scroll bar
			this.setInitializerForClass(SimpleScrollBar, simpleScrollBarInitializer);
			this.setInitializerForClass(Button, horizontalSimpleScrollBarThumbInitializer, THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB);
			this.setInitializerForClass(Button, verticalSimpleScrollBarThumbInitializer, THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB);

			//slider
			this.setInitializerForClass(Slider, sliderInitializer);
			this.setInitializerForClass(Button, simpleButtonInitializer, Slider.DEFAULT_CHILD_NAME_THUMB);
			this.setInitializerForClass(Button, horizontalSliderMinimumTrackInitializer, THEME_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK);
			this.setInitializerForClass(Button, horizontalSliderMaximumTrackInitializer, THEME_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK);
			this.setInitializerForClass(Button, verticalSliderMinimumTrackInitializer, THEME_NAME_VERTICAL_SLIDER_MINIMUM_TRACK);
			this.setInitializerForClass(Button, verticalSliderMaximumTrackInitializer, THEME_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK);

			//tab bar
			//we don't need an initializer for the TabBar class in this theme
			this.setInitializerForClass(Button, tabInitializer, TabBar.DEFAULT_CHILD_NAME_TAB);

			//text input
			this.setInitializerForClass(TextInput, textInputInitializer);
			this.setInitializerForClass(TextInput, textInputLightInitializer,Constants.INPUT_FIELD_REGISTER);
			this.setInitializerForClass(TextInput, searchTextInputInitializer, TextInput.ALTERNATE_NAME_SEARCH_TEXT_INPUT);

			//toggle switch
			this.setInitializerForClass(ToggleSwitch, toggleSwitchInitializer);
			this.setInitializerForClass(Button, simpleButtonInitializer, ToggleSwitch.DEFAULT_CHILD_NAME_THUMB);
			this.setInitializerForClass(Button, toggleSwitchTrackInitializer, ToggleSwitch.DEFAULT_CHILD_NAME_ON_TRACK);
			//we don't need an initializer for the off track in this theme
			//the toggle switch layout uses a single track
		}

		protected function pageIndicatorNormalSymbolFactory():DisplayObject
		{
			const symbol:ImageLoader = new ImageLoader();
			symbol.source = this.pageIndicatorNormalSkinTexture;
			symbol.textureScale = this.scale;
			return symbol;
		}
		protected function pageIndicatorDisabledSymbolFactory():DisplayObject
		{
			const symbol:ImageLoader = new ImageLoader();
			symbol.source = this.atlas.getTexture("page-indicator-disable-skin");
			symbol.textureScale = this.scale;
			return symbol;
		}

		protected function pageIndicatorSelectedSymbolFactory():DisplayObject
		{
			const symbol:ImageLoader = new ImageLoader();
			symbol.source = this.pageIndicatorSelectedSkinTexture;
			symbol.textureScale = this.scale;
			return symbol;
		}

		protected function imageLoaderFactory():ImageLoader
		{
			const image:ImageLoader = new ImageLoader();
			image.textureScale = this.scale;
			return image;
		}

		protected function nothingInitializer(target:DisplayObject):void {}

		protected function screenInitializer(screen:Screen):void
		{
			screen.originalDPI = this._originalDPI;
		}

		protected function panelScreenInitializer(screen:PanelScreen):void
		{
			screen.originalDPI = this._originalDPI;
		}

		protected function scrollScreenInitializer(screen:ScrollScreen):void
		{
			screen.originalDPI = this._originalDPI;
		}

		protected function simpleButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				width: 60 * this.scale,
				height: 60 * this.scale,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;

			button.minWidth = button.minHeight = 60 * this.scale;
			button.minTouchWidth = button.minTouchHeight = 88 * this.scale;
		}

		protected function labelInitializer(label:Label):void
		{
			label.textRendererProperties.elementFormat = this.lightElementFormat;
			label.textRendererProperties.disabledElementFormat = this.disabledElementFormat;
		}
		
		protected function labelErrorInitializer(label:Label):void
		{
			label.textRendererFactory=labelErrorCreate;
		}
		protected function labelPopUpInitializer(label:Label):void
		{
			label.textRendererFactory=labelPopUpRendererText;
		}
		protected function labelStandartInitializer(label:Label):void
		{
			label.textRendererProperties.elementFormat = this.lightElementFormat;
			label.textRendererProperties.disabledElementFormat = this.disabledElementFormat;
		}

		protected function headingLabelInitializer(label:Label):void
		{
			label.textRendererProperties.elementFormat = this.largeLightElementFormat;
			label.textRendererProperties.disabledElementFormat = this.largeDisabledElementFormat;
		}

		protected function detailLabelInitializer(label:Label):void
		{
			label.textRendererProperties.elementFormat = this.smallLightElementFormat;
			label.textRendererProperties.disabledElementFormat = this.smallDisabledElementFormat;
		}

		protected function itemRendererAccessoryLabelInitializer(renderer:TextBlockTextRenderer):void
		{
			renderer.elementFormat = this.lightElementFormat;
		}

		protected function itemRendererIconLabelInitializer(renderer:TextBlockTextRenderer):void
		{
			renderer.elementFormat = this.lightElementFormat;
		}

		protected function alertMessageInitializer(renderer:TextBlockTextRenderer):void
		{
			renderer.wordWrap = true;
			renderer.elementFormat = this.lightElementFormat;
		}

		protected function scrollTextInitializer(text:ScrollText):void
		{
			text.textFormat = this.scrollTextTextFormat;
			text.paddingTop = text.paddingBottom = text.paddingLeft = 32 * this.scale;
			text.paddingRight = 36 * this.scale;
		}

		protected function baseButtonInitializer(button:Button):void
		{
			button.defaultLabelProperties.elementFormat = this.darkUIElementFormat;
			button.disabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			button.selectedDisabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;

			button.paddingTop = button.paddingBottom = 8 * this.scale;
			button.paddingLeft = button.paddingRight = 16 * this.scale;
			button.gap = 12 * this.scale;
			button.minWidth = button.minHeight = 60 * this.scale;
			button.minTouchWidth = button.minTouchHeight = 88 * this.scale;
		}

		protected function buttonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.defaultSelectedValue = this.buttonSelectedUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
			skinSelector.displayObjectProperties =
			{
				width: 60 * this.scale,
				height: 60 * this.scale,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.baseButtonInitializer(button);
		}

		protected function callToActionButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonCallToActionUpSkinTextures;
			skinSelector.setValueForState(this.buttonCallToActionDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				width: 60 * this.scale,
				height: 60 * this.scale,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.baseButtonInitializer(button);
		}

		protected function quietButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = null;
			skinSelector.defaultSelectedValue = this.buttonSelectedUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
			{
				width: 60 * this.scale,
				height: 60 * this.scale,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;

			button.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			button.downLabelProperties.elementFormat = this.darkUIElementFormat;
			button.disabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;
			button.defaultSelectedLabelProperties.elementFormat = this.darkUIElementFormat;
			button.selectedDisabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;

			button.paddingTop = button.paddingBottom = 8 * this.scale;
			button.paddingLeft = button.paddingRight = 16 * this.scale;
			button.gap = 12 * this.scale;
			button.minWidth = button.minHeight = 60 * this.scale;
			button.minTouchWidth = button.minTouchHeight = 88 * this.scale;
		}

		protected function dangerButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonDangerUpSkinTextures;
			skinSelector.setValueForState(this.buttonDangerDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				width: 60 * this.scale,
				height: 60 * this.scale,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.baseButtonInitializer(button);
		}

		protected function backButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonBackUpSkinTextures;
			skinSelector.setValueForState(this.buttonBackDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonBackDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				width: 60 * this.scale,
				height: 60 * this.scale,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.baseButtonInitializer(button);
			button.paddingLeft = 28 * this.scale;
		}

		protected function forwardButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonForwardUpSkinTextures;
			skinSelector.setValueForState(this.buttonForwardDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonForwardDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				width: 60 * this.scale,
				height: 60 * this.scale,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;
			this.baseButtonInitializer(button);
			button.paddingRight = 28 * this.scale;
		}
		protected function getStartButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonGetStartUpSkinTextures;
			skinSelector.defaultSelectedValue = this.buttonGetStartUpSkinTextures;
			skinSelector.setValueForState(this.buttonGetStartDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonGetStartDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.buttonGetStartUpSkinTextures, Button.STATE_DISABLED, true);
			skinSelector.displayObjectProperties =
				{
					width: 60 * this.scale,
						height: 60 * this.scale,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;
			
			button.labelFactory = labelCreate;		
			this.baseButtonInitializer(button);
		}
		protected function getLoginButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonGetStartUpSkinTextures;
			skinSelector.defaultSelectedValue = this.buttonGetStartUpSkinTextures;
			skinSelector.setValueForState(this.buttonGetStartDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonGetStartDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.buttonGetStartUpSkinTextures, Button.STATE_DISABLED, true);
			skinSelector.displayObjectProperties =
				{	
						width: 60 * this.scale,
						height: 60 * this.scale,
						textureScale: this.scale
				};
			button.stateToSkinFunction = skinSelector.updateValue;	
			button.labelFactory = labelCreate;		
			this.baseButtonInitializer(button);
		}
		
		
		protected function createButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonCreateSkinTextures;
			skinSelector.defaultSelectedValue = this.buttonCreateSkinTextures;
			skinSelector.setValueForState(this.buttonCreateDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonCreateDownSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.buttonCreateSkinTextures, Button.STATE_DISABLED, true);
			button.stateToSkinFunction = skinSelector.updateValue;	
			button.labelFactory = labelCreate;		
			this.baseButtonInitializer(button);
		}
		protected function categoriesButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonCategoriesSkinTextures;
			skinSelector.defaultSelectedValue = this.buttonCategoriesDownSkinTextures;
			skinSelector.setValueForState(this.buttonCategoriesDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonCategoriesDownSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.buttonCategoriesSkinTextures, Button.STATE_DISABLED, true);
			button.stateToSkinFunction = skinSelector.updateValue;	
			button.labelFactory = labelCreate;		
			this.baseButtonInitializer(button);
		}
		
		protected function menuButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonMenuSkinTextures;
			skinSelector.defaultSelectedValue = this.buttonMenuDownSkinTextures;
			skinSelector.setValueForState(this.buttonMenuDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonMenuDownSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.buttonMenuSkinTextures, Button.STATE_DISABLED, true);
			button.stateToSkinFunction = skinSelector.updateValue;	
			button.labelFactory = labelCreate;		
			this.baseButtonInitializer(button);
			
		}
		
		protected function gridToggleButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonToggleGrigUpSkin;
			skinSelector.defaultSelectedValue = this.buttonToggleGrigDownSkin;
			skinSelector.setValueForState(this.buttonToggleGrigDownSkin, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonToggleGrigDownSkin, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.buttonToggleGrigUpSkin, Button.STATE_DISABLED, true);
			button.stateToSkinFunction = skinSelector.updateValue;	
			button.labelFactory = labelCreate;		
			this.baseButtonInitializer(button);
		}
		
		protected function backExploreButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonBackSkin;
			skinSelector.defaultSelectedValue = this.buttonBackSkin;
			skinSelector.setValueForState(this.buttonBackSkin, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonBackSkin, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.buttonBackSkin, Button.STATE_DISABLED, true);
			button.stateToSkinFunction = skinSelector.updateValue;	
			button.labelFactory = labelCreate;		
			this.baseButtonInitializer(button);
		}
		
		protected function shareButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonShareSkin;
			skinSelector.defaultSelectedValue = this.buttonShareSkin;
			skinSelector.setValueForState(this.buttonShareSkin, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonShareSkin, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.buttonShareSkin, Button.STATE_DISABLED, true);
			button.stateToSkinFunction = skinSelector.updateValue;	
			button.labelFactory = labelCreate;		
			this.baseButtonInitializer(button);
		}
		
		protected function listToggleButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonTogglelistUpSkin;
			skinSelector.defaultSelectedValue = this.buttonToggleListDownSkin;
			skinSelector.setValueForState(this.buttonToggleListDownSkin, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonToggleListDownSkin, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.buttonTogglelistUpSkin, Button.STATE_DISABLED, true);
			button.stateToSkinFunction = skinSelector.updateValue;	
			button.labelFactory = labelCreate;		
			this.baseButtonInitializer(button);
		}

		protected function buttonGroupButtonInitializer(button:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.buttonUpSkinTextures;
			skinSelector.defaultSelectedValue = this.buttonSelectedUpSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.buttonDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.setValueForState(this.buttonSelectedDisabledSkinTextures, Button.STATE_DISABLED, true);
			skinSelector.displayObjectProperties =
			{
				width: 76 * this.scale,
				height: 76 * this.scale,
				textureScale: this.scale
			};
			button.stateToSkinFunction = skinSelector.updateValue;

			button.defaultLabelProperties.elementFormat = this.largeUIDarkElementFormat;
			button.disabledLabelProperties.elementFormat = this.largeUIDarkDisabledElementFormat;
			button.selectedDisabledLabelProperties.elementFormat = this.largeUIDarkDisabledElementFormat;

			button.paddingTop = button.paddingBottom = 8 * this.scale;
			button.paddingLeft = button.paddingRight = 16 * this.scale;
			button.gap = 12 * this.scale;
			button.minWidth = button.minHeight = 76 * this.scale;
			button.minTouchWidth = button.minTouchHeight = 88 * this.scale;
		}

		protected function alertButtonGroupButtonInitializer(button:Button):void
		{
			this.buttonInitializer(button);
			button.minWidth = 120 * this.scale;
		}

		protected function pickerListButtonInitializer(button:Button):void
		{
			this.buttonInitializer(button);

			const defaultIcon:ImageLoader = new ImageLoader();
			defaultIcon.source = this.pickerListButtonIconTexture;
			defaultIcon.textureScale = this.scale;
			defaultIcon.snapToPixels = true;
			button.defaultIcon = defaultIcon;

			button.gap = Number.POSITIVE_INFINITY;
			button.iconPosition = Button.ICON_POSITION_RIGHT;
		}

		protected function toggleSwitchTrackInitializer(track:Button):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				width: 140 * this.scale,
				height: 60 * this.scale,
				textureScale: this.scale
			};
			track.stateToSkinFunction = skinSelector.updateValue;
		}

		protected function tabInitializer(tab:Button):void
		{
			const defaultSkin:Quad = new Quad(88 * this.scale, 88 * this.scale, TAB_BACKGROUND_COLOR);
			tab.defaultSkin = defaultSkin;

			const downSkin:Scale9Image = new Scale9Image(this.tabDownSkinTextures, this.scale);
			tab.downSkin = downSkin;

			const defaultSelectedSkin:Scale9Image = new Scale9Image(this.tabSelectedSkinTextures, this.scale);
			tab.defaultSelectedSkin = defaultSelectedSkin;

			const disabledSkin:Quad = new Quad(88 * this.scale, 88 * this.scale, TAB_DISABLED_BACKGROUND_COLOR);
			tab.disabledSkin = disabledSkin;

			const selectedDisabledSkin:Scale9Image = new Scale9Image(this.tabSelectedDisabledSkinTextures, this.scale);
			tab.selectedDisabledSkin = selectedDisabledSkin;

			tab.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			tab.defaultSelectedLabelProperties.elementFormat = this.darkUIElementFormat;
			tab.disabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;
			tab.selectedDisabledLabelProperties.elementFormat = this.darkUIDisabledElementFormat;

			tab.paddingTop = tab.paddingBottom = 8 * this.scale;
			tab.paddingLeft = tab.paddingRight = 16 * this.scale;
			tab.gap = 12 * this.scale;
			tab.minWidth = tab.minHeight = 88 * this.scale;
			tab.minTouchWidth = tab.minTouchHeight = 88 * this.scale;
		}

		protected function buttonGroupInitializer(group:ButtonGroup):void
		{
			group.minWidth = 560 * this.scale;
			group.gap = 18 * this.scale;
		}

		protected function alertButtonGroupInitializer(group:ButtonGroup):void
		{
			group.direction = ButtonGroup.DIRECTION_HORIZONTAL;
			group.horizontalAlign = ButtonGroup.HORIZONTAL_ALIGN_CENTER;
			group.verticalAlign = ButtonGroup.VERTICAL_ALIGN_JUSTIFY;
			group.distributeButtonSizes = false;
			group.gap = 12 * this.scale;
			group.paddingTop = 12 * this.scale;
			group.paddingRight = 12 * this.scale;
			group.paddingBottom = 12 * this.scale;
			group.paddingLeft = 12 * this.scale;
			group.customButtonName = THEME_NAME_ALERT_BUTTON_GROUP_BUTTON;
		}

		protected function itemRendererInitializer(renderer:BaseDefaultItemRenderer):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.itemRendererUpSkinTextures;
			skinSelector.defaultSelectedValue = this.itemRendererSelectedSkinTextures;
			skinSelector.setValueForState(this.itemRendererSelectedSkinTextures, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
			{
				width: 88 * this.scale,
				height: 88 * this.scale,
				textureScale: this.scale
			};
			renderer.stateToSkinFunction = skinSelector.updateValue;

			renderer.defaultLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.downLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.defaultSelectedLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;

			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = renderer.paddingBottom = 8 * this.scale;
			renderer.paddingLeft = 32 * this.scale;
			renderer.paddingRight = 24 * this.scale;
			renderer.gap = 20 * this.scale;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = renderer.minHeight = 88 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 88 * this.scale;

			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
		}
		protected function itemRendererIntroductionInitializer(renderer:BaseDefaultItemRenderer):void
		{
			renderer.defaultLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.downLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.defaultSelectedLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeLightElementFormat;
			
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_CENTER;
			renderer.paddingTop = renderer.paddingBottom = 8 * this.scale;
			renderer.paddingLeft = 32 * this.scale;
			renderer.paddingRight = 24 * this.scale;
			renderer.gap = 20 * this.scale;
			renderer.iconPosition = Button.ICON_POSITION_TOP;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_MANUAL;
			renderer.minWidth = renderer.minHeight = 88 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 88 * this.scale;
			renderer.iconSourceField = "texture";
			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
		}


		protected function pickerListItemRendererInitializer(renderer:BaseDefaultItemRenderer):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.itemRendererUpSkinTextures;
			skinSelector.setValueForState(this.itemRendererSelectedSkinTextures, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
			{
				width: 88 * this.scale,
				height: 88 * this.scale,
				textureScale: this.scale
			};
			renderer.stateToSkinFunction = skinSelector.updateValue;

			const defaultSelectedIcon:Image = new Image(this.pickerListItemSelectedIconTexture);
			defaultSelectedIcon.scaleX = defaultSelectedIcon.scaleY = this.scale;
			renderer.defaultSelectedIcon = defaultSelectedIcon;

			const defaultIcon:Quad = new Quad(defaultSelectedIcon.width, defaultSelectedIcon.height, 0xff00ff);
			defaultIcon.alpha = 0;
			renderer.defaultIcon = defaultIcon;

			renderer.defaultLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.downLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;

			renderer.itemHasIcon = false;
			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = renderer.paddingBottom = 8 * this.scale;
			renderer.paddingLeft = 32 * this.scale;
			renderer.paddingRight = 24 * this.scale;
			renderer.gap = Number.POSITIVE_INFINITY;
			renderer.iconPosition = Button.ICON_POSITION_RIGHT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = renderer.minHeight = 88 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 88 * this.scale;
		}

		protected function insetItemRendererInitializer(renderer:DefaultGroupedListItemRenderer, defaultSkinTextures:Scale9Textures, selectedAndDownSkinTextures:Scale9Textures):void
		{
			const skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = defaultSkinTextures;
			skinSelector.defaultSelectedValue = selectedAndDownSkinTextures;
			skinSelector.setValueForState(selectedAndDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.displayObjectProperties =
			{
				width: 88 * this.scale,
				height: 88 * this.scale,
				textureScale: this.scale
			};
			renderer.stateToSkinFunction = skinSelector.updateValue;

			renderer.defaultLabelProperties.elementFormat = this.largeLightElementFormat;
			renderer.downLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.defaultSelectedLabelProperties.elementFormat = this.largeDarkElementFormat;
			renderer.disabledLabelProperties.elementFormat = this.largeDisabledElementFormat;

			renderer.horizontalAlign = Button.HORIZONTAL_ALIGN_LEFT;
			renderer.paddingTop = renderer.paddingBottom = 8 * this.scale;
			renderer.paddingLeft = 32 * this.scale;
			renderer.paddingRight = 24 * this.scale;
			renderer.gap = 20 * this.scale;
			renderer.iconPosition = Button.ICON_POSITION_LEFT;
			renderer.accessoryGap = Number.POSITIVE_INFINITY;
			renderer.accessoryPosition = BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;
			renderer.minWidth = renderer.minHeight = 88 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 88 * this.scale;

			renderer.accessoryLoaderFactory = this.imageLoaderFactory;
			renderer.iconLoaderFactory = this.imageLoaderFactory;
		}

		protected function insetMiddleItemRendererInitializer(renderer:DefaultGroupedListItemRenderer):void
		{
			this.insetItemRendererInitializer(renderer, this.itemRendererUpSkinTextures, this.itemRendererSelectedSkinTextures);
		}

		protected function insetFirstItemRendererInitializer(renderer:DefaultGroupedListItemRenderer):void
		{
			this.insetItemRendererInitializer(renderer, this.insetItemRendererFirstUpSkinTextures, this.insetItemRendererFirstSelectedSkinTextures);
		}

		protected function insetLastItemRendererInitializer(renderer:DefaultGroupedListItemRenderer):void
		{
			this.insetItemRendererInitializer(renderer, this.insetItemRendererLastUpSkinTextures, this.insetItemRendererLastSelectedSkinTextures);
		}

		protected function insetSingleItemRendererInitializer(renderer:DefaultGroupedListItemRenderer):void
		{
			this.insetItemRendererInitializer(renderer, this.insetItemRendererSingleUpSkinTextures, this.insetItemRendererSingleSelectedSkinTextures);
		}

		protected function headerRendererInitializer(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			const defaultSkin:Quad = new Quad(44 * this.scale, 44 * this.scale, GROUPED_LIST_HEADER_BACKGROUND_COLOR);
			renderer.backgroundSkin = defaultSkin;

			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_LEFT;
			renderer.contentLabelProperties.elementFormat = this.lightUIElementFormat;
			renderer.paddingTop = renderer.paddingBottom = 4 * this.scale;
			renderer.paddingLeft = renderer.paddingRight = 16 * this.scale;
			renderer.minWidth = renderer.minHeight = 44 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 44 * this.scale;

			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}

		protected function footerRendererInitializer(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			const defaultSkin:Quad = new Quad(44 * this.scale, 44 * this.scale, GROUPED_LIST_FOOTER_BACKGROUND_COLOR);
			renderer.backgroundSkin = defaultSkin;

			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_CENTER;
			renderer.contentLabelProperties.elementFormat = this.lightElementFormat;
			renderer.paddingTop = renderer.paddingBottom = 4 * this.scale;
			renderer.paddingLeft = renderer.paddingRight = 16 * this.scale;
			renderer.minWidth = renderer.minHeight = 44 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 44 * this.scale;

			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}

		protected function insetHeaderRendererInitializer(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			const defaultSkin:Quad = new Quad(66 * this.scale, 66 * this.scale, 0xff00ff);
			defaultSkin.alpha = 0;
			renderer.backgroundSkin = defaultSkin;

			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_LEFT;
			renderer.contentLabelProperties.elementFormat = this.lightUIElementFormat;
			renderer.paddingTop = renderer.paddingBottom = 4 * this.scale;
			renderer.paddingLeft = renderer.paddingRight = 32 * this.scale;
			renderer.minWidth = renderer.minHeight = 66 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 44 * this.scale;

			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}

		protected function insetFooterRendererInitializer(renderer:DefaultGroupedListHeaderOrFooterRenderer):void
		{
			const defaultSkin:Quad = new Quad(66 * this.scale, 66 * this.scale, 0xff00ff);
			defaultSkin.alpha = 0;
			renderer.backgroundSkin = defaultSkin;

			renderer.horizontalAlign = DefaultGroupedListHeaderOrFooterRenderer.HORIZONTAL_ALIGN_CENTER;
			renderer.contentLabelProperties.elementFormat = this.lightElementFormat;
			renderer.paddingTop = renderer.paddingBottom = 4 * this.scale;
			renderer.paddingLeft = renderer.paddingRight = 32 * this.scale;
			renderer.minWidth = renderer.minHeight = 66 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 44 * this.scale;

			renderer.contentLoaderFactory = this.imageLoaderFactory;
		}

		protected function radioInitializer(radio:Radio):void
		{
			const iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			iconSelector.defaultValue = this.radioUpIconTexture;
			iconSelector.defaultSelectedValue = this.radioSelectedUpIconTexture;
			iconSelector.setValueForState(this.radioDownIconTexture, Button.STATE_DOWN, false);
			iconSelector.setValueForState(this.radioDisabledIconTexture, Button.STATE_DISABLED, false);
			iconSelector.setValueForState(this.radioSelectedDownIconTexture, Button.STATE_DOWN, true);
			iconSelector.setValueForState(this.radioSelectedDisabledIconTexture, Button.STATE_DISABLED, true);
			iconSelector.displayObjectProperties =
			{
				scaleX: this.scale,
				scaleY: this.scale
			};
			radio.stateToIconFunction = iconSelector.updateValue;

			radio.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			radio.disabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;
			radio.selectedDisabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;

			radio.gap = 8 * this.scale;
			radio.minTouchWidth = radio.minTouchHeight = 88 * this.scale;
		}

		protected function checkInitializer(check:Check):void
		{
			const iconSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			iconSelector.defaultValue = this.checkUpIconTexture;
			iconSelector.defaultSelectedValue = this.checkSelectedUpIconTexture;
			iconSelector.setValueForState(this.checkDownIconTexture, Button.STATE_DOWN, false);
			iconSelector.setValueForState(this.checkDisabledIconTexture, Button.STATE_DISABLED, false);
			iconSelector.setValueForState(this.checkSelectedDownIconTexture, Button.STATE_DOWN, true);
			iconSelector.setValueForState(this.checkSelectedDisabledIconTexture, Button.STATE_DISABLED, true);
			iconSelector.displayObjectProperties =
			{
				scaleX: this.scale,
				scaleY: this.scale
			};
			check.stateToIconFunction = iconSelector.updateValue;

			check.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			check.disabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;
			check.selectedDisabledLabelProperties.elementFormat = this.lightUIDisabledElementFormat;

			check.gap = 8 * this.scale;
			check.minTouchWidth = check.minTouchHeight = 88 * this.scale;
		}

		protected function sliderInitializer(slider:Slider):void
		{
			slider.trackLayoutMode = Slider.TRACK_LAYOUT_MODE_MIN_MAX;
			if(slider.direction == Slider.DIRECTION_VERTICAL)
			{
				slider.customMinimumTrackName = THEME_NAME_VERTICAL_SLIDER_MINIMUM_TRACK;
				slider.customMaximumTrackName = THEME_NAME_VERTICAL_SLIDER_MAXIMUM_TRACK;
			}
			else
			{
				slider.customMinimumTrackName = THEME_NAME_HORIZONTAL_SLIDER_MINIMUM_TRACK;
				slider.customMaximumTrackName = THEME_NAME_HORIZONTAL_SLIDER_MAXIMUM_TRACK;
			}
		}

		protected function horizontalSliderMinimumTrackInitializer(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				textureScale: this.scale
			};
			skinSelector.displayObjectProperties.width = 210 * this.scale;
			skinSelector.displayObjectProperties.height = 60 * this.scale;
			track.stateToSkinFunction = skinSelector.updateValue;
		}

		protected function horizontalSliderMaximumTrackInitializer(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				textureScale: this.scale
			};
			skinSelector.displayObjectProperties.width = 210 * this.scale;
			skinSelector.displayObjectProperties.height = 60 * this.scale;
			track.stateToSkinFunction = skinSelector.updateValue;
		}

		protected function verticalSliderMinimumTrackInitializer(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				textureScale: this.scale
			};
			skinSelector.displayObjectProperties.width = 60 * this.scale;
			skinSelector.displayObjectProperties.height = 210 * this.scale;
			track.stateToSkinFunction = skinSelector.updateValue;
		}

		protected function verticalSliderMaximumTrackInitializer(track:Button):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundSkinTextures;
			skinSelector.setValueForState(this.buttonDownSkinTextures, Button.STATE_DOWN, false);
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, Button.STATE_DISABLED, false);
			skinSelector.displayObjectProperties =
			{
				textureScale: this.scale
			};
			skinSelector.displayObjectProperties.width = 60 * this.scale;
			skinSelector.displayObjectProperties.height = 210 * this.scale;
			track.stateToSkinFunction = skinSelector.updateValue;
		}

		protected function toggleSwitchInitializer(toggle:ToggleSwitch):void
		{
			toggle.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_SINGLE;

			toggle.defaultLabelProperties.elementFormat = this.lightUIElementFormat;
			toggle.onLabelProperties.elementFormat = this.selectedUIElementFormat;
		}

		protected function numericStepperInitializer(stepper:NumericStepper):void
		{
			stepper.buttonLayoutMode = NumericStepper.BUTTON_LAYOUT_MODE_SPLIT_HORIZONTAL;
			stepper.incrementButtonLabel = "+";
			stepper.decrementButtonLabel = "-";
		}

		protected function simpleScrollBarInitializer(scrollBar:SimpleScrollBar):void
		{
			if(scrollBar.direction == SimpleScrollBar.DIRECTION_HORIZONTAL)
			{
				scrollBar.paddingRight = scrollBar.paddingBottom = scrollBar.paddingLeft = 4 * this.scale;
				scrollBar.customThumbName = THEME_NAME_HORIZONTAL_SIMPLE_SCROLL_BAR_THUMB;
			}
			else
			{
				scrollBar.paddingTop = scrollBar.paddingRight = scrollBar.paddingBottom = 4 * this.scale;
				scrollBar.customThumbName = THEME_NAME_VERTICAL_SIMPLE_SCROLL_BAR_THUMB;
			}
		}

		protected function horizontalSimpleScrollBarThumbInitializer(thumb:Button):void
		{
			var defaultSkin:Scale3Image = new Scale3Image(this.horizontalScrollBarThumbSkinTextures, this.scale);
			defaultSkin.width = 10 * this.scale;
			thumb.defaultSkin = defaultSkin;
		}

		protected function verticalSimpleScrollBarThumbInitializer(thumb:Button):void
		{
			var defaultSkin:Scale3Image = new Scale3Image(this.verticalScrollBarThumbSkinTextures, this.scale);
			defaultSkin.height = 10 * this.scale;
			thumb.defaultSkin = defaultSkin;
		}

		protected function baseTextInputInitializer(input:TextInput):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundInsetSkinTextures;
			skinSelector.setValueForState(this.backgroundDisabledSkinTextures, TextInput.STATE_DISABLED);
			skinSelector.setValueForState(this.backgroundFocusedSkinTextures, TextInput.STATE_FOCUSED);
			skinSelector.displayObjectProperties =
			{
				width: 264 * this.scale,
				height: 60 * this.scale,
				textureScale: this.scale
			};
			input.stateToSkinFunction = skinSelector.updateValue;

			input.minWidth = input.minHeight = 60 * this.scale;
			input.minTouchWidth = input.minTouchHeight = 88 * this.scale;
			input.gap = 12 * this.scale;
			input.paddingTop = 12 * this.scale;
			input.paddingBottom = 10 * this.scale;
			input.paddingLeft = input.paddingRight = 14 * this.scale;
			input.textEditorProperties.fontFamily = "Helvetica";
			input.textEditorProperties.fontSize = 24 * this.scale;
			input.textEditorProperties.color = LIGHT_TEXT_COLOR;

			input.promptProperties.elementFormat = this.lightElementFormat;
		}
		protected function baseLightTextInputInitializer(input:TextInput):void
		{
			var skinSelector:SmartDisplayObjectStateValueSelector = new SmartDisplayObjectStateValueSelector();
			skinSelector.defaultValue = this.backgroundLightFocusedSkinTextures;
			skinSelector.setValueForState(this.backgroundLightFocusedSkinTextures, TextInput.STATE_DISABLED);
			skinSelector.setValueForState(this.backgroundLightSkinTextures, TextInput.STATE_FOCUSED);
			skinSelector.displayObjectProperties =
			{
				width: 264 * this.scale,
				height: 60 * this.scale,
				textureScale: this.scale
			};
			input.stateToSkinFunction = skinSelector.updateValue;

			input.minWidth = input.minHeight = 60 * this.scale;
			input.minTouchWidth = input.minTouchHeight = 88 * this.scale;
			input.gap = 12 * this.scale;
			input.paddingTop = 25* this.scale;
			input.paddingBottom = 10 * this.scale;
			input.paddingLeft = input.paddingRight = 14 * this.scale;
			input.textEditorProperties.fontFamily = "Helvetica";
			input.textEditorProperties.fontSize = 25* this.scale;
			input.textEditorProperties.color = DARK_TEXT_COLOR;

			input.promptProperties.elementFormat = this.promptElementFormat;
		}

		protected function textInputInitializer(input:TextInput):void
		{
			this.baseTextInputInitializer(input);
		}
		protected function textInputLightInitializer(input:TextInput):void
		{
			this.baseLightTextInputInitializer(input);
		}

		protected function searchTextInputInitializer(input:TextInput):void
		{
			this.baseTextInputInitializer(input);

			var searchIcon:ImageLoader = new ImageLoader();
			searchIcon.source = this.searchIconTexture;
			searchIcon.snapToPixels = true;
			input.defaultIcon = searchIcon;
		}

		protected function numericStepperTextInputInitializer(input:TextInput):void
		{
			const backgroundSkin:Scale9Image = new Scale9Image(this.backgroundSkinTextures, this.scale);
			backgroundSkin.width = 60 * this.scale;
			backgroundSkin.height = 60 * this.scale;
			input.backgroundSkin = backgroundSkin;

			const backgroundDisabledSkin:Scale9Image = new Scale9Image(this.backgroundDisabledSkinTextures, this.scale);
			backgroundDisabledSkin.width = 60 * this.scale;
			backgroundDisabledSkin.height = 60 * this.scale;
			input.backgroundDisabledSkin = backgroundDisabledSkin;

			const backgroundFocusedSkin:Scale9Image = new Scale9Image(this.backgroundFocusedSkinTextures, this.scale);
			backgroundFocusedSkin.width = 60 * this.scale;
			backgroundFocusedSkin.height = 60 * this.scale;
			input.backgroundFocusedSkin = backgroundFocusedSkin;

			input.minWidth = input.minHeight = 60 * this.scale;
			input.minTouchWidth = input.minTouchHeight = 88 * this.scale;
			input.gap = 12 * this.scale;
			input.paddingTop = 12 * this.scale;
			input.paddingBottom = 10 * this.scale;
			input.paddingLeft = input.paddingRight = 14 * this.scale;
			input.isEditable = false;
			input.textEditorFactory = stepperTextEditorFactory;
			input.textEditorProperties.textFormat = this.lightUICenteredTextFormat;
			input.textEditorProperties.embedFonts = true;
		}

		protected function pageIndicatorInitializer(pageIndicator:PageIndicator):void
		{
			pageIndicator.normalSymbolFactory = this.pageIndicatorNormalSymbolFactory;
			pageIndicator.selectedSymbolFactory = this.pageIndicatorSelectedSymbolFactory;
			pageIndicator.gap = 10 * this.scale;
			pageIndicator.paddingTop = pageIndicator.paddingRight = pageIndicator.paddingBottom =
				pageIndicator.paddingLeft = 6 * this.scale;
			pageIndicator.minTouchWidth = pageIndicator.minTouchHeight = 44 * this.scale;
		}
		protected function pageIndicatorIntroInitializer(pageIndicator:PageIndicator):void
		{
			pageIndicator.normalSymbolFactory =this.pageIndicatorDisabledSymbolFactory;
			pageIndicator.selectedSymbolFactory = this.pageIndicatorSelectedSymbolFactory;
			pageIndicator.gap = 10 * this.scale;
			pageIndicator.paddingTop = pageIndicator.paddingRight = pageIndicator.paddingBottom =
				pageIndicator.paddingLeft = 6 * this.scale;
			pageIndicator.minTouchWidth = pageIndicator.minTouchHeight = 44 * this.scale;
		}

		protected function progressBarInitializer(progress:ProgressBar):void
		{
			const backgroundSkin:Scale9Image = new Scale9Image(this.backgroundSkinTextures, this.scale);
			backgroundSkin.width = 240 * this.scale;
			backgroundSkin.height = 22 * this.scale;
			progress.backgroundSkin = backgroundSkin;

			const backgroundDisabledSkin:Scale9Image = new Scale9Image(this.backgroundDisabledSkinTextures, this.scale);
			backgroundDisabledSkin.width = 240 * this.scale;
			backgroundDisabledSkin.height = 22 * this.scale;
			progress.backgroundDisabledSkin = backgroundDisabledSkin;

			const fillSkin:Scale9Image = new Scale9Image(this.buttonUpSkinTextures, this.scale);
			fillSkin.width = 8 * this.scale;
			fillSkin.height = 22 * this.scale;
			progress.fillSkin = fillSkin;

			const fillDisabledSkin:Scale9Image = new Scale9Image(this.buttonDisabledSkinTextures, this.scale);
			fillDisabledSkin.width = 8 * this.scale;
			fillDisabledSkin.height = 22 * this.scale;
			progress.fillDisabledSkin = fillDisabledSkin;
		}

		protected function headerInitializer(header:Header):void
		{
			header.minWidth = 88 * this.scale;
			header.minHeight = 88 * this.scale;
			header.paddingTop = header.paddingRight = header.paddingBottom =
				header.paddingLeft = 14 * this.scale;
			header.gap = 8 * this.scale;
			header.titleGap = 12 * this.scale;

			const backgroundSkin:TiledImage = new TiledImage(this.headerBackgroundSkinTexture, this.scale);
			backgroundSkin.width = backgroundSkin.height = 88 * this.scale;
			header.backgroundSkin = backgroundSkin;
			header.titleProperties.elementFormat = this.headerElementFormat;
		}
		
				
		protected function headerCreateInitializer(header:Header):void{
			header.minWidth = 88 * this.scale;
			header.minHeight = 88 * this.scale;
			header.paddingTop = header.paddingRight = header.paddingBottom =
				header.paddingLeft = 14 * this.scale;
			header.gap = 8 * this.scale;
			header.titleGap = 12 * this.scale;

			var pBackgroundSkin:Image=new Image(atlas.getTexture("header_create"));
			pBackgroundSkin.scaleX=scale;
			pBackgroundSkin.scaleY=scale;
			header.backgroundSkin = pBackgroundSkin;
		}
		
		protected function headerProfileInitializer(header:Header):void	{
			header.minWidth = 88 * this.scale;
			header.minHeight = 88 * this.scale;
			header.paddingTop = header.paddingRight = header.paddingBottom =
				header.paddingLeft = 14 * this.scale;
			header.gap = 8 * this.scale;
			header.titleGap = 12 * this.scale;

			var pBackgroundSkin:Image=new Image(atlas.getTexture("header_profile"));
			pBackgroundSkin.scaleX=scale;
			pBackgroundSkin.scaleY=scale;
			header.backgroundSkin = pBackgroundSkin;
		}
		protected function headerSettingsInitializer(header:Header):void	{
			header.minWidth = 88 * this.scale;
			header.minHeight = 88 * this.scale;
			header.paddingTop = header.paddingRight = header.paddingBottom =
				header.paddingLeft = 14 * this.scale;
			header.gap = 8 * this.scale;
			header.titleGap = 12 * this.scale;

			var pBackgroundSkin:Image=new Image(atlas.getTexture("header_settings"));
			pBackgroundSkin.scaleX=scale;
			pBackgroundSkin.scaleY=scale;
			header.backgroundSkin = pBackgroundSkin;
		}
		protected function headerExploreInitializer(header:Header):void	{
			header.minWidth = 88 * this.scale;
			header.minHeight = 88 * this.scale;
			header.paddingTop = header.paddingRight = header.paddingBottom =
				header.paddingLeft = 14 * this.scale;
			header.gap = 8 * this.scale;
			header.titleGap = 12 * this.scale;

			var pBackgroundSkin:Image=new Image(atlas.getTexture("header_explore"));
			pBackgroundSkin.scaleX=scale;
			pBackgroundSkin.scaleY=scale;
			header.backgroundSkin = pBackgroundSkin;
		}

		protected function headerWithoutBackgroundInitializer(header:Header):void
		{
			header.minWidth = 88 * this.scale;
			header.minHeight = 88 * this.scale;
			header.paddingTop = header.paddingBottom = 14 * this.scale;
			header.paddingLeft = header.paddingRight = 18 * this.scale;

			header.titleProperties.elementFormat = this.headerElementFormat;
			
		}
		

		protected function pickerListInitializer(list:PickerList):void
		{
			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				list.popUpContentManager = new CalloutPopUpContentManager();
			}
			else
			{
				const centerStage:VerticalCenteredPopUpContentManager = new VerticalCenteredPopUpContentManager();
				centerStage.marginTop = centerStage.marginRight = centerStage.marginBottom =
					centerStage.marginLeft = 24 * this.scale;
				list.popUpContentManager = centerStage;
			}

			const layout:VerticalLayout = new VerticalLayout();
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_BOTTOM;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
			layout.useVirtualLayout = true;
			layout.gap = 0;
			layout.paddingTop = layout.paddingRight = layout.paddingBottom =
				layout.paddingLeft = 0;
			list.listProperties.layout = layout;
			list.listProperties.verticalScrollPolicy = List.SCROLL_POLICY_ON;

			if(DeviceCapabilities.isTablet(Starling.current.nativeStage))
			{
				list.listProperties.minWidth = 560 * this.scale;
				list.listProperties.maxHeight = 528 * this.scale;
			}
			else
			{
				const backgroundSkin:Scale9Image = new Scale9Image(this.backgroundSkinTextures, this.scale);
				backgroundSkin.width = 20 * this.scale;
				backgroundSkin.height = 20 * this.scale;
				list.listProperties.backgroundSkin = backgroundSkin;
				list.listProperties.paddingTop = list.listProperties.paddingRight =
					list.listProperties.paddingBottom = list.listProperties.paddingLeft = 8 * this.scale;
			}

			list.listProperties.itemRendererName = THEME_NAME_PICKER_LIST_ITEM_RENDERER;
		}

		protected function calloutInitializer(callout:Callout):void
		{
			const backgroundSkin:Scale9Image = new Scale9Image(this.backgroundPopUpSkinTextures, this.scale);
			//arrow size is 40 pixels, so this should be a bit larger
			backgroundSkin.width = 50 * this.scale;
			backgroundSkin.height = 50 * this.scale;
			callout.backgroundSkin = backgroundSkin;

			const topArrowSkin:Image = new Image(this.calloutTopArrowSkinTexture);
			topArrowSkin.scaleX = topArrowSkin.scaleY = this.scale;
			callout.topArrowSkin = topArrowSkin;

			const rightArrowSkin:Image = new Image(this.calloutRightArrowSkinTexture);
			rightArrowSkin.scaleX = rightArrowSkin.scaleY = this.scale;
			callout.rightArrowSkin = rightArrowSkin;

			const bottomArrowSkin:Image = new Image(this.calloutBottomArrowSkinTexture);
			bottomArrowSkin.scaleX = bottomArrowSkin.scaleY = this.scale;
			callout.bottomArrowSkin = bottomArrowSkin;

			const leftArrowSkin:Image = new Image(this.calloutLeftArrowSkinTexture);
			leftArrowSkin.scaleX = leftArrowSkin.scaleY = this.scale;
			callout.leftArrowSkin = leftArrowSkin;

			callout.paddingTop = callout.paddingBottom = 12 * this.scale;
			callout.paddingLeft = callout.paddingRight = 14 * this.scale;
		}

		protected function panelInitializer(panel:Panel):void
		{
			const backgroundSkin:Scale9Image = new Scale9Image(this.backgroundPopUpSkinTextures, this.scale);
			panel.backgroundSkin = backgroundSkin;

			panel.paddingTop = 0;
			panel.paddingRight = 8 * this.scale;
			panel.paddingBottom = 8 * this.scale;
			panel.paddingLeft = 8 * this.scale;
		}

		protected function alertInitializer(alert:Alert):void
		{
			const backgroundSkin:Scale9Image = new Scale9Image(this.backgroundPopUpSkinTextures, this.scale);
			alert.backgroundSkin = backgroundSkin;

			alert.paddingTop = 0;
			alert.paddingRight = 24 * this.scale;
			alert.paddingBottom = 16 * this.scale;
			alert.paddingLeft = 24 * this.scale;
			alert.gap = 16 * this.scale;
			alert.maxWidth = alert.maxHeight = 560 * this.scale;
		}

		protected function listInitializer(list:List):void
		{
			var backgroundSkin:Quad = new Quad(88 * this.scale, 88 * this.scale, LIST_BACKGROUND_COLOR);
			//list.backgroundSkin = backgroundSkin;
		}
		protected function listIntroductionInitializer(list:List):void
		{
			list.dataProvider=textureIntroductionLoad();		
		}
		protected function listCreateInitializer(list:List):void
		{
			list.dataProvider=textureCreateLoad();		
		}
		protected function listMenuInitializer(list:List):void
		{
			var backgroundSkin:Quad = new Quad(88 * this.scale, 88 * this.scale, 0x262a2e);
			list.backgroundSkin = backgroundSkin;		
		}
		protected function listPopUpShareInitializer(list:List):void
		{
			list.dataProvider = shareDataProvider();
		}
		protected function itemRendererMenuInitializer(renderer:ItemRendererMenuList):void
		{
			renderer.scale=scale;
			renderer.padding = 35*scale;
			
			var backgroundSkinDark:Image = new Image(atlas.getTexture("background_list_menu_dark"));	
				backgroundSkinDark.scaleX = scale;
				backgroundSkinDark.scaleY = scale;
				
			var backgroundSkinLight:Image = new Image(atlas.getTexture("background_list_menu"));		
				backgroundSkinLight.scaleX = scale;
				backgroundSkinLight.scaleY = scale
					
			var iconArrow:Image = new Image(atlas.getTexture("menu_arrow"));	
				iconArrow.scaleX=scale;
				iconArrow.scaleY=scale;
			
			renderer.lightBackground = backgroundSkinLight;
			renderer.darkBackground = backgroundSkinDark;
			renderer.rendererText=labelCreate;
			renderer.icon=iconArrow;		
		}

		protected function itemRendererProfileListInitializer(renderer:ItemRendererProfileList):void
		{
			renderer.scale=scale;;
					
			var pInfoBackground:Image = new Image(atlas.getTexture("background_info_panel_profile_list"));		
				pInfoBackground.scaleY = scale;
			renderer.backgroundInfoPanel=pInfoBackground;
			if(renderer.isBigFontSize){
				renderer.rendererText=labelHTMLBigCreate;
			}else{
				renderer.rendererText=labelStatusCreate;
			}
		}
		
		protected function itemRendererSettingsInitializer(renderer:ItemRendererSettingsList):void
		{
			renderer.scale=scale;
			renderer.padding=15*scale;
			
			var pTopElementBackground:Quad=new Image(atlas.getTexture("list_itemRenderer_top"));
			renderer.topBackground=pTopElementBackground;
			
			var pElementBackground:Quad=new Image(atlas.getTexture("list_itemRenderer_default"));
			renderer.defaultBackground=pElementBackground;
			
			var pBottomElementBackground:Quad=new Image(atlas.getTexture("list_itemRenderer_bottom"));
			renderer.bottomBackground=pElementBackground;
			
			renderer.rendererText=labelProfileRendererText;
		}
		
		protected function itemRendererCreateFooterInitializer(renderer:ItemRendererFooterCreate):void
		{
			renderer.scale=scale;
			renderer.padding=7;
			renderer.minWidth = renderer.minHeight = 88 * this.scale;
			renderer.minTouchWidth = renderer.minTouchHeight = 88 * this.scale;
			renderer.rendererText = labelLisrRendererCreate;
			renderer.rendererAccessoryText=labelStatusCreate;
			
		}


		protected function groupedListInitializer(list:GroupedList):void
		{
			const backgroundSkin:Quad = new Quad(88 * this.scale, 88 * this.scale, LIST_BACKGROUND_COLOR);
			list.backgroundSkin = backgroundSkin;
		}

		protected function scrollContainerToolbarInitializer(container:ScrollContainer):void
		{
			if(!container.layout)
			{
				const layout:HorizontalLayout = new HorizontalLayout();
				layout.paddingTop = layout.paddingRight = layout.paddingBottom =
					layout.paddingLeft = 14 * this.scale;
				layout.gap = 8 * this.scale;
				container.layout = layout;
			}
			container.minWidth = 88 * this.scale;
			container.minHeight = 88 * this.scale;

			const backgroundSkin:TiledImage = new TiledImage(this.headerBackgroundSkinTexture, this.scale);
			backgroundSkin.width = backgroundSkin.height = 88 * this.scale;
			container.backgroundSkin = backgroundSkin;
		}
		
				
		protected function ViewIntroductionInitializer(pViewIntroduction:ViewIntroduction):void	{
			pViewIntroduction.scale=scale;	
			
			
			var pBackgroundSkin:Image=new Image(atlas.getTexture("Background"));
			pBackgroundSkin.scaleX = scale;	
			pBackgroundSkin.scaleY = scale;
			pViewIntroduction.backgroundSkin=pBackgroundSkin;

			var pBackground:Image = new Image(atlas.getTexture("IntroductionBackgroundRutor"));
			pBackground.scaleX = scale;			
			pBackground.scaleY = scale;
			pViewIntroduction.background=pBackground;
			
			var pIntroductionSkin:Image=new Image(atlas.getTexture("IntroductionBackground"));	
			pIntroductionSkin.scaleX = scale;	
			pIntroductionSkin.scaleY = scale;
			pViewIntroduction.introductionSkin=pIntroductionSkin;
			
			var pLogoSkin:Image=new Image(atlas.getTexture("introduction_logo_slogan"));
			pLogoSkin.scaleX=scale;
			pLogoSkin.scaleY=scale;
			pViewIntroduction.logo = pLogoSkin;
		}
		protected function BusyIndicatorInitializer(pBusyIndicator:BusyIndicator):void	{
			pBusyIndicator.createBusyIndicator(atlas,"busyIndicator_");
				
		}
		
		protected function ViewRegistrationInitializer(pViewLogin:ViewLogin):void	{
			pViewLogin.scale=scale;			
	
			var pBackgroundSkin:Image=new Image(atlas.getTexture("Background"));
			pBackgroundSkin.scaleX = scale;	
			pBackgroundSkin.scaleY = scale;
			pViewLogin.backgroundSkin=pBackgroundSkin
				
			var pBackground:Quad=new Quad(400 * scale,Starling.current.nativeStage.stageHeight,0x2f363b);			
			pViewLogin.background=pBackground;
			
			var pLogo:Image=new Image(atlas.getTexture("logo_register"));
			pLogo.scaleX = pLogo.scaleY = scale;		
			pViewLogin.logo=pLogo;
		}
		
		protected function ViewCreateInitializer(pViewCreate:ViewCreateScreen):void{
			pViewCreate.scale=scale;
			
			var pBackgroundColor:Quad=new Quad(Starling.current.nativeStage.stageWidth, Starling.current.nativeStage.stageHeight,0x2a2c2f);
			pViewCreate.backgroundSkin=pBackgroundColor;
			
			var pBackgroundImage:Image=new Image(atlas.getTexture("backgroundCreatePanel"));
			pBackgroundImage.scaleX=scale;
			pBackgroundImage.scaleY=scale;
			pViewCreate.background=pBackgroundImage
			pViewCreate.rendererText = labelHTML;
						
		}
		protected function myFooterInitializer(pFooter:MyFooter):void{			
			pFooter.scale=scale;
			
			var pBackgroundImage:Image=new Image(atlas.getTexture("footer_background"));
			pBackgroundImage.scaleX=scale;
			pBackgroundImage.scaleY=scale;
			pFooter.backgroundSkin=pBackgroundImage;
		}
		protected function ViewLeftDrawerInitializer(pLeftDrawer:ViewMenu):void{
			pLeftDrawer.scale=scale;
			
			var pLogoSkin:Image=new Image(atlas.getTexture("header_menu"));
			pLogoSkin.scaleX=scale;
			pLogoSkin.scaleY=scale;
			
			pLeftDrawer.logo = pLogoSkin;
			
		}
		
		protected function ViewSettingsInitializer(pViewSettings:ViewSettings):void{
			pViewSettings.scale=scale;
		
			
			var pBackgroundSkin:Image=new Image(atlas.getTexture("Background"));
			pBackgroundSkin.width = Starling.current.nativeStage.stageWidth;	
			pBackgroundSkin.scaleY = scale;
			pViewSettings.backgroundSkin=pBackgroundSkin;
			
			var pLogoSkin:Image=new Image(atlas.getTexture("label_acount"));
			pLogoSkin.scaleX=scale;
			pLogoSkin.scaleY=scale;
			pViewSettings.logoListName = pLogoSkin;		
			
		}
		protected function ViewExploreInitializer(pViewExplore:ViewExplore):void{
			pViewExplore.scale=scale;
		
			
			var pBackgroundSkin:Image=new Image(atlas.getTexture("Background"));
			pBackgroundSkin.width = Starling.current.nativeStage.stageWidth;	
			pBackgroundSkin.scaleY = scale;
			pViewExplore.backgroundSkin=pBackgroundSkin;			
			
			var pBackground:Quad=new Quad(540*scale,600*scale,0xFFFFFF);
			pViewExplore.background=pBackground;	
			
			var pIconLike:Image=new Image(atlas.getTexture("icon_blue_like"));
			pIconLike.scaleX = scale;	
			pIconLike.scaleY = scale;
			pViewExplore.iconLike=pIconLike;			
			
			var pIconClock:Image=new Image(atlas.getTexture("icon_clock"));
			pIconClock.scaleX = scale;	
			pIconClock.scaleY = scale;
			pViewExplore.iconClock=pIconClock;		
			
			pViewExplore.rendererText=labelViewShare;

		}
		protected function popUpInitializer(pPopUp:PopUpChangeUserData):void{
			pPopUp.scale=scale;
		
			
			var pBackgroundSkin:Quad=new Quad(Starling.current.nativeStage.stageWidth,Starling.current.nativeStage.stageHeight,0x000000);
			pBackgroundSkin.alpha=.8;			
			pPopUp.backgroundSkin=pBackgroundSkin;
			
			var pBackground:Quad=new Quad(400*scale,300*scale,0x838383);
			pPopUp.background=pBackground;		
		}
		protected function CreatePopUpInitializer(pPopUp:CreatePopUp):void{
			pPopUp.scale=scale;
		
			
			var pBackgroundSkin:Quad=new Quad(Starling.current.nativeStage.stageWidth,Starling.current.nativeStage.stageHeight,0x000000);
			pBackgroundSkin.alpha=.8;			
			pPopUp.backgroundSkin=pBackgroundSkin;
			
			var pBackground:Image=new Image(atlas.getTexture("background_pop_up"));
			pPopUp.background=pBackground;		
		}
		protected function PopUpShareInitializer(pPopUp:PopUpShare):void{
			pPopUp.scale=scale;
		}

		protected function ViewProfileInitializer(pViewProfile:ViewProfile):void{			
			pViewProfile.scale=scale;
			
			var pBackgroundSkin:Image=new Image(atlas.getTexture("Background"));
			pBackgroundSkin.width = Starling.current.nativeStage.stageWidth;	
			pBackgroundSkin.scaleY = scale;
			pViewProfile.backgroundSkin=pBackgroundSkin;
			
				
			var pBackgroundImage:Image=new Image(atlas.getTexture("background_profile"));
			pBackgroundImage.scaleX=scale;
			pBackgroundImage.scaleY=scale;
			pViewProfile.background=pBackgroundImage;
				
		
			var pPhotoBorder:Image=new Image(atlas.getTexture("photo_border"));
			pPhotoBorder.scaleX=scale;
			pPhotoBorder.scaleY=scale;
			pViewProfile.photoBorder=pPhotoBorder;
			
			pViewProfile.rendererTextStatus=labelProfileRendererStatusText;
			pViewProfile.rendererText=labelProfileRendererText;
		}

		protected function insetGroupedListInitializer(list:GroupedList):void
		{
			list.itemRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_ITEM_RENDERER;
			list.firstItemRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_FIRST_ITEM_RENDERER;
			list.lastItemRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_LAST_ITEM_RENDERER;
			list.singleItemRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_SINGLE_ITEM_RENDERER;
			list.headerRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_HEADER_RENDERER;
			list.footerRendererName = GroupedList.ALTERNATE_CHILD_NAME_INSET_FOOTER_RENDERER;

			const layout:VerticalLayout = new VerticalLayout();
			layout.useVirtualLayout = true;
			layout.padding = 18 * this.scale;
			layout.gap = 0;
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_JUSTIFY;
			layout.verticalAlign = VerticalLayout.VERTICAL_ALIGN_TOP;
			layout.manageVisibility = true;
			list.layout = layout;
		}

		protected function root_addedToStageHandler(event:Event):void
		{
			this.initializeRoot();
		}

		protected function textureIntroductionLoad():ListCollection	{
			var pIdea:Texture = atlas.getTexture("idea_introduction");
			var pContribute:Texture = atlas.getTexture("introduction_contribute");
			var pFriends:Texture = atlas.getTexture("introduction_share_with_you_friends");
			var pBuyHome:Texture = atlas.getTexture("introduction_buy_from_home");
				
			var pCollection:ListCollection=new ListCollection(
														[  	{ label:"", texture:pIdea },
															{ label:"", texture: pFriends },
															{ label:"", texture: pContribute},
															{ label:"", texture: pBuyHome} ])
				
			return pCollection;	
		}
		protected function shareDataProvider():ListCollection	{
			var pFacebook:Texture = atlas.getTexture("facebook");
			var pTwitter:Texture = atlas.getTexture("twitter");
			var pPinterest:Texture = atlas.getTexture("pinterest");
			var pMailRu:Texture = atlas.getTexture("mail");
			var pTumblr:Texture = atlas.getTexture("tumblr");
				
			var pCollection:ListCollection=new ListCollection(
														[  	{ label:"Facebook", texture:pFacebook },
															{ label:"Twitter", texture: pTwitter },
															{ label:"Pinterest", texture: pPinterest},
															{ label:"Mail.ru", texture: pMailRu} ,
															{ label:"Tumblr", texture: pTumblr} ])
				
			return pCollection;	
		}
		
		protected function textureCreateLoad():ListCollection	{
			
			var pTheme_real:Image =new Image( atlas.getTexture("theme_real"));
			pTheme_real.scaleX=scale;
			pTheme_real.scaleY=scale;
			var pTheme_fancy_sparkling_roses:Image = new Image(atlas.getTexture("theme_fancy_sparkling_roses"));
			pTheme_fancy_sparkling_roses.scaleX=scale;
			pTheme_fancy_sparkling_roses.scaleY=scale;
			var pTheme_gradient:Image =new Image( atlas.getTexture("theme_gradient"));
			pTheme_gradient.scaleX=scale;
			pTheme_gradient.scaleY=scale;
			var pTheme_gryngy_ice_fire:Image = new Image(atlas.getTexture("theme_gryngy_ice_fire"));
			pTheme_gryngy_ice_fire.scaleX=scale;
			pTheme_gryngy_ice_fire.scaleY=scale;
			var pTheme_gryngy_blood_ice:Image =new Image( atlas.getTexture("theme_gryngy_blood_ice"));
			pTheme_gryngy_blood_ice.scaleX=scale;
			pTheme_gryngy_blood_ice.scaleY=scale;
			var pTheme_organic:Image = new Image(atlas.getTexture("theme_organic"));
			pTheme_organic.scaleX=scale;
			pTheme_organic.scaleY=scale;
			var pTheme_plain_digital_screen:Image = new Image(atlas.getTexture("theme_plain_digital_screen"));
			pTheme_plain_digital_screen.scaleX=scale;
			pTheme_plain_digital_screen.scaleY=scale;
			var pTheme_plain_sea_weed:Image =new Image( atlas.getTexture("theme_plain_sea_weed"));
			pTheme_plain_sea_weed.scaleX=scale;
			pTheme_plain_sea_weed.scaleY=scale;
			var pTheme_plain_whipped_iceCream:Image =new Image( atlas.getTexture("theme_plain_whipped_iceCream"));
			pTheme_plain_whipped_iceCream.scaleX=scale;
			pTheme_plain_whipped_iceCream.scaleY=scale;
			var pTheme_fancy_chocolate:Image =new Image( atlas.getTexture("theme-fancy_chocolate"));
			pTheme_fancy_chocolate.scaleX=scale;
			pTheme_fancy_chocolate.scaleY=scale;
			var pTheme_fancy_loranga_lights:Image = new Image(atlas.getTexture("theme-fancy_loranga_lights"));
			pTheme_fancy_loranga_lights.scaleX=scale;
			pTheme_fancy_loranga_lights.scaleY=scale;

			var pCollection:ListCollection=new ListCollection(
														[  	{ label:"Real",accessoryText:"TE<font color='#ffff00'><b>XT</b></font>", texture:pTheme_real, texture_big:Texture.fromEmbeddedAsset(THEME_REAL,false),text:"<p align='center'> <font face='TrajanPro' color='#000000'> <font color='#ffff00'>TWO THINGS </font> <br/>ARE INFINITE: <br/>THE UNIVERSE <br/> & <br/> <font  color='#ffff00'>HUMAN STUPIDITY </font> <br/>AND I'M NOT SURE <br/> <br/>ABOUT THE UNIVERSE. <br/> <br/>- ALBERT EINSTEIN </font> </p>"},
															
															{ label:"Sparkling roses",accessoryText:"TE<font color='#9b317c'><i>XT</i></font>", texture:pTheme_fancy_sparkling_roses, texture_big:Texture.fromEmbeddedAsset(THEME_FANCY_SPARKLING_ROSES,false),text:"<p align='left'> <font face='Calibri' color='#1f2a4f'>Great <font color='#942c70'> minds discuss ideas; </font> <br/>average <font color='#942c70'> minds discuss <br/>events; </font> small <font color='#942c70'> minds discuss <br/>people. </font> <br/>- Eleanor Roosevelt </font></p>"},
															
															{ label:"Blood ice", accessoryText:"<font color='#2f2fcc'>TE</font><font color='#ff0000'><b>XT</b></font>",texture: pTheme_gryngy_blood_ice, texture_big:Texture.fromEmbeddedAsset(THEME_GRYNGY_BLOOD_ICE,false),text:"<p align='center'> <font face='CenturyGothic' color='#000000'>I AM THE<br/><font color='#ff0000'>GREATEST,</font> <br/>I SAID THAT EVEN<br/><font color='#ff0000'> BEFORE</font><br/><font  color='#333333'> I KNEW I WAS.<br/><br/>-Muhammad Ali</font></font></p>" },
															
															{ label:"Gradient",accessoryText:"TE<font color='#2f2f54'><i>XT</i></font>", texture: pTheme_gradient, texture_big:Texture.fromEmbeddedAsset(THEME_GRADIENT,false),text:"<p align='left'> <font face='Noteworthy' color='#ffff00'>I never thought of <font color='#ff0000'> losing, </font> <br/>but now that it's <br/>happened, the only thing is to do it <font color='#ff0000'> right. </font> <br/>We all have to take <br/><font color='#ff0000'>defeats </font> in life. <br/> <br/><font color='#ff0000'>- Muhammad Ali </font> </font> </p>"},
															
															{ label:"Ice fire",accessoryText:"TE<font color='#ffff00'><b>XT</b></font>", texture: pTheme_gryngy_ice_fire, texture_big:Texture.fromEmbeddedAsset(THEME_GRYNGY_ICE_FIRE,false),text:"<p align='center'> <b> <font face='FranklinGothic' color='#0d3838'>Great spirits have <br/>always encountered <br/><font  color='#9c317d'> violent </font> <br/>opposition from <br/><font color='#9c317d'>mediocre minds. </font> <br/>- Albert Einstein </font> </p>"},
															
															{ label:"Organic",accessoryText:"TE<font color='#9b317c'><i>XT</i></font>", texture: pTheme_organic, texture_big:Texture.fromEmbeddedAsset(THEME_ORGANIC,false),text:"<p align='center'> <font face='CooperBlackStd'> <b>  <font color='#ffff00'>California </font> <br/>is a fine place to live <br/> if you happen to be an <font color='#ffff00'>orange. </font> <br/>-Fred Allen </b> </font></p>"},
															
															{ label:"Chocolate",accessoryText:"TE<font color='#ff0000'><b>XT</b></font>", texture: pTheme_fancy_chocolate, texture_big:Texture.fromEmbeddedAsset(THEME_FANCY_CHOCOLATE,false),text:"<p align='center'> <b> <font face='Georgia' color='#49220d'>I DON'T <br/><font color='#14bbdf'>WANT </font> <br/>LIFE TO IMITATE ART. <br/>I WANT LIFE <br/>to be <br/><font color='#14bbdf'>ART. </font> <br/>- Ernst Fische</font> </p>"},
															
															{ label:"Digital screen",accessoryText:"TE<font color='#2f2fff'><i>XT</i></font>", texture: pTheme_plain_digital_screen, texture_big:Texture.fromEmbeddedAsset(THEME_PLAIN_DIGITAL_SCREEN,false),text:"<p align='left'> <font face='AmericanTypewriter' color='#c6d5e9'>All great achievements <br/><b>require <font  color='#00dffc'>time.</font></b><br/>- Maya Angelou </font></p> "},
															
															{ label:"Ice cream",accessoryText:"TE<font color='#ffff00'><b>XT</b></font>", texture: pTheme_plain_whipped_iceCream, texture_big:Texture.fromEmbeddedAsset(THEME_PLAIN_WHIPPED_ICECREAM,false),text:"<p align='center'> <font face='ComicSansMS' color='#fff7bd'>HELVETICA <br/>-Massimo Vignell </font> </p>"},
															
															{ label:"Sea weed",accessoryText:"TE<font color='#9b317c'><i>XT</i></font>", texture: pTheme_plain_sea_weed, texture_big:Texture.fromEmbeddedAsset(THEME_PLAIN_SEA_WEED,false),text:"<p align='left'> <font face='Helvetica'>ALL OUR <br/><font color='#f5634a'>DREAMS </font> <br/>CAN COME TRUE, <br/>IF WE HAVE THE <br/><font color='#f5634a'>COURAGE </font> <br/>TO PURSUE THEM. <br/><font color='#f5634a'>- WALT DISNEY </font></font></p>"},
															
															{ label:"Loranga lights",accessoryText:"TE<font color='#ffff00'><b>XT</b></font>", texture: pTheme_fancy_loranga_lights, texture_big:Texture.fromEmbeddedAsset(THEME_FANCY_LORANGA_LIGHTS,false),text:"<p align='left'><font face='Avenir'>If you hear a voice within <br/>you say 'you cannot <br/>paint,' <font color='#ffff00'> then by all <br/>means paint </font>, and that <br/>voice will be silenced.<br/><font color='#ffff00'>- Vincent Van Gogh </font> </font></p>"} ]);
				
			return pCollection;	
		}
		
		
		protected function labelCreate():ITextRenderer{
			
			var pTextRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			pTextRenderer.textFormat = new TextFormat( FONT_COOPER,25*scale, 0xffffff,null,null,null,null,null,TextAlign.CENTER );
			pTextRenderer.embedFonts = true;
			return pTextRenderer;
		}
		protected function labelErrorCreate():ITextRenderer{
			
			var pTextRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			pTextRenderer.textFormat = new TextFormat(FONT_COOPER ,16*scale, 0xff0000,null,null,null,null,null,TextAlign.CENTER );
			pTextRenderer.embedFonts = true;
			return pTextRenderer;
		}
		protected function labelStatusCreate():ITextRenderer{
			
			var pTextRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			pTextRenderer.isHTML=true
			pTextRenderer.textFormat = new TextFormat("Calibri" ,20*scale, 0xFFFFFF,null,null,null,null,null,TextAlign.CENTER );
			pTextRenderer.embedFonts = true;
			return pTextRenderer;
		}
		protected function labelViewShare():ITextRenderer{
			
			var pTextRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			pTextRenderer.isHTML=true
			pTextRenderer.textFormat = new TextFormat("Calibri" ,20*scale, 0x4a90da,null,null,null,null,null,TextAlign.LEFT );
			pTextRenderer.embedFonts = true;
			return pTextRenderer;
		}
		protected function labelHTMLBigCreate():ITextRenderer{
			
			var pTextRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			pTextRenderer.isHTML=true
			pTextRenderer.textFormat = new TextFormat("Calibri" ,40*scale, 0xFFFFFF,null,null,null,null,null,TextAlign.CENTER );
			pTextRenderer.embedFonts = true;
			return pTextRenderer;
		}
		
		protected function labelHTML():ITextRenderer{
			
			var pTextRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
			pTextRenderer.textFormat = new TextFormat("_sans", 24 * this.scale, LIGHT_TEXT_COLOR);
			pTextRenderer.isHTML=true
			pTextRenderer.embedFonts = true;
		
			return pTextRenderer;
		}
		
		protected function labelLisrRendererCreate():ITextRenderer{
			
			var pTextRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();			
			pTextRenderer.textFormat = new TextFormat(FONT_COOPER ,17*scale, 0x6666666,null,null,null,null,null,TextAlign.CENTER );
			pTextRenderer.embedFonts = true;
			return pTextRenderer;
		}		
		protected function labelProfileRendererStatusText():ITextRenderer{
			
			var pTextRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();			
			pTextRenderer.textFormat = new TextFormat("Helvetica" ,16*scale, 0x808080,true,null,null,null,null,TextAlign.LEFT );
			pTextRenderer.embedFonts = true;
			pTextRenderer.wordWrap=true;
			return pTextRenderer;
		}		
		protected function labelProfileRendererText():ITextRenderer{
			
			var pTextRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();			
			pTextRenderer.textFormat = new TextFormat("Helvetica" ,18*scale, 0x404040,true,null,null,null,null,TextAlign.LEFT );
			pTextRenderer.embedFonts = true;
			return pTextRenderer;
		}		
		protected function labelPopUpRendererText():ITextRenderer{
			
			var pTextRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();			
			pTextRenderer.textFormat = new TextFormat("Helvetica" ,30*scale, 0x404040,true,null,null,null,null,TextAlign.CENTER );
			pTextRenderer.embedFonts = true;
			pTextRenderer.wordWrap=true;
			return pTextRenderer;
		}		
	}
}
