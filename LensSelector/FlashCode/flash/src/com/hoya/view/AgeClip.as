package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import fl.motion.Color;
	
	public class AgeClip extends ContentBase
	{	
		private var _currentIndex:int = 0;
	
		public function AgeClip()
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
			barShadow.play();
			barOverlay.play();
		}
		
		private function introComplete():void
		{
			enable();
			dragClip.buttonMode = true;
			dragClip.useHandCursor = true;
			dragClip.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			dragClip.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			recommender.AnswerQuestion1(18);
			enableNext();
		}
		
		override public function enable():void
		{
			super.enable();			
		}
		
		private function beginDrag(e:MouseEvent):void
		{
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, updateDrag);
			stage.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			var rectangle:Rectangle = new Rectangle(717, 153, 0, 292);
			dragClip.startDrag(false, rectangle);
		}
		
		private function endDrag(e:MouseEvent):void
		{
			dragClip.stopDrag();
			evalDrag();
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, updateDrag);
			stage.removeEventListener(MouseEvent.MOUSE_UP, endDrag);
			var age:int = 18;
			switch(_currentIndex)
			{
				case 0:
					age = 18;
					break;
				case 1:
					age = 19;
					break;
				case 2:
					age = 24;
					break;
				case 3:
					age = 30;
					break;
				case 4:
					age = 40;
					break;
				case 5:
					age = 50;
					break;
				case 6:
					age = 60;
					break;
				case 7:
					age = 70;
					break;
				case 8:
					age = 80;
					break;
/*				case 9:
					age = 55;
					break;
				case 10:
					age = 60;
					break;
				case 11:
					age = 65;
					break;
				case 12:
					age = 70;
					break;
				case 13:
					age = 75;
					break;
				case 14:
					age = 80;
					break;*/
			}
			recommender.AnswerQuestion1(age);
		}
		
		private function evalDrag():void
		{
			maskClip.y = dragClip.y;
			var labelClip:MovieClip = this.getChildByName("label" + _currentIndex) as MovieClip;
			unhighlightClip(labelClip);
			for(var i:int = 0; i < 10; i++)
			{
				var tickClip:MovieClip = this.getChildByName("tick" + i) as MovieClip;
				if(dragClip.y >= tickClip.y)
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
			maskClip.y = dragClip.y;
			evalDrag();
			e.updateAfterEvent();
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