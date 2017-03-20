package 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	public class Handlers
	{
		public function SetButton(btn:MovieClip):void {
			
		}
		
		protected static function onMouseDown(event: MouseEvent): void {
			event.target.nextFrame();
		}
		
		protected static function onMouseUp(event: MouseEvent): void {
			event.target.prevFrame();
		}
		
		protected static function onMouseOver(event: MouseEvent): void {
			event.target.nextFrame();
		}
		
		protected static function onMouseOut(event: MouseEvent): void {
			event.target.gotoAndStop(1);
		}
		
		public static function SetButton(button:MovieClip, clickFunc:Function = null):void
		{
			button.stop();
			button.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			button.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			button.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			button.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			if (clickFunc != null)
				button.addEventListener(MouseEvent.CLICK, clickFunc)
			
		}
		
		public static function UnSetButton(button:MovieClip, clickFunc:Function = null):void
		{
			button.stop();
			button.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			button.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			button.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			button.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			if (clickFunc != null)
				button.removeEventListener(MouseEvent.CLICK, clickFunc);

		}
	}
}