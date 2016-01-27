package com.hoya.view
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import com.hoya.model.MoreInfoVO;
	import caurina.transitions.Tweener;
	
	public class MoreInfoClip extends MovieClip
	{
		private var _loader:Loader;
		private var _dataVO:MoreInfoVO;
		
		public function MoreInfoClip()
		{
			super();
			_loader = new Loader();
			imageClip.addChild(_loader);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, hideLoader);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
		}
		
		public function get dataVO():MoreInfoVO
		{
			return _dataVO;
		}
		
		public function set dataVO(newVal:MoreInfoVO):void
		{
			_dataVO = newVal;
			setContent();
		}
		
		private function setContent():void
		{
			labelClip.categoryText.text = _dataVO.categoryText.toUpperCase();
			labelClip.headerText.text = _dataVO.headerText.toUpperCase();
			labelClip.copyText.text = _dataVO.copyText;
			
			if(_dataVO.imageURL.length > 0)
			{
				labelClip.y = this.height - labelClip.height;
				showLoader();
				_loader.load(new URLRequest(_dataVO.imageURL));
				imageClip.visible = true;
			}
			else
			{
				labelClip.y = (this.height - labelClip.height) / 2;
				hideLoader();
				imageClip.visible = false;
			}
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			trace(e);
		}
		
		private function playLoaderAnimation():void
		{
			
			loaderAnimationClip.gotoAndPlay("loop");
		}
		
		private function stopLoaderAnimation():void
		{
			loaderAnimationClip.gotoAndStop("paused");
		}
		
		private function showLoader(e:Event = null):void
		{
			Tweener.addTween(loaderAnimationClip, {alpha:1, time:.25, transition:"linear", onComplete:playLoaderAnimation});
		}
		
		private function hideLoader(e:Event = null):void
		{
			Tweener.addTween(loaderAnimationClip, {alpha:0, time:.25, transition:"linear", onComplete:stopLoaderAnimation});
		}
	}
}