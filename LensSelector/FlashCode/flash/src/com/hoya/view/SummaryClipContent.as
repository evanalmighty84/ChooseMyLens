package com.hoya.view
{
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import caurina.transitions.Tweener;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import com.blitzagency.xray.logger.XrayLog;
	
	public class SummaryClipContent extends MovieClip
	{	
		public static const PRIMARY:String = "PRIMARY";
		public static const COMPLEMENTARY:String = "COMPLEMENTARY";
		public static const SPECIALITY:String = "SPECIALITY";
		public static const SHOW_RECOMMENDATION:String = "SHOW_RECOMMENDATION";
		private var _type:String;
		private var _xmlData:XML;
		private var _loader1:Loader = new Loader();
		private var _loader2:Loader;
		private var _toLoad:Number = 1;
		private var _loaded:Number = 0;
		private var _log:XrayLog = new XrayLog();
		
		public function SummaryClipContent()
		{
			super();
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		public function init(type:String, specialtyType:String = ""):void
		{
			viewRecommendationButton.addEventListener(MouseEvent.CLICK, onViewRecommendationClick);
			_type = type;
			_loader1.contentLoaderInfo.addEventListener(Event.COMPLETE, mainImageLoadComplete);
			_loader1.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			if(_type == PRIMARY)
			{
				txtField.text = _xmlData.lens.primaryCopy;
				var primaryList:XMLList = _xmlData.lens.primaryImages.elements("image");
				_loader1.load(new URLRequest(primaryList[0]));
			}
			else if(_type == COMPLEMENTARY)
			{
				txtField.text = _xmlData.lens.complementaryCopy;
				var complementaryList:XMLList = _xmlData.lens.complementaryImages.elements("image");
				_loader1.load(new URLRequest(complementaryList[0]));
			}
			else if(_type == SPECIALITY)
			{
				
				txtField.text = _xmlData.lens.specialtyCopy;
				var specialtiesList:XMLList = _xmlData.specialties.elements("sport");
				var sport:XML;
				for(var i:int = 0; i < specialtiesList.length(); i++)
				{
					if(specialtyType == specialtiesList[i].attribute("id"))
					{
						sport = specialtiesList[i];
						break;
					}
				}
				_loader1.load(new URLRequest(sport.image));
				_toLoad = 2;
				var tintList:XMLList = sport.tints.elements("tint");
				_loader2 = new Loader();
				_loader2.contentLoaderInfo.addEventListener(Event.COMPLETE, overlayLoadComplete);
				_loader2.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				_loader2.width = imageClip.width;
				_loader2.height = imageClip.height;
				_loader2.load(new URLRequest(tintList[0].image));
			}
		}
		
		private function onViewRecommendationClick(e:MouseEvent):void
		{
			dispatchEvent(new Event(SHOW_RECOMMENDATION));
		}
		
		private function mainImageLoadComplete(e:Event):void
		{
			_loaded++;
			_loader1.width = imageClip.width;
			_loader1.height = imageClip.height;
			imageClip.addChild(_loader1);
			if(_toLoad == _loaded)
			{
				Tweener.addTween(imageClip, {alpha:1, time:.5, transition:"linear"});
				Tweener.addTween(overlayClip, {alpha:1, time:.5, transition:"linear"});
			}
		}
		
		private function overlayLoadComplete(e:Event):void
		{
			_loaded++;
			_loader2.width = overlayClip.width;
			_loader2.height = overlayClip.height;
			overlayClip.addChild(_loader2);
			if(_toLoad == _loaded)
			{
				Tweener.addTween(imageClip, {alpha:1, time:.5, transition:"linear"});
				Tweener.addTween(overlayClip, {alpha:1, time:.5, transition:"linear"});
			}
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			_log.debug("e :: " + e);
		}
		
		public function enable():void
		{
			this.mouseEnabled = true;
			this.mouseChildren = true;
		}
		
		public function set xmlData(newVal:XML):void
		{
			_xmlData = newVal;
		}
	}
}