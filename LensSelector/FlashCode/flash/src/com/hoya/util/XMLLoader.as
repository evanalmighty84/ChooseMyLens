package com.hoya.util
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class XMLLoader extends EventDispatcher
	{		
		public static const XML_LOAD_COMPLETE:String = "XML Load Complete";
		public static const XML_LOAD_ERROR:String = "XML Load Error";
		private var _xmlLoader:URLLoader;
		private var _dataURL:String;
		private var _xmlData:XML;
		
		public function XMLLoader()
		{
			super();
		}
		
		public function get dataURL():String
		{
			return _dataURL;
		}
		
		public function set dataURL(newVal:String):void
		{
			_dataURL = newVal;
		}
		
		public function get xmlData():XML
		{
			return _xmlData;
		}
		
		public function loadData():void
		{
			var xmlLoadRequest:URLRequest = new URLRequest(_dataURL);
			_xmlLoader = new URLLoader();
			_xmlLoader.addEventListener(Event.COMPLETE, xmlLoadCompleteHandler);
			_xmlLoader.addEventListener(IOErrorEvent.IO_ERROR, xmlErrorHandler);
			_xmlLoader.load(xmlLoadRequest);
		}

		private function xmlLoadCompleteHandler(e:Event):void 
		{
			cleanUp();
			_xmlData = new XML(_xmlLoader.data);
			dispatchEvent(new Event(XML_LOAD_COMPLETE));
        }
		
		private function xmlErrorHandler(e:Event):void
		{
			cleanUp();
			dispatchEvent(new Event(XML_LOAD_ERROR));
		}
		
		private function cleanUp():void
		{
			_xmlLoader.removeEventListener(Event.COMPLETE, xmlLoadCompleteHandler);
			_xmlLoader.removeEventListener(IOErrorEvent.IO_ERROR, xmlErrorHandler);
		}
	}
}