package com.hoya.view
{
	// The specialty image viewer should be ported and used here instead of this class...
	import flash.display.MovieClip;
	import flash.display.BlendMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import caurina.transitions.Tweener;
	
	public class ImageViewerClip extends MovieClip
	{	
		public static const HIDE_LOADER:String = "Hide Loader";
		private var _imageArray:Array = new Array();
		private var _thumbArray:Array = new Array();
		private var _imageLoaderArray:Array;
		private var _thumbLoaderArray:Array;
		private var _imageCount:int;
		private var _thumbCount:int;
		private var _currentElement:Loader;
		public var titleText:String = "";
		public var copyText:String = "";
		
		
		public function ImageViewerClip()
		{
			super();
		}
		
		public function init():void
		{
			descriptionClip.titleText.text = titleText;
			descriptionClip.copyText.text = copyText;
			loadImages();
			loadThumbs();
		}
		
		private function enable():void
		{
			var show:Number = Math.floor(Math.random() * 5);
			showImage(show);
			
			thumb1.buttonMode = true;
			thumb1.useHandCursor = true;
			thumb1.addEventListener(MouseEvent.CLICK, onButtonClick);
			thumb1.addEventListener(MouseEvent.MOUSE_OVER, onButtonRollOver);
			thumb1.addEventListener(MouseEvent.MOUSE_OUT, onButtonRollOut);
			
			thumb2.buttonMode = true;
			thumb2.useHandCursor = true;
			thumb2.addEventListener(MouseEvent.CLICK, onButtonClick);
			thumb2.addEventListener(MouseEvent.MOUSE_OVER, onButtonRollOver);
			thumb2.addEventListener(MouseEvent.MOUSE_OUT, onButtonRollOut);
			
			thumb3.buttonMode = true;
			thumb3.useHandCursor = true;
			thumb3.addEventListener(MouseEvent.CLICK, onButtonClick);
			thumb3.addEventListener(MouseEvent.MOUSE_OVER, onButtonRollOver);
			thumb3.addEventListener(MouseEvent.MOUSE_OUT, onButtonRollOut);
			
			thumb4.buttonMode = true;
			thumb4.useHandCursor = true;
			thumb4.addEventListener(MouseEvent.CLICK, onButtonClick);
			thumb4.addEventListener(MouseEvent.MOUSE_OVER, onButtonRollOver);
			thumb4.addEventListener(MouseEvent.MOUSE_OUT, onButtonRollOut);
			
			thumb5.buttonMode = true;
			thumb5.useHandCursor = true;
			thumb5.addEventListener(MouseEvent.CLICK, onButtonClick);
			thumb5.addEventListener(MouseEvent.MOUSE_OVER, onButtonRollOver);
			thumb5.addEventListener(MouseEvent.MOUSE_OUT, onButtonRollOut);
			
			_currentElement = _thumbLoaderArray[show];
			_currentElement.alpha = 1;
			pointerClip.x = this["thumb" + (show + 1)].x;
			Tweener.addTween(this, {alpha:1, time:.5, transition:"easeInCubic"});
			dispatchEvent(new Event(HIDE_LOADER));
		}
		
		public function get imageArray():Array
		{
			return _imageArray;
		}
		
		public function set imageArray(newVal:Array):void
		{
			_imageArray = newVal;
			
		}
		
		public function get thumbArray():Array
		{
			return _thumbArray;
		}
		
		public function set thumbArray(newVal:Array):void
		{
			_thumbArray = newVal;
		}
		
		private function onButtonClick(e:MouseEvent):void
		{
			var clip:MovieClip = e.currentTarget as MovieClip;
			var loader:Loader = clip.getChildAt(1) as Loader;
			Tweener.addTween(_currentElement, {alpha:.5, time:.25, transition:"linear"});
			Tweener.addTween(loader, {alpha:1, time:.25, transition:"linear"});
			_currentElement = loader;			
			pointerClip.x = clip.x;
			for(var i:int = 0; i < _thumbLoaderArray.length; i++)
			{
				if(loader == _thumbLoaderArray[i])
				{
					showImage(i);
					break;
				}
			}
		}
		
		private function onButtonRollOver(e:MouseEvent):void
		{ 
			var element:MovieClip = e.currentTarget as MovieClip;
			var loader:Loader = element.getChildAt(1) as Loader;
			Tweener.addTween(loader, {alpha:1, time:.25, transition:"linear"});
		}
		
		private function onButtonRollOut(e:MouseEvent):void
		{
			var element:MovieClip = e.currentTarget as MovieClip;
			var loader:Loader = element.getChildAt(1) as Loader;
			if(_currentElement != loader)
			{
				Tweener.addTween(loader, {alpha:.5, time:.25, transition:"linear"});
			}
		}
		
		private function showImage(index:int):void
		{
			if(imageClip.numChildren > 0)
			{
				imageClip.removeChildAt(0);
			}
			imageClip.addChild(_imageLoaderArray[index]);
		}
		
		private function evalCount():void
		{
			if(_thumbCount == _thumbArray.length && _imageCount == _imageArray.length)
			{
				enable();
			}
		}
		
		private function loadThumbs():void
		{
			_thumbLoaderArray = new Array();
			for(var i:int = 0; i < _thumbArray.length; i++)
			{
				var loader:Loader = new Loader();
				loader.alpha = .5;
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, thumbLoadComplete);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				_thumbLoaderArray.push(loader);
				var thumb:MovieClip = this.getChildByName("thumb" + (i + 1)) as MovieClip;
				thumb.addChild(loader);
				loader.load(new URLRequest(_thumbArray[i]));
			}
		}
		
		private function loadImages():void
		{
			_imageLoaderArray = new Array();
			for(var i:int = 0; i < _imageArray.length; i++)
			{
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, imageLoadComplete);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
				_imageLoaderArray.push(loader);
				loader.load(new URLRequest(_imageArray[i]));
			}
		}
		
		private function thumbLoadComplete(e:Event):void
		{
			_thumbCount++;
			evalCount();
		}
		
		private function imageLoadComplete(e:Event):void
		{
			_imageCount++;
			evalCount();
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			trace(e);
		}
	}
}