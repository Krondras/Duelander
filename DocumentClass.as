package 
{
	import flash.display.*;
	import flash.system.*;
	
	public class DocumentClass extends MovieClip 
	{
		public var menuScreen:MenuScreen;
		public var playScreen:ZeroVoider;
		public var gameOverScreen:GameOverScreen;
 		public var isMuted:Boolean;
		
		public function DocumentClass() 
		{
			stage.stageFocusRect = false;
			isMuted = false;
			menuScreen = new MenuScreen(stage, isMuted);
			menuScreen.addEventListener( NavigationEvent.START, onRequestStart );
			menuScreen.addEventListener( NavigationEvent.CLOSEGAME, onRequestQuit );
			addChild( menuScreen );
		}
		
		public function onPlayerDeath( playerEvent:PlayerEvent ):void
		{
			isMuted = playScreen.isMuted;
			var finalScore:Number = playScreen.getFinalScore();
			gameOverScreen = new GameOverScreen(isMuted);
			addChild( gameOverScreen );
			gameOverScreen.setFinalScore( finalScore );
 			gameOverScreen.addEventListener( NavigationEvent.RESTART, onRequestRestart );
			gameOverScreen.addEventListener( NavigationEvent.CLOSEGAME, onRequestQuit );
			
			removeChild( playScreen );
			playScreen = null;
			stage.focus = gameOverScreen;
		}
		
		public function startGame():void
		{
			isMuted = menuScreen.isMuted;
			playScreen = new ZeroVoider(stage, menuScreen.isMuted);
			playScreen.addEventListener( PlayerEvent.DEAD, onPlayerDeath );
			addChild( playScreen );
			
			removeChild( menuScreen );
			menuScreen = null;
			stage.focus = playScreen;
			
		}
		
		public function onRequestStart( navigationEvent:NavigationEvent ):void
		{
			startGame();
		}
		
		public function onRequestRestart( navigationEvent:NavigationEvent ):void
		{
			restartGame();
		}
		
		public function onRequestQuit ( navigationEvent:NavigationEvent): void
		{
			quitGame();
		}
		
		public function onRequestToMenu( navigationEvent:NavigationEvent ):void
		{
			toMainMenu();
		}
		
		public function restartGame():void
		{
			isMuted = gameOverScreen.isMuted;
			playScreen = new ZeroVoider(stage, isMuted);
			playScreen.addEventListener( NavigationEvent.START, onRequestStart );
			addChild( playScreen );
 
 			removeChild( gameOverScreen );
			gameOverScreen = null;
			stage.focus = playScreen;
		}
		
		public function toMainMenu():void
		{
			isMuted = gameOverScreen.isMuted;
			menuScreen = new MenuScreen(stage, isMuted);
			menuScreen.addEventListener( NavigationEvent.START, onRequestStart );
			addChild( menuScreen );
 
 			removeChild( gameOverScreen );
			gameOverScreen = null;
			stage.focus = menuScreen;
		}
		
		public function quitGame()
		{
			trace("DURIAN ARMS! MISTERRRRRRRRR DANGEROUS!");
			fscommand("quit");
		}
	}
}