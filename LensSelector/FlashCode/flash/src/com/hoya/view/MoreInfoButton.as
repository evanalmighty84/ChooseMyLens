package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.hoya.model.MoreInfoVO;
	
	public class MoreInfoButton extends MovieClip
	{	
		public static const MORE_INFO_CLICK:String = "More Info Click";
		private var _dataVO:MoreInfoVO;
		
		public function MoreInfoButton()
		{
			super();
			button.buttonMode = true;
			button.useHandCursor = true;
			button.addEventListener(MouseEvent.CLICK, onButtonClick);
		}
		
		public function get dataVO():MoreInfoVO
		{
			return _dataVO;
		}
		
		public function set dataVO(newVal:MoreInfoVO):void
		{
			_dataVO = newVal;
			setData();
		}
		
		private function setData():void
		{
			headerText.text = _dataVO.headerText;
			subHeaderText.text = _dataVO.subHeaderText;
		}
		
		private function onButtonClick(e:MouseEvent):void
		{
			dispatchEvent(new Event(MORE_INFO_CLICK));
		}
	}
}