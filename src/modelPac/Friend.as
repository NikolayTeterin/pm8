package modelPac
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;

	public class Friend extends SuperFriend
	{
		private var _id:String;
		public function get getID():String { return _id; } 
		public function set setID(setValue:String):void { _id = setValue; }
		
		private var _firstName:String;
		public function get getFirstName():String { return _firstName; } 
		public function set setFirstName(setValue:String):void { _firstName = setValue; this.label.text = _firstName; }
		
		private var _lastName:String;
		public function get getLastName():String { return _lastName; } 
		public function set setLastName(value:String):void { _lastName = value; }
		
		private var _online:Boolean;
		public function get getOnline():Boolean { return _online; } 
		public function set setOnline(setValue:Boolean):void { _online = setValue; }
		
		private var _image:Loader = new Loader();
		//public function get getImage():Loader { return _image; } 
		public function set setImage(value:String):void { _image.load(new URLRequest(value)); this.frame.addChild(_image); }
		
		public function Friend(id:String, firstName:String, lastName:String, online:Boolean, imageURL:String):void
		{
			super();
			_id = id;
			setFirstName = firstName;
			setLastName = lastName;
			_online = online;
			setImage = imageURL;
			
			checkBox.stop();
			checkBox.check.visible = false;
			checkBox.addEventListener(MouseEvent.MOUSE_OVER, Facade.handlers.onMouseOver);
			checkBox.addEventListener(MouseEvent.MOUSE_OUT, Facade.handlers.onMouseOut);
			checkBox.addEventListener(MouseEvent.MOUSE_DOWN, Facade.handlers.onMouseDown);
			checkBox.addEventListener(MouseEvent.MOUSE_UP, Facade.handlers.onMouseUp);
			checkBox.addEventListener(MouseEvent.CLICK, onCheckBoxClick);		
			
			this.addEventListener(MouseEvent.CLICK, onFriendClick);
			
		}
		
		protected function onFriendClick(event:MouseEvent):void
		{
			//Facade.controller.SendRequest("82232368", "222");
			Facade.controller.WallPost("12703356");
		}
		
		private function onCheckBoxClick(event: MouseEvent): void {
//			if (checkBox.currentFrame == 3) {
//				checkBox.removeEventListener(MouseEvent.CLICK, onCheckBoxClick);
//				return;
//			}
			checkBox.check.visible = !checkBox.check.visible;
			if (checkBox.check.visible)
				Facade.controller.selectedList.push(this);
			else
				Facade.controller.selectedList.pop();
				
		}
	}
}