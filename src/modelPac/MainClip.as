package modelPac
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	public class MainClip extends SuperMainClip
	{
		
		private var maxI:int;
		private var itemCounter:int;
		private var list:Array;
		
		public function MainClip()
		{
			super();
			stop();
			Handlers.SetButton(sendButton);
			sendButton.addEventListener(MouseEvent.CLICK, onSendButtonClick);
			
			this.search.addEventListener(KeyboardEvent.KEY_UP, onSearchInput);
			this.search.addEventListener(MouseEvent.CLICK, onSearchClick);
			
			Handlers.SetButton(leftArrow);
			Handlers.SetButton(rightArrow);
		}
		
		protected function onSearchClick(event:MouseEvent):void
		{
			search.removeEventListener(MouseEvent.CLICK, onSearchClick);
			search.textField.text = "";
			this.addEventListener(MouseEvent.CLICK, outSearch);
		}
		
		protected function outSearch(event:MouseEvent):void
		{
			if (
				event.target == search.textField
				|| event.target.name == "check"
				|| event.target.name == "checkBox"
				|| event.target.name == "box"
				|| event.target.name == this.sendButton.name
				|| event.target.parent.name == rightArrow.name
				|| event.target.parent.name == leftArrow.name
				)				
				return;

			search.textField.text = "Найти друга по имени";
			this.removeEventListener(MouseEvent.CLICK, outSearch);
			search.addEventListener(MouseEvent.CLICK, onSearchClick);
			Facade.controller.searchedList = new Array();
			SetField(currentFrame, true);
		}
		
		protected function onSearchInput(event:KeyboardEvent):void
		{
			Facade.controller.SetSearchedList(search.textField.text);
			trace(search.textField.text);
		}
		
		protected function onSendButtonClick(event:MouseEvent):void
		{
			var fr:Friend;
			var lnt:int = Facade.controller.selectedList.length;
			trace("selectedList.length = " + Facade.controller.selectedList.length);
			for (var i:int = 0; i < lnt; i++)
			{
				fr = Facade.controller.selectedList.shift();
				fr.checkBox.gotoAndStop("disable");
				fr.checkBox.mouseEnabled = false;
				Handlers.UnSetButton(fr.checkBox);
				fr.checkBox.removeEventListener(MouseEvent.CLICK, fr.onCheckBoxClick);

			}
		}
		
		public function onEnterFrame(event:Event):void
		{
			SetField(this.currentFrame, true);
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
		
		
		public function SetField(frameInd: int = 99, res:Boolean = false):void {
			if (res) 
				ResetField();
			if (frameInd == 2) {
				list = Facade.controller.offlineList;
			}
			else if (frameInd == 1) {
				list = Facade.controller.onlineList;			
			}
			else if (frameInd == 0) {
				list = Facade.controller.searchedList;
			}

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
		
		private function ResetField():void
		{
			if (itemCounter !=0 )
			for (var i: int = itemCounter - BaseValue.countItemPerFrame; i < itemCounter; i++)
				if (list[i] != null)
					list[i].visible = false;
			maxI = 0;
			itemCounter = 0;
		}
		
		protected function RightArrowClick(event:MouseEvent):void
		{
			for (var i: int = itemCounter - BaseValue.countItemPerFrame; i < itemCounter; i++)
				if (list[i] != null)
					list[i].visible = false;
			if (Facade.controller.searchedList.length == 0)
				SetField(this.currentFrame);
			else
				SetField(0);
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
			if (Facade.controller.searchedList.length == 0)
				SetField(this.currentFrame);
			else
				SetField(0);
		}
	}
}