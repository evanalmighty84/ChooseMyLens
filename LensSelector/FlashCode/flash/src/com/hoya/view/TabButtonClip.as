package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.blitzagency.xray.logger.XrayLog;
	
	public class TabButtonClip extends MovieClip
	{	
		public static const BUTTON_CLICK:String = "Button Click";
		public static const PRIMARY:String = "Primary";
		public static const COMPLEMENTARY:String = "Complementary";
		public static const SPECIALTY:String = "Specialty";
		private var _showButton2:Boolean = false;
		private var _showButton3:Boolean = false;
		private var _previousButton:MovieClip;
		private var _currentButton:MovieClip;
		private var _selected:String;
		private var _index:int;
		
		private var _log:XrayLog = new XrayLog();
		
		public function TabButtonClip()
		{
			super(); 
		}
		
		public function setupButtons(buttonArray:Array, index:int):void
		{
			_index = index;
			button1.txtField.text = buttonArray[0];
			if(buttonArray[1])
			{
				_showButton2 = true;
				button2.txtField.text = buttonArray[1];
				button2.alpha = 1;
			}
			
			if(buttonArray[2])
			{
				_showButton3 = true;
				button3.txtField.text = buttonArray[2];
				button3.alpha = 1;
			}
		}
		
		public function get selected():String
		{
			switch(_currentButton.txtField.text)
			{
				case "PRIMARY":
					_selected = PRIMARY;
					break;
				case "COMPLEMENTARY":
					_selected = COMPLEMENTARY;
					break;
				case "SPECIALTY":
					_selected = SPECIALTY;
					break;
			}
			return _selected;
		}
		
		public function enable():void
		{
			_currentButton = this["button" + _index]
			_previousButton = _currentButton;
			button1.mouseChildren = false;
			button1.buttonMode = true;
			button1.useHandCursor = true;
			button1.addEventListener(MouseEvent.CLICK, onButtonClick);
			if(_showButton2)
			{
				button2.mouseChildren = false;
				button2.buttonMode = true;
				button2.useHandCursor = true;
				button2.addEventListener(MouseEvent.CLICK, onButtonClick);
			}
			
			if(_showButton3)
			{
				button3.mouseChildren = false;
				button3.buttonMode = true;
				button3.useHandCursor = true;
				button3.addEventListener(MouseEvent.CLICK, onButtonClick);
			}
			
			_currentButton.mouseEnabled = false;
			_currentButton.gotoAndStop("selected");
			_currentButton.txtField.textColor = 0xFFFFFF;
		}
		
		private function onButtonClick(e:MouseEvent):void
		{	
			
			_currentButton = e.currentTarget as MovieClip;
			_log.debug("_previousButton " + _previousButton);
			_log.debug("_currentButton " + _currentButton);
			if(_previousButton != _currentButton)
			{
				_previousButton.gotoAndStop("deselected");
				_previousButton.txtField.textColor = 0xB8BABD; 
				_previousButton.mouseEnabled = true;
				_previousButton = _currentButton;
				_currentButton.mouseEnabled = false;
				_currentButton.gotoAndStop("selected");
				_currentButton.txtField.textColor = 0xFFFFFF; 
				dispatchEvent(new Event(BUTTON_CLICK));
			}
		}
	}
}