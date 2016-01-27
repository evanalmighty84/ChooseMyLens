package com.hoya.util
{
	import com.google.analytics.GATracker;
	
	import flash.display.DisplayObject;
	import flash.events.EventDispatcher;
	
	[Bindable]
	public class TrackingUtil extends EventDispatcher
	{
		private static var _instance:TrackingUtil;
		private var gaTracker:GATracker;
		
		public function TrackingUtil(key:SingletonEnforcer)
		{
			super();
		}
		
		public static function getInstance():TrackingUtil
		{
			if(_instance == null)
			{
				_instance = new TrackingUtil(new SingletonEnforcer());
			}
			return _instance;
		}
		
		public function init(displayObject:DisplayObject):void
		{
			gaTracker = new GATracker(displayObject, "UA-2068024-47", "AS3", false);
		}
		
		public function trackPageView(view:String):void
		{
			if(gaTracker)
			{
				gaTracker.trackPageview(view);
			}
		}
		
		public function trackEvent(category:String, action:String, label:String):void
		{
			if(gaTracker)
			{
				gaTracker.trackEvent(category, action, label);
			}
		} 
	}
}

internal class SingletonEnforcer{}