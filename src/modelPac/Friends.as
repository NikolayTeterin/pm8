package modelPac
{
	import flash.display.Loader;

	public class Friends extends User
	{
		private var _id:String;
		public function get getID():String { return _id; } 
		public function set setID(setValue:String):void { _id = setValue; }
		
		private var _firstName:String;
		public function get getFirstName():String { return _firstName; } 
		public function set setFirstName(setValue:String):void { _firstName = setValue; }
		
		private var _lastName:String;
		public function get getLastName():String { return _lastName; } 
		public function set setLastName(value:String):void { _lastName = value; }
		
		private var _online:Boolean;
		public function get getOnline():Boolean { return _online; } 
		public function set setOnline(setValue:Boolean):void { _online = setValue; }
		
		private var _image:Loader;
		public function get getImage():Loader { return _image; } 
		public function set setImage(setValue:Loader):void { _image = setValue; }
		
		public function Friends(id:String, firstName:String, lastName:String, online:Boolean, image:Loader):void
		{
			super();
			_id = id;
			setFirstName = firstName;
			setLastName = lastName;
			_online = online;
			_image = image;
			checkBox.check.visible = false;
			this.label.text = _firstName;
		}
	}
}