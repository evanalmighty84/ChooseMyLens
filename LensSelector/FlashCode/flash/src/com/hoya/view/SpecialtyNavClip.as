package com.hoya.view
{
	import fl.motion.Color;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.hoya.model.SpecialtyNavElementVO;
	import caurina.transitions.Tweener;
	
	public class SpecialtyNavClip extends MovieClip
	{
		public static const ELEMENT_CLICK:String = "Element Click";
		public static const SHOW_DESCRIPTION:String = "SHOW DESCRIPTION";
		public static const HIDE_DESCRIPTION:String = "HIDE DESCRIPTION";
		private var _xmlData:XML;
		private var _currentElement:SpecialtyNavElementVO;
		private var _rollOverElement:SpecialtyNavElementVO;
		private var _selectedElement:SpecialtyNavTintClip;
		private var _elementVOArray:Array;
		private var _elementArray:Array = new Array();
		private var _enableScroll:Boolean;
		private var _leftBoundary:int;
		private var _rightBoundary:int;
		public var hideDescription:Boolean = true;
		
		
		public function SpecialtyNavClip()
		{
			super();
		}
		
		public function set xmlData(newVal:XML):void
		{
			_xmlData = newVal;
			setupData();
		}
		
		public function get currentElement():SpecialtyNavElementVO
		{
			return _currentElement;
		}
		
		private function setupData():void
		{
			_elementVOArray = new Array();
			var xmlList:XMLList = _xmlData.tints.elements("tint");
			for(var i:int = 0; i < xmlList.length(); i++)
			{
				var element:SpecialtyNavElementVO = new SpecialtyNavElementVO();
				element.tintName = xmlList[i].attribute("id");
				element.tintCopy = xmlList[i].copy;
				element.tintValue = xmlList[i].hex;
				element.index = i;
				_elementVOArray.push(element);
			}
		}
		
		public function init():void
		{
			cleanUp();
			createElements();
			positionElements();
			setInitialElement();
			setupScroll();
		}
		
		private function cleanUp():void
		{
			for(var i:int = 0; i < _elementArray.length; i++)
			{
				var tintClip:SpecialtyNavTintClip = _elementArray[i] as SpecialtyNavTintClip;
				elementClip.removeChild(tintClip);
			}
		}
		
		private function createElements():void
		{
			_elementArray = new Array();
			for(var i:int = 0; i < _elementVOArray.length; i++)
			{
				var tintClip:SpecialtyNavTintClip = new SpecialtyNavTintClip();
				tintClip.elementVO = _elementVOArray[i] as SpecialtyNavElementVO;
				var tint:Color = new Color();
				tint.setTint(new uint("0x" + tintClip.elementVO.tintValue), 1);
				tintClip.transform.colorTransform = tint;
				tintClip.alpha = .5;
				tintClip.buttonMode = true;
				tintClip.useHandCursor = true;
				tintClip.addEventListener(MouseEvent.CLICK, elementClick);
				tintClip.addEventListener(MouseEvent.ROLL_OVER, elementRollover);
				tintClip.addEventListener(MouseEvent.ROLL_OUT, elementRollOut);
				_elementArray.push(tintClip);
			}
		}
		
		private function positionElements():void
		{
			for(var i:int = 0; i < _elementArray.length; i++)
			{
				var currentElement:SpecialtyNavTintClip = _elementArray[i] as SpecialtyNavTintClip;
				if(i > 0)
				{
					var previousElement:SpecialtyNavTintClip = _elementArray[i - 1] as SpecialtyNavTintClip;
					currentElement.x = previousElement.x + previousElement.width;
				}
				else
				{
					currentElement.x = 0;
				}
				elementClip.addChild(currentElement);
			}
			elementClip.addChildAt(elementClip.pointerClip, elementClip.numChildren - 1);
		}
		
		private function setInitialElement():void
		{
			_selectedElement = _elementArray[0] as SpecialtyNavTintClip;
			_currentElement = _selectedElement.elementVO;
			tintLabel.text = _currentElement.tintName;
			tintDescription.copyText.text = _currentElement.tintCopy;
			tintDescription.alpha = 0;
			_selectedElement.alpha = 1;
			elementClip.pointerClip.x = _selectedElement.x;
		}
		
		private function elementClick(e:MouseEvent):void
		{
			var element:SpecialtyNavTintClip = e.currentTarget as SpecialtyNavTintClip;
			elementClip.pointerClip.x = element.x;
			if(_selectedElement != element)
			{
				Tweener.addTween(_selectedElement, {alpha:.5, time:.25, transition:"linear"});
				Tweener.addTween(element, {alpha:1, time:.25, transition:"linear"});
				_selectedElement = element;
				_currentElement = element.elementVO;
				tintLabel.text = _currentElement.tintName;
				tintDescription.copyText.text = _currentElement.tintCopy;
			}
			dispatchEvent(new Event(ELEMENT_CLICK));
		}
		
		private function elementRollover(e:MouseEvent):void
		{
			var element:SpecialtyNavTintClip = e.currentTarget as SpecialtyNavTintClip;
			tintLabel.text = element.elementVO.tintName;
			Tweener.addTween(element, {alpha:1, time:.25, transition:"linear"});
			tintDescription.copyText.text = element.elementVO.tintCopy;
			showTintDescription();
		}
		
		public function showTintDescription():void
		{
			if(hideDescription)
			{
				dispatchEvent(new Event(SHOW_DESCRIPTION));
				Tweener.addTween(tintDescription, {alpha:1, time:.25, transition:"linear"});
			}
		}
		
		private function hideTintDescription():void
		{
			if(hideDescription)
			{
				dispatchEvent(new Event(HIDE_DESCRIPTION));
				Tweener.addTween(tintDescription, {alpha:0, time:.25, transition:"linear"});
			}
		}
		
		private function elementRollOut(e:MouseEvent):void
		{
			hideTintDescription();
			var element:SpecialtyNavTintClip = e.currentTarget as SpecialtyNavTintClip;
			if(_currentElement != element.elementVO)
			{
				tintLabel.text = _currentElement.tintName;
				Tweener.addTween(element, {alpha:.5, time:.25, transition:"linear"});
			}
			tintDescription.copyText.text = _currentElement.tintCopy;
		}		
		
		private function setupScroll():void
		{
			setupBounds();
			if(_enableScroll)
			{
				leftButton.alpha = .5;
				leftButton.buttonMode = true;
				leftButton.useHandCursor = true;
				leftButton.mouseEnabled = false;
				
				rightButton.alpha = 1;
				rightButton.buttonMode = true;
				rightButton.useHandCursor = true;
				rightButton.mouseEnabled = true;
				
				
				leftButton.addEventListener(MouseEvent.ROLL_OVER, slideRight);
				leftButton.addEventListener(MouseEvent.ROLL_OUT, removeTweens);
				rightButton.addEventListener(MouseEvent.ROLL_OVER, slideLeft);
				rightButton.addEventListener(MouseEvent.ROLL_OUT, removeTweens);
			}
			else
			{
				leftButton.mouseEnabled = false;
				leftButton.alpha = .5;
				rightButton.mouseEnabled = false;
				rightButton.alpha = .5;
			}
		}
		
		private function setupBounds():void
		{
			_leftBoundary = leftButton.x + leftButton.width;
			_rightBoundary = rightButton.x;
			elementClip.x = _leftBoundary;
			var rightPos:int = elementClip.x + elementClip.width;
			if(_elementArray.length > 6)
			{
				_enableScroll = true;
			}
			else
			{
				_enableScroll = false;
			}
		}
		
		private function slideLeft(e:MouseEvent):void
		{
			rightButton.gotoAndStop("over");
			var newPos:Number = _rightBoundary - elementClip.width;
			var rate:Number = (elementClip.x - newPos) * .0080;
			Tweener.addTween(elementClip, {x:newPos, time:rate, transition:"linear", onComplete:removeTweens});
		}
		
		private function removeTweens(e:MouseEvent = null):void
		{
			evalPosition();
			Tweener.removeTweens(elementClip);
		}
		
		private function slideRight(e:MouseEvent):void
		{
			leftButton.gotoAndStop("over");
			var newPos:Number = _leftBoundary;
			var rate:Number = (Math.abs(elementClip.x - newPos) * .0080);
			Tweener.addTween(elementClip, {x:newPos, time:rate, transition:"linear", onComplete:removeTweens});
		}
		
		private function evalPosition():void
		{
			var leftPos:Number = elementClip.x;
			var rightPos:Number = elementClip.x + elementClip.width;
			if(leftPos >= _leftBoundary)
			{
				leftButton.alpha = .5;
				leftButton.gotoAndStop("up");
				leftButton.mouseEnabled = false;
			}
			else
			{
				leftButton.alpha = 1;
				leftButton.mouseEnabled = true;
			}
			
			if(rightPos <= _rightBoundary)
			{
				rightButton.alpha = .5;
				rightButton.gotoAndStop("up");
				rightButton.mouseEnabled = false;
			}
			else
			{
				rightButton.alpha = 1;
				rightButton.mouseEnabled = true;
			}
		}
	}
}