package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import caurina.transitions.Tweener;
	import recomendations.Recomender;
	import com.hoya.util.TrackingUtil;
	import com.blitzagency.xray.logger.XrayLog;
	
	public class ContentClip extends MovieClip
	{
		private var _previousClip:MovieClip;
		private var _currentClip:MovieClip;
		private var _recommender:Recomender;
		private var _recommendationIndex:int;
		private var _recommendationCount:int;
		private var _serviceURL:String;
		private var _lid:String;
		private var _gid:String;
		private var _ShowCoupon:String;
		private var _googleMapsAPI:String;
		private var _couponLink:String;
		private var _trackingUtil:TrackingUtil = TrackingUtil.getInstance();
		//private var _log:XrayLog = new XrayLog();
		
		public function ContentClip()
		{
			super();
		}
		
		public function get lid():String
		{
			return _lid;
		}
		
		public function set lid(newVal:String):void
		{
			_lid = newVal;
		}
		
		public function get gid():String
		{
			return _gid;
		}
		
		public function set gid(newVal:String):void
		{
			_gid = newVal;
		}
		
		public function get ShowCoupon():String
		{
			return _ShowCoupon;
		}
		
		public function set ShowCoupon(newVal:String):void
		{
			_ShowCoupon = newVal;
		}		
		
		public function get googleMapsAPI():String
		{
			return _googleMapsAPI;
		}
		
		public function set googleMapsAPI(newVal:String):void
		{
			_googleMapsAPI = newVal;
			//_log.debug("content clip _googleMapsAPI :: " + _googleMapsAPI);
		}
		
		public function get couponLink():String
		{
			return _couponLink;
		}
		
		public function set couponLink(newVal:String):void
		{
			_couponLink = newVal;
		}
		
		public function get recommendationIndex():int
		{
			return _recommendationIndex;
		}
		
		public function get recommendationCount():int
		{
			return _recommendationCount;
		}
		
		public function set serviceURL(newVal:String):void
		{
			_serviceURL = newVal;
			init();
		}
		
		public function set privacyPolicyURL(newVal:String):void
		{
			recommendationsClip.privacyPolicyURL = newVal;
		}
		
		public function set xmlData(newVal:XML):void
		{
			summaryClip.xmlData = newVal;
			recommendationsClip.xmlData = newVal;
		}
		
		private function init():void
		{
			_recommender = new Recomender(_serviceURL);
			recommendationsClip.addEventListener(RecommendationsClip.INDEX_CHANGE, updateIndex);
			_currentClip = introClip;
			_currentClip.addEventListener(ContentBase.ENABLE_NEXT, enableNextButton);
			_currentClip.addEventListener(ContentBase.SHOW_NEXT, showNext);
			_currentClip.recommender = _recommender;
			_currentClip.init();
		}
		
		public function updateView(index:int):void
		{
			_previousClip = _currentClip;
			_previousClip.removeEventListener(ContentBase.ENABLE_NEXT, enableNextButton);
			_previousClip.removeEventListener(ContentBase.SHOW_NEXT, showNext);
			_previousClip.disable();
			switch(index)
			{
				// ABOUT //
				case 1:
					_currentClip = ageClip;
					_trackingUtil.trackPageView("AGE RANGE");
					break;
				case 2:
					_currentClip = genderClip;
					_trackingUtil.trackPageView("GENDER");
					break;
				case 3:
					_currentClip = zipClip;
					zipClip.addEventListener(ZipClip.ENTER_KEY, propogateEvent);
					_trackingUtil.trackPageView("ZIP CODE");
					break;
				// LIFE_STYLE //
				case 4:
					_currentClip = whereClip;
					_trackingUtil.trackPageView("INDOORS VS OUT");
					break;
				case 5:
					_currentClip = indoorOutdoorClip;
					_trackingUtil.trackPageView("SAME PAIR");
					break;
				case 6:
					_currentClip = howMuchClip;
					_trackingUtil.trackPageView("TIME SPENT");
					break;
				case 7:
					_currentClip = whatKindClip;
					_trackingUtil.trackPageView("EYEWARE");
					break;
				case 8:
					_currentClip = featuresClip;
					_trackingUtil.trackPageView("FEATURES");
					break;
				// EYE_CARE //
				case 9:
					_currentClip = lightSensitiveClip;
					_trackingUtil.trackPageView("GLARE/REFLECTIONS");
					break;
				case 10:
					_currentClip = nightDrivingClip;
					_trackingUtil.trackPageView("EYE STRAIN");
					break;
				case 11:
					_currentClip = correctiveVisionClip;
					_trackingUtil.trackPageView("CORRECTIVE VISION");
					break;
				case 12:
					_currentClip = visionTypeClip;
					_trackingUtil.trackPageView("NEAR/FAR");
					break;
				// LEISURE //
				case 13:
					_currentClip = leisureActivitiesClip;
					_trackingUtil.trackPageView("ACTIVITY ENJOYED");
					break;
				// SUMMARY //
				case 14:
					_currentClip = summaryClip;
					_trackingUtil.trackPageView("SUMMARY");
					break;
				// RECOMMENDATIONS //
				case 15:
					_currentClip = recommendationsClip;
					recommendationsClip.selectedType = summaryClip.selectedType;
					recommendationsClip.googleMapsAPI = _googleMapsAPI;
					recommendationsClip.couponLink = _couponLink;
					recommendationsClip.ShowCoupon = _ShowCoupon;
					switch(summaryClip.selectedType)
					{
						case SummaryClipContent.PRIMARY:
							_trackingUtil.trackPageView("PRIMARY RECOMMENDATION");
							break;
						case SummaryClipContent.COMPLEMENTARY:
							_trackingUtil.trackPageView("COMPLEMENTARY RECOMMENDATION");
							break;
						case SummaryClipContent.SPECIALITY:
							_trackingUtil.trackPageView("SPECIALTY RECOMMENDATION");
							break;
					}
					break;
			}
			if(index != 3 && zipClip.hasEventListener(ZipClip.ENTER_KEY))
			{
				zipClip.removeEventListener(ZipClip.ENTER_KEY, propogateEvent);
			}
			_currentClip.recommender = _recommender;
			_currentClip.lid = _lid;
			_currentClip.gid = _gid;
			_currentClip.addEventListener(ContentBase.ENABLE_NEXT, enableNextButton);
			_currentClip.addEventListener(ContentBase.SHOW_NEXT, showNext);
		}
		
		public function slideLeftIn():void
		{
			var newX:int = 0;
			Tweener.addTween(_currentClip, {delay:.50, x:newX, alpha:1, time:.5, transition:"easeOutCubic", onComplete:initContent});
		}
		
		public function slideLeftOut():void
		{
			var newX:int = -guideClip.width;
			Tweener.addTween(_previousClip, {x:newX, alpha:0, time:.5, transition:"easeInCubic"});
		}
		
		public function slideRightIn():void
		{
			var newX:int = 0;
			Tweener.addTween(_currentClip, {delay:.50, x:newX, alpha:1, time:.5, transition:"easeOutCubic", onComplete:initContent});
		}
		
		public function slideRightOut():void
		{
			var newX:int = guideClip.width;
			Tweener.addTween(_previousClip, {x:newX, alpha:0, time:.5, transition:"easeInCubic"});
		}
		
		private function initContent():void
		{
			_currentClip.init();
		}
		
		private function enableNextButton(e:Event):void
		{
			dispatchEvent(new Event(ContentBase.ENABLE_NEXT));
		}
		
		private function showNext(e:Event):void
		{
			dispatchEvent(new Event(ContentBase.SHOW_NEXT));
		}
		
		private function updateIndex(e:Event):void
		{
			_recommendationIndex = recommendationsClip.index;
			_recommendationCount = recommendationsClip.count;
			dispatchEvent(new Event(RecommendationsClip.INDEX_CHANGE));
		}
		
		private function propogateEvent(e:Event):void
		{
			dispatchEvent(e);
		}
	}
}