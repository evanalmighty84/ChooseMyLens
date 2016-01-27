package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import caurina.transitions.Tweener;
	import com.hoya.util.TrackingUtil;
	import com.blitzagency.xray.logger.XrayLog;
	import flash.display.SimpleButton;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;	
	
	public class RecommendationsClip extends ContentBase
	{	
		public static const INDEX_CHANGE:String = "Index Change";
		private var _enableComplementary:Boolean = true;
		private var _enableSpecialty:Boolean = true;
		private var _previousClip:MovieClip;
		private var _currentClip:MovieClip;
		private var _index:int = 1;
		private var _count:int = 0;
		private var _xmlData:XML;
		public var selectedType:String;
		public var googleMapsAPI:String;
		private var _trackingUtil:TrackingUtil = TrackingUtil.getInstance();
		//private var _log:XrayLog = new XrayLog();
		
		public var ShowCoupon:String;
		public var couponButton:SimpleButton;
		public var couponLink:String;

		public function RecommendationsClip()
		{
			super();
		}
		
		override public function init():void
		{
			super.init();
			recommender.BuildRecs();
			recommender.FinalizeRecomendations();
			couponButton.visible = false;
			
			//Primary
			//recommender.buildTestData1();
			
			//Primary/Complementary
			//recommender.buildTestData2();
			
			//Primary/Specialty
			//recommender.buildTestData3();
			
			//Primary/Complementary/Specialty
			//trace("TODO :: Remove recommendations hack");
			//recommender.buildTestData4();
			
			emailClip.recommender = recommender;
			emailClip.xmlData = _xmlData;
			emailClip.lid = lid;
			emailClip.gid = gid;
			emailClip.googleMapsAPI = googleMapsAPI;
			//_log.debug("RecommendationsClip googleMapsAPI :: " + googleMapsAPI);
			emailClip.init();
			primaryClip.mouseEnabled = false;
			primaryClip.mouseChildren = false;
			primaryClip.lens = recommender.Primary;
			primaryClip.xmlData = _xmlData;
			primaryClip.init();
			_count++;
			complementaryClip.mouseEnabled = false;
			complementaryClip.mouseChildren = false;
			if(recommender.Secondary)
			{

				complementaryClip.lens = recommender.Secondary;
				complementaryClip.xmlData = _xmlData;
				complementaryClip.init();
				_count++;
			}
			else
			{
				_enableComplementary = false;
			}
			specialtyClip.mouseEnabled = false;
			specialtyClip.mouseChildren = false;
			if(recommender.Specialty)
			{
				specialtyClip.recommender = recommender;
				specialtyClip.xmlData = _xmlData;
				specialtyClip.init();
				_count++;
			}
			else
			{
				_enableSpecialty = false;
			}
			if(selectedType == SummaryClipContent.PRIMARY)
			{
				_currentClip = primaryClip;
			}
			else if(selectedType == SummaryClipContent.COMPLEMENTARY)
			{
				_currentClip = complementaryClip;
				_index = 2;
			}
			else if(selectedType == SummaryClipContent.SPECIALITY)
			{
				_currentClip = specialtyClip;
				if(_count == 2)
				{
					_index = 2;
				}
				else if(_count == 3)
				{
					_index = 3;
				}
			}
			setupTabButtons();
			dispatchEvent(new Event(INDEX_CHANGE));
		}
		
		public function set privacyPolicyURL(newVal:String):void
		{
			emailClip.privacyPolicyURL = newVal;
		}
		
		public function set xmlData(newVal:XML):void
		{
			_xmlData = newVal;
		}
		
		public function get index():int
		{
			return _index;
		}
		
		public function get count():int
		{
			return _count;
		}
		
		override public function playIntro():void
		{
			super.playIntro();
			this.play();
			animationClip.play();
		}
		
		private function setupTabButtons():void
		{
			var buttonArray:Array = new Array("PRIMARY");
			
			if(_enableComplementary)
			{	buttonArray.push("COMPLEMENTARY");
				if(_enableSpecialty)
				{
					buttonArray.push("SPECIALTY");
				}
				else
				{
					buttonArray.push(null);
				}
			}
			else if(_enableSpecialty)
			{
				buttonArray.push("SPECIALTY");
				buttonArray.push(null);
			}
			else
			{
				buttonArray.push(null);
				buttonArray.push(null);
			}
			tabButtonClip.setupButtons(buttonArray, _index);
		}
		
		private function playTabAnimation():void
		{
			if(_enableComplementary && _enableSpecialty)
			{
				thirdTab.play();
			}
			else if(_enableComplementary || _enableSpecialty)
			{
				secondTab.play();
			}
		}
		
		private function introComplete():void
		{
			showClip(_currentClip, showIntialContentComplete);
		}
		
		private function showIntialContentComplete():void
		{
			if(ShowCoupon.toLowerCase() == "true"){
				couponButton.visible = true;
			}
			
			couponButton.addEventListener(MouseEvent.CLICK, couponClick);

			tabButtonClip.addEventListener(TabButtonClip.BUTTON_CLICK, updateView);
			tabButtonClip.enable();
			emailClip.addEventListener(EmailClip.BACK_CLICK, hideModal);
			emailButton.useHandCursor = true;
			emailButton.addEventListener(MouseEvent.CLICK, showModal);
			enable();
		}
		
		override public function enable():void
		{
			super.enable();
		}
		
		private function updateView(e:Event):void
		{
			_previousClip = _currentClip;
			switch(tabButtonClip.selected)
			{
				case TabButtonClip.PRIMARY:
					_index = 1;
					_currentClip = primaryClip;
					_trackingUtil.trackPageView("PRIMARY RECOMMENDATION");
					break;
				case TabButtonClip.COMPLEMENTARY:
					_index = 2;
					_currentClip = complementaryClip;
					_trackingUtil.trackPageView("COMPLEMENTARY RECOMMENDATION");
					break;
				case TabButtonClip.SPECIALTY:
					if(_enableComplementary && _enableSpecialty)
					{
						_index = 3;
					}
					else
					{
						_index = 2;
					}
					
					_currentClip = specialtyClip;
					_trackingUtil.trackPageView("SPECIALTY RECOMMENDATION");
					break;
			}
			dispatchEvent(new Event(INDEX_CHANGE));
			hideClip(_previousClip, showCurrentClip);
		}
		
		private function showCurrentClip():void
		{
			showClip(_currentClip);
		}
		
		private function showClip(clip:MovieClip, callback:Function = null):void
		{
			clip.mouseEnabled = true;
			clip.mouseChildren = true;
			Tweener.addTween(clip, {alpha:1, time:.5, transition:"linear", onComplete:callback});
		}
		
		private function hideClip(clip:MovieClip, callback:Function = null):void
		{
			clip.mouseEnabled = false;
			clip.mouseChildren = false;
			Tweener.addTween(clip, {alpha:0, time:.5, transition:"linear", onComplete:callback});
		}
		
		private function showModal(e:Event):void
		{
			recommender.BuildRecs();
			recommender.FinalizeRecomendations();
			emailClip.enable();
			emailClip.mouseEnabled = true;
			emailClip.mouseChildren = true;
			Tweener.addTween(emailClip, {scaleX:1, scaleY:1, x:14, y:25, alpha:1, time:.75, transition:"easeInExpo"});
		}
		
		private function hideModal(e:Event):void
		{
			emailClip.mouseEnabled = false;
			emailClip.mouseChildren = false;
			Tweener.addTween(emailClip, {scaleX:.65, scaleY:.65, x:330, y:135, alpha:0, time:.75, transition:"easeInExpo"});
		}
		
		public function couponClick(e:MouseEvent):void{
			var request:URLRequest = new URLRequest(couponLink);
			try {
				navigateToURL(request, '_blank');
			} catch (e:Error) {
				//trace("Error: View Policy Link");
			}			
		}
	}
}