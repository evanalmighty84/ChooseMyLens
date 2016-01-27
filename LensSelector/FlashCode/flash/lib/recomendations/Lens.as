package recomendations
{
	
	/**
	 * ...
	 * @author Mark Coleman
	 */
	public class Lens 
	{
		public var Design:String;
		public var Material:String;
		public var Treatments:Array;
		public var Progressive:Boolean = false;
		public var Outdoor:Boolean = false;
		public function Lens() 
		{
			Material = "Phoenix";
			Treatments = new Array();
			addTreatment("SHV EX3");
		}
		public function addTreatment(treatment:String)
		{
			var containsItem:Boolean = false;
			for (var i = 0; i < Treatments.length; i++)
			{
				if (treatment == Treatments[i])
				{
					containsItem = true;
				}
			}
			if (!containsItem)
			{
				Treatments.push(treatment);
			}
		}
		public function removeTreatment(treatment:String)
		{
			Treatments = Treatments.filter(function(x:*, index:int, array:Array) { 
				if (x != treatment) { return true; }
				else { return false;}
				
			});
		}
		public function serialize(type:String):String 
		{
			var out = type+","+Design + "," + Material ;
			for (var i:int = 0; i < Treatments.length; i++)
			{
				out += "," + Treatments[i];
			}
			return out;
		}
		
	}
	
}