package BaseClasses
{
	public class BaseClass
		
	{
		public function BaseClass()
		{
			onRegister();
		}
		
		protected function onRegister():void
		{
			//for override
		}
		
		protected function onDispose():void
		{
			//for override
		}
	}
}