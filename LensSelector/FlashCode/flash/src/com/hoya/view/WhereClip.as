package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.DisplayShortcuts;
	
	public class WhereClip extends ContentBase
	{	
		private var _rate:int = 50;
		public function WhereClip()
		{
			super();
			DisplayShortcuts.init();
		}
		
		override public function init():void
		{
			super.init();
		}
		
		override public function playIntro():void
		{
			super.playIntro();
			this.play();
			chartShadow.play();
			chartOverlay.play();
		}
		
		private function playPieMask():void
		{
			Tweener.addTween(pieMask, {_frame:91, time:1, transition:"linear"});
			Tweener.addTween(pieLabelClip, {delay:.5, alpha:1, time:.5, transition:"linear", onComplete:showDrag});
		}	
		
		private function showDrag():void
		{
			Tweener.addTween(clickAndDragLabel, {alpha:1, time:.5, transition:"linear"});
			Tweener.addTween(dragClip, {alpha:1, time:.5, transition:"linear", onComplete:introComplete});
		}
		
		private function introComplete():void
		{
			enable();
			dragClip.buttonMode = true;
			dragClip.useHandCursor = true;
			dragClip.addEventListener(MouseEvent.MOUSE_DOWN, beginDrag);
			dragClip.addEventListener(MouseEvent.MOUSE_UP, endDrag);
			recommender.AnswerQuestion4(50);
			enableNext();
		}
		
		override public function enable():void
		{
			super.enable();
		}
		
		private function beginDrag(e:MouseEvent):void
		{
			Tweener.addTween(clickAndDragLabel, {alpha:0, time:.5, transition:"linear"});
			stage.addEventListener(MouseEvent.MOUSE_MOVE, updateDrag);
			stage.addEventListener(MouseEvent.MOUSE_UP, endDrag);
		}
		
		private function updateDrag(e:MouseEvent):void
		{
			var angle:Number = Math.atan2(this.mouseY - dragClip.y, this.mouseX - dragClip.x);
			var degrees:Number = Math.round(angle*180/Math.PI);
			updateMask(degrees);
			setLabels(degrees);
			dragClip.rotation = degrees;
		}
		
		private function updateMask(degrees:Number):void
		{
			var tempDegrees:Number = Math.round(degrees/2 + 91);
			pieMask.gotoAndStop(tempDegrees);
		}
		
		private function setLabels(degrees:Number):void
		{
			var tempVal:Number = Math.round(Math.abs(degrees / 360) * 100);
			
			if(degrees >= 0)
			{	
				_rate = tempVal + 50;
				pieLabelClip.indoorsLabel.text = String(tempVal + 50 + "%");
				pieLabelClip.outdoorsLabel.text = String(50 - tempVal + "%");
			}
			else
			{
				_rate = 50 - tempVal;
				pieLabelClip.outdoorsLabel.text = String(tempVal + 50 + "%");
				pieLabelClip.indoorsLabel.text = String(50 - tempVal + "%");
			}
		}
		
		private function endDrag(e:MouseEvent):void
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, updateDrag);
			stage.removeEventListener(MouseEvent.MOUSE_UP, endDrag);			
			recommender.AnswerQuestion4(_rate);
		}
	}
}