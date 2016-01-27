package com.hoya.view
{
	import fl.motion.Color;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;
	
	
	public class GenderClip extends ContentBase
	{
		private var _selectedButton:MovieClip;
		
		public function GenderClip()
		{
			super();
			ColorShortcuts.init();
		}
		
		override public function init():void
		{
			super.init();
		}
		
		override public function playIntro():void
		{
			super.playIntro();
			this.play();
			maleShadow.play();
			maleOverlay.play();
		}
		
		private function startFemale():void
		{
			femaleShadow.play();
			femaleOverlay.play();
		}
		
		private function introComplete():void
		{
			maleButton.buttonMode = true;
			maleButton.useHandCursor = true;
			maleButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			maleButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			maleButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			
			femaleButton.buttonMode = true;
			femaleButton.useHandCursor = true;
			femaleButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			femaleButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			femaleButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			enable();
		}
		
		override public function enable():void
		{
			super.enable();
		}
		
		private function evalClip(buttonClip:MovieClip):MovieClip
		{
			var clip:MovieClip
			if(buttonClip.name == "maleButton")
			{
				clip = maleOverlay;
			}
			else if(buttonClip.name == "femaleButton")
			{
				clip = femaleOverlay;
			}
			return clip;
		}
		
		private function evalLabel(buttonClip:MovieClip):MovieClip
		{
			var clip:MovieClip
			if(buttonClip.name == "maleButton")
			{
				clip = maleLabel;
			}
			else if(buttonClip.name == "femaleButton")
			{
				clip = femaleLabel;
			}
			return clip;
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			var clip:MovieClip = e.currentTarget as MovieClip;
			if(clip != _selectedButton)
			{
				showOverState(evalClip(clip));
				highlightLabel(evalLabel(clip));
			}
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			var clip:MovieClip = e.currentTarget as MovieClip;
			if(clip != _selectedButton)
			{
				showUpState(evalClip(clip));
				unhighlightLabel(evalLabel(clip));
			}
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			maleButton.mouseEnabled = true;
			femaleButton.mouseEnabled = true;
			_selectedButton = e.currentTarget as MovieClip;
			_selectedButton.mouseEnabled = false;
			showSelectedState(evalClip(_selectedButton));
			toggleButton(evalClip(_selectedButton));
			answerQuestion();
			showNext();
		}
		
		private function showUpState(clip:MovieClip):void
		{
			Tweener.addTween(clip, {_brightness:0, time:.5, transition:"easeInitCubic"});
		}
		
		private function showOverState(clip:MovieClip):void
		{
			Tweener.addTween(clip, {_brightness:-.9, time:.5, transition:"easeInitCubic"});
		}
		
		private function showSelectedState(clip:MovieClip):void
		{
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.color = 0x0177c1;
			Tweener.addTween(clip, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
		}
		
		private function toggleButton(clip:MovieClip):void
		{
			var colorTransform:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
			if(clip == maleOverlay)
			{
				unhighlightLabel(femaleLabel);
				Tweener.addTween(femaleOverlay, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
			}
			else if(clip == femaleOverlay)
			{
				unhighlightLabel(maleLabel);
				Tweener.addTween(maleOverlay, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
			}
		}
		
		private function highlightLabel(clip:MovieClip):void
		{
			var tint:Color = new Color();
			tint.setTint(0x0177C1, 1);
			clip.transform.colorTransform = tint;
		}
		
		private function unhighlightLabel(clip:MovieClip):void
		{
			var tint:Color = new Color();
			tint.setTint(0x0177C1, 0);
			clip.transform.colorTransform = tint;
		}
		
		private function answerQuestion():void
		{
			if(_selectedButton == maleButton)
			{
				recommender.AnswerQuestion2(true);
			}
			else
			{
				recommender.AnswerQuestion2(false);
			}
		}
	}
}