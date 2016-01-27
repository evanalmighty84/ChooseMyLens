package com.hoya.view
{
	import fl.motion.Color;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;
	
	public class LeisureActivitiesClip extends ContentBase
	{	
		private var _selectedButton:MovieClip;
		
		public function LeisureActivitiesClip()
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
			buttonsOverlay.play();
			buttonsShadow.play();
		}
		
		private function introComplete():void
		{
			bikingButton.buttonMode = true;
			bikingButton.useHandCursor = true;
			bikingButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			bikingButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			bikingButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			boatingButton.buttonMode = true;
			boatingButton.useHandCursor = true;
			boatingButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			boatingButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			boatingButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			fishingButton.buttonMode = true;
			fishingButton.useHandCursor = true;
			fishingButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			fishingButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			fishingButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			huntingButton.buttonMode = true;
			huntingButton.useHandCursor = true;
			huntingButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			huntingButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			huntingButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			hikingButton.buttonMode = true;
			hikingButton.useHandCursor = true;
			hikingButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			hikingButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			hikingButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			golfingButton.buttonMode = true;
			golfingButton.useHandCursor = true;
			golfingButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			golfingButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			golfingButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			runningButton.buttonMode = true;
			runningButton.useHandCursor = true;
			runningButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			runningButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			runningButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			skiingButton.buttonMode = true;
			skiingButton.useHandCursor = true;
			skiingButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			skiingButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			skiingButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			tennisButton.buttonMode = true;
			tennisButton.useHandCursor = true;
			tennisButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			tennisButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			tennisButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			noneButton.buttonMode = true;
			noneButton.useHandCursor = true;
			noneButton.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			noneButton.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			noneButton.addEventListener(MouseEvent.CLICK, onMouseClick);
			enable();
		}
		
		override public function enable():void
		{
			super.enable();
		}
		
		private function evalClip(buttonClip:MovieClip):MovieClip
		{
			var clip:MovieClip
			if(buttonClip)
			{
				if(buttonClip.name == "bikingButton")
				{
					clip = bikingOverlay;
				}
				else if(buttonClip.name == "boatingButton")
				{
					clip = boatingOverlay;
				}
				else if(buttonClip.name == "fishingButton")
				{
					clip = fishingOverlay;
				}
				else if(buttonClip.name == "huntingButton")
				{
					clip = huntingOverlay;
				}
				else if(buttonClip.name == "hikingButton")
				{
					clip = hikingOverlay;
				}
				else if(buttonClip.name == "golfingButton")
				{
					clip = golfingOverlay;
				}
				else if(buttonClip.name == "runningButton")
				{
					clip = runningOverlay;
				}
				else if(buttonClip.name == "skiingButton")
				{
					clip = skiingOverlay;
				}
				else if(buttonClip.name == "tennisButton")
				{
					clip = tennisOverlay;
				}
				else if(buttonClip.name == "noneButton")
				{
					clip = noneOverlay;
				}
			}
			return clip;
		}
		
		private function evalLabel(buttonClip:MovieClip):MovieClip
		{
			var clip:MovieClip
			if(buttonClip)
			{
				if(buttonClip.name == "bikingButton")
				{
					clip = bikingLabel;
				}
				else if(buttonClip.name == "boatingButton")
				{
					clip = boatingLabel;
				}
				else if(buttonClip.name == "fishingButton")
				{
					clip = fishingLabel;
				}
				else if(buttonClip.name == "huntingButton")
				{
					clip = huntingLabel;
				}
				else if(buttonClip.name == "hikingButton")
				{
					clip = hikingLabel;
				}
				else if(buttonClip.name == "golfingButton")
				{
					clip = golfingLabel;
				}
				else if(buttonClip.name == "runningButton")
				{
					clip = runningLabel;
				}
				else if(buttonClip.name == "skiingButton")
				{
					clip = skiingLabel;
				}
				else if(buttonClip.name == "tennisButton")
				{
					clip = tennisLabel;
				}
				else if(buttonClip.name == "noneButton")
				{
					clip = noneLabel;
				}
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
			bikingButton.mouseEnabled = true;
			boatingButton.mouseEnabled = true;
			fishingButton.mouseEnabled = true;
			huntingButton.mouseEnabled = true;
			hikingButton.mouseEnabled = true;
			golfingButton.mouseEnabled = true;
			runningButton.mouseEnabled = true;
			skiingButton.mouseEnabled = true;
			tennisButton.mouseEnabled = true;
			noneButton.mouseEnabled = true;
			toggleButton(evalLabel(_selectedButton), evalClip(_selectedButton));
			_selectedButton = e.currentTarget as MovieClip;
			_selectedButton.mouseEnabled = false;
			showSelectedState(evalClip(_selectedButton));
			highlightLabel(evalLabel(_selectedButton));
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
		
		private function toggleButton(labelClip:MovieClip, overlayClip:MovieClip):void
		{			
			if(labelClip)
			{
				unhighlightLabel(labelClip);
			}
			
			if(overlayClip)
			{
				var colorTransform:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
				Tweener.addTween(overlayClip, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
			}
		}
		
		private function highlightLabel(clip:MovieClip):void
		{
			var tint:Color = new Color();
			tint.setTint(0xFFFFFF, 1);
			clip.transform.colorTransform = tint;
		}
		
		private function unhighlightLabel(clip:MovieClip):void
		{
			var tint:Color = new Color();
			tint.setTint(0xFFFFFF, 0);
			clip.transform.colorTransform = tint;
		}
		
		private function answerQuestion():void
		{
			var val:String;
			if(_selectedButton == bikingButton)
			{
				val = "Biking";
			}
			else if(_selectedButton == boatingButton)
			{
				val = "Boating";
			}
			else if(_selectedButton == fishingButton)
			{
				val = "Fishing";
			}
			else if(_selectedButton == huntingButton)
			{
				val = "Hunting";
			}
			else if(_selectedButton == hikingButton)
			{
				val = "Hiking";
			}
			else if(_selectedButton == golfingButton)
			{
				val = "Golfing";
			}
			else if(_selectedButton == runningButton)
			{
				val = "Running";
			}
			else if(_selectedButton == skiingButton)
			{
				val = "Skiing";
			}
			else if(_selectedButton == tennisButton)
			{
				val = "Tennis";
			}
			else if(_selectedButton == noneButton)
			{
				val = "None";
			}
			recommender.AnswerQuestion14(val);
		}
	}
}