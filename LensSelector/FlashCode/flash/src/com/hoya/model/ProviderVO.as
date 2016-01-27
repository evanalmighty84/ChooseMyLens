package com.hoya.model
{
	public class ProviderVO extends Object
	{
		private var _providerID:String = "";
		private var _providerName:String = "";
		private var _providerAddress:String = "";
		private var _providerCity:String = "";
		private var _providerState:String = "";
		private var _providerZip:String = "";
		private var _providerPhone:String = "";
		private var _providerURL:String = "";
		private var _certs:Array = new Array();
		
		public function ProviderVO()
		{
			super();
		}
		
		public function get providerID():String
		{
			return _providerID;
		}
		
		public function set providerID(newVal:String):void
		{
			_providerID = newVal;
		}
		
		public function get providerName():String
		{
			return _providerName;
		}
		
		public function set providerName(newVal:String):void
		{
			_providerName = newVal;
		}
		
		public function get providerAddress():String
		{
			return _providerAddress;
		}
		
		public function set providerAddress(newVal:String):void
		{
			_providerAddress = newVal;
		}

		public function get providerCity():String
		{
			return _providerCity;
		}
		
		public function set providerCity(newVal:String):void
		{
			_providerCity = newVal;
		}
		
		public function get providerState():String
		{
			return _providerState;
		}
		
		public function set providerState(newVal:String):void
		{
			_providerState = newVal;
		}
		
		public function get providerZip():String
		{
			return _providerZip;
		}
		
		public function set providerZip(newVal:String):void
		{
			_providerZip = newVal;
		}
		
		public function get providerPhone():String
		{
			return _providerPhone;
		}
		
		public function set providerPhone(newVal:String):void
		{
			_providerPhone = newVal;
		}
		
		public function get providerURL():String
		{
			return _providerURL;
		}
		
		public function set providerURL(newVal:String):void
		{
			_providerURL = newVal;
		}
		
		public function get certs():Array
		{
			return _certs;
		}
		
		public function set certs(newVal:Array):void
		{
			_certs = newVal;
		}
	}
}