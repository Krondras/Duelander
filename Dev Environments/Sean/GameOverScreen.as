package 
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*
	import flash.text.*;
	import flash.media.*;
 
	public class GameOverScreen extends MovieClip 
	{
		public function GameOverScreen() 
		{
			retryBtn.addEventListener( MouseEvent.CLICK, onClickRestart );
		}
 
		public function onClickRestart( mouseEvent:MouseEvent ):void 
		{
 			dispatchEvent( new NavigationEvent(NavigationEvent.RESTART ));
		}
	}
}