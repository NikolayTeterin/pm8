package viewPac
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import BaseClasses.BaseClass;
	
	import modelPac.Friend;
	import modelPac.MainClip;
	
	public class MainView extends BaseClass
	{
		private var _clip:MainClip;// = new MainClip();
		private var _friend:Friend;
		//private var _checkBox:CheckBox;
		private var _log:TextField;
		
		public function get getClip():MovieClip
		{
			return _clip;
		}
		
		public function set ToLog(value:String):void 
		{ 
			_log.appendText(value + "\n"); 
		}
	
		public function MainView()
		{
			super();
		}
		
		override protected function onRegister():void
		{			
			_clip = new MainClip();
			_clip.button_2.addEventListener(MouseEvent.CLICK, TabClick);
			Facade.gameStage.addChild(_clip);
			_log = _clip.tf;			
		}
		
		protected function TabClick(event:MouseEvent):void
		{
			_clip.gotoAndStop(_clip.currentFrame == 1 ? 2 : 1);
			_clip.addEventListener(Event.ENTER_FRAME, Facade.view.getClip.onEnterFrame);
			//Facade.controller.SendRequest("82232368", "222");
			//Facade.controller.WallPost("12703356");
		}
	}
}