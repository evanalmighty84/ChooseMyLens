package com.hoya.model
{
	public class MoreInfoVO extends Object
	{
		private var _categoryText:String;
		private var _headerText:String;
		private var _subHeaderText:String;
		private var _copyText:String;
		private var _imageURL:String;
		
		public function MoreInfoVO()
		{
			super();
			
		}
		
		public function get categoryText():String
		{
			return _categoryText;
		}
		
		public function set categoryText(newVal:String):void
		{
			_categoryText = newVal;
		}
		
		public function get headerText():String
		{
			return _headerText;
		}
		
		public function set headerText(newVal:String):void
		{
			_headerText = newVal;
		}
		
		public function get subHeaderText():String
		{
			return _subHeaderText;
		}
		
		public function set subHeaderText(newVal:String):void
		{
			_subHeaderText = newVal;
		}
		
		public function get copyText():String
		{
			return _copyText;
		}
		
		public function set copyText(newVal:String):void
		{
			_copyText = newVal;
		}
		
		public function get imageURL():String
		{
			return _imageURL;
		}
		
		public function set imageURL(newVal:String):void
		{
			_imageURL = newVal;
		}
	}
}