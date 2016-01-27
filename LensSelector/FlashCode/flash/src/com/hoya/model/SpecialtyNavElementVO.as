package com.hoya.model
{
	public class SpecialtyNavElementVO extends Object
	{
		private var _tintName:String;
		private var _tintCopy:String;
		private var _tintValue:String;
		private var _index:int;
		
		public function SpecialtyNavElementVO()
		{
			super();
		}
		
		public function get tintName():String
		{
			return _tintName;
		}
		
		public function set tintName(newVal:String):void
		{
			_tintName = newVal;
		}
		
		public function get tintCopy():String
		{
			return _tintCopy;
		}
		
		public function set tintCopy(newVal:String):void
		{
			_tintCopy = newVal;
		}
		
		public function get tintValue():String
		{
			return _tintValue;
		}
		
		public function set tintValue(newVal:String):void
		{
			_tintValue = newVal;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function set index(newVal:int):void
		{
			_index = newVal;
		}
	}
}