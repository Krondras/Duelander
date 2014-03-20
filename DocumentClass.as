package 
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*
	import flash.text.*;
	import flash.media.*;
	
	public class DocumentClass extends MovieClip 
	{
		public var playScreen:Main;
 
		public function DocumentClass() 
		{
			playScreen = new Main(stage);
			addChild( playScreen );
			//changePlayerBtn.addEventListener(MouseEvent.CLICK, changeCharacter);
			playScreen.addEventListener( PlayerEvent.DEAD, onPlayerDeath );
		}
		
		public function onPlayerDeath( avatarEvent:PlayerEvent ):void
		{
			var gameOverScreen:GameOverScreen = new GameOverScreen();
			gameOverScreen.x = 0;
			gameOverScreen.y = 0;
			addChild( gameOverScreen );
		 
			playScreen = null;
		}
	}
}