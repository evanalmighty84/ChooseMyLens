package com.hoya.model
{
	public class CertVO extends Object
	{
		private var _imageURL:String;
		private var _titleText:String;
		private var _copyText:String;
		
		public function CertVO()
		{
			super();
		}
		
		public function get imageURL():String
		{
			return _imageURL;
		}
		
		public function set imageURL(newVal:String):void
		{
			_imageURL = newVal;
		}
		
		public function get titleText():String
		{
			return _titleText;
		}
		
		public function set titleText(newVal:String):void
		{
			_titleText = newVal;
		}
		
		public function get copyText():String
		{
			return _copyText;
		}
		
		public function set copyText(newVal:String):void
		{
			_copyText = newVal;
		}
	}
}