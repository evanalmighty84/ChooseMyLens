package recomendations
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import com.adobe.serialization.json.JSON;
	
	/**
	 * ...
	 * @author Mark Coleman
	 */
	public class WSConnection 
	{
		public var emailAddress:String;
		public var baseUrl:String;
		public var sessionId:String;
		public var zipCode:String;
		
		public function WSConnection(url:String) 
		{
			this.baseUrl = url;
		}
		
		public function saveAnswer(Question:String, Value:String):void
		{
			var req:URLRequest = new URLRequest(this.baseUrl+"/save_question.aspx?sessionId="+sessionId+"&question"+Question+"="+Value+"&r="+Math.random());
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(IOErrorEvent.IO_ERROR, IOErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, SecurityErrorHandler);
			loader.load(req);
		}
		
		public function startSession()
		{
			var req:URLRequest = new URLRequest(this.baseUrl + "/start_Session.aspx"+"?r="+Math.random());
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, startSessionComplete);
			loader.addEventListener(IOErrorEvent.IO_ERROR, IOErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, SecurityErrorHandler);
			loader.load(req);
		}
		
		public function endSession(emailAddress:String)
		{
			this.emailAddress = emailAddress;
			var req:URLRequest = new URLRequest(this.baseUrl+ "/end_Session.aspx?sessionId="+sessionId+"&email="+emailAddress+"&zipcode="+zipCode+"&r="+Math.random());
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(IOErrorEvent.IO_ERROR, IOErrorHandler);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, SecurityErrorHandler);
			loader.load(req);
		}
		
		private function startSessionComplete(e:Event)
		{
			this.sessionId = e.target.data;
		}
		
		private function IOErrorHandler(e:IOErrorEvent):void
		{
			trace("e :: " + e);
		}
		
		private function SecurityErrorHandler(e:SecurityErrorEvent):void
		{
			trace("e :: " + e);
		}
	}
	
}