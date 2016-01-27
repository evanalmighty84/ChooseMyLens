package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.hoya.model.MoreInfoVO;
	import caurina.transitions.Tweener;
	import recomendations.Recomender;
	
	public class SpecialtyClip extends MovieClip
	{	
		public static const SHOW_LOADER:String = "Show Loader";
		public static const HIDE_LOADER:String = "Hide Loader";
		private var _xmlData:XML;
		private var _recommender:Recomender;
		
		public function SpecialtyClip()
		{
			super();
			infoWindowClip.x = -297;
			infoWindowClip.addEventListener(InfoWindowClip.CLOSE_CLICK, closeInfoWindow);
			imageViewerClip.addEventListener(SpecialtyImageViewerClip.HIDE_LOADER, hideLoader);
			imageViewerClip.addEventListener(SpecialtyImageViewerClip.UPDATE_TINT_LABEL, updateTintLabel);
			changeActivitiesButton.addEventListener(MouseEvent.CLICK, changeActivityButtonClick);
			changeActivityClip.addEventListener(ChangeActivityClip.CHANGE_ACTIVITY, changeActivity);
			designClip.addEventListener(MoreInfoButton.MORE_INFO_CLICK, showMoreInfo);
			materialsClip.addEventListener(MoreInfoButton.MORE_INFO_CLICK, showMoreInfo);
			treatmentClip1.addEventListener(MoreInfoButton.MORE_INFO_CLICK, showMoreInfo);
			treatmentClip2.addEventListener(MoreInfoButton.MORE_INFO_CLICK, showMoreInfo);
			treatmentClip3.addEventListener(MoreInfoButton.MORE_INFO_CLICK, showMoreInfo);
		}
		
		public function set recommender(newVal:Recomender):void
		{
			_recommender = newVal;
		}
		
		public function set xmlData(newVal:XML):void
		{
			_xmlData = newVal;
		}
		
		public function init():void
		{
			if(_recommender.specialtyType != null)
			{
				changeActivityClip.setCurrentActivity(_recommender.specialtyType);
				updateData(false);
			}
		}
		
		private function updateData(refreshContent:Boolean = true):void
		{
			var i:int;
			var count:int;
			var moreInfoVO:MoreInfoVO;
			var specialtiesList:XMLList = _xmlData.specialties.elements("sport");
			var sport:XML;

			count = specialtiesList.length();
			
			for(i = 0; i < count; i++)
			{
				if(_recommender.specialtyType == specialtiesList[i].attribute("id"))
				{
					sport = specialtiesList[i];
					break;
				}
			}
			
			imageViewerClip.xmlData = sport;
			imageViewerClip.titleText = _xmlData.lens.specialtyTitle;
			imageViewerClip.copyText = _xmlData.lens.specialtyCopy;
			showLoader();
			imageViewerClip.init();
			
			moreInfoVO = new MoreInfoVO();
			moreInfoVO.categoryText = "DESIGN:";
			moreInfoVO.headerText = sport.design.header;
			moreInfoVO.subHeaderText = sport.design.subheader;
			moreInfoVO.copyText = sport.design.copy;
			moreInfoVO.imageURL = sport.design.image;
			designClip.dataVO = moreInfoVO;
			
			moreInfoVO = new MoreInfoVO();
			moreInfoVO.categoryText = "MATERIALS:";
			moreInfoVO.headerText = sport.material.header;
			moreInfoVO.subHeaderText = sport.material.subheader;
			moreInfoVO.copyText = sport.material.copy;
			moreInfoVO.imageURL = sport.material.image;
			materialsClip.dataVO = moreInfoVO;
			
			treatmentClip1.visible = false;
			treatmentClip2.visible = false;
			treatmentClip3.visible = false;
			var treatmentList:XMLList = sport.treatment.elements("treat");
			count = treatmentList.length();
			if(count > 3)
			{
				count = 3;
			}
			var voArray:Array = new Array();
			for(i = 0; i < count; i++)
			{
				moreInfoVO = new MoreInfoVO();
				moreInfoVO.categoryText = "TREATMENTS:";
				moreInfoVO.headerText = treatmentList[i].header;
				moreInfoVO.subHeaderText = treatmentList[i].subheader;
				moreInfoVO.copyText = treatmentList[i].copy;
				moreInfoVO.imageURL = treatmentList[i].image;
				voArray.push(moreInfoVO);						
			}
			for(i = 0; i < voArray.length; i++)
			{
				var treatmentClip:MoreInfoButton = this.getChildByName("treatmentClip" + (i + 1)) as MoreInfoButton;
				treatmentClip.dataVO = voArray[i] as MoreInfoVO;
				treatmentClip.visible = true;
				tintLabelClip.y = treatmentClip.y + treatmentClip.height;
			}
			
			updateTintLabel();
			
			if(refreshContent)
			{
				showClip();
			}
		}
		
		private function updateTintLabel(e:Event = null):void
		{
			tintLabelClip.navElementVO = imageViewerClip.currentElement;
			_recommender.AnswerQuestion15(imageViewerClip.currentElement.tintName);
		}
		
		private function changeActivity(e:Event):void
		{
			_recommender.specialtyType = changeActivityClip.currentActivity;
			_recommender.AnswerQuestion14(changeActivityClip.currentActivity);
			hideChangeActivityClip();
			hideClip();
		}
		
		private function hideClip():void
		{
			Tweener.addTween(this, {delay:.5 ,alpha:0, time:.5, transition:"linear", onComplete:updateData});
		}
		
		private function showClip():void
		{
			Tweener.addTween(this, {alpha:1, time:.5, transition:"linear"});
		}
		
		private function changeActivityButtonClick(e:MouseEvent):void
		{
			if(changeActivityClip.currentState == ChangeActivityClip.STATE_OPEN)
			{
				hideChangeActivityClip();
			}
			else if(changeActivityClip.currentState == ChangeActivityClip.STATE_CLOSED)
			{
				showChangeActivityClip();
			}
		}
		
		private function showChangeActivityClip():void
		{
			changeActivityClip.mouseEnabled = true;
			changeActivityClip.mouseChildren = true;
			changeActivityClip.currentState = ChangeActivityClip.STATE_OPEN;
			Tweener.addTween(changeActivityClip, {y:316, time:1, transition:"easeOutCubic"});
		}
		
		private function hideChangeActivityClip():void
		{
			changeActivityClip.mouseEnabled = false;
			changeActivityClip.mouseChildren = false;
			changeActivityClip.currentState = ChangeActivityClip.STATE_CLOSED;
			Tweener.addTween(changeActivityClip, {y:525, time:1, transition:"easeInCubic"});
		}
		
		private function playLoaderAnimation():void
		{
			loaderAnimationClip.gotoAndPlay("loop");
		}
		
		private function stopLoaderAnimation():void
		{
			loaderAnimationClip.gotoAndStop("paused");
		}
		
		private function showLoader():void
		{
			Tweener.addTween(loaderAnimationClip, {alpha:1, time:.25, transition:"linear", onComplete:playLoaderAnimation});
		}
		
		private function hideLoader(e:Event):void
		{
			Tweener.addTween(loaderAnimationClip, {alpha:0, time:.25, transition:"linear", onComplete:stopLoaderAnimation});
		}
		
		private function showMoreInfo(e:Event):void
		{
			var clip:MoreInfoButton = e.currentTarget as MoreInfoButton;
			infoWindowClip.dataVO = clip.dataVO;
			openInfoWindow();
		}
		
		private function openInfoWindow():void
		{
			this.mouseEnabled = true;
			Tweener.addTween(infoWindowClip, {x:326, time:1.25, transition:"easeOutCubic"});
		}
		
		private function closeInfoWindow(e:Event):void
		{
			this.mouseEnabled = false;
			Tweener.addTween(infoWindowClip, {x:-297, time:1.25, transition:"easeInCubic"});
		}
	}
}