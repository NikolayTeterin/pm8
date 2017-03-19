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
			trace(event.target.name);
		}
		
		protected static function onMouseOut(event: MouseEvent): void {
			event.target.gotoAndStop(1);
		}
		
		public static function SetButton(button:MovieClip):void
		{
			button.stop();
			button.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			button.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			button.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			button.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			
		}
		
		public static function UnSetButton(button:MovieClip):void
		{
			button.stop();
			button.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			button.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			button.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			button.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);

		}
	}
}