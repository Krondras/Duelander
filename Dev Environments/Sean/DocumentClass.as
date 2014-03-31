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
		public var selectScreen:SelectScreen; //container for the character selection
		public var playScreen:Main; //container variable for the play screen
		public var gameOverScreen:GameOverScreen; //container variable for the game over screen.
		
		public var finalPlayTime:int;
 		
		public function DocumentClass() //Initializes the title screen when you first open the game.
		{
			titleScreen = new TitleScreen(); //creates the title screen
			titleScreen.addEventListener( NavigationEvent.CHARSELECT, onRequestCharSelect ); //adds a listener for the game to start (see TitleScreen.as)
			addChild( titleScreen ); //Adds the title screen to the stage.
		}
		
		public function onPlayerDeath( playerEvent:PlayerEvent ):void //Changes to the game over screen when the player dies.
		{
			finalPlayTime = playScreen.gameTime;
			gameOverScreen = new GameOverScreen(stage, finalPlayTime); //creates the game over screen
			addChild( gameOverScreen ); //adds the game over screen to the stage
		 	gameOverScreen.addEventListener( NavigationEvent.RESTART, onRequestRestart ); //adds a listener for the game to restart (see GameOverScreen.as)
			playScreen = null; //removes the play screen.
		}
		
		public function onRequestCharSelect( navigationEvent:NavigationEvent ):void
		{
			selectScreen = new SelectScreen(); //creates the gameplay screen
			selectScreen.addEventListener( NavigationEvent.START, onRequestStart ); //adds a listener for the player to die 
			addChild( selectScreen ); //adds the game over screen to the stage
		 
			titleScreen = null; //removes the title screen.
		}
		
		public function onRequestStart( navigationEvent:NavigationEvent ):void
		{ 
			playScreen = new Main(stage, selectScreen.playerType); //creates the gameplay screen
			playScreen.addEventListener( PlayerEvent.DEAD, onPlayerDeath ); //adds a listener for the player to die 
			addChild( playScreen ); //adds the game over screen to the stage
		 
			selectScreen = null; //removes the title screen.
		}
		
		public function onRequestRestart( navigationEvent:NavigationEvent ):void
		{
			restartGame(); //runs the restartGame function right below this one.
		}
		
		public function restartGame():void //restarts the game
		{
			selectScreen = new SelectScreen(); //creates a new play screen
			selectScreen.addEventListener( NavigationEvent.START, onRequestStart );//waits for the player to die like before
			addChild( selectScreen );//adds the play screen back to the stage
		 
			gameOverScreen = null;//removes the game over screen
		}
	}
}