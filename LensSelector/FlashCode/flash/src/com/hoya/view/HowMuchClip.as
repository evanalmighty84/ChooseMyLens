package com.hoya.view
{
	import fl.motion.Color;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.geom.ColorTransform;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;
	
	public class HowMuchClip extends ContentBase
	{	
	
		private var _dragClip:MovieClip;
		private var _maskClip:MovieClip;
		private var _currentBar:MovieClip;
		private var _currentLabel:MovieClip;
		private var _currentIndex:int = 0;
		private var _computer:int = 0;
		private var _television:int = 0;
		private var _reading:int = 0;
		private var _driving:int = 0;
		private var _sports:int = 0;
		private var _arts:int = 0;
		
		public function HowMuchClip()
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
			barOverlay.play();
			barShadow.play();
			this.play();
		}
		
		private function introComplete():void
		{
			enable();
			Tweener.addTween(dragClip0.dragLabel, {alpha:1, time:.5, transition:"linear"});
			Tweener.addTween(dragClip0.nub, {alpha:1, time:.5, transition:"linear"});
			dragClip0.buttonMode = true;
			dragClip0.useHandCursor = true;
			dragClip0.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			dragClip0.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			dragClip0.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			dragClip0.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			
			Tweener.addTween(dragClip1.dragLabel, {alpha:1, time:.5, transition:"linear"});
			Tweener.addTween(dragClip1.nub, {alpha:1, time:.5, transition:"linear"});
			dragClip1.buttonMode = true;
			dragClip1.useHandCursor = true;
			dragClip1.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			dragClip1.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			dragClip1.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			dragClip1.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			
			Tweener.addTween(dragClip2.dragLabel, {alpha:1, time:.5, transition:"linear"});
			Tweener.addTween(dragClip2.nub, {alpha:1, time:.5, transition:"linear"});
			dragClip2.buttonMode = true;
			dragClip2.useHandCursor = true;
			dragClip2.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			dragClip2.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			dragClip2.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			dragClip2.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			
			Tweener.addTween(dragClip3.dragLabel, {alpha:1, time:.5, transition:"linear"});
			Tweener.addTween(dragClip3.nub, {alpha:1, time:.5, transition:"linear"});
			dragClip3.buttonMode = true;
			dragClip3.useHandCursor = true;
			dragClip3.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			dragClip3.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			dragClip3.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			dragClip3.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			
			Tweener.addTween(dragClip4.dragLabel, {alpha:1, time:.5, transition:"linear"});
			Tweener.addTween(dragClip4.nub, {alpha:1, time:.5, transition:"linear"});
			dragClip4.buttonMode = true;
			dragClip4.useHandCursor = true;
			dragClip4.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			dragClip4.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			dragClip4.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			dragClip4.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			
			Tweener.addTween(dragClip5.dragLabel, {alpha:1, time:.5, transition:"linear"});
			Tweener.addTween(dragClip5.nub, {alpha:1, time:.5, transition:"linear"});
			dragClip5.buttonMode = true;
			dragClip5.useHandCursor = true;
			dragClip5.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			dragClip5.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			dragClip5.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			dragClip5.addEventListener(MouseEvent.MOUSE_UP, endDrag);
		}
		
		override public function enable():void
		{
			super.enable();
		}
		
		private function beginDrag(e:MouseEvent):void
		{
			enableNext();
			stage.addEventListener(MouseEvent.MOUSE_MOVE, updateDrag);
			stage.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			var rectangle:Rectangle = new Rectangle(176, _dragClip.y, 255, 0);
			_dragClip.startDrag(false, rectangle);
			//Tweener.addTween(_dragClip.dragLabel, {alpha:0, time:.5, transition:"linear"});
		}
		
		private function endDrag(e:MouseEvent):void
		{
			_dragClip.stopDrag();
			evalDrag();
			onMouseOut(e);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, updateDrag);
			stage.removeEventListener(MouseEvent.MOUSE_UP, endDrag);
			var hours:int = 0;
			switch(_currentIndex)
			{
				case 0:
					hours = 0;
					break;
				case 1:
					hours = 1;
					break;
				case 2:
					hours = 1;
					break;
				case 3:
					hours = 2;
					break;
				case 4:
					hours = 2;
					break;
				case 5:
					hours = 3;
					break;
				case 6:
					hours = 3;
					break;
				case 7:
					hours = 4;
					break;
				case 8:
					hours = 4;
					break;
				case 9:
					hours = 5;
					break;
				case 10:
					hours = 5;
					break;
				case 11:
					hours = 6;
					break;
				case 12:
					hours = 6;
					break;
				case 13:
					hours = 7;
					break;
				case 14:
					hours = 8;
					break;
			}
			
			switch(_dragClip)
			{
				case dragClip0:
						_computer = hours;
					break;
				case dragClip1:
						_television = hours;
					break;
				case dragClip2:
						_reading = hours;
					break;
				case dragClip3:
						_driving = hours;
					break;
				case dragClip4:
						_sports = hours;
					break;
				case dragClip5:
						_arts = hours;
					break;
			}
			recommender.AnswerQuestion6(_computer, _television, _reading, _driving, _sports, _arts);
		}
		
		private function evalDrag():void
		{
			_maskClip.width = (_dragClip.x + 25) - _maskClip.x;
			var labelClip:MovieClip = this.getChildByName("label" + _currentIndex) as MovieClip;
			unhighlightClip(labelClip);
			
			for(var i:int = 0; i < 16; i++)
			{
				var tickClip:MovieClip = this.getChildByName("tick" + i) as MovieClip;
				if((_dragClip.x + 25) <= tickClip.x)
				{
					if(i == 0)
					{
						_currentIndex = 0;
					}
					else
					{
						_currentIndex = i - 1;
					}
					highlightClip(this.getChildByName("label" + _currentIndex) as MovieClip);
					break;
				}
			}
		}
		
		private function updateDrag(e:MouseEvent):void
		{
			evalDrag();
			e.updateAfterEvent();
		}
		
		private function onMouseOver(e:MouseEvent = null):void
		{
			if(!e.buttonDown)
			{
				_dragClip = e.currentTarget as MovieClip;
				switch(_dragClip)
				{
					case dragClip0:
							_currentBar = this.getChildByName("bar" + 1) as MovieClip;
							_maskClip = this.getChildByName("maskClip" + 0) as MovieClip;
						break;
					case dragClip1:
							_currentBar = this.getChildByName("bar" + 2) as MovieClip;
							_maskClip = this.getChildByName("maskClip" + 1) as MovieClip;
						break;
					case dragClip2:
							_currentBar = this.getChildByName("bar" + 3) as MovieClip;
							_maskClip = this.getChildByName("maskClip" + 2) as MovieClip;
						break;
					case dragClip3:
							_currentBar = this.getChildByName("bar" + 4) as MovieClip;
							_maskClip = this.getChildByName("maskClip" + 3) as MovieClip;
						break;
					case dragClip4:
							_currentBar = this.getChildByName("bar" + 5) as MovieClip;
							_maskClip = this.getChildByName("maskClip" + 4) as MovieClip;
						break;
					case dragClip5:
							_currentBar = this.getChildByName("bar" + 6) as MovieClip;
							_maskClip = this.getChildByName("maskClip" + 5) as MovieClip;
						break;
				}
				evalDrag();
				var colorTransform:ColorTransform = new ColorTransform();
				colorTransform.color = 0x0177c1;
				Tweener.addTween(_currentBar, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
				Tweener.addTween(_dragClip.nub, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
			}
		}
		
		private function onMouseOut(e:MouseEvent = null):void
		{	
			var colorTransform:ColorTransform;
			if(!e.buttonDown && e.type == MouseEvent.MOUSE_OUT || e.currentTarget == stage)
			{
				var labelClip:MovieClip = this.getChildByName("label" + _currentIndex) as MovieClip;
				unhighlightClip(labelClip);
				colorTransform = new ColorTransform(.6, .6, .6, 1, 0, 0, 0, 0);
				Tweener.addTween(_currentBar, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
				Tweener.addTween(_dragClip.nub, {_colorTransform:new ColorTransform(), time:.5, transition:"easeInitCubic"});
			}
		}
		
		private function highlightClip(clip:MovieClip):void
		{
			var tint:Color = new Color();
			tint.setTint(0x0177C1, 1);
			clip.transform.colorTransform = tint;
		}
		
		private function unhighlightClip(clip:MovieClip):void
		{
			var tint:Color = new Color();
			tint.setTint(0x0177C1, 0);
			clip.transform.colorTransform = tint;
		}
	}
}