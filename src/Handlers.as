package 
{
	import flash.events.MouseEvent;

	public class Handlers
	{
		public function onMouseDown(event: MouseEvent): void {
			event.target.nextFrame();
		}
		
		public function onMouseUp(event: MouseEvent): void {
			event.target.prevFrame();
		}
		
		public function onMouseOver(event: MouseEvent): void {
			
			event.target.nextFrame();
		}
		
		
		public function onMouseOut(event: MouseEvent): void {
			event.target.gotoAndStop(1);
		}
	}
}