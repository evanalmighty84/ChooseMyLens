package com.hoya.controller
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import com.hoya.view.ContentBase;
	import com.hoya.view.ZipClip;
	import com.hoya.view.RecommendationsClip;
	import com.hoya.util.XMLLoader;
	import com.hoya.util.TrackingUtil;
	import com.blitzagency.xray.logger.XrayLog;
	
	public class HoyaContentController extends MovieClip
	{
		private var _previousIndex:int = 0;
		private var _currentIndex:int = 0;
		private var _configLoader:XMLLoader;
		private var _xmlLoader:XMLLoader;
		private var _lid:String = "";
		private var _gid:String = "";
		private var _googleMapsAPI:String;
		private var _couponLink:String;
		private var _ShowCoupon:String = "";
		private var _trackingUtil:TrackingUtil = TrackingUtil.getInstance();
		private var _log:XrayLog = new XrayLog();
		
		public function HoyaContentController()
		{
			super();
			init();
			loadConfig();
			loadXML();
		}
		
		private function init():void
		{
			contentClip.mask = gradientMask;
			gradientMask.background.mask = gradientMask.backgroundMask;
			navArrowClip.enableNextText();
			navArrowClip.addEventListener(NavArrowClip.UPDATE_VIEW_BACK, evalIndex);
			navArrowClip.addEventListener(NavArrowClip.UPDATE_VIEW_NEXT, evalIndex);
			contentClip.addEventListener(ContentBase.ENABLE_NEXT, enableNextButton);
			contentClip.addEventListener(ContentBase.SHOW_NEXT, showNext);
			contentClip.addEventListener(ZipClip.ENTER_KEY, showNext);
			contentClip.addEventListener(RecommendationsClip.INDEX_CHANGE, updateIndex);
			_trackingUtil.trackPageView("HOME");
			_log.debug("proxy test");
		}
		
		private function loadConfig():void
		{
			_configLoader = new XMLLoader();
			_configLoader.dataURL = "swfconfig.xml";
			_configLoader.addEventListener(XMLLoader.XML_LOAD_COMPLETE, configLoadComplete);
			_configLoader.loadData();
		}
		
		private function configLoadComplete(e:Event):void
		{
			_configLoader.removeEventListener(XMLLoader.XML_LOAD_COMPLETE, onXMLLoadComplete);
			contentClip.serviceURL = _configLoader.xmlData.serviceURL;
			_googleMapsAPI = _configLoader.xmlData.googleMapsAPI;
			_couponLink = _configLoader.xmlData.couponLink;
			if(stage.loaderInfo.parameters.lid)
			{
				_lid = stage.loaderInfo.parameters.lid;
			}
			
			if(stage.loaderInfo.parameters.gid)
			{
				_gid = stage.loaderInfo.parameters.gid;
			}
			
			if(stage.loaderInfo.parameters.ShowCoupon)
			{
				_ShowCoupon = stage.loaderInfo.parameters.ShowCoupon;
			}
			
			
			
		}
		
		private function loadXML():void
		{
			_xmlLoader = new XMLLoader();
			_xmlLoader.dataURL = "recommendation.xml";
			_xmlLoader.addEventListener(XMLLoader.XML_LOAD_COMPLETE, onXMLLoadComplete);
			_xmlLoader.loadData();
		}
		
		private function onXMLLoadComplete(e:Event):void
		{
			_xmlLoader.removeEventListener(XMLLoader.XML_LOAD_COMPLETE, onXMLLoadComplete);
			contentClip.xmlData = _xmlLoader.xmlData;
			contentClip.lid = _lid;
			contentClip.gid = _gid;
			contentClip.googleMapsAPI = _googleMapsAPI;
			contentClip.couponLink = _couponLink;
			contentClip.ShowCoupon = _ShowCoupon;
		}
		
		private function showNext(e:Event):void
		{
			evalIndex(new Event(NavArrowClip.UPDATE_VIEW_NEXT));
		}
		
		private function evalIndex(e:Event):void
		{
			_previousIndex = _currentIndex;
			if(e.type == NavArrowClip.UPDATE_VIEW_BACK)
			{
				_currentIndex--;
			}
			else if(e.type == NavArrowClip.UPDATE_VIEW_NEXT)
			{
				_currentIndex++;
			}
			updateNav();
			updateView();
			doTranstion();
		}
		
		private function updateNav():void
		{
			navArrowClip.disableNext();
			navArrowClip.disableNextText();
			if(_currentIndex > 1)
			{
				navArrowClip.enableBack();
			}
			else
			{
				navArrowClip.disableBack();
			}
		}
		
		private function enableNextButton(e:Event):void
		{
			navArrowClip.enableNext();
		}
		
		private function removeMask():void
		{
			removeChild(gradientMask);
			contentClip.mask = null;
		}
		
		private function updateView():void
		{
			contentClip.updateView(_currentIndex);
			switch(_currentIndex)
			{
				// ABOUT //
				case 1:
//trace("TODO :: remove controller hack");
//navArrowClip.disableAll();
//removeMask();
					footerClip.updateView(1, 3, FooterClip.ABOUT);
					break;
				case 2:
					footerClip.updateView(2, 3, FooterClip.ABOUT);
					break;
				case 3:
					footerClip.updateView(3, 3, FooterClip.ABOUT);
					break;
				// LIFE_STYLE //
				case 4:
					footerClip.updateView(1, 5, FooterClip.LIFE_STYLE);
					break;
				case 5:
					footerClip.updateView(2, 5, FooterClip.LIFE_STYLE);
					break;
				case 6:
					footerClip.updateView(3, 5, FooterClip.LIFE_STYLE);
					break;
				case 7:
					footerClip.updateView(4, 5, FooterClip.LIFE_STYLE);
					break;
				case 8:
					footerClip.updateView(5, 5, FooterClip.LIFE_STYLE);
					break;
				// EYE_CARE //
				case 9:
					footerClip.updateView(1, 4, FooterClip.EYE_CARE);
					break;
				case 10:
					footerClip.updateView(2, 4, FooterClip.EYE_CARE);
					break;
				case 11:
					footerClip.updateView(3, 4, FooterClip.EYE_CARE);
					break;
				case 12:
					footerClip.updateView(4, 4, FooterClip.EYE_CARE);
					break;
				// LEISURE //
				case 13:
					footerClip.updateView(1, 1, FooterClip.LEISURE);
					break;
				// SUMMARY //
				case 14:
					navArrowClip.disableAll();
					removeMask();
					footerClip.updateView(1, 1, FooterClip.SUMMARY);
					break;
				// RECOMMENDATIONS //
				case 15:
					footerClip.updateView(1, 3, FooterClip.LENS_RECOMMENDATIONS);
					break;
			}
		}
		
		private function updateIndex(e:Event):void
		{
			footerClip.updateView(contentClip.recommendationIndex, contentClip.recommendationCount, FooterClip.LENS_RECOMMENDATIONS);
		}
		
		private function doTranstion():void
		{
			if(_currentIndex > _previousIndex)
			{
				contentClip.slideLeftOut();
				contentClip.slideLeftIn();
			}
			else if(_currentIndex < _previousIndex)
			{
				contentClip.slideRightOut();
				contentClip.slideRightIn();
			}
		}	
	}
}