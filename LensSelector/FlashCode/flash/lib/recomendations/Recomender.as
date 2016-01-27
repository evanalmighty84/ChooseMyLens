package recomendations
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.navigateToURL; 
	import flash.external.*;
	
	/**
	 * ...
	 * @author Mark Coleman
	 */
	public class Recomender 
	{
		public var baseUrl:String;
		public var Primary:Lens;
		public var Secondary:Lens;
		public var Specialty:Lens;
		public var specialtyType:String;
		public var _zipCode:String;
		private var answers:Array;
		public var service:WSConnection;
		private var rebuildRecs:Boolean;
		private var age:int;
		private var isMale:Boolean;
		
		public function Recomender(url:String) 
		{
			answers = new Array();
			Primary = new Lens();
			//Secondary = new Lens();
			//Specialty = new Lens();
			//Specialty.Design = "Nulux EP";
			//Specialty.Material = "Phoenix";
			this.baseUrl = url;
			if(this.baseUrl.charAt(this.baseUrl.length - 1) == "/")
			{
				this.baseUrl = this.baseUrl.slice(0, this.baseUrl.length - 1);
			}
			service = new WSConnection(this.baseUrl);
			service.startSession();
		}
		
		public function AnswerQuestion1(ageRange:int)
		{
			
			service.saveAnswer("1", ageRange.toString());
			answers[1] = ageRange;
		}
		
		//age question
		public function BuildQuestion1(ageRange:int)
		{
			if (ageRange < 2)
			{
				Primary.Design = "Nulux EP";
			}
			else if (ageRange == 2)
			{
				Primary.Design = "Nulux EP";
			}
			else
			{
				Primary.Progressive = true;
			}
			this.age = ageRange;
			
		}
		public function AnswerQuestion2(isMale:Boolean)
		{
			service.saveAnswer("2", isMale.toString());
			answers[2] = isMale;
		}
		public function BuildQuestion2(isMale:Boolean)
		{
			this.isMale = isMale;
			if (Primary.Progressive)
			{
				
					Primary.Design = "Lifestyle";
				
			}
		}
		public function AnswerQuestion3(zipCode:String)
		{
			_zipCode = zipCode;
			service.saveAnswer("3", zipCode);
			service.zipCode = zipCode;
		}
		public function AnswerQuestion4(Rate:int)
		{
			//this particular method looks retarded.
			//it is
			//stupid flash seems to set secondary to a referance instead of a copy of.
			service.saveAnswer("4", Rate.toString());
			answers[4] = Rate;
		}
		public function BuildQuestion4(Rate:int)
		{
			Primary.addTreatment("Anti-Reflective");
			Primary.addTreatment("Photochromic");
			if (Secondary == null)
			{
				Secondary = new Lens();
			}
			Secondary.Design = Primary.Design;
			Secondary.Material = Primary.Material;
			Secondary.Progressive = Primary.Progressive;
			Secondary.addTreatment("Anti-Reflective");
			Secondary.addTreatment("Photochromic");
			Secondary.addTreatment("Polarized");
			Secondary.addTreatment("Tint");
			Secondary.Outdoor = true;
			
			if (Rate > 50)
			{
				var temp = Primary;
				Primary = Secondary;
				Secondary = temp;
			}
		}
		public function AnswerQuestion5(SinglePair:Boolean)
		{
			service.saveAnswer("5", SinglePair.toString());
			answers[5] = SinglePair;
		}
		public function BuildQuestion5(SinglePair:Boolean)
		{
			if (SinglePair)
			{
				if (Primary.Outdoor)
				{
					Primary.removeTreatment("Tint");
				}
				else
				{
					Primary.addTreatment("Polarized");
				}
				Primary.addTreatment("Photochromic");
				Secondary = null;
			}
		}
		public function AnswerQuestion6(computer:int, tv:int, reading:int, driving:int, sports:int, crafts:int)
		{
			service.saveAnswer("6", computer + "," + tv + "," + reading + "," + driving + "," + sports + "," + crafts);
			answers[6] = { computer:computer, tv:tv, reading: reading, driving: driving, sports:sports, crafts:crafts };
		}
		public function BuildQuestion6(computer:int, tv:int, reading:int, driving:int, sports:int, crafts:int)
		{	
			if (computer > 2 || reading > 2 || crafts > 2)
			{
				if (Primary.Progressive)
				{
					Primary.Design = "Lifestyle";					
				}
				if (Secondary != null && Secondary.Progressive)
				{
					Secondary.Design = "TACT";
					Secondary.Material = "1.60";
				}
				if (age > 2 && Secondary==null)
				{
					Secondary = new Lens();
					Secondary.Design = "TACT";
					Secondary.Material = "1.60";
				}
			}
		}
		public function AnswerQuestion7(single:Boolean,progressive:Boolean,bifocal:Boolean,contacts:Boolean,none:Boolean)
		{
			service.saveAnswer("7",single+","+progressive+","+bifocal+","+contacts+","+none);
			answers[7] = { single:single, progressive:progressive, bifocal:bifocal, contacts:contacts, none:none};
		}
		public function BuildQuestion7(single:Boolean,progressive:Boolean,bifocal:Boolean,contacts:Boolean,none:Boolean)
		{
			if (this.age >= 3)
			{
				if (single)
				{
					Primary.Progressive = false;
						Primary.Design = "Nulux EP";
				}
				else
				{
					if (progressive || bifocal)
					{
						Primary.Progressive = true;
						Primary.Design = "Lifestyle";
					}
				}
			}
		}
		public function AnswerQuestion8(style:int, lensThickness:int, frameMaterial:int, fit:int, lensType:int, lensColor:int, durability:int, weight:int)
		{
			service.saveAnswer("8", style + "," + lensThickness + "," + frameMaterial + "," + fit + "," + lensType + "," + lensColor + "," + durability + "," + weight);
			answers[8] = { style:style, lensThickness:lensThickness, frameMaterial:frameMaterial, fit:fit, lensType:lensType, lensColor:lensColor, durability:durability, weight:weight };
		}
		public function BuildQuestion8(style:int, lensThickness:int, frameMaterial:int, fit:int, lensType:int, lensColor:int, durability:int, weight:int)
		{
			if (style == 1 || lensThickness == 1)
			{
				//Primary.Material = "1.7";
			}
		}
		public function AnswerQuestion13(answer:Boolean)
		{
			service.saveAnswer("9", answer.toString());
			answers[9] = answer;
		}
		public function BuildQuestion9(answer:Boolean)
		{
			//we have to make sure we don't duplicate treatments.
			Primary.removeTreatment("Anti-Reflective");
			Primary.addTreatment("Anti-Reflective");
		}
		public function AnswerQuestion10(answer:Boolean)
		{
			service.saveAnswer("10", answer.toString());
			answers[10] = answer;
		}
		public function BuildQuestion10(answer:Boolean)
		{
			//we have to make sure we don't duplicate treatments.
			Primary.removeTreatment("Anti-Reflective");
			Primary.addTreatment("Anti-Reflective");
		};
		public function AnswerQuestion11(answer:Boolean)
		{
			service.saveAnswer("11", answer.toString());
			answers[11] = answer;
		}
		public function BuildQuestion11(answer:Boolean)
		{
			//we have to make sure we don't duplicate treatments.
			Primary.removeTreatment("Anti-Reflective");
			Primary.addTreatment("Anti-Reflective");
		}
		public function AnswerQuestion9(answer:Boolean)
		{
			service.saveAnswer("12", answer.toString());
			answers[12] = answer;
		}
		public function BuildQuestion12(answer:Boolean)
		{
			trace("building question 12");
			trace("primary: " + Primary + " secondary: " + Secondary);
			//we have to make sure we don't duplicate treatments.
			Primary.removeTreatment("Anti-Reflective");
			Primary.addTreatment("Anti-Reflective");
			Primary.removeTreatment("Polarized");
			Primary.addTreatment("Polarized");
			//don't ask, you don't want to know
			if (Secondary != null)
			{
				if(Secondary.Design == "TACT")
				{
					Secondary.Material = "1.60";
					Secondary.removeTreatment("Photochromatic");
				}
				else
				{
					Secondary.addTreatment("Photochromatic");
				}
			}
			
		}
		public function AnswerQuestion12(answer:int)
		{
			service.saveAnswer("13", answer.toString());
		}
		public function AnswerQuestion14(sport:String)
		{
			service.saveAnswer("14", sport);
			this.specialtyType = sport;
			answers[14] = sport;
		}
		public function BuildQuestion14(sport:String)
		{
			//just to make sure
			Primary.removeTreatment("Photochromic");
			Specialty.Design = "Lifestyle";
			Specialty.addTreatment("Polarized");
			Specialty.addTreatment("Anti-Reflective");
			Specialty.addTreatment("Photochromic");
			Specialty.addTreatment("Tint");
			//remember, the default style is lifestyle
			//we pass in the style via design for special cases.
			switch(sport)
			{
				case "Biking":
					Specialty.Design = "Nulux EP";
					break;
				case "Boating":
					Specialty.removeTreatment("Polarized");
					break;
				case "Fishing":
					break;
				case "Golfing":
					Specialty.removeTreatment("Anti-Reflective");
					break;
				case "Hiking":
					break;
				case "Hunting":
					Specialty.removeTreatment("Polarized");
					Specialty.removeTreatment("Anti-Reflective");
					break;
				case "Running":
					Specialty.Design = "Nulux EP";
					break;
				case "Skiing":
					Specialty.Design = "Nulux EP";
					Specialty.removeTreatment("Polarized");
					break;
				case "Tennis":
					Specialty.Design = "Nulux EP";
					break;
			}
			
		}
		public function AnswerQuestion15(tint:String)
		{
			service.saveAnswer("15", tint);
		}
		
		public function AnswerQuestion17(providerId:String)
		{
			service.saveAnswer("17", providerId);
		}
		
		public function AnswerQuestionGlare(answer:Boolean):void
		{
			// TODO :: save answer here...
			//service.saveAnswer("glare", answer.toString());
		}
		
		public function OptIn(optedIn:Boolean)
		{
			service.saveAnswer("18", optedIn.toString());
		}
		public function FinalizeRecomendations()
		{
			
			var csv = Primary.serialize("Primary");
			if (Secondary != null)
			{
				if (Secondary.Design == "TACT")
				{
					Secondary.Material = "1.60";
				}
				csv += "|"+Secondary.serialize("Secondary");
			}
			if (Primary != null && Specialty != null)
			{
				csv += "|"+Specialty.serialize("Specialty");
			}
			else if (Primary != null)
			{
				csv += "|Specialty,None,None";
			}
			trace("sending csv:"+csv);
			service.saveAnswer("16", csv);
		}
		public function SaveRecs()
		{
			service.endSession("");
		}
		public function SaveEmail(emailAddress:String)
		{
			service.endSession(emailAddress);
		}
		public function BuildRecs()
		{
			Primary = new Lens();
			Secondary = new Lens();
			Specialty = null;
			var recs:Object = ExternalInterface.call("BuildRecs", answers);
			Primary.Treatments = recs.primary.Treatements;
			Primary.Design = recs.primary.Design;
			Primary.Material = recs.primary.Material;
			Secondary.Treatments = recs.secondary.Treatements;
			Secondary.Design = recs.secondary.Design;
			Secondary.Material = recs.secondary.Material;
			//BuildQuestion1(answers[1]);
			//BuildQuestion2(answers[2]);
			//BuildQuestion4(answers[4]);
			//BuildQuestion5(answers[5]);
			//BuildQuestion6(answers[6].computer, answers[6].tv, answers[6].reading, answers[6].driving, answers[6].sport, answers[6].craft);
			//BuildQuestion7(answers[7].single, answers[7].progressive, answers[7].bifocal, answers[7].contacts, answers[7].none);
			//BuildQuestion8(answers[8].style,answers[8].lensThickness,answers[8].frameMaterial,answers[8].fit,answers[8].lensType,answers[8].lensColor,answers[8].durability,answers[8].weight);
			//BuildQuestion9(answers[9]);
			//BuildQuestion10(answers[10]);
			//BuildQuestion11(answers[11]);
			//BuildQuestion12(answers[12]);
			if (answers[14] != "None")
			{
				//we're going to keep Specialty null until the sport has been selected.
				Specialty = new Lens();
				//BuildQuestion14(answers[14]);	
				Specialty.Treatments = recs.specialty.Treatements;
				Specialty.Design = recs.specialty.Design;
				Specialty.Material = recs.specialty.Material;
			}
			Primary.removeTreatment("Photochromic");
		}
		
		public function GetStateFromZip(zip:String,callback:Function):void
		{
			var req:URLRequest = new URLRequest(baseUrl + "/get_state.aspx?zipcode=" + zip);
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, callback);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.load(req);
		}
		
		public function GetProvidersFromLID(lid:String, callback:Function):void
		{
			var req:URLRequest = new URLRequest(baseUrl + "/get_provider.aspx?lid=" + lid);
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, callback);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.load(req);
		}
		
		public function GetProvidersFromGID(gid:String, callback:Function):void
		{
			var req:URLRequest = new URLRequest(baseUrl + "/get_provider.aspx?gid=" + gid);
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, callback);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.load(req);
		}
		
		public function GetProvidersFromZip(zip:String, callback:Function):void
		{
			var req:URLRequest = new URLRequest(baseUrl + "/get_provider.aspx?zipcode=" + zip);
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, callback);
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.load(req);
		}
		
		public function SendEmail(address:String):void
		{
			var req:URLRequest = new URLRequest(baseUrl + "/send_email.aspx?sesssionId="+this.service.sessionId);
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.load(req);
		}
		
		public function PrintResults():void
		{
			var req:URLRequest = new URLRequest(baseUrl + "/send_email.aspx?sesssionId=" + this.service.sessionId + "&print=1");
			navigateToURL(req, "_blank");
			service.saveAnswer("19", "true");
		}
		
		private function ioErrorHandler(e:IOErrorEvent):void
		{
			trace("e :: " + e);
		}
		
		// Dev Methods //////////////////////////////////////////////////////////////////////////////////////
		public function buildTestData1():void
		{
			//Primary
			Primary = new Lens();
			Primary.Design = "TACT";
			Primary.Material = "Phoenix";
			Primary.Treatments = new Array("Anti-Reflective","Photochromic","Polarized");
			
			Secondary = null;
			
			Specialty = null;

		}
		
		public function buildTestData2():void
		{
			//Primary/Complementary 
			Primary = new Lens();
			Primary.Design = "TACT";
			Primary.Material = "Phoenix";
			Primary.Treatments = new Array("Anti-Reflective","Photochromic","Polarized");
			
			Secondary = new Lens();
			Secondary.Design = "Nulux EP";
			Secondary.Material = "1.7";
			Secondary.Treatments = new Array("Anti-Reflective","Photochromic","Tint");
			
			Specialty = null;

		}
		
		public function buildTestData3():void
		{
			//Primary/Specialty 
			Primary = new Lens();
			Primary.Design = "TACT";
			Primary.Material = "Phoenix";
			Primary.Treatments = new Array("Anti-Reflective","Photochromic","Polarized");
			
			Secondary = null;
			
			specialtyType = "Biking";
			Specialty = new Lens();
			Specialty.Design = "Lifestyle";
			Specialty.Material = "1.67";
			Specialty.Treatments = new Array("Tint","Anti-Reflective","Polarized");
		}
		
		public function buildTestData4():void
		{
			//trace("buildTestData4");
			//Primary/Complementary/Specialty 
			Primary = new Lens();
			Primary.Design = "TACT";
			Primary.Material = "Phoenix";
			Primary.Treatments = new Array("Anti-Reflective","Photochromic","Polarized");
			
			Secondary = new Lens();
			Secondary.Design = "Nulux EP";
			Secondary.Material = "1.7";
			Secondary.Treatments = new Array("Anti-Reflective","Photochromic");
			
			specialtyType = "Biking";
			Specialty = new Lens();
			Specialty.Design = "Nulux EP";
			Specialty.Material = "1.67";
			Specialty.Treatments = new Array("Tint","Anti-Reflective");
		}
	}
}