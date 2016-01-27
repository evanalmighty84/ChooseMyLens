package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import com.hoya.model.SpecialtyNavElementVO;
	import caurina.transitions.Tweener;
	
	public class TintLabelClip extends MovieClip
	{	
		private var _navElementVO:SpecialtyNavElementVO;
		
		public function TintLabelClip()
		{
			super();
			txtField.autoSize = TextFieldAutoSize.LEFT;
			txtField.multiline = false;
			txtField.wordWrap = false;
		}
		
		public function get navElementVO():SpecialtyNavElementVO
		{
			return _navElementVO;
		}
		
		public function set navElementVO(newVal:SpecialtyNavElementVO):void
		{
			_navElementVO = newVal;
			updateData();
		}
		
		private function updateData():void
		{
			txtField.width = 10;
			txtField.text = _navElementVO.tintName;
			tintColorClip.graphics.clear();
			tintColorClip.graphics.beginFill(new uint("0x" + _navElementVO.tintValue), 1);
			tintColorClip.graphics.drawRect(0, 0, tintColorClip.width, tintColorClip.height);
			tintColorClip.x = Math.round(txtField.x + txtField.width + 10);
			tintColorClip.alpha = 1;
		}
	}
}