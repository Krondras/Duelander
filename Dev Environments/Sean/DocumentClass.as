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
		public var playScreen:MovieClip; //container variable for the play screen
		public var gameOverScreen:GameOverScreen; //container variable for the game over screen.
		public var nextStageScreen:NextStageScreen; // container variable for the next stage screen.
		public var submitScreen:ScoreSubmissionScreen;
		public var leaderboardScreen:LeaderboardDisplayScreen;
		
		public var playerType:String; //Remembers the character that the player selected.
		
		public var remainingTime:int; //How much time's left.
		public var finalPlayTime:int; //Remembers the final play time that the player achieved.
 		public var numEnemiesKilled:int; //Remembers the number of enemies killed.
		
		public var enemyPicker:int;
		public var maxNum = 3;
		public var minNum = 0;
		public function DocumentClass() //Initializes the title screen when you first open the game.
		{
			loadMainMenu();
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
			playerType = selectScreen.playerType;
			chooseNextStage();
			
			if (enemyPicker == 0)
				playScreen = new KnightStage(stage, playerType, 30); //creates the gameplay screen
			
			else if (enemyPicker == 1)
				playScreen = new DuelistStage(stage, playerType, 30); //creates the gameplay screen
				
			else
				playScreen = new SamuraiStage(stage, playerType, 30); //creates the gameplay screen
				
			playScreen.addEventListener(PlayerEvent.DEAD, onPlayerDeath ); //adds a listener for the player to die 
			playScreen.addEventListener(NavigationEvent.NEXTSTAGE, onPlayerWin);
			addChild( playScreen ); //adds the play screen to the stage
			selectScreen = null; //removes the select screen.
		}
		
		public function onPlayerWin( navigationEvent:NavigationEvent ):void
		{
			if (playScreen != null)
			{
				finalPlayTime += playScreen.getTimeElapsed();
				remainingTime = playScreen.timerValue;
				numEnemiesKilled += 1;
				//trace(finalPlayTime);
				loadNextStage();
			}
		}
		
		public function onPlayerDeath( playerEvent:PlayerEvent ):void //Changes to the game over screen when the player dies.
		{
			if (playScreen != null)
			{
				finalPlayTime += playScreen.getTimeElapsed();
			}
			
			if (gameOverScreen == null)
			{
				gameOverScreen = new GameOverScreen(stage, finalPlayTime, numEnemiesKilled); //creates the game over screen
			}
			
			addChild( gameOverScreen ); //adds the game over screen to the stage
		 	gameOverScreen.addEventListener( NavigationEvent.RESTART, onRequestRestart ); //adds a listener for the game to restart (see GameOverScreen.as)
			gameOverScreen.addEventListener( NavigationEvent.TOMENU, onRequestMenu);
			gameOverScreen.addEventListener( NavigationEvent.TOSUBMIT, onRequestSubmit );
			playScreen = null; //removes the play screen.
		}
		
		public function onRequestRestart( navigationEvent:NavigationEvent ):void
		{
			restartGame(); //runs the restartGame function right below this one.
		}
		
		public function onRequestSubmitted( navigationEvent:NavigationEvent ):void
		{
			displayLeaderboard(); //runs the restartGame function right below this one.
		}
		
		public function restartGame():void //restarts the game
		{
			remainingTime = 0;
			finalPlayTime = 0;
			numEnemiesKilled = 0;
			selectScreen = new SelectScreen(); //creates a new select screen
			selectScreen.addEventListener( NavigationEvent.START, onRequestStart );//waits for the player to pick a character
			addChild( selectScreen );//adds the select screen back to the stage
		 
			gameOverScreen = null;//removes the game over screen
		}
		
		public function onRequestMenu( navigationEvent:NavigationEvent ):void
		{
			loadMainMenu(); //Loads up the main menu
		}
		
		public function onRequestSubmit( navigationEvent:NavigationEvent ):void
		{
			goToSubmitScreen(); //runs the restartGame function right below this one.
		}
		
		public function onRequestContinue(navigationEvent:NavigationEvent): void
		{
			chooseNextStage();
			
			if (enemyPicker == 0)
				playScreen = new KnightStage(stage, playerType, remainingTime); //creates the gameplay screen
			
			else if (enemyPicker == 1)
				playScreen = new DuelistStage(stage, playerType, remainingTime); //creates the gameplay screen
				
			else
				playScreen = new SamuraiStage(stage, playerType, remainingTime); //creates the gameplay screen
				
			playScreen.addEventListener(PlayerEvent.DEAD, onPlayerDeath ); //adds a listener for the player to die 
			playScreen.addEventListener(NavigationEvent.NEXTSTAGE, onPlayerWin);
			addChild( playScreen ); //adds the play screen to the stage
		 	
			nextStageScreen = null; //removes the select screen.
		}
		
		public function goToSubmitScreen():void //restarts the game
		{
			submitScreen = new ScoreSubmissionScreen(numEnemiesKilled,finalPlayTime); //creates a new select screen
			submitScreen.addEventListener( NavigationEvent.SUBMITTED, onRequestSubmitted );//waits for the player to submit a score or quit
			addChild( submitScreen );//adds the submit screen back to the stage
		
			gameOverScreen = null;//removes the game over screen
			nextStageScreen = null; //removes the next level screen
		}
		
		public function displayLeaderboard():void //restarts the game
		{
			leaderboardScreen = new LeaderboardDisplayScreen(stage); //creates a new select screen
			leaderboardScreen.addEventListener( NavigationEvent.TOMENU, onRequestMenu );//waits for the player to submit a score or quit
			addChild( leaderboardScreen );//adds the submit screen back to the stage
		
			gameOverScreen = null;//removes the game over screen
			nextStageScreen = null; //removes the next level screen
		}
		
		public function loadNextStage():void //loads the next level
		{
			nextStageScreen = new NextStageScreen(stage, finalPlayTime, numEnemiesKilled); //creates a new select screen
			nextStageScreen.addEventListener( NavigationEvent.CONTINUE, onRequestContinue );//waits for the player to pick a character
			nextStageScreen.addEventListener( NavigationEvent.TOMENU, onRequestMenu);
			nextStageScreen.addEventListener( NavigationEvent.TOSUBMIT, onRequestSubmit );
			addChild( nextStageScreen );//adds the select screen back to the stage
		 
			playScreen = null;//removes the game over screen
		}
		
		public function loadMainMenu()
		{
			titleScreen = new TitleScreen(); //creates the title screen
			titleScreen.addEventListener( NavigationEvent.CHARSELECT, onRequestCharSelect ); //adds a listener for the game to start (see TitleScreen.as)
			addChild( titleScreen ); //Adds the title screen to the stage.
			
			selectScreen = null;
			playScreen = null;
			gameOverScreen = null;
			nextStageScreen = null;
			submitScreen = null;
			leaderboardScreen = null;
		}
		
		public function chooseNextStage():void //sets up the next level
		{
			var levelOK:Boolean = false;
			
			enemyPicker = (Math.round(Math.random() * (maxNum - minNum)) + minNum);
			trace(enemyPicker);
			
			/*while(levelOK == false)
			{
				enemyPicker = Math.random()*3;
				
				if (playerType == "Samurai" && enemyPicker == 2)
					enemyPicker = Math.random()*3;
					
				else if (playerType == "Duelist" && enemyPicker == 1)
					enemyPicker = Math.random()*3;
					
				else if (playerType == "Knight" && enemyPicker == 0)
					enemyPicker = Math.random()*3;
					
				else
					levelOK = true;
			}**/
		}
	}
}