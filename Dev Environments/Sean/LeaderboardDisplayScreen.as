package 
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*
	import flash.text.*;
	import flash.media.*;
 
	public class LeaderboardDisplayScreen extends MovieClip 
	{
		public var playStage:Stage;
		private var playTime:int;
		private var enemiesKilled:int;
		private var playTimeText:TextField = new TextField();
		private var enemiesKilledText:TextField = new TextField();
		private var timeAdded:Boolean = false;
		
		public function LeaderboardDisplayScreen(tempStage:Stage) 
		{
			mainMenuBtn.addEventListener( MouseEvent.CLICK, onClickMenu);
			
		}
 
		public function onClickMenu( mouseEvent:MouseEvent ):void 
		{
			clearScreen();
 			dispatchEvent( new NavigationEvent(NavigationEvent.TOMENU ));
		}
		
		public function clearScreen()
		{
		}
		
	}
}