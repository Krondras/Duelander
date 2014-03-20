package 
{
	import flash.display.*;
	import flash.utils.*;
	import flash.events.*
	import flash.text.*;
	import flash.media.*;
	
	public class DocumentClass extends MovieClip 
	{
		public var titleScreen:TitleScreen; //container variable for the title screen
		public var playScreen:Main; //container variable for the play screen
		public var gameOverScreen:GameOverScreen; //container variable for the game over screen.
 
		public function DocumentClass() //Initializes the title screen when you first open the game.
		{
			titleScreen = new TitleScreen(); //creates the title screen
			titleScreen.addEventListener( NavigationEvent.START, onRequestStart ); //adds a listener for the game to start (see TitleScreen.as)
			addChild( titleScreen ); //Adds the title screen to the stage.
		}
		
		public function onPlayerDeath( playerEvent:PlayerEvent ):void //Changes to the game over screen when the player dies.
		{
			gameOverScreen = new GameOverScreen(); //creates the game over screen
			addChild( gameOverScreen ); //adds the game over screen to the stage
		 	gameOverScreen.addEventListener( NavigationEvent.RESTART, onRequestRestart ); //adds a listener for the game to restart (see GameOverScreen.as)
			playScreen = null; //removes the play screen.
		}
		
		public function onRequestStart( navigationEvent:NavigationEvent ):void
		{
			playScreen = new Main(stage); //creates the gameplay screen
			playScreen.addEventListener( PlayerEvent.DEAD, onPlayerDeath ); //adds a listener for the player to die 
			addChild( playScreen ); //adds the game over screen to the stage
		 
			titleScreen = null; //removes the title screen.
		}
		
		public function onRequestRestart( navigationEvent:NavigationEvent ):void
		{
			restartGame(); //runs the restartGame function right below this one.
		}
		
		public function restartGame():void //restarts the game
		{
			playScreen = new Main(stage); //creates a new play screen
			playScreen.addEventListener( PlayerEvent.DEAD, onPlayerDeath );//waits for the player to die like before
			addChild( playScreen );//adds the play screen back to the stage
		 
			gameOverScreen = null;//removes the game over screen
		}
	}
}