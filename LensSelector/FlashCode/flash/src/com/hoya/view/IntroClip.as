package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import recomendations.Recomender;
	
	public class IntroClip extends ContentBase
	{	
		public function IntroClip()
		{
			super();
		}
		
		override public function init():void
		{
			super.init();
			this.play();
		}
		
		private function introComplete():void
		{
			enableNext();
			introButton.addEventListener(MouseEvent.CLICK, showNext);
		}
		
		override public function showNext(e:Event = null):void
		{
			recommender.AnswerQuestion9(true);
			super.showNext();
		}
	}
}