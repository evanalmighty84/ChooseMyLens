package com.hoya.view
{
	import flash.display.MovieClip;
	import caurina.transitions.Tweener;
	
	public class FooterClip extends MovieClip
	{
		public static const ABOUT:String = "About";
		public static const LIFE_STYLE:String = "Life Style";
		public static const EYE_CARE:String = "Eye Care";
		public static const LEISURE:String = "Leisure";
		public static const SUMMARY:String = "Summary";
		public static const LENS_RECOMMENDATIONS:String = "Life Recommendations";
		
		private var _previousClip:MovieClip;
		private var _currentClip:MovieClip;
		private var _previousArrow:MovieClip;
		private var _currentArrow:MovieClip;
		
		public function FooterClip()
		{
			super();
		}
		
		public function updateView(index:int, total:int, section:String):void
		{
			counterClip.indexTextField.text = String(index);
			counterClip.totalTextField.text = String(total);
			showClip(counterClip);
			
			if(_currentClip)
			{
				_previousClip = _currentClip;
				hideClip(_previousClip);
			}
			
			if(_currentArrow)
			{
				_previousArrow = _currentArrow;
				hideArrow(_previousArrow);
			}
			
			switch(section)
			{
				case ABOUT:
					_currentClip = aboutLabel;
					_currentArrow = aboutArrow;
					break;
				case LIFE_STYLE:
					_currentClip = lifestyleLabel;
					_currentArrow = lifestyleArrow
					break;
				case EYE_CARE:
					_currentClip = eyeCareLabel;
					_currentArrow = eyeCareArrow;
					break;
				case LEISURE:
					_currentClip = leisureLabel;
					_currentArrow = leisureArrow;
					break;
				case SUMMARY:
					_currentClip = summaryLabel;
					_currentArrow = summaryArrow;
					break;
				case LENS_RECOMMENDATIONS:
					_currentClip = recommendationsLabel;
					_currentArrow = recommendationsArrow;
					break;
			}
			showClip(_currentClip);
			showArrow(_currentArrow);
		}
		
		private function showClip(clip:MovieClip):void
		{
			Tweener.addTween(clip, {alpha:1, time:.5, transition:"linear"});
		}
		
		private function hideClip(clip:MovieClip):void
		{
			Tweener.addTween(clip, {alpha:.5, time:.5, transition:"linear"});
		}
		
		private function showArrow(clip:MovieClip):void
		{
			Tweener.addTween(clip, {alpha:.75, time:.5, transition:"linear"});
		}
		
		private function hideArrow(clip:MovieClip):void
		{
			Tweener.addTween(clip, {alpha:0, time:.5, transition:"linear"});
		}
	}
}