/*

Библиотека для работы с API Мой Мир@Mail.Ru

http://flapps.ru/forum/ - форум о создании флеш приложений с использованием API различных социальных сетей

*/
package com.socialApplication.service.api.mailRu.my{
	public class Parameter {
		public var name:String;
		public var value:String;

		public function Parameter (name: String, value: String)
		{
			this.name = name;
			this.value = value;
			this.value = this.value.replace(/\"/g, '\\\"');
			this.value = this.value.replace(/\'/g, '\\\'');
		}

		public function toString():String {
			return name + "=" + additionalEncode(encodeURI(value));
		}

		public function toUsualString():String {
			return name + "=" + value;
		}

		private function additionalEncode(str: String):String {
			str=str.replace(/\"/g,'%22');
			str=str.replace(/\#/g,'%23');
			str=str.replace(/\&/g,'%26');
			str=str.replace(/\'/g,'%27');
			str=str.replace(/\+/g,'%2B');
			str=str.replace(/\%5C\%27/g,'%27');
			str=str.replace(/\%5C\%22/g,'%22');

			return str;
		}
	}
}