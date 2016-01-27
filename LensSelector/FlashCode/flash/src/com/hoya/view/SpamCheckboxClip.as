package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class SpamCheckboxClip extends MovieClip
	{	
		public static const BUTTON_CLICKED:String = "Button Clicked";
		private var _selected:Boolean;
		
		public function SpamCheckboxClip()
		{
			super();
			this.buttonMode = true;
			this.useHandCursor = true;
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseOverHandler);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseOutHandler);
			this.addEventListener(MouseEvent.CLICK, mouseClickHandler);
			
		}
		
		public function get selected():Boolean
		{
			return _selected;
		}
		
		private function mouseOverHandler(e:MouseEvent):void
		{
			if(!_selected)
			{
				this.gotoAndStop("over");
			}
		}
		
		private function mouseOutHandler(e:MouseEvent):void
		{
			if(!_selected)
			{
				this.gotoAndStop("up");
			}
		}
		
		private function mouseClickHandler(e:MouseEvent):void
		{
			if(_selected)
			{
				this.gotoAndStop("up");
			}
			else
			{
				this.gotoAndStop("selected");
			}
			_selected = !_selected;
			dispatchEvent(new Event(BUTTON_CLICKED));
		}
		
		public function deselect():void
		{
			_selected = false;
			this.gotoAndStop("up");
		}
	}
}