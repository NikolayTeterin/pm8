package modelPac
{
	import BaseClasses.BaseClass;

	public class MainModel extends BaseClass
	{		
		public function MainModel()
		{
			super();	
		}
		
		override protected function onRegister():void
		{
			Facade.controller.GetUsers();
		}		
	}
}