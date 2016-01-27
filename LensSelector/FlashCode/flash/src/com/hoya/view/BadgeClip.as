package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import com.hoya.model.CertVO;
	
	public class BadgeClip extends MovieClip
	{	
		private var _certs:Array = new Array();
		
		public function BadgeClip()
		{
			super();
		}
		
		public function get certs():Array
		{
			return _certs;
		}
		
		public function set certs(newVal:Array):void
		{
			_certs = newVal;
		}
		
		public function init():void
		{
			for(var i:int = 0; i < _certs.length; i++)
			{
				var certVO:CertVO = _certs[i] as CertVO;
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				loader.load(new URLRequest("images/" + certVO.imageURL));
				if(i > 0)
				{
					loader.x = (i * 30);
				}
				this.addChild(loader);
				
			}
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			trace("e :: " + e);
		}
	}
}