package controllerPac
{
	import BaseClasses.BaseClass;
	
	import vk.APIConnection;
	
	public class MainController extends BaseClass
	{
		private var flashVars:Object;
		private var VK:APIConnection;
		
		
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
				flashVars['sid'] = "7ff256eea527ba2a70e1c83438febb954182f5ad4b54a5c9e006d11aed3d6624cd2551c458c7a264093a6";
				flashVars['secret'] = "26OHqxA8obdsQpXs0Px0";
				// -- //
			}
			Facade.view.setLog = String(flashVars['sid']);
			VK = new APIConnection(flashVars);
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
			Facade.view.setLog = data.text;
		}
		
		private function onRequestCancel(data: Object):void
		{
			Facade.view.setLog = data.text;
		}
		
		private function onRequestFail(data: Object):void
		{
			Facade.view.setLog = data.text;
		}

		private function onError(data: Object):void
		{
			Facade.view.setLog = data.error_msg;
			Facade.view.setLog = data.error_code;
		}

		private function onSuccess(data: Object):void
		{
			Facade.view.setLog = data.error_msg;
			Facade.view.setLog = data.error_code;
		}
		
		public function GetUsers():void
		{
			VK.api("friends.get", {
				access_token: flashVars['access_token'],
				user_id: flashVars['viewer_id'],
				fields: "first_name,last_name,online,photo_50"
			},
				Facade.model.onLoadFriends, onError);
		}
		

		
	}
}