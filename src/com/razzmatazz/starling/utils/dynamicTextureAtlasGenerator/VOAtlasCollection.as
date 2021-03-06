package com.razzmatazz.starling.utils.dynamicTextureAtlasGenerator {

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

	public class VOAtlasCollection {
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
		private var _atlasCollection:Vector.<TextureAtlas>;

		
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function VOAtlasCollection() {
		}

		
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL METHODS 
		// 
		//---------------------------------------------------------------------------------------------------------
		public function getTexture(pId:String):Texture {
			var pTexture:Texture;
			var pCollectionLength:int = _atlasCollection.length;
			for (var i:int=0; i<pCollectionLength; ++i) {
				var pAtlas:TextureAtlas = _atlasCollection[i];
				pTexture = pAtlas.getTexture(pId);
				if(pTexture){
					break;
				}
			}
			return pTexture;
		}
		
		
		public function destroy():void {
			var pCollectionLength:int = _atlasCollection.length;
			for (var i:int=0; i<pCollectionLength; ++i) {
				var pAtlas:TextureAtlas = _atlasCollection[i];
				pAtlas.dispose();
			}
		}

		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  GETTERS & SETTERS   
		// 
		//---------------------------------------------------------------------------------------------------------
		public function set atlasCollection(value:Vector.<TextureAtlas>):void {
			_atlasCollection = value;
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