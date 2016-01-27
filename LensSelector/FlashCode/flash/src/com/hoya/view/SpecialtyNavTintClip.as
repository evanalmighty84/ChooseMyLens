package com.hoya.view
{
	import flash.display.MovieClip;
	import com.hoya.model.SpecialtyNavElementVO;
	
	public class SpecialtyNavTintClip extends MovieClip
	{	
		private var _elementVO:SpecialtyNavElementVO;
		
		public function SpecialtyNavTintClip()
		{
			super();
		}
		
		public function get elementVO():SpecialtyNavElementVO
		{
			return _elementVO;
		}
		
		public function set elementVO(newVal:SpecialtyNavElementVO):void
		{
			_elementVO = newVal;
		}
	}
}