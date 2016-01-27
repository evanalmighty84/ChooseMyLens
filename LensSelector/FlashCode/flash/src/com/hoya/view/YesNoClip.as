package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;
	
	public class YesNoClip extends MovieClip
	{	
		public static const YES_NO_CLICK:String = "Yes No Click";
		private var _selectedButton:MovieClip;
		public var yesOverlay:MovieClip;
		public var noOverlay:MovieClip;
		
		
		public function YesNoClip()
		{
			super();
			ColorShortcuts.init();
			yesButton.buttonMode = true;
			yesButton.useHandCursor = true;
			yesButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			yesButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			yesButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			noButton.buttonMode = true;
			noButton.useHandCursor = true;
			noButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			noButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			noButton.addEventListener(MouseEvent.CLICK, onMouseClick);
		}
		
		public function get selectedValue():Boolean
		{
			var val:Boolean;
			if(_selectedButton.name == "yesButton")
			{
				val = true;
			}
			else if(_selectedButton.name == "noButton")
			{
				val = false;
			}
			return val;
		}
		
		private function evalClip(buttonClip:MovieClip):MovieClip
		{
			var clip:MovieClip
			if(buttonClip.name == "yesButton")
			{
				clip = yesOverlay;
			}
			else if(buttonClip.name == "noButton")
			{
				clip = noOverlay;
			}
			return clip;
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			var clip:MovieClip = e.currentTarget as MovieClip;
			if(clip != _selectedButton)
			{
				showOverState(evalClip(clip));
			}
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			var clip:MovieClip = e.currentTarget as MovieClip;
			if(clip != _selectedButton)
			{
				showUpState(evalClip(clip));
			}
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			yesButton.mouseEnabled = true;
			noButton.mouseEnabled = true;
			_selectedButton = e.currentTarget as MovieClip;
			_selectedButton.mouseEnabled = false;
			showSelectedState(evalClip(_selectedButton));
			toggleButton(evalClip(_selectedButton));
			dispatchEvent(new Event(YES_NO_CLICK));
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
			if(clip == yesOverlay)
			{
				Tweener.addTween(noOverlay, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
			}
			else if(clip == noOverlay)
			{
				Tweener.addTween(yesOverlay, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
			}
		}
	}
}