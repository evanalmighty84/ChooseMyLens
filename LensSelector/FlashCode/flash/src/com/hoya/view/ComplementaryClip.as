package com.hoya.view
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import com.hoya.model.MoreInfoVO;
	import recomendations.Lens;
	import caurina.transitions.Tweener;
	
	public class ComplementaryClip extends MovieClip
	{	
		public static const HIDE_LOADER:String = "Hide Loader";
		private var _xmlData:XML;
		private var _lens:Lens;
		
		
		public function ComplementaryClip()
		{
			super();			
			infoWindowClip.x = -297;
			infoWindowClip.addEventListener(InfoWindowClip.CLOSE_CLICK, closeInfoWindow);
			imageViewerClip.addEventListener(ImageViewerClip.HIDE_LOADER, hideLoader);
			designClip.addEventListener(MoreInfoButton.MORE_INFO_CLICK, showMoreInfo);
			materialsClip.addEventListener(MoreInfoButton.MORE_INFO_CLICK, showMoreInfo);
			treatmentClip1.addEventListener(MoreInfoButton.MORE_INFO_CLICK, showMoreInfo);
			treatmentClip2.addEventListener(MoreInfoButton.MORE_INFO_CLICK, showMoreInfo);
			treatmentClip3.addEventListener(MoreInfoButton.MORE_INFO_CLICK, showMoreInfo);
		}
		
		public function set lens(newVal:Lens):void
		{
			_lens = newVal;
		}
		
		public function set xmlData(newVal:XML):void
		{
			_xmlData = newVal;
		}
		
		public function init():void
		{
			var i:int;
			var count:int;
			var moreInfoVO:MoreInfoVO;
			var thumbList:XMLList = _xmlData.lens.complementaryThumbs.elements("image");
			count = thumbList.length();
			for(i = 0; i < count; i++)
			{
				imageViewerClip.thumbArray.push(thumbList[i]); 
			}
			
			var imageList:XMLList = _xmlData.lens.complementaryImages.elements("image");
			count = imageList.length();
			for(i = 0; i < count; i++)
			{
				imageViewerClip.imageArray.push(imageList[i]); 
			}
			imageViewerClip.titleText = _xmlData.lens.complementaryTitle;
			imageViewerClip.copyText = _xmlData.lens.complementaryCopy;
			showLoader();
			imageViewerClip.init();
			var designList:XMLList = _xmlData.lens.designs.elements("design");
			count = designList.length();
			for(i = 0; i < count; i++)
			{
				if(_lens.Design == designList[i].attribute("id"))
				{
					moreInfoVO = new MoreInfoVO();
					moreInfoVO.categoryText = "DESIGN:";
					moreInfoVO.headerText = designList[i].header;
					moreInfoVO.subHeaderText = designList[i].subheader;
					moreInfoVO.copyText = designList[i].copy;
					moreInfoVO.imageURL = designList[i].image;
					break;
				}
			}
			designClip.dataVO = moreInfoVO;
			var materialList:XMLList = _xmlData.lens.materials.elements("material");
			count = materialList.length();
			for(i = 0; i < count; i++)
			{

				if(materialList[i].attribute("id") == _lens.Material)
				{
					moreInfoVO = new MoreInfoVO();
					moreInfoVO.categoryText = "MATERIALS:";
					moreInfoVO.headerText = materialList[i].header;
					moreInfoVO.subHeaderText = materialList[i].subheader;
					moreInfoVO.copyText = materialList[i].copy;
					moreInfoVO.imageURL = materialList[i].image;
				}
			}
			materialsClip.dataVO = moreInfoVO;

			
			treatmentClip1.visible = false;
			treatmentClip2.visible = false;
			treatmentClip3.visible = false;
			count = _lens.Treatments.length;
			var treatmentList:XMLList = _xmlData.lens.treatments.elements("treatment");
			var secondCount:int = treatmentList.length();
			var voArray:Array = new Array();
			if(count > 3)
			{
				count = 3;
			}
			for(i = 0; i < count; i++)
			{
				for(var j:int = 0; j < secondCount; j++)
				{
					if(_lens.Treatments[i] == treatmentList[j].attribute("id"))
					{
						moreInfoVO = new MoreInfoVO();
						moreInfoVO.categoryText = "TREATMENTS:";
						moreInfoVO.headerText = treatmentList[j].header;
						moreInfoVO.subHeaderText = treatmentList[j].subheader;
						moreInfoVO.copyText = treatmentList[j].copy;
						moreInfoVO.imageURL = treatmentList[j].image;
						voArray.push(moreInfoVO);						
					}
				}
			}
			
			for(i = 0; i < voArray.length; i++)
			{
				var treatmentClip:MoreInfoButton = this.getChildByName("treatmentClip" + (i + 1)) as MoreInfoButton;
				treatmentClip.dataVO = voArray[i] as MoreInfoVO;
				treatmentClip.visible = true;
				tintLabelClip.y = treatmentClip.y + treatmentClip.height;
			}
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