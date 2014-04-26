package 
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*
	import flash.text.*;
	import flash.media.*;
 
	public class GameOverScreen extends MovieClip 
	{
		public var playStage:Stage;
		private var playTimeText:TextField = new TextField();
		private var enemiesKilledText:TextField = new TextField();
		private var timeAdded:Boolean = false;
		
		public function GameOverScreen(tempStage:Stage, tempPlayTime:uint, tempEnemiesKilled:int) 
		{
			playStage = tempStage;
			playTimeText.width = 450;
			playTimeText.height = 100;
			playTimeText.x = 75;
			playTimeText.y = 100;
			
			enemiesKilledText.width = 425;
			enemiesKilledText.height = 100;
			enemiesKilledText.x = 75;
			enemiesKilledText.y = 150;
			
			var timeTextFormat:TextFormat = new TextFormat();
			timeTextFormat.font = "Arial";
			timeTextFormat.align = "center";
			timeTextFormat.size = 36;
			timeTextFormat.color = 0x000000;
			
			playTimeText.defaultTextFormat = timeTextFormat;
			playTimeText.selectable = false;
			enemiesKilledText.defaultTextFormat = timeTextFormat;
			enemiesKilledText.selectable = false;
			
			playTimeText.text = "Current Time: "+ tempPlayTime + " second(s)";
			enemiesKilledText.text = tempEnemiesKilled + " rival(s) defeated";
			
			var textAdded:Boolean = false;
			
			if (textAdded == false)
			{
				playStage.addChild(playTimeText);
				trace("Play time added");
				playStage.addChild(enemiesKilledText);
				trace("Enemy count added");
				textAdded = true;
			}
			
			retryBtn.addEventListener( MouseEvent.CLICK, onClickRestart ); //Submits a restart query to document class
			mainMenuBtn.addEventListener(MouseEvent.CLICK, onClickMenu); //Submits a main menu query to document class
			//submitScoreBtn.addEventListener( MouseEvent.CLICK, onClickSubmit) //Submits a score submission query to document class
		}
 
		public function onClickRestart( mouseEvent:MouseEvent ):void 
		{
			clearScreen();
			if(!playStage.contains(playTimeText) && !playStage.contains(enemiesKilledText))
 				dispatchEvent( new NavigationEvent(NavigationEvent.RESTART ));
		}
		
		public function onClickSubmit( mouseEvent:MouseEvent ):void 
		{
			clearScreen();
			
			if(!playStage.contains(playTimeText) && !playStage.contains(enemiesKilledText))
 				dispatchEvent( new NavigationEvent(NavigationEvent.TOSUBMIT ));
		}
		
		public function onClickMenu( mouseEvent:MouseEvent ):void 
		{
			clearScreen();
			
			if(!playStage.contains(playTimeText) && !playStage.contains(enemiesKilledText))
 				dispatchEvent( new NavigationEvent(NavigationEvent.TOMENU ));
		}
		
		public function clearScreen()
		{
			playTimeText.text = "";
			enemiesKilledText.text =" ";
			playStage.removeChild(playTimeText);
			playStage.removeChild(enemiesKilledText);
		}
		
	}
}