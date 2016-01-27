package com.hoya.controller
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.SecurityDomain;
	import flash.system.LoaderContext;
	import caurina.transitions.Tweener;
	import com.hoya.util.TrackingUtil;
	
	public class HoyaLoaderController extends MovieClip
	{
		private var _loader:Loader;
		private var _trackingUtil:TrackingUtil = TrackingUtil.getInstance();
		
		public function HoyaLoaderController()
		{
			super();
			loaderClip.logoMask.scaleY = 0;
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			_loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loadError);
			_loader.load(new URLRequest("hoyaContent.swf"), new LoaderContext(false, ApplicationDomain.currentDomain, SecurityDomain.currentDomain));
			_trackingUtil.init(this);
		}		
		
		private function loadProgress(e:ProgressEvent):void 
		{    
			var loaded:int = Math.round(e.bytesLoaded);
			var total:int = Math.round(e.bytesTotal);
			var percent:int = loaded/total * 100;
			loaderClip.logoMask.scaleY = percent * .01;
		}

		private function loadComplete(e:Event):void
		{
		  	contentContainer.addChild(_loader.content);
			Tweener.addTween(contentContainer, {alpha:1, time:1, transition:"linear"});
			Tweener.addTween(loaderClip, {alpha:0, time:1, transition:"linear", onComplete:cleanUp});
		}
		
		private function loadError(e:IOErrorEvent):void
		{
			trace("load error :: " + e.text);
			cleanUp();
		}
		
		private function cleanUp():void
		{
			removeChild(loaderClip);
			_loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadProgress);
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
			_loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, loadError);
			_loader = null;
		}
	}
}