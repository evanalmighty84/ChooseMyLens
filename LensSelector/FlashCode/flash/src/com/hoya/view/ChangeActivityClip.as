package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import caurina.transitions.Tweener;
	import caurina.transitions.properties.TextShortcuts;
	
	public class ChangeActivityClip extends MovieClip
	{	
		public static const CHANGE_ACTIVITY:String = "Change Activity";
		public static const STATE_OPEN:String = "State Open";
		public static const STATE_CLOSED:String = "State Closed";
		private var _currentClip:MovieClip;
		private var _currentActivity:String;
		private var _currentState:String = STATE_CLOSED;
		
		public function ChangeActivityClip()
		{
			super();
			TextShortcuts.init();
			bikingButton.txtField.text = "BIKING";
			bikingButton.mouseChildren = false;
			bikingButton.buttonMode = true;
			bikingButton.useHandCursor = true;
			bikingButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			bikingButton.addEventListener(MouseEvent.MOUSE_OVER, onButtonRollOver);
			bikingButton.addEventListener(MouseEvent.MOUSE_OUT, onButtonRollOut);
			
			boatingButton.txtField.text = "BOATING/WATER SPORTS";
			boatingButton.mouseChildren = false;
			boatingButton.buttonMode = true;
			boatingButton.useHandCursor = true;
			boatingButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			boatingButton.addEventListener(MouseEvent.MOUSE_OVER, onButtonRollOver);
			boatingButton.addEventListener(MouseEvent.MOUSE_OUT, onButtonRollOut);
			
			fishingButton.txtField.text = "FISHING";
			fishingButton.mouseChildren = false;
			fishingButton.buttonMode = true;
			fishingButton.useHandCursor = true;
			fishingButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			fishingButton.addEventListener(MouseEvent.MOUSE_OVER, onButtonRollOver);
			fishingButton.addEventListener(MouseEvent.MOUSE_OUT, onButtonRollOut);
			
			huntingButton.txtField.text = "HUNTING/SHOOTING";
			huntingButton.mouseChildren = false;
			huntingButton.buttonMode = true;
			huntingButton.useHandCursor = true;
			huntingButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			huntingButton.addEventListener(MouseEvent.MOUSE_OVER, onButtonRollOver);
			huntingButton.addEventListener(MouseEvent.MOUSE_OUT, onButtonRollOut);
			
			hikingButton.txtField.text = "HIKING";
			hikingButton.mouseChildren = false;
			hikingButton.buttonMode = true;
			hikingButton.useHandCursor = true;
			hikingButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			hikingButton.addEventListener(MouseEvent.MOUSE_OVER, onButtonRollOver);
			hikingButton.addEventListener(MouseEvent.MOUSE_OUT, onButtonRollOut);
			
			golfingButton.txtField.text = "GOLFING";
			golfingButton.mouseChildren = false;
			golfingButton.buttonMode = true;
			golfingButton.useHandCursor = true;
			golfingButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			golfingButton.addEventListener(MouseEvent.MOUSE_OVER, onButtonRollOver);
			golfingButton.addEventListener(MouseEvent.MOUSE_OUT, onButtonRollOut);
			
			runningButton.txtField.text = "RUNNING";
			runningButton.mouseChildren = false;
			runningButton.buttonMode = true;
			runningButton.useHandCursor = true;
			runningButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			runningButton.addEventListener(MouseEvent.MOUSE_OVER, onButtonRollOver);
			runningButton.addEventListener(MouseEvent.MOUSE_OUT, onButtonRollOut);
			
			skiingButton.txtField.text = "SKI/SNOW SPORTS";
			skiingButton.mouseChildren = false;
			skiingButton.buttonMode = true;
			skiingButton.useHandCursor = true;
			skiingButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			skiingButton.addEventListener(MouseEvent.MOUSE_OVER, onButtonRollOver);
			skiingButton.addEventListener(MouseEvent.MOUSE_OUT, onButtonRollOut);
			
			tennisButton.txtField.text = "TENNIS";
			tennisButton.mouseChildren = false;
			tennisButton.buttonMode = true;
			tennisButton.useHandCursor = true;
			tennisButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			tennisButton.addEventListener(MouseEvent.MOUSE_OVER, onButtonRollOver);
			tennisButton.addEventListener(MouseEvent.MOUSE_OUT, onButtonRollOut);
		}
		
		public function get currentActivity():String
		{
			return _currentActivity;
		}
		
		public function get currentState():String
		{
			return _currentState;
		}
		
		public function set currentState(newVal:String):void
		{
			_currentState = newVal;
		}
		
		public function setCurrentActivity(newVal:String):void
		{
			if(_currentClip)
			{
				setUpState(_currentClip);
			}
			
			switch(newVal)
			{
				case "Biking":
					_currentActivity = "Biking";
					setSelectedState(bikingButton);
					break;
				case "Boating":
					_currentActivity = "Boating";
					setSelectedState(boatingButton);
					break;
				case "Fishing":
					_currentActivity = "Fishing";
					setSelectedState(fishingButton);
					break;
				case "Hunting":
					_currentActivity = "Hunting";
					setSelectedState(huntingButton);
					break;
				case "Hiking":
					_currentActivity = "Hiking";
					setSelectedState(hikingButton);
					break;
				case "Golfing":
					_currentActivity = "Golfing";
					setSelectedState(golfingButton);
					break;
				case "Running":
					_currentActivity = "Running";
					setSelectedState(runningButton);
					break;
				case "Skiing":
					_currentActivity = "Skiing";
					setSelectedState(skiingButton);
					break;
				case "Tennis":
					_currentActivity = "Tennis";
					setSelectedState(tennisButton);
					break;
			}
		}
		
		private function onButtonClick(e:Event):void
		{
			var clip:MovieClip = e.currentTarget as MovieClip;
			if(_currentClip != clip)
			{
				setUpState(_currentClip);
				_currentClip = clip;
				setSelectedState(_currentClip);
				switch(_currentClip)
				{
					case bikingButton:
						_currentActivity = "Biking";
						break;
					case boatingButton:
						_currentActivity = "Boating";
						break;
					case fishingButton:
						_currentActivity = "Fishing";
						break;
					case huntingButton:
						_currentActivity = "Hunting";
						break;
					case hikingButton:
						_currentActivity = "Hiking";
						break;
					case golfingButton:
						_currentActivity = "Golfing";
						break;
					case runningButton:
						_currentActivity = "Running";
						break;
					case skiingButton:
						_currentActivity = "Skiing";
						break;
					case tennisButton:
						_currentActivity = "Tennis";
						break;
					
				}
				dispatchEvent(new Event(CHANGE_ACTIVITY));
			}
		}
		
		private function onButtonRollOver(e:MouseEvent):void
		{
			var clip:MovieClip = e.currentTarget as MovieClip;
			if(_currentClip != clip)
			{
				setOverState(clip);
			}
		}
		
		private function onButtonRollOut(e:MouseEvent):void
		{
			var clip:MovieClip = e.currentTarget as MovieClip;
			if(_currentClip != clip)
			{
				setUpState(clip);
			}
		}
		
		private function setSelectedState(clip:MovieClip):void
		{
			_currentClip = clip;
			clip.mouseEnabled = false;
			Tweener.addTween(clip.txtField, {_text_color:0x14181C, time:.5});
		}
		
		private function setOverState(clip:MovieClip):void
		{
			Tweener.addTween(clip.txtField, {_text_color:0x0177C1, time:.5});
		}
		
		private function setUpState(clip:MovieClip):void
		{
			clip.mouseEnabled = true;
			Tweener.addTween(clip.txtField, {_text_color:0xC6C6C6, time:.5});
		}
	}
}