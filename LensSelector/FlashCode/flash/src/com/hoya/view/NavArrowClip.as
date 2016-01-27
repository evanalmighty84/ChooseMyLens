package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import caurina.transitions.Tweener;
	
	public class NavArrowClip extends MovieClip
	{
		public static const UPDATE_VIEW_BACK:String = "Update View Back";
		public static const UPDATE_VIEW_NEXT:String = "Update View Next";
		
		public function NavArrowClip()
		{
			super();
			disableBack();
			disableNext();
			init();
		}
		
		private function init():void
		{
			back.useHandCursor = true;
			back.buttonMode = true;
			back.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			back.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			back.addEventListener(MouseEvent.CLICK, clickHandler);
			next.useHandCursor = true;
			next.buttonMode = true;
			next.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler);
			next.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler);
			next.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		public function enableNextText():void
		{
			//next.nextText.alpha = 1;
		}
		
		public function disableNextText():void
		{
			//next.nextText.alpha = 0;
		}
		
		public function enableBack():void
		{
			back.mouseEnabled = true;
			back.mouseChildren = true;
			Tweener.addTween(back, {alpha:1, time:.5, transition:"linear"});
		}
		
		public function disableBack():void
		{
			back.mouseEnabled = false;
			back.mouseChildren = false;
			back.gotoAndStop("up");
			Tweener.addTween(back, {alpha:.0, time:.5, transition:"linear"});
		}
		
		public function enableNext():void
		{
			next.mouseEnabled = true;
			next.mouseChildren = true;
			Tweener.addTween(next, {alpha:1, time:.5, transition:"linear"});
		}
		
		public function disableNext():void
		{
			next.mouseEnabled = false;
			next.mouseChildren = false;
			next.gotoAndStop("up");
			Tweener.addTween(next, {alpha:.25, time:.5, transition:"linear"});
		}
		
		public function disableAll():void
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
			Tweener.addTween(this, {alpha:0, time:.5, transition:"linear"});
		}
		
		private function rollOverHandler(e:MouseEvent):void
		{
			var clip:MovieClip = e.currentTarget as MovieClip;
			Tweener.addTween(clip.over, {alpha:1, time:.25, transition:"linear"});
			Tweener.addTween(clip.up, {alpha:0, time:.25, transition:"linear"});
		}
		
		private function rollOutHandler(e:MouseEvent):void
		{
			var clip:MovieClip = e.currentTarget as MovieClip;
			Tweener.addTween(clip.over, {alpha:0, time:.25, transition:"linear"});
			Tweener.addTween(clip.up, {alpha:1, time:.25, transition:"linear"});
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			switch(e.currentTarget.name)
			{
				case "back":
					dispatchEvent(new Event(UPDATE_VIEW_BACK));
					break;
				case "next":
					dispatchEvent(new Event(UPDATE_VIEW_NEXT));
					break;
			}
		}
	}
}