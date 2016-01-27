package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import recomendations.Recomender;
	
	public class ContentBase extends MovieClip
	{
		public static const ENABLE_NEXT:String = "Enable Next";
		public static const SHOW_NEXT:String = "Show Next";
		private var _playIntro:Boolean = true;
		private var _enableNext:Boolean = false;
		private var _recommender:Recomender;
		private var _lid:String;
		private var _gid:String;
	
		public function ContentBase()
		{
			super();
		}
		
		public function init():void
		{
			if(_playIntro)
			{
				_playIntro = false;
				playIntro();
			}
			else
			{
				if(_enableNext)
				{
					enableNext();
				}
				enable();
			}
		}
		
		public function get recommender():Recomender
		{
			return _recommender;
		}
		
		public function set recommender(newVal:Recomender):void
		{
			_recommender = newVal;
		}
		
		public function get lid():String
		{
			return _lid;
		}
		
		public function set lid(newVal:String):void
		{
			_lid = newVal;
		}
		
		public function get gid():String
		{
			return _gid;
		}
		
		public function set gid(newVal:String):void
		{
			_gid = newVal;
		}
		
		public function playIntro():void
		{
			// overridden in the class
		}
		
		public function enable():void
		{
			this.mouseEnabled = true;
			this.mouseChildren = true;
		}
		
		public function disable():void
		{
			this.mouseEnabled = false;
			this.mouseChildren = false;
		}
		
		public function enableNext():void
		{
			_enableNext = true;
			dispatchEvent(new Event(ENABLE_NEXT));
		}
		
		public function showNext(e:Event = null):void
		{
			_enableNext = true;
			dispatchEvent(new Event(SHOW_NEXT));
		}
	}
}