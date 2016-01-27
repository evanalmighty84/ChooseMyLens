package com.hoya.view
{
	import fl.motion.Color;
	import flash.geom.ColorTransform;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import caurina.transitions.Tweener;
	import com.hoya.model.SpecialtyNavElementVO;
	
	public class SpecialtyImageViewerClip extends MovieClip
	{	
		public static const HIDE_LOADER:String = "Hide Loader";
		public static const UPDATE_TINT_LABEL:String = "Update Tint Label";
		private var _backgroundImage:Loader;
		private var _overlayLoader:Loader;
		private var _overlayArray:Array;
		private var _xmlData:XML;
		private var _tintList:XMLList;
		private var _overlayCount:int = 0;
		private var _loadedCount:int = 0;
		public var titleText:String = "";
		public var copyText:String = ""
		
		public function SpecialtyImageViewerClip()
		{
			super();
			navClip.addEventListener(SpecialtyNavClip.ELEMENT_CLICK, onElementClick);
			navClip.addEventListener(SpecialtyNavClip.SHOW_DESCRIPTION, hideDescription);
			navClip.addEventListener(SpecialtyNavClip.HIDE_DESCRIPTION, showDescription);
			descriptionClip.addEventListener(ImageViewerDescriptionClip.CLOSE, onDescriptionClose);
		}
		
		public function init():void
		{
			this.alpha = 0;
			descriptionClip.titleText.text = titleText;
			descriptionClip.copyText.text = copyText;
			navClip.init();
			loadBackgroundImage(_xmlData.image);
		}
		
		public function get currentElement():SpecialtyNavElementVO
		{
			return navClip.currentElement;
		}
		
		public function set xmlData(newVal:XML):void
		{
			_xmlData = newVal;
			navClip.xmlData = _xmlData;
		}
		
		private function enable():void
		{
			Tweener.addTween(this, {alpha:1, time:.5, transition:"linear"});
			_overlayLoader = _overlayArray[0] as Loader;
			imageClip.addChild(_overlayLoader);
			dispatchEvent(new Event(HIDE_LOADER));
		}
		
		private function onDescriptionClose(e:Event):void
		{
			navClip.showTintDescription();
			navClip.hideDescription = false;
			descriptionClip.removeEventListener(ImageViewerDescriptionClip.CLOSE, onDescriptionClose);
			navClip.removeEventListener(SpecialtyNavClip.SHOW_DESCRIPTION, hideDescription);
			navClip.removeEventListener(SpecialtyNavClip.HIDE_DESCRIPTION, showDescription);
		}
		
		private function showDescription(e:Event):void
		{
			descriptionClip.mouseEnabled = true;
			Tweener.addTween(descriptionClip, {alpha:1, time:.25, transition:"linear"});
		}
		
		private function hideDescription(e:Event):void
		{
			descriptionClip.mouseEnabled = false;
			Tweener.addTween(descriptionClip, {alpha:0, time:.25, transition:"linear"});
		}
		
		private function onElementClick(e:Event):void
		{
			if(_overlayLoader)
			{
				imageClip.removeChild(_overlayLoader);
			}
			_overlayLoader = _overlayArray[navClip.currentElement.index] as Loader;
			imageClip.addChild(_overlayLoader);
			dispatchEvent(new Event(UPDATE_TINT_LABEL));
		}
			
		private function loadBackgroundImage(image:String):void
		{
			if(_backgroundImage)
			{
				imageClip.removeChild(_backgroundImage);
			}
			
			_backgroundImage = new Loader();
			imageClip.addChild(_backgroundImage);
			_backgroundImage.contentLoaderInfo.addEventListener(Event.COMPLETE, backGroundImageLoadComplete);
			_backgroundImage.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			_backgroundImage.load(new URLRequest(image));
		}
		
		private function backGroundImageLoadComplete(e:Event):void
		{
			_backgroundImage.contentLoaderInfo.removeEventListener(Event.COMPLETE, backGroundImageLoadComplete);
			_backgroundImage.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loadOverlays();
		}
		
		private function loadOverlays():void
		{
			if(_overlayLoader)
			{
				imageClip.removeChild(_overlayLoader);
			}
			var xmlList:XMLList = _xmlData.tints.elements("tint");
			_overlayArray = new Array();
			for(var i:int = 0; i < xmlList.length(); i++)
			{
				_overlayCount++;
				var tempLoader:Loader = new Loader();
				_overlayArray.push(tempLoader);
				tempLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoadComplete);
				tempLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				tempLoader.load(new URLRequest(xmlList[i].image));
			}
		}
		
		private function imageLoadComplete(e:Event):void
		{
			e.currentTarget.removeEventListener(Event.COMPLETE, imageLoadComplete);
			e.currentTarget.removeEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			_loadedCount++;
			if(_loadedCount == _overlayCount)
			{
				enable();
			}
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			trace(e);
		}
	}
}