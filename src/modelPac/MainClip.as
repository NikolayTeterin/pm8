package modelPac
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class MainClip extends SuperMainClip
	{
		
		private var maxI:int;
		private var itemCounter:int;
		private var list:Array;
		
		public function MainClip()
		{
			super();
			//this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		public function onEnterFrame(event:Event):void
		{
			maxI = 0;
			itemCounter = 0;
			SetField(this.currentFrame);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		public function SetField(frameInd: int):void {
			list = frameInd == 2 ? Facade.controller.offlineList : Facade.controller.onlineList;
			maxI = BaseValue.countItemPerFrame + itemCounter;
			maxI = maxI > list.length ? (maxI - (maxI - list.length)) : maxI;
			for (var i: int = itemCounter; i < maxI; i++) {
				list[i].x = i % 2 == 0 ? 125 : 375;
				list[i].y = 200 + 30 * (i % 2 == 0 ? i % BaseValue.countItemPerFrame : (i % BaseValue.countItemPerFrame - 1));
				this.addChildAt(DisplayObject(list[i]), numChildren - 1);
				list[i].visible = true;
			}
			if (itemCounter >= BaseValue.countItemPerFrame) {
				leftArrow.visible = true;
				leftArrow.addEventListener(MouseEvent.CLICK, LeftArrowClick);
			} else {
				leftArrow.visible = false;
				leftArrow.removeEventListener(MouseEvent.CLICK, LeftArrowClick);
			}
			if (itemCounter + BaseValue.countItemPerFrame >= list.length) {
				rightArrow.visible = false;
				rightArrow.removeEventListener(MouseEvent.CLICK, RightArrowClick);
			} else {
				rightArrow.visible = true;
				rightArrow.addEventListener(MouseEvent.CLICK, RightArrowClick);
			}
			itemCounter = i;
		}
		
		protected function RightArrowClick(event:MouseEvent):void
		{
			for (var i: int = 0; i < maxI; i++)
				if (list[i] != null)
					list[i].visible = false;
			SetField(this.currentFrame);
			
		}
		
		protected function LeftArrowClick(event:MouseEvent):void
		{
			var start: int = maxI - (maxI % BaseValue.countItemPerFrame);
			if (start > maxI - 1)
				start = maxI - BaseValue.countItemPerFrame;
			for (var i: int = maxI - 1; i >= start; i--)
				if (list[i] != null)
					list[i].visible = false;
			itemCounter = start - BaseValue.countItemPerFrame;
			SetField(this.currentFrame);
		}
	}
}