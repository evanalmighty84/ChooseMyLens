package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;
	
	public class VisionTypeClip extends ContentBase
	{	
		private var _selectedButton:MovieClip;
	
		public function VisionTypeClip()
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
			nearOverlay.play();
			nearShadow.play();
		}
		
		private function playFar():void
		{
			farOverlay.play();
			farShadow.play();
		}
		
		private function playBoth():void
		{
			bothOverlay.play();
			bothShadow.play();
		}
		
		private function introComplete():void
		{
			ColorShortcuts.init();
			nearToolTip.mouseEnabled = false;
			farToolTip.mouseEnabled = false;
			bothToolTip.mouseEnabled = false;
			
			nearButton.buttonMode = true;
			nearButton.useHandCursor = true;
			nearButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			nearButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			nearButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			farButton.buttonMode = true;
			farButton.useHandCursor = true;
			farButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			farButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			farButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			bothButton.buttonMode = true;
			bothButton.useHandCursor = true;
			bothButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			bothButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			bothButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			enable();
		}
		
		override public function enable():void
		{
			super.enable();
		}
		
		
		public function get selectedValue():String
		{
			var val:String;
			if(_selectedButton == nearButton)
			{
				val = "near";
			}
			else if(_selectedButton == farButton)
			{
				val = "far";
			}
			else if(_selectedButton == bothButton)
			{
				val = "both";
			}
			return val;
		}
		
		private function evalClip(buttonClip:MovieClip):MovieClip
		{
			var clip:MovieClip
			if(buttonClip == nearButton)
			{
				clip = nearOverlay;
			}
			else if(buttonClip == farButton)
			{
				clip = farOverlay;
			}
			else if(buttonClip == bothButton)
			{
				clip = bothOverlay;
			}
			return clip;
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			var clip:MovieClip = e.currentTarget as MovieClip;
			showToolTip(evalClip(clip));
			if(clip != _selectedButton)
			{
				showOverState(evalClip(clip));
			}
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			var clip:MovieClip = e.currentTarget as MovieClip;
			hideToolTip(evalClip(clip));
			if(clip != _selectedButton)
			{
				showUpState(evalClip(clip));
			}
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			nearButton.mouseEnabled = true;
			farButton.mouseEnabled = true;
			bothButton.mouseEnabled = true;
			_selectedButton = e.currentTarget as MovieClip;
			_selectedButton.mouseEnabled = false;
			showSelectedState(evalClip(_selectedButton));
			toggleButton(evalClip(_selectedButton));
			answerQuestion();
			showNext();
		}
		
		private function showToolTip(clip:MovieClip):void
		{
			var toolTip:MovieClip;
			if(clip == nearOverlay)
			{
				toolTip = nearToolTip;
			}
			else if(clip == farOverlay)
			{
				toolTip = farToolTip;
			}
			else if(clip == bothOverlay)
			{
				toolTip = bothToolTip;
			}
			Tweener.addTween(toolTip, {alpha:1, time:.25, transition:"linear"});
		}
		
		private function hideToolTip(clip:MovieClip):void
		{
			var toolTip:MovieClip;
			if(clip == nearOverlay)
			{
				toolTip = nearToolTip;
			}
			else if(clip == farOverlay)
			{
				toolTip = farToolTip;
			}
			else if(clip == bothOverlay)
			{
				toolTip = bothToolTip;
			}
			Tweener.addTween(toolTip, {alpha:0, time:.25, transition:"linear"});
		}
		
		private function answerQuestion():void
		{
			var val:int;
			if(_selectedButton == nearButton)
			{
				val = 0;
			}
			else if(_selectedButton == farButton)
			{
				val = 1;
			}
			else if(_selectedButton == bothButton)
			{
				val = 2;
			}
			recommender.AnswerQuestion12(val);
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
			if(clip == nearOverlay)
			{
				Tweener.addTween(farOverlay, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
				Tweener.addTween(bothOverlay, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
			}
			else if(clip == farOverlay)
			{
				Tweener.addTween(nearOverlay, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
				Tweener.addTween(bothOverlay, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
			}
			else if(clip == bothOverlay)
			{
				Tweener.addTween(nearOverlay, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
				Tweener.addTween(farOverlay, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
			}
		}
	}
}