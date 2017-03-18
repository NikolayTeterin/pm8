package controllerPac
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;	
	import BaseClasses.BaseClass;
	import modelPac.Friend;	
	import vk.APIConnection;
	
	public class MainController extends BaseClass
	{
		private var flashVars:Object;
		private var VK:APIConnection;
		public var onlineList:Array = new Array()
		public var offlineList:Array = new Array();
		
		
		public function MainController()
		{
			super();
		}
		
		override protected function onRegister():void
		{
			flashVars = Facade.gameStage.loaderInfo.parameters as Object;
			if (!flashVars.api_id) {
				// -- For local testing enter you test-code here:
				flashVars['api_id'] = "5918660";
				flashVars['viewer_id'] = "12703356";
				flashVars['sid'] = "26OHqxA8obdsQpXs0Px0";//"7ff256eea527ba2a70e1c83438febb954182f5ad4b54a5c9e006d11aed3d6624cd2551c458c7a264093a6";
				flashVars['secret'] = "26OHqxA8obdsQpXs0Px0";
				flashVars['access_token'] = "72d8f3fd72d8f3fd72d8f3fd577282bc39772d872d8f3fd2a15cb4356a7cf49823f381f";
				// -- //
			}
			//Facade.view.ToLog = String(flashVars['sid']);
			VK = new APIConnection(flashVars);
			
			//GetUsers();
		}
		
		public function WallPost(ownerID:String):void
		{
			VK.api("wall.post", {
				api_id: "5918660",
				sid: "26OHqxA8obdsQpXs0Px0",
				owner_id: ownerID,
				v: "5.62",
				message: "123"
			},
				function (o: Object): void {trace ("Compl");}, onError);	
		}
		
		public function SendMessage(userID:String, mess:String):void
		{
			VK.api("messages.send", {
				api_id: "5918660",
				sid: "26OHqxA8obdsQpXs0Px0",
				user_id: userID,
				//access_token: flashVars['access_token'],
				v: "5.62",
				message: mess
			},
				function (o: Object): void {trace ("Compl");}, onError);
		}
			
		
		public function SendRequest(userID:String, mess:String):void
		{
			VK.callMethod("showRequestBox", 82232368, mess, "myRequestKey", onRequestSuccess, onRequestCancel, onRequestFail);
		}
		
		private function onRequestSuccess(data: Object):void
		{
			Facade.view.ToLog = data.text;
		}
		
		private function onRequestCancel(data: Object):void
		{
			Facade.view.ToLog = data.text;
		}
		
		private function onRequestFail(data: Object):void
		{
			Facade.view.ToLog = data.text;
		}

		private function onError(data: Object):void
		{
			Facade.view.ToLog = data.error_msg;
			Facade.view.ToLog = data.error_code;
		}

		private function onSuccess(data: Object):void
		{
			Facade.view.ToLog = data.error_msg;
			Facade.view.ToLog = data.error_code;
		}
		
		public function GetUsers():void
		{
			var API_URL: String = "https://api.vk.com/method/";
			var method: String = "friends.get.xml";
			var methodPost: String = "wall.post.xml";
			var URLLoad: URLLoader = new URLLoader();
			var v: URLVariables = new URLVariables();
			var URLReq: URLRequest = new URLRequest(API_URL + method);
			v.access_token = flashVars['access_token'];
			v.v = "5.62";
			v.user_id = flashVars['viewer_id'];
			v.fields = "first_name,last_name,online,photo_50";
			
			URLReq.data = v;
			URLReq.method = URLRequestMethod.POST;
			URLLoad.load(URLReq);
			URLLoad.addEventListener(Event.COMPLETE, onLoadFriends);

/*			VK.api("friends.get", {
				access_token: flashVars['access_token'],
				user_id: flashVars['viewer_id'],
				fields: "first_name,last_name,online,photo_50"
			},
			onLoadFriends, onError);
*/		
		}	
		
		protected function onLoadFriends(event:Event):void
		{
				Facade.view.ToLog = "Ok";
				var it: int = 0;
				//trace(event.target.data);
				var myxml:XML = XML(event.target.data);
				while (myxml.items.user.id[it] != null) {
					//trace(myxml.items.user.photo_50[it]);
					if (myxml.items.user.online[it] == 1)
						onlineList.push(new Friend(
							myxml.items.user.id[it],
							myxml.items.user.first_name[it],
							myxml.items.user.last_name[it],
							myxml.items.user.online[it]
							//myxml.items.user.photo_50[it]
						));
					else
						offlineList.push(new Friend(
							myxml.items.user.id[it],
							myxml.items.user.first_name[it],
							myxml.items.user.last_name[it],
							myxml.items.user.online[it]
							//myxml.items.user.photo_50[it]
						));
					it++;
				}
				trace(onlineList.length);
				trace(offlineList.length);
				
				Facade.view.getClip.addEventListener(Event.ENTER_FRAME, Facade.view.getClip.onEnterFrame);
				
				//			Facade.view.getClip.nextFrame()
		}
		
	}
}