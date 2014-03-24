package 
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*
	import flash.text.*;
	import flash.media.*;
 
	public class TitleScreen extends MovieClip 
	{
		public function TitleScreen() 
		{
			startBtn.addEventListener( MouseEvent.CLICK, onClickStart );
		}
 
		public function onClickStart( mouseEvent:MouseEvent ):void 
		{
 			dispatchEvent( new NavigationEvent(NavigationEvent.CHARSELECT ));
		}
	}
}