package 
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*
	import flash.text.*;
	import flash.media.*;
 
	public class SelectScreen extends MovieClip 
	{
		public var playerType:String;
		
		public function SelectScreen() 
		{
			samuraiBtn.addEventListener( MouseEvent.CLICK, onClickSamuraiStart );
			duelistBtn.addEventListener( MouseEvent.CLICK, onClickDuelistStart );
			knightBtn.addEventListener( MouseEvent.CLICK, onClickKnightStart );
		}
 
		public function onClickSamuraiStart( mouseEvent:MouseEvent ):void 
		{
			playerType = "Samurai";
 			dispatchEvent( new NavigationEvent(NavigationEvent.START ));
		}
		
		public function onClickDuelistStart( mouseEvent:MouseEvent ):void 
		{
			playerType = "Duelist";
 			dispatchEvent( new NavigationEvent(NavigationEvent.START ));
		}
		
		public function onClickKnightStart( mouseEvent:MouseEvent ):void 
		{
			playerType = "Knight";
 			dispatchEvent( new NavigationEvent(NavigationEvent.START ));
		}
	}
}