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
		private var timeAdded:Boolean = false;
		
		public function GameOverScreen(tempStage:Stage, tempPlayTime:uint) 
		{
			playStage = tempStage;
			playTimeText.width = 400;
			playTimeText.height = 100;
			playTimeText.x = playStage.width/2 - 200;
			playTimeText.y = playStage.height/2 - 75;
			
			var timeTextFormat:TextFormat = new TextFormat();
			timeTextFormat.font = "Arial";
			timeTextFormat.align = "center";
			timeTextFormat.size = 36;
			timeTextFormat.color = 0x000000;
			playTimeText.defaultTextFormat = timeTextFormat;
			playTimeText.selectable = false;
			
			playTimeText.text = "Final Time: "+ tempPlayTime + " seconds";
			
			if (playStage.contains(playTimeText) == false)
			{
				playStage.addChild(playTimeText);
			}
			
			retryBtn.addEventListener( MouseEvent.CLICK, onClickRestart );
		}
 
		public function onClickRestart( mouseEvent:MouseEvent ):void 
		{
			playStage.removeChild(playTimeText);
 			dispatchEvent( new NavigationEvent(NavigationEvent.RESTART ));
		}
		
		public function clockTime(ms:int) 
		{
			var seconds:int = Math.floor(ms/1000);
			var minutes:int = Math.floor(seconds/60);
			seconds -= minutes*60;
			var timeString:String = minutes+":"+String(seconds+100).substr(1,2);
			return timeString;
		}
	}
}