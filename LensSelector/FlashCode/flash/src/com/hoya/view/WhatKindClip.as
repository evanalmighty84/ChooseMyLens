package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class WhatKindClip extends ContentBase
	{	
		public function WhatKindClip()
		{
			super();
		}
		
		override public function init():void
		{
			super.init();
		}
		
		override public function playIntro():void
		{
			super.playIntro();
			this.play();
		}
		
		private function introComplete():void
		{
			singleVision.addEventListener(CheckboxClip.BUTTON_CLICKED, evalAnswers);
			progressive.addEventListener(CheckboxClip.BUTTON_CLICKED, evalAnswers);
			bifocal.addEventListener(CheckboxClip.BUTTON_CLICKED, evalAnswers);
			contacts.addEventListener(CheckboxClip.BUTTON_CLICKED, evalAnswers);
			none.addEventListener(CheckboxClip.BUTTON_CLICKED, evalAnswers);
			enable();
		}
		
		private function evalAnswers(e:Event):void
		{
			if(e.currentTarget == none)
			{
				if(none.selected)
				{
					singleVision.deselect();
					progressive.deselect();
					bifocal.deselect();
					contacts.deselect();
				}
			}
			else if(none.selected)
			{
				none.deselect();
			}
			recommender.AnswerQuestion7(singleVision.selected, progressive.selected, bifocal.selected, contacts.selected, none.selected);
			enableNext();
		}
		
		override public function enable():void
		{
			super.enable();
		}
	}
}