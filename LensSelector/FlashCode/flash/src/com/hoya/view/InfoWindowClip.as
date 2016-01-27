package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.hoya.model.MoreInfoVO;
	import caurina.transitions.Tweener;
	
	public class InfoWindowClip extends MovieClip
	{	
		public static const CLOSE_CLICK:String = "CLOSE_CLICK";
		private var _dataVO:MoreInfoVO;
	
		public function InfoWindowClip()
		{
			super();
			this.mouseEnabled = false;
			closeButton.useHandCursor = true;
			closeButton.addEventListener(MouseEvent.CLICK, onCloseClick);
		}
		
		public function get dataVO():MoreInfoVO
		{
			return _dataVO;
		}
		
		public function set dataVO(newVal:MoreInfoVO):void
		{
			if(_dataVO != newVal)
			{
				_dataVO = newVal;
				hideContent();
			}
		}
		
		private function onCloseClick(e:MouseEvent):void
		{
			dispatchEvent(new Event(CLOSE_CLICK));
		}
		
		private function setupContent():void
		{
			moreInfoClip.dataVO = _dataVO;
			showContent();
		}
		
		private function hideContent():void
		{
			Tweener.addTween(moreInfoClip, {alpha:0, time:.25, transition:"linear", onComplete:setupContent});
		}
		
		private function showContent():void
		{
			Tweener.addTween(moreInfoClip, {alpha:1, time:.5, transition:"linear"});
		}
	}
}