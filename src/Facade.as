package
{
	import flash.display.Stage;
	
	import controllerPac.MainController;
	
	import modelPac.MainModel;
	
	import viewPac.MainView;

	public class Facade
	{
		public static var gameStage:Stage;
		
		public static var view:MainView;
		public static var controller:MainController;
		public static var model:MainModel;
		public static var baseValue:BaseValue;
		public static var handlers:Handlers;
		
		public function Facade()
		{
			
		}
	}
}