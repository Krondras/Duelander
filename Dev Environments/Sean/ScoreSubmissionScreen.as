package  {
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*
	import flash.text.*;
	import flash.media.*;
	
	public class ScoreSubmissionScreen extends MovieClip {
		
		public var playerName:String;
		public var confirmTimer:Timer = new Timer(3000, 0);
		private var confirmSubmitText:TextField = new TextField();
		
		public function ScoreSubmissionScreen() 
		{
			submitBtn.addEventListener(MouseEvent.CLICK, onClickSubmit);
			confirmTimer.addEventListener(TimerEvent.TIMER, goToMainMenu);
		}
		
		public function onClickSubmit( mouseEvent:MouseEvent ):void 
		{
			var timerStarted = false;
			
			if(!timerStarted)
			{
				confirmTimer.start()
				timerStarted = true;
			}
			
			//playStage.removeChild(playTimeText);
			//playStage.removeChild(enemiesKilledText);
		}
		
		public function goToMainMenu(event:TimerEvent): void
		{
			dispatchEvent( new NavigationEvent(NavigationEvent.SUBMITTED));
		}
	}
	
}
