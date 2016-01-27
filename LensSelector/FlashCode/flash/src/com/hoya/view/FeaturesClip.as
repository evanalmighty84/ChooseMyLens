package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import caurina.transitions.Tweener;
	
	public class FeaturesClip extends ContentBase
	{	
		
		private var _currentOverlay:MovieClip;
		private var _labelClip:MovieClip;
		private var _currentClip:MovieClip;
		
		public function FeaturesClip()
		{
			super();
		}
		
		override public function init():void
		{
			super.init();			
			labelClip1.txtField.text = "STYLE";
			labelClip2.txtField.text = "FRAME MATERIAL";
			labelClip3.txtField.text = "FIT";
			labelClip4.txtField.text = "DURABILITY";
			labelClip5.txtField.text = "LIGHT WEIGHT";
			labelClip6.txtField.text = "LENS TYPE";
			labelClip7.txtField.text = "LENS THINNESS";
			labelClip8.txtField.text = "LENS COLOR";
		}
		
		override public function playIntro():void
		{
			super.playIntro();
			this.play();
			barsShadow.play();
			barsOverlay.play();
		}
		
		private function introComplete():void
		{
			button1.buttonMode = true;
			button1.useHandCursor = true;
			button1.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			button1.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			button1.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			
			button2.buttonMode = true;
			button2.useHandCursor = true;
			button2.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			button2.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			button2.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			
			button3.buttonMode = true;
			button3.useHandCursor = true;
			button3.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			button3.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			button3.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			
			button4.buttonMode = true;
			button4.useHandCursor = true;
			button4.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			button4.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			button4.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			
			button5.buttonMode = true;
			button5.useHandCursor = true;
			button5.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			button5.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			button5.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			
			button6.buttonMode = true;
			button6.useHandCursor = true;
			button6.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			button6.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			button6.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			
			button7.buttonMode = true;
			button7.useHandCursor = true;
			button7.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			button7.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			button7.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			
			button8.buttonMode = true;
			button8.useHandCursor = true;
			button8.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			button8.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			button8.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);

			enable();
			answerQuestion();
			enableNext();
		}
		
		override public function enable():void
		{
			super.enable();
		}
		
		private function onMouseOver(e:MouseEvent):void
		{
			var clip:MovieClip = e.currentTarget as MovieClip;
			evalButton(clip);
			var colorTransform:ColorTransform = new ColorTransform(.6, .6, .6, 1, 0, 0, 0, 0);
			Tweener.addTween(_currentOverlay, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
		}
		
		private function onMouseOut(e:MouseEvent):void
		{
			var clip:MovieClip = e.currentTarget as MovieClip;
			evalButton(clip);
			var colorTransform:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 0);
			Tweener.addTween(_currentOverlay, {_colorTransform:colorTransform, time:.5, transition:"easeInitCubic"});
		}
		
		private function beginDrag(e:MouseEvent):void
		{
			if(!_currentClip)
			{
				var clip:MovieClip = e.currentTarget as MovieClip;
				evalButton(clip);
			}
			_labelClip = _currentClip;
			dragClip.x = _currentClip.x;
			dragClip.y = _currentClip.y;
			dragClip.txtField.text = _currentClip.txtField.text;
			dragClip.alpha = 1;
			var rectangle:Rectangle = new Rectangle(0, 0, this.width - dragClip.width, this.height - dragClip.height);
			stage.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			dragClip.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			dragClip.startDrag(false, rectangle);
		}
		
		private function endDrag(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_UP, endDrag);
			dragClip.removeEventListener(MouseEvent.MOUSE_UP, endDrag);
			dragClip.stopDrag();
			evalDrag();
			dragClip.alpha = 0;
			dragClip.x = 0;
			dragClip.y = 0;
			answerQuestion();
		}
		
		private function evalButton(clip:MovieClip):void
		{
			switch(clip)
			{
				case button1:
					_currentOverlay = overlayClip1;
					_currentClip = labelClip1;
					break;
				case button2:
					_currentOverlay = overlayClip2;
					_currentClip = labelClip2;
					break;
				case button3:
					_currentOverlay = overlayClip3;
					_currentClip = labelClip3;
					break;
				case button4:
					_currentOverlay = overlayClip4;
					_currentClip = labelClip4;
					break;
				case button5:
					_currentOverlay = overlayClip5;
					_currentClip = labelClip5;
					break;
				case button6:
					_currentOverlay = overlayClip6;
					_currentClip = labelClip6;
					break;
				case button7:
					_currentOverlay = overlayClip7;
					_currentClip = labelClip7;
					break;
				case button8:
					_currentOverlay = overlayClip8;
					_currentClip = labelClip8;
					break;
			}
		}
		
		private function evalDrag():void
		{
			if(dragClip.hitTestObject(button1))
			{
				_labelClip.txtField.text = labelClip1.txtField.text;
				labelClip1.txtField.text = dragClip.txtField.text;
			}
			else if(dragClip.hitTestObject(button2))
			{
				_labelClip.txtField.text = labelClip2.txtField.text;
				labelClip2.txtField.text = dragClip.txtField.text;
			}
			else if(dragClip.hitTestObject(button3))
			{
				_labelClip.txtField.text = labelClip3.txtField.text;
				labelClip3.txtField.text = dragClip.txtField.text;
			}
			else if(dragClip.hitTestObject(button4))
			{
				_labelClip.txtField.text = labelClip4.txtField.text;
				labelClip4.txtField.text = dragClip.txtField.text;
			}
			else if(dragClip.hitTestObject(button5))
			{
				_labelClip.txtField.text = labelClip5.txtField.text;
				labelClip5.txtField.text = dragClip.txtField.text;
			}
			else if(dragClip.hitTestObject(button6))
			{
				_labelClip.txtField.text = labelClip6.txtField.text;
				labelClip6.txtField.text = dragClip.txtField.text;
			}
			else if(dragClip.hitTestObject(button7))
			{
				_labelClip.txtField.text = labelClip7.txtField.text;
				labelClip7.txtField.text = dragClip.txtField.text;
			}
			else if(dragClip.hitTestObject(button8))
			{
				_labelClip.txtField.text = labelClip8.txtField.text;
				labelClip8.txtField.text = dragClip.txtField.text;
			}
		}
		
		private function answerQuestion():void
		{			
			for(var i:int = 1; i < 9; i++)
			{
				var clip:MovieClip = getChildByName("labelClip" + i) as MovieClip;
				if(clip.txtField.text == "STYLE")
				{
					var style:int = i;
				}
				else if(clip.txtField.text == "FRAME MATERIAL")
				{
					var material:int = i;
				}
				else if(clip.txtField.text == "FIT")
				{
					var fit:int = i;
				}
				else if(clip.txtField.text == "DURABILITY")
				{
					var durability:int = i;
				}
				else if(clip.txtField.text == "LIGHT WEIGHT")
				{
					var weight:int = i;
				}
				else if(clip.txtField.text == "LENS TYPE")
				{
					var type:int = i;
				}
				else if(clip.txtField.text == "LENS THINNESS")
				{
					var thinness:int = i;
				}
				else if(clip.txtField.text == "LENS COLOR")
				{
					var color:int = i;
				}
			}
			recommender.AnswerQuestion8(style, thinness, material, fit, type, color, durability, weight);
		}
	}
}