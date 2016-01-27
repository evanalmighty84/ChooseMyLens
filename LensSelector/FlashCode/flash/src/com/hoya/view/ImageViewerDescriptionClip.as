package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import caurina.transitions.Tweener;
	
	public class ImageViewerDescriptionClip extends MovieClip
	{	
		public static const CLOSE:String = "CLOSE";
		
		public function ImageViewerDescriptionClip()
		{
			super();
			closeButtonX.addEventListener(MouseEvent.CLICK, onCloseClick);
		}
		
		private function onCloseClick(e:MouseEvent):void
		{
			closeButtonX.removeEventListener(MouseEvent.CLICK, onCloseClick);
			dispatchEvent(new Event(CLOSE));
			var newY:Number = (this.y + this.height);
			Tweener.addTween(this, {y:newY, time:.25, transition:"linear", onComplete:onCloseComplete});
		}
		
		private function onCloseComplete():void
		{
			this.visible = false;
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
	}
}