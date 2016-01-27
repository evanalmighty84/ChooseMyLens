package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import com.hoya.model.ProviderVO;
	import com.blitzagency.xray.logger.XrayLog;
	
	public class ProviderButton extends MovieClip
	{	
		private var _providerVO:ProviderVO;
		public static const PROVIDER_CLICK:String = "PROVIDER CLICK";
		public static const BADGE_CLICK:String = "BADGE CLICK";
		public static const VIEW_MAP_CLICK:String = "VIEW MAP CLICK";
		
		private var _log:XrayLog = new XrayLog();
		
		public function ProviderButton()
		{
			super();
		}
		
		public function get providerVO():ProviderVO
		{
			return _providerVO;
		}
		
		public function set providerVO(newVal:ProviderVO):void
		{
			_providerVO = newVal;
			setData();
		}
		
		private function setData():void
		{
			providerName.text = _providerVO.providerName;
			providerAddress1.text = _providerVO.providerAddress;
			providerAddress2.text = _providerVO.providerCity + ", " + _providerVO.providerState + " " + _providerVO.providerZip;
			providerPhone.text = _providerVO.providerPhone;
			badgeClip.certs = providerVO.certs;
		}
		
		public function init():void
		{
			if(_providerVO.providerURL.length > 0)
			{
				visitWebsiteButton.alpha = 1;
				visitWebsiteButton.buttonMode = true;
				visitWebsiteButton.useHandCursor = true;
				visitWebsiteButton.addEventListener(MouseEvent.CLICK, onWebsiteButtonClick);
			}
			else
			{
				visitWebsiteButton.visible = false;
				visitWebsiteButton.mouseEnabled = false;
			}

			if(providerVO.certs.length > 0)
			{
				
				badgeClip.init();
				badgeClip.buttonMode = true;
				badgeClip.useHandCursor = true;
				badgeClip.addEventListener(MouseEvent.CLICK, onBadgeClick);
			}
			transparentButton.buttonMode = true;
			transparentButton.useHandCursor = true;
			transparentButton.addEventListener(MouseEvent.CLICK, onProviderClick);
			
			showMapButton.buttonMode = true;
			showMapButton.useHandCursor = true;
			showMapButton.addEventListener(MouseEvent.CLICK, viewMapClick);
		}
		
		private function onWebsiteButtonClick(e:MouseEvent):void
		{
			navigateToURL(new URLRequest(_providerVO.providerURL), "_blank");
		}
		
		private function onProviderClick(e:MouseEvent):void
		{
			dispatchEvent(new Event(PROVIDER_CLICK));
		}
		
		private function onBadgeClick(e:MouseEvent):void
		{
			dispatchEvent(new Event(BADGE_CLICK));
		}
		
		private function viewMapClick(e:MouseEvent):void
		{
			dispatchEvent(new Event(VIEW_MAP_CLICK));
		}
	}
}