package com.socialApplication.model{
	import com.socialApplication.model.vo.VOUserData;

	public interface IModel	{
	
		function set inputedData(pValue:Object):void;
		function set userData(pValue:VOUserData):void;
		function get userData():VOUserData;
		function set newDataLogin(pValue:String):void;
		function set newDataPassword(pValue:String):void;	
		
	}
}