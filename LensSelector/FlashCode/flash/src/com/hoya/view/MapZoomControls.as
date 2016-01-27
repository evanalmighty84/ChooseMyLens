package  com.hoya.view
{
	import com.google.maps.controls.ControlBase
	import com.google.maps.controls.ControlPosition;
	import flash.events.MouseEvent;
	import com.google.maps.interfaces.IMap;
	import flash.display.MovieClip;
	
	public class MapZoomControls extends ControlBase
	{
		private var zoomInButton:MovieClip;
		private var zoomOutButton:MovieClip;
		
		public function MapZoomControls() 
		{
			 super(new ControlPosition(ControlPosition.ANCHOR_TOP_LEFT, 7, 7)); 
		}

		override public function initControlWithMap(map:IMap):void
		{
			super.initControlWithMap(map);
			zoomInButton = new ZoomInButton();
			zoomInButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			zoomInButton.buttonMode = true;
			zoomInButton.useHandCursor = true;
			addChild(zoomInButton);
			zoomOutButton = new ZoomOutButton();
			zoomOutButton.addEventListener(MouseEvent.CLICK, onButtonClick);
			zoomOutButton.buttonMode = true;
			zoomOutButton.useHandCursor = true;
			zoomOutButton.y = zoomInButton.y + zoomInButton.height + 4;
			addChild(zoomOutButton);
		}
		
		private function onButtonClick(e:MouseEvent):void
		{
			if(e.currentTarget == zoomInButton)
			{
				map.zoomIn();    
			}
			else if(e.currentTarget == zoomOutButton)
			{
				map.zoomOut();
			}
		}
	}
}