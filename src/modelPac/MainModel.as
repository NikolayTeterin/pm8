package modelPac
{
	import BaseClasses.BaseClass;
	import flash.events.Event;

	public class MainModel extends BaseClass
	{
		private var friends:Array;
		public function MainModel()
		{
			super();	
		}
		
		override protected function onRegister():void
		{
			friends = new Array();
			//Facade.controller.GetUsers();
		}
		
		public function onLoadFriends(e: Event):void
		{
//			var it: int = 0;
//			trace(e.target.data);
//			var myxml:XML = XML(e.target.data);
//			while (myxml.items.user.id[it] != null) {
//				trace(myxml.items.user.photo_50[it]);
//				var name: String = myxml.items.user.first_name[it];
//				if (myxml.items.user.online[it] == 1)
//					onlineList.push(CreateUser(name, myxml.items.user.online[it], myxml.items.user.photo_50[it]));
//				else
//					offlineList.push(CreateUser(name, myxml.items.user.online[it], myxml.items.user.photo_50[it]));
//				it++;
//			}
//			trace(onlineList.length);
//			trace(offlineList.length);
//			nextFrame();
		}
		
	}
}