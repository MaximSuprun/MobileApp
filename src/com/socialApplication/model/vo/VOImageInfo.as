package com.socialApplication.model.vo{
	
	public class VOImageInfo{
		//--------------------------------------------------------------------------------------------------------- 
		// 
		//  PUBLIC & INTERNAL VARIABLES 
		// 
		//---------------------------------------------------------------------------------------------------------
		private var _title:String="";
		private var _number_of_likes:String="";
		private var _number_of_comments:String="";
		private var _id:String="";
		private var _url:String="";
		private var _age:String="";
		private var _userName:String="";
		
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
		
		public function VOImageInfo(){
			
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
		public function get url():String{return _url;}
		public function set url(value:String):void{
			_url = value;
		}
		
		public function get age():String{return _age;}
		public function set age(value:String):void{
			_age = value;
		}
		
		public function get userName():String{return _userName;}
		public function set userName(value:String):void{
			_userName = value;
		}
		
		public function get id():String{return _id;}
		public function set id(value:String):void{
			_id = value;
		}

		public function get number_of_comments():String	{return _number_of_comments;}
		public function set number_of_comments(value:String):void{
			_number_of_comments = value;
		}

		public function get number_of_likes():String{return _number_of_likes;}
		public function set number_of_likes(value:String):void{
			_number_of_likes = value;
		}

		public function get title():String{return _title;}
		public function set title(value:String):void{
			_title = value;
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