package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.display.Loader;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import caurina.transitions.Tweener;
	import com.hoya.model.CertVO;
	import com.blitzagency.xray.logger.XrayLog;
	
	import com.blitzagency.xray.logger.XrayLog;
	
	public class CertificationClip extends MovieClip
	{	
		private var _certs:Array = new Array();
		private var _certClipArray:Array;
		private var _log:XrayLog = new XrayLog();
		
		public function CertificationClip()
		{
			super();
			this.mouseEnabled = false;
			this.mouseChildren = false;
			certHolder.closeButton.buttonMode = true;
			certHolder.closeButton.useHandCursor = true;
			certHolder.closeButton.addEventListener(MouseEvent.CLICK, closeClick);
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
			_certClipArray = new Array();
			_log.debug("_certs.length :: " + _certs.length);
			for(var i:int = 0; i < _certs.length; i++)
			{
				var certClip:CertClip = new CertClip();
				_certClipArray.push(certClip);
				certClip.certVO = _certs[i] as CertVO;
				_log.debug("initializing certClip");
				certClip.init();
				certClip.x = 12;
				if(i == 0)
				{
					certClip.y = 53;
				}
				else
				{
					var previousCert:CertClip = _certClipArray[i - 1] as CertClip;
					certClip.y = previousCert.y + previousCert.height;
				}
				certHolder.addChild(certClip);
			}
			certHolder.backgroundClip.height = certHolder.height + 15;
			certHolder.y = (this.height - certHolder.height) / 2;
		}
		
		
		
		private function errorHandler(e:IOErrorEvent):void
		{
			trace("e :: " + e);
		}
		
		private function closeClick(e:MouseEvent):void
		{
			Tweener.addTween(this, {alpha:0, time:.5, transition:"linear", onComplete:cleanUp});
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		private function cleanUp():void
		{
			for(var i:int = 0; i < _certClipArray.length; i++)
			{
				var certClip:CertClip = _certClipArray[i] as CertClip;
				certHolder.removeChild(certClip);
			}
		}
	}
}