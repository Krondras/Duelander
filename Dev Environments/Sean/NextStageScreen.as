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
			
			if (playStage.contains(playTimeText) == false)
			{
				playStage.addChild(playTimeText);
			}
			
			if (playStage.contains(enemiesKilledText) == false)
			{
				playStage.addChild(enemiesKilledText);
			}
			
			continueBtn.addEventListener( MouseEvent.CLICK, onClickContinue );
		}
 
		public function onClickContinue( mouseEvent:MouseEvent ):void 
		{
			playStage.removeChild(playTimeText);
			playStage.removeChild(enemiesKilledText);
 			dispatchEvent( new NavigationEvent(NavigationEvent.CONTINUE ));
		}
	}
}