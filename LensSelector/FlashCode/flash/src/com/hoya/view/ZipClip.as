package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.net.URLLoader;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.geom.ColorTransform;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.ColorShortcuts;
	
	public class ZipClip extends ContentBase
	{	
		public static const ENTER_KEY:String = "ENTER KEY";
		private var _state:String;
		private var _allowEnter:Boolean = false;
		
		public function ZipClip()
		{
			super();
		}
		
		override public function init():void
		{
			super.init();
			ColorShortcuts.init();
			textInput.restrict = "0-9";
		}
		
		override public function playIntro():void
		{
			super.playIntro();
			this.play();
			usShadow.play();
			usOverlay.play();
		}
		
		private function introComplete():void
		{
			textInput.type = TextFieldType.INPUT;
			textInput.addEventListener(Event.CHANGE, onTextInput);
			textInput.addEventListener(MouseEvent.MOUSE_DOWN, onMouseClick);
			this.addEventListener(KeyboardEvent.KEY_DOWN, keyListener);
			enable();
		}
		
		private function keyListener(e:KeyboardEvent):void
		{
			if(e.charCode == 13 && _allowEnter)
			{
				dispatchEvent(new Event(ENTER_KEY));
			}
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			hideLabel();
		}
		
		private function onTextInput(e:Event):void
		{
			hideLabel();
			if(textInput.text.length == 5)
			{
				_allowEnter = true;
				recommender.AnswerQuestion3(textInput.text);
				recommender.GetStateFromZip(textInput.text, textInputCallback);
			}
			else
			{
				_allowEnter = false;
			}
		}
		
		private function textInputCallback(e:Event):void
		{
			var loader:URLLoader = e.currentTarget as URLLoader;
			if(_state != loader.data)
			{
				_state = loader.data;
				unhighlightState();
			}
		}
		
		private function setState():void
		{
			usaMap.gotoAndStop(_state);
			highlightState();
		}
		
		override public function enable():void
		{
			super.enable();
			stage.focus = textInput;
		}
		
		private function hideLabel():void
		{
			Tweener.addTween(enterZipLabel, {alpha:0, time:.25, transition:"linear"});
		}
		
		private function unhighlightState():void
		{
			var colorTransform:ColorTransform = new ColorTransform(.26, .2, .2, 0, 194, 118, 0, 0);
			Tweener.addTween(usHighlight, {_colorTransform:colorTransform, time:.5, transition:"linear", onComplete:setState});
		}
		
		private function highlightState():void
		{
			var colorTransform:ColorTransform = new ColorTransform();
			colorTransform.color = 0x0177c1;
			Tweener.addTween(usHighlight, {_colorTransform:colorTransform, time:.5, transition:"linear", onComplete:enableNext});
		}
	}
}