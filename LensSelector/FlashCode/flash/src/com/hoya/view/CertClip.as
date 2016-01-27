package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import com.hoya.model.CertVO;
	import caurina.transitions.Tweener;
	
	import com.blitzagency.xray.logger.XrayLog;
	
	public class CertClip extends MovieClip
	{	
		private var _certVO:CertVO;
		
		public function CertClip()
		{
			super();
		}
		
		public function get certVO():CertVO
		{
			return _certVO;
		}
		
		public function set certVO(newVal:CertVO):void
		{
			_certVO = newVal;
		}
		
		public function init():void
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.load(new URLRequest("images/" + _certVO.imageURL));
			iconClip.addChild(loader);
			titleText.text = _certVO.titleText;
			copyText.text = _certVO.copyText;
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			trace("e :: " + e);
		}
	}
}