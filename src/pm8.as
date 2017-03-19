package
{
	import flash.display.Sprite;
	
	import Handlers;
	
	import controllerPac.MainController;
	
	import modelPac.MainModel;
	
	import viewPac.MainView;
	
	[SWF(width = "663", height="573")]
	public class pm8 extends Sprite
	{
		public function pm8()
		{
			Facade.gameStage = stage;
			Facade.handlers = new Handlers();
			
			Facade.controller = new MainController();
			Facade.model = new MainModel();
			Facade.view = new MainView();
			Facade.baseValue = new BaseValue();
		}
	}
}