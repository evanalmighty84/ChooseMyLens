package  com.hoya.view
{
	import flash.display.MovieClip;
	import com.google.maps.Map;
	import com.google.maps.MapEvent;
	import com.google.maps.MapType;
	import com.google.maps.MapOptions;
	import com.google.maps.LatLng;
	import com.google.maps.controls.ZoomControl;
	import com.google.maps.controls.MapTypeControl;
	import com.google.maps.services.ClientGeocoder;
	import com.google.maps.services.GeocodingEvent;
	import com.google.maps.overlays.Marker;
	import com.google.maps.MapMouseEvent;
	import com.google.maps.InfoWindowOptions;
	import com.hoya.view.MapZoomControls;
	import com.hoya.model.ProviderVO;
	import caurina.transitions.Tweener;
	import flash.events.MouseEvent;
	import com.blitzagency.xray.logger.XrayLog;
	import com.google.maps.services.DirectionsEvent;
	import com.google.maps.services.Directions;
	import com.google.maps.overlays.MarkerOptions;
	
	public class MapContainer extends MovieClip
	{
		private var map:Map;
		private var clientGeocoder:ClientGeocoder;
		private var defaultLocation:LatLng = new LatLng(33.0220709, -96.974753);
		private var marker:Marker;
		private var directions:Directions;
		private var placemarks:Array;
		private var _googleMapsAPI;
		private var geocodeSuccess:Boolean = false;
		private var _providerVO:ProviderVO;
		
		private var _log:XrayLog = new XrayLog();
		
		public function MapContainer() 
		{
			this.visible = false;
			this.alpha = 0;
		}
		
		public function set googleMapsAPI(newVal:String):void
		{
			_googleMapsAPI = newVal;
		}
		
		public function init():void
		{
			backButton.addEventListener(MouseEvent.CLICK, closeMap);
			directionsButton.addEventListener(MouseEvent.CLICK, onDirectionsClick);
			map = new Map();
			map.key = _googleMapsAPI; 
			map.sensor = "false";  
			map.addEventListener(MapEvent.MAP_PREINITIALIZE, onMapPreinitialize);
			map.addEventListener(MapEvent.MAP_READY, onMapReady);
			map.x = 22;
			map.y = 117;
			map.width = 896;
			map.height = 436;
			this.addChild(map);
		}
		
		public function updateLocation(providerVO:ProviderVO):void
		{
			resetValues();
			_providerVO = providerVO;
			providerName.htmlText = _providerVO.providerName.toUpperCase();
			var providerInfo:String = _providerVO.providerAddress + "<BR>" + _providerVO.providerCity + ", " + _providerVO.providerState + " " + _providerVO.providerZip + "<BR>PHONE:" +  _providerVO.providerPhone;
			provider.htmlText = providerInfo.toUpperCase(); 
			endAddressHeader.text = _providerVO.providerName.toUpperCase();
			var address:String = _providerVO.providerAddress + " " + _providerVO.providerCity + " " + _providerVO.providerState + " " + _providerVO.providerZip;
			endAddress.text = address.toUpperCase();
			try
			{
				doGeocoding(address);
			}
			catch(e:Error)
			{
				trace("cannot load google maps api");
			}
		}
		
		private function resetValues():void
		{
			provider.htmlText = "";
			endAddressHeader.text = "";
			endAddress.text = "";
		}
		
		private function onMapPreinitialize(e:MapEvent):void 
		{  
			try
			{
				map.removeEventListener(MapEvent.MAP_PREINITIALIZE, onMapPreinitialize);
				var mapOptions:MapOptions = new MapOptions();
				mapOptions.center = defaultLocation;
				mapOptions.zoom = 14,
				mapOptions.mapType = MapType.NORMAL_MAP_TYPE;
				map.setInitOptions(mapOptions);
				
				clientGeocoder = new ClientGeocoder();
				clientGeocoder.addEventListener(GeocodingEvent.GEOCODING_SUCCESS, onGeocodeSuccess);
				clientGeocoder.addEventListener(GeocodingEvent.GEOCODING_FAILURE, onGeocodeFailure);
				
				directions = new Directions();
				directions.addEventListener(DirectionsEvent.DIRECTIONS_SUCCESS, onDirectionsSuccess);   
				directions.addEventListener(DirectionsEvent.DIRECTIONS_FAILURE, onDirectionsFailure);  
			}
			catch(e:Error)
			{
				trace("error trying to initialize map");
			}
		}
		
		public function doGeocoding(address:String):void
		{
			clientGeocoder.geocode(address); 
			geocodeSuccess = false;
		}
		
		private function onGeocodeSuccess(e:GeocodingEvent):void
		{
			placemarks = e.response.placemarks;         
			if(placemarks.length > 0) 
			{      
				geocodeSuccess = true;
				map.clearOverlays();
				map.setCenter(placemarks[0].point);
				marker = new Marker(placemarks[0].point, new MarkerOptions({fillStyle: {color:0x0177C1}}));   
				marker.addEventListener(MapMouseEvent.CLICK, onMarkerClick);
				map.addOverlay(marker);
			}
			Tweener.addTween(this, {_autoAlpha:1, time:.5});
		}
		
		private function onMarkerClick(e:MapEvent):void
		{
			if(placemarks.length > 0)
			{
				marker.openInfoWindow(new InfoWindowOptions({title: _providerVO.providerName,  content: placemarks[0].address}));
			}
			else
			{
				marker.openInfoWindow(new InfoWindowOptions({title: "HOYA Vision Care, North America",  content: "651 E. Corporate Drive Lewisville, TX 75057"}));
			}
		}
		
		private function onGeocodeFailure(e:GeocodingEvent):void
		{
			_log.debug("onGeocodeFailure");
		}
		
		private function onMapReady(e:MapEvent):void
		{
			map.addControl(new MapZoomControls());
			map.addControl(new MapTypeControl()); 
			map.removeMapType(MapType.PHYSICAL_MAP_TYPE);
			marker = new Marker(defaultLocation);   
			marker.addEventListener(MapMouseEvent.CLICK, onMarkerClick);
			map.addOverlay(marker);
		}
		
		private function closeMap(e:MouseEvent):void
		{
			Tweener.addTween(this, {_autoAlpha:0, time:.5});
		}
		
		private function onDirectionsClick(e:MouseEvent):void
		{
			_log.debug("onDirectionsClick");
			if(startAddress.text.length > 0)
			{
				_log.debug("loading :: " + startAddress.text + " to " +  endAddress.text);
				directions.load(startAddress.text + " to " +  endAddress.text);
				
			}
		}
		
		private function onDirectionsFailure(e:DirectionsEvent):void 
		{  
			 _log.debug("onDirectionsFailure");
		}  
		
		private function onDirectionsSuccess(e:DirectionsEvent):void 
		{   
			_log.debug("onDirectionsSuccess");
			directions = e.directions as Directions;                    			
			var startMarker:Marker;   
			var endMarker:Marker;           
			map.clearOverlays();  
			map.addOverlay(directions.createPolyline());   
			map.setZoom(map.getBoundsZoomLevel(directions.bounds));  
			map.setCenter(directions.bounds.getCenter());      
			startMarker = new Marker(directions.getRoute(0).startGeocode.point, new MarkerOptions({fillStyle: {color:0x0177C1}}));   
			endMarker = new Marker(directions.getRoute(0).endGeocode.point, new MarkerOptions({fillStyle: {color:0x0177C1}}));   
			map.addOverlay(startMarker);   
			map.addOverlay(endMarker);
		}
	}
}
