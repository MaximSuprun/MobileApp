package com.socialApplication.model.vo{
	
	public class VOUserData{
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
		private var _avatar:String="";
		private var _description:String="";
		private var _id:String="";
		private var _countOfLikes:String="";
		private var _countOfComments:String="";
		private var _countOfPosts:String="";
		private var _status:String="";
		private var _token:String="";
		
		//--------------------------------------------------------------------------------------------------------- 
		//
		//  CONSTRUCTOR 
		// 
		//---------------------------------------------------------------------------------------------------------
		
		public function VOUserData()
		{
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

		public function get status():String{return _status;}
		public function set status(value:String):void{
			_status = value;
		}
		
		public function get token():String{return _token;}
		public function set token(value:String):void{
			_token = value;
		}

		public function get countOfPosts():String{return _countOfPosts;}
		public function set countOfPosts(value:String):void{
			_countOfPosts = value;
		}
		
		public function get countOfComments():String{return _countOfComments;}
		public function set countOfComments(value:String):void{
			_countOfComments = value;
		}

		public function get countOfLikes():String{return _countOfLikes;}
		public function set countOfLikes(value:String):void{
			_countOfLikes = value;
		}

		public function get id():String{return _id;}
		public function set id(value:String):void{
			_id = value;
		}

		public function get description():String{return _description;}
		public function set description(value:String):void{
			_description = value;
		}

		public function get avatar():String{return _avatar;}
		public function set avatar(value:String):void{
			_avatar = value;
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