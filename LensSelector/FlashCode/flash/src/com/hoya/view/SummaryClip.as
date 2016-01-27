package com.hoya.view
{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import caurina.transitions.Tweener;
	
	public class SummaryClip extends ContentBase
	{	
		private var _xmlData:XML;
		private var _enableComplementary:Boolean = false;
		private var _enableSpecialty:Boolean = false;
		public var selectedType:String;
		
		public function SummaryClip()
		{
			super();
		}
		
		override public function init():void
		{
			super.init();
			recommender.BuildRecs();
			recommender.FinalizeRecomendations();
			
			//Primary
			//recommender.buildTestData1();
			
			//Primary/Complementary
			//recommender.buildTestData2();
			
			//Primary/Specialty
			//recommender.buildTestData3();
			
			//Primary/Complementary/Specialty
			//recommender.buildTestData4();
			
			primaryClip.xmlData = _xmlData;
			primaryClip.init(SummaryClipContent.PRIMARY);
			primaryClip.addEventListener(SummaryClipContent.SHOW_RECOMMENDATION, onRecommendationClick);
			animationClip1.play();
			if(recommender.Secondary)
			{
				_enableComplementary = true;
				
				complementaryClip.xmlData = _xmlData;
				complementaryClip.init(SummaryClipContent.COMPLEMENTARY);
				complementaryClip.addEventListener(SummaryClipContent.SHOW_RECOMMENDATION, onRecommendationClick);
			}
			
			if(recommender.Specialty)
			{
				_enableSpecialty = true;
				specialtyClip.xmlData = _xmlData;
				specialtyClip.init(SummaryClipContent.SPECIALITY, recommender.specialtyType);
				specialtyClip.addEventListener(SummaryClipContent.SHOW_RECOMMENDATION, onRecommendationClick);
			}
			
			if(_enableComplementary && _enableSpecialty)
			{
				animationClip2.play();
				animationClip3.play();
			}
			else if(_enableComplementary && !_enableSpecialty)
			{
				animationClip2.play();
				Tweener.addTween(animationClip3, {alpha:.25, time:.5, transition:"linear"});
			}
			else if(!_enableComplementary && _enableSpecialty)
			{
				animationClip2.play();
				specialtyClip.x = complementaryClip.x;
				specialtyClip.y = complementaryClip.y;
				Tweener.addTween(animationClip3, {alpha:.25, time:.5, transition:"linear"});
			}
			else
			{
				Tweener.addTween(animationClip2, {alpha:.25, time:.5, transition:"linear"});
				Tweener.addTween(animationClip3, {alpha:.25, time:.5, transition:"linear"});
			}			
		}
		
		override public function playIntro():void
		{
			super.playIntro();
			this.play();
		}
		
		
		private function introComplete():void
		{			
			Tweener.addTween(primaryClip, {alpha:1, time:.5, transition:"linear", onComplete:enable});
			if(_enableComplementary)
			{
				Tweener.addTween(complementaryClip, {alpha:1, time:.5, transition:"linear"});
			}
			
			if(_enableSpecialty)
			{
				Tweener.addTween(specialtyClip, {alpha:1, time:.5, transition:"linear"});
			}
		}
		
		override public function enable():void
		{
			super.enable();
			primaryClip.enable();
			if(_enableComplementary)
			{
				complementaryClip.enable();
			}
			
			if(_enableSpecialty)
			{
				specialtyClip.enable();
			}
		}
		
		public function set xmlData(newVal:XML):void
		{
			_xmlData = newVal;
		}
		
		private function onRecommendationClick(e:Event):void
		{
			if(e.currentTarget == primaryClip)
			{
				selectedType = SummaryClipContent.PRIMARY;
			}
			else if(e.currentTarget == complementaryClip)
			{
				selectedType = SummaryClipContent.COMPLEMENTARY;
			}
			else if(e.currentTarget == specialtyClip)
			{
				selectedType = SummaryClipContent.SPECIALITY;
			}
			showNext();
		}
	}
}