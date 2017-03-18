package viewPac
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import BaseClasses.BaseClass;
	
	import modelPac.Friends;
	
	public class MainView extends BaseClass
	{
		private var _clip:MovieClip = new MainClip();
		private var _friend:Friends;
		
		public function get getClip():MovieClip
		{
			return _clip;
		}
		
		private var _log:TextField = new TextField();
		public function set setLog(setValue:String):void 
		{ 
			_log.appendText(setValue + "\n"); 
		}
	
		public function MainView()
		{
			super();
		}
		
		override protected function onRegister():void
		{			
			_clip.button_2.addEventListener(MouseEvent.CLICK, TabClick);
			Facade.gameStage.addChild(_clip);
			
			_friend = new Friends("1", "name", "su123123", 1, null);
			Facade.gameStage.addChild(_friend);
			
		}
		
		protected function TabClick(event:MouseEvent):void
		{
			_clip.gotoAndStop(_clip.currentFrame == 1 ? 2 : 1);
			//Facade.controller.SendRequest("82232368", "222");
			//Facade.controller.WallPost("12703356");
		}
	}
}