package 
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*
	import flash.text.*;
	import flash.media.*;
 
	public class NextStageScreen extends MovieClip 
	{
		public var playStage:Stage;
		private var playTimeText:TextField = new TextField();
		private var enemiesKilledText:TextField = new TextField();
		private var timeAdded:Boolean = false;
		
		public function NextStageScreen(tempStage:Stage, tempPlayTime:uint, tempEnemiesKilled:int) 
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
			
			if (!textAdded)
			{
				playStage.addChild(playTimeText);
				trace("Play time added");
				playStage.addChild(enemiesKilledText);
				trace("Enemy count added");
				textAdded = true;
			}
			
			continueBtn.addEventListener( MouseEvent.CLICK, onClickContinue);
			mainMenuBtn.addEventListener( MouseEvent.CLICK, onClickMenu);
			submitScoreBtn.addEventListener( MouseEvent.CLICK, onClickSubmit);
		}
 
		public function onClickContinue( mouseEvent:MouseEvent ):void 
		{
			clearScreen();
 			dispatchEvent( new NavigationEvent(NavigationEvent.CONTINUE ));
		}
		
		public function onClickSubmit( mouseEvent:MouseEvent ):void 
		{
			clearScreen();
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