package controllerPac
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import BaseClasses.BaseClass;
	
	import modelPac.Friend;
	import modelPac.MainClip;
	
	import vk.APIConnection;
	
	public class MainController extends BaseClass
	{
		private var flashVars:Object;
		private var VK:APIConnection;
		public var onlineList:Array = new Array()
		public var offlineList:Array = new Array();
		public var selectedList:Array = new Array();
		public var searchedList:Array = new Array();
		
		
		public function MainController()
		{
			super();
		}
		
		override protected function onRegister():void
		{
			flashVars = Facade.gameStage.loaderInfo.parameters as Object;
			if (!flashVars.api_id) {
				flashVars['api_id'] = "5918660";
				flashVars['viewer_id'] = "12703356";
				//flashVars['sid'] = "26OHqxA8obdsQpXs0Px0";
				//flashVars['secret'] = "26OHqxA8obdsQpXs0Px0";
				flashVars['access_token'] = "72d8f3fd72d8f3fd72d8f3fd577282bc39772d872d8f3fd2a15cb4356a7cf49823f381f";
			}
			VK = new APIConnection(flashVars);
		}
		
		public function WallPost(ownerID:String):void
		{
			VK.api("wall.post", {
				api_id: "5918660",
				sid: flashVars['sid'],//"26OHqxA8obdsQpXs0Px0",
				secret: flashVars['secret'],
				owner_id: ownerID,
				v: "5.62",
				message: "test WallPost"
			},
				onSuccess, onError);	
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
				onSuccess, onError);
		}
			
		
		public function SendRequest(userID:String, mess:String):void
		{
			VK.callMethod("showRequestBox", 82232368, mess, "myRequestKey", onSuccess, onRequestCancel, onError);
		}
		
		private function onRequestCancel(data: Object):void
		{
			Facade.view.ToLog = "Request denied";
		}

		private function onError(data: Object):void
		{
			Facade.view.ToLog = "error #" + data.error_code + ": " + data.error_msg;
		}

		private function onSuccess(data: Object):void
		{
			Facade.view.ToLog = "succes with " + data;
		}
		
		public function GetUsers():void
		{
			var API_URL: String = BaseValue.API_URL;
			var method: String = BaseValue.FRIENDS_METHOD;
			var URLLoad: URLLoader = new URLLoader();
			var v: URLVariables = new URLVariables();
			var URLReq: URLRequest = new URLRequest(API_URL + method);
			v.access_token = flashVars['access_token'];
			v.user_id = flashVars['viewer_id'];
			v.fields = "first_name,last_name,online,photo_50";
			v.v = "5.62";
			
			URLReq.data = v;
			URLReq.method = URLRequestMethod.POST;
			URLLoad.load(URLReq);
			URLLoad.addEventListener(Event.COMPLETE, onLoadFriends);
		}	
		
		protected function onLoadFriends(event:Event):void
		{
				//Facade.view.ToLog = "Ok";
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
							myxml.items.user.online[it],
							myxml.items.user.photo_50[it]
						));
					else
						offlineList.push(new Friend(
							myxml.items.user.id[it],
							myxml.items.user.first_name[it],
							myxml.items.user.last_name[it],
							myxml.items.user.online[it],
							myxml.items.user.photo_50[it]
						));
					it++;
				}
//				Facade.view.ToLog = onlineList.length + " друзей онлайн";
//				Facade.view.ToLog = offlineList.length + " друзей офлайн";
				
				Facade.view.getClip.addEventListener(Event.ENTER_FRAME, Facade.view.getClip.onEnterFrame);
		}
		
		public function SetSearchedList(text:String):void
		{
			searchedList = new Array();
			var fr:int = Facade.view.getClip.currentFrame;
			var list:Array = fr == 1 ? onlineList : offlineList;
					
			for (var i:int = 0; i < list.length; i++)
			{
				var str:String = list[i].getFirstName;
				str = str.toLocaleLowerCase();
				text = text.toLocaleLowerCase();
				if (str.substr(0, text.length) == text)
				{
					searchedList.push(list[i]);
				}
			}
			Facade.view.getClip.SetField();
		}
	}
}