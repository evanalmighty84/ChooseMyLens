package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import recomendations.Recomender;
	import caurina.transitions.Tweener;
	import com.adobe.serialization.json.JSON; 
	import com.hoya.model.ProviderVO;
	import com.hoya.model.CertVO;
	import caurina.transitions.Tweener;
	import flash.events.KeyboardEvent;
	import com.hoya.util.TrackingUtil;
	import com.blitzagency.xray.logger.XrayLog;
	
	 
	public class EmailClip extends MovieClip
	{	
		public static const BACK_CLICK:String = "Back Click";
		private var _recommender:Recomender;
		private var _buttonArray:Array = new Array();
		private var _currentButton:ProviderButton;
		private var _allowScroll:Boolean = false;
		private var _providerVOArray:Array;
		private var _emailEnabled:Boolean = false;
		private var _privacyPolicyURL:String;
		private var _firstRun:Boolean = true;
		private var _timer:Timer;
		private var _lid:String;
		private var _gid:String;
		private var _googleMapsAPI:String;
		private var _xmlData:XML;
		private var _trackingUtil:TrackingUtil = TrackingUtil.getInstance();
		//private var _log:XrayLog = new XrayLog();
				
		public function EmailClip()
		{
			super();
			this.mouseEnabled = false;
			this.mouseChildren = false;
			zipTextInput.restrict = "0-9";
			zipTextInput.maxChars = 5;
			zipTextInput.addEventListener(Event.CHANGE, onZipTextInput);
			zipTextInput.addEventListener(MouseEvent.MOUSE_DOWN, clearTextField);
			emailTextInput.addEventListener(Event.CHANGE, onEmailTextInput);
			emailTextInput.addEventListener(MouseEvent.MOUSE_DOWN, clearTextField);
			spamCheckBoxClip.addEventListener(SpamCheckboxClip.BUTTON_CLICKED, spamButtonClick);
			//privacyPolicyButton.useHandCursor = true;
			//privacyPolicyButton.addEventListener(MouseEvent.CLICK, onPrivacyClick);
			printResultsButton.useHandCursor = true;
			printResultsButton.addEventListener(MouseEvent.CLICK, onPrintClick);
			emailResultsButton.useHandCursor = true;
			emailResultsButton.addEventListener(MouseEvent.CLICK, onEmailClick);
			backToRecommendationButton.useHandCursor = true;
			backToRecommendationButton.addEventListener(MouseEvent.CLICK, onBackClick);
			scrollThumb.visible = false;
			scrollThumb.buttonMode = true;
			scrollThumb.useHandCursor = true;
			scrollThumb.addEventListener(MouseEvent.MOUSE_DOWN, startScroll);
			scrollThumb.addEventListener(MouseEvent.MOUSE_UP, endScroll);
			scrollBackground.alpha = .5;
			this.addEventListener(KeyboardEvent.KEY_DOWN, keyListener);
		}
		
		public function set lid(newVal:String):void
		{
			_lid = newVal;
		}
		
		public function set gid(newVal:String):void
		{
			_gid = newVal;
		}
		
		public function set googleMapsAPI(newVal:String):void
		{
			_googleMapsAPI = newVal;
		}
		
		public function set xmlData(newVal:XML):void
		{
			_xmlData = newVal;
		}
		
		public function set recommender(newVal:Recomender):void
		{
			_recommender = newVal;
		}
		
		public function init():void
		{
			mapContainer.googleMapsAPI = _googleMapsAPI;
			mapContainer.init();
		}
		
		public function enable():void
		{
			if(_firstRun)
			{
				_firstRun = false;
				if(_gid.length > 0)
				{
					zipTextInput.visible = false;
					zipLabel.visible = false;
					_recommender.GetProvidersFromGID(_gid, zipTextInputCallback);
				}
				else if(_lid.length > 0)
				{
					zipTextInput.visible = false;
					zipLabel.visible = false;
					_recommender.GetProvidersFromLID(_lid, zipTextInputCallback);
				}
				else
				{
					zipTextInput.text = _recommender._zipCode;
					_recommender.GetProvidersFromZip(zipTextInput.text, zipTextInputCallback);
				}
			}
		}
		
		public function set privacyPolicyURL(newVal:String):void
		{
			_privacyPolicyURL = newVal;
		}
		
		private function clearTextField(e:MouseEvent):void
		{
			var txtField:TextField = e.currentTarget as TextField;
			txtField.text = "";
		}
		
		private function onZipTextInput(e:Event):void
		{
			if(zipTextInput.text.length == 5)
			{
				_recommender.GetProvidersFromZip(zipTextInput.text, zipTextInputCallback);
			}
		}
		
		private function onEmailTextInput(e:Event):void
		{
			if(emailTextInput.text.indexOf("@") >= 0)
			{
				_emailEnabled = true;
			}
			else
			{
				_emailEnabled = false;
			}
		}
		
		private function zipTextInputCallback(e:Event):void
		{
			var certList:XMLList = _xmlData.lens.certs.elements("cert");
			var loader:URLLoader = e.currentTarget as URLLoader;
			var results:Object = JSON.decode(loader.data as String); 
			_providerVOArray = new Array();
			for (var i:Object in results) 
			{ 
				for(var j:Object in results[i])
				{
					var providerVO:ProviderVO = new ProviderVO;
					providerVO.providerID = results[i][j].id;
					providerVO.providerName = results[i][j].name;
					providerVO.providerAddress = results[i][j].address;
					providerVO.providerCity = results[i][j].city;
					providerVO.providerState = results[i][j].state;
					providerVO.providerZip = results[i][j].zip;
					providerVO.providerPhone = results[i][j].phone;
					providerVO.providerURL = results[i][j].url;					
					var certString:String = results[i][j].certs;
					if(certString.length > 0)
					{
						var tempArray:Array = new Array();
						tempArray = certString.split("|");
						for(var c:int = 0; c < tempArray.length; c++)
						{
							var certVO:CertVO = new CertVO();
							certVO.imageURL = tempArray[c];
							for(var cl:int = 0; cl < certList.length(); cl++)
							{
								if(certVO.imageURL == certList[cl].imageURL)
								{
									certVO.titleText = certList[cl].titleText;
									certVO.copyText = certList[cl].copyText;
								}
							}
							providerVO.certs.push(certVO);
						}
					}
					_providerVOArray.push(providerVO);
				}
				
			}
			cleanUp();
			createItems();
			setupScroll();
		}
		
		private function cleanUp():void
		{
			for(var i:int = 0; i < _buttonArray.length; i++)
			{
				var button:ProviderButton = _buttonArray[i] as ProviderButton;
				button.removeEventListener(MouseEvent.MOUSE_OVER, providerRollOver);
				button.removeEventListener(MouseEvent.MOUSE_OUT, providerRollOut);
				button.removeEventListener(ProviderButton.PROVIDER_CLICK, providerClick);
				providerClip.removeChild(button);
			}
		}
		
		private function createItems():void
		{
			var count:int = 0;
			_buttonArray = new Array();
			for(var i:int = 0; i < _providerVOArray.length; i++)
			{
				var button:ProviderButton = new ProviderButton();
				button.providerVO = _providerVOArray[i] as ProviderVO;
				button.init();
				button.alpha = .5;
				button.buttonMode = true;
				button.useHandCursor = true;
				button.addEventListener(MouseEvent.MOUSE_OVER, providerRollOver);
				button.addEventListener(MouseEvent.MOUSE_OUT, providerRollOut);
				button.addEventListener(ProviderButton.PROVIDER_CLICK, providerClick);
				button.addEventListener(ProviderButton.BADGE_CLICK, badgeClick);
				button.addEventListener(ProviderButton.VIEW_MAP_CLICK, viewMapClick);
				var previousButton:ProviderButton;
				count++;
				if(count > 3)
				{
					count = 1;
				}
				
				if(i > 0)
				{
					switch(count)
					{
						case 1:
							previousButton = _buttonArray[i - 3] as ProviderButton;
							button.x = previousButton.x;
							button.y = previousButton.y + previousButton.height + 13;
							break;
						case 2:
							previousButton = _buttonArray[i - 1] as ProviderButton;
							button.x = previousButton.x + previousButton.width + 13;
							button.y = previousButton.y;
							break;
						case 3:
							previousButton = _buttonArray[i - 1] as ProviderButton;
							button.x = previousButton.x + previousButton.width + 13;
							button.y = previousButton.y;
							break;
					}
				}
				else
				{
					button.x = 0;
					button.y = 0;
				}
				_buttonArray.push(button);
				providerClip.addChild(button);
			}
			if(_buttonArray.length > 0)
			{
				_currentButton = _buttonArray[0] as ProviderButton;
				_currentButton.alpha = 1;
				var providerVO:ProviderVO = _currentButton.providerVO;
				_recommender.AnswerQuestion17(providerVO.providerID);
			}
		}
		
		private function setupScroll():void
		{
			scrollThumb.y = scrollBackground.y;
			providerClip.y = 280;
			if(providerClip.height > 175)
			{
				scrollThumb.visible = true;
				scrollBackground.alpha = 1;
				_allowScroll = true;
			}
			else
			{
				scrollThumb.visible = false;
				_allowScroll = false;
				scrollBackground.alpha = .5;
			}
		}
		
		private function startScroll(e:MouseEvent):void
		{
			if(_allowScroll)
			{
				var bounds:Rectangle = new Rectangle(scrollBackground.x - 5, scrollBackground.y, 0, scrollBackground.height - scrollThumb.height);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, updateScroll);
				stage.addEventListener(MouseEvent.MOUSE_UP, endScroll);
				scrollThumb.startDrag(false, bounds);
			}
		}
		
		private function updateScroll(e:MouseEvent):void
		{
			var moveVal:Number = (providerClip.height - 175)/(scrollBackground.height - scrollThumb.height); 
			var diff:Number = scrollThumb.y - scrollBackground.y
			providerClip.y = Math.round(diff * -1 * moveVal + 280);
		}
		
		private function endScroll(e:MouseEvent):void
		{
			if(_allowScroll)
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, updateScroll);
				stage.removeEventListener(MouseEvent.MOUSE_UP, endScroll);
				scrollThumb.stopDrag();
			}
		}
		
		private function providerRollOver(e:MouseEvent):void
		{
			var button:ProviderButton = e.currentTarget as ProviderButton;
			button.alpha = 1;
		}
		
		private function providerRollOut(e:MouseEvent):void
		{
			var button:ProviderButton = e.currentTarget as ProviderButton;
			if(button != _currentButton)
			{
				button.alpha = .5;
			}
		}
		
		private function providerClick(e:Event):void
		{
			if(_currentButton)
			{
				_currentButton.alpha = .5;
			}
			_currentButton = e.currentTarget as ProviderButton;
			_currentButton.alpha = 1;
			var providerVO:ProviderVO = _currentButton.providerVO;
			_recommender.AnswerQuestion17(providerVO.providerID);
		}
		
		private function onPrintClick(e:MouseEvent):void
		{
			_recommender.PrintResults();
			_recommender.BuildRecs();
			_recommender.FinalizeRecomendations();
			_trackingUtil.trackEvent("RECOMMENDATION", "CLICK ACTION", "PRINT MY RESULTS");
		}
		
		private function keyListener(e:KeyboardEvent):void
		{
			if(e.charCode == 13)
			{
				onEmailClick();
			}
		}
		
		private function onEmailClick(e:MouseEvent = null):void
		{
			if(_emailEnabled)
			{
				emailResultsButton.mouseEnabled = false;
				emailResultsButton.useHandCursor = false;
				_timer = new Timer(10000, 1);
				_timer.addEventListener(TimerEvent.TIMER_COMPLETE, enableEmailButton);
				_timer.start();
				Tweener.addTween(emailSentLabel, {alpha:1, time:.5, transition:"linear"});
				spamButtonClick();
				_recommender.SaveEmail(emailTextInput.text);
				_recommender.SendEmail(emailTextInput.text);
				_recommender.BuildRecs();
				_recommender.FinalizeRecomendations();
				_trackingUtil.trackEvent("RECOMMENDATION", "CLICK ACTION", "EMAIL MY RESULTS");
			}
		}
		
		private function enableEmailButton(e:TimerEvent):void
		{
			_timer.removeEventListener(TimerEvent.TIMER_COMPLETE, enableEmailButton);
			emailResultsButton.mouseEnabled = true;
			emailResultsButton.useHandCursor = true;
		}
		
		private function onBackClick(e:MouseEvent):void
		{
			dispatchEvent(new Event(BACK_CLICK));
		}
		
		private function spamButtonClick(e:Event = null):void
		{
			_recommender.OptIn(spamCheckBoxClip.selected);
		}
		
		private function badgeClick(e:Event):void
		{
			var providerButton:ProviderButton = e.target as ProviderButton;
			certificationClip.certs = providerButton.providerVO.certs;
			certificationClip.init();
			certificationClip.mouseEnabled = true;
			certificationClip.mouseChildren = true;
			Tweener.addTween(certificationClip, {alpha:1, time:.5, transition:"linear"});
		}
		
		private function viewMapClick(e:Event):void
		{
			
			var providerButton:ProviderButton = e.currentTarget as ProviderButton;
			//_log.debug("providerButton :: " + providerButton);
			//_log.debug("providerButton.providerVO :: " + providerButton.providerVO);
			mapContainer.updateLocation(providerButton.providerVO);
		}
	}
}