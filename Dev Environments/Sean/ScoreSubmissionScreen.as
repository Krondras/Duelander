package  {
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*
	import flash.text.*;
	import flash.media.*;
	import flash.net.*;
	public class ScoreSubmissionScreen extends MovieClip {
		
		public var playerName:String;
		public var confirmTimer:Timer = new Timer(3000, 0);
		private var confirmSubmitText:TextField = new TextField();
		private var score:int;
		private var time:int;
		var netConnection:NetConnection = new NetConnection();
		var responder:Responder = new Responder(storeAndPrint, null);
		public function ScoreSubmissionScreen(tempEnemiesKilled:int, tempPlayerTime:int) 
		{
			submitBtn.addEventListener(MouseEvent.CLICK, onClickSubmit);
			confirmTimer.addEventListener(TimerEvent.TIMER, goToMainMenu);
			netConnection.connect("http://localhost/amfphp-2.2/amfphp-2.2/Amfphp/Services/ExampleService.php");
			score = tempEnemiesKilled;
			time = tempPlayerTime;
		}
		
		public function onClickSubmit( mouseEvent:MouseEvent ):void 
		{
			var timerStarted = false;
			
			if(!timerStarted)
			{
				confirmTimer.start()
				timerStarted = true;
			}
			
			
			netConnection.call("ExampleService/storeScore", responder, score, time, "bob");
			//playStage.removeChild(playTimeText);
			//playStage.removeChild(enemiesKilledText);
		}
		
		public function goToMainMenu(event:TimerEvent): void
		{
			dispatchEvent( new NavigationEvent(NavigationEvent.SUBMITTED));
		}
		
		public function storeAndPrint(leaderBoard:Array)
		{
			if(leaderBoard != null)
			{
				trace("IT WORKS");
			}
		}
	}
	
}
