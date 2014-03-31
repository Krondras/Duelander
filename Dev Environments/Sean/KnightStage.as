﻿package  {

	/*To do:
	switch to alex's state-trackings tyle
	on enemy death, create a NEXT STAGE screen.
	*/

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*
	import flash.text.*;
	import flash.media.*;
	import flash.sensors.*;
	
	public class KnightStage extends MovieClip 
	{

		public var player:Player;
		public var playerType:String;
		
		public var enemy:Enemy;
		public var enemyType:String;
		
		public var keys:Object = new Object(); //Creates an object called keys that will be used to read what keys are being pressed.
		
		public var mainStage:Stage;
		
		public var gameTimer:Timer = new Timer(25);
		public var playerActionTimer:Timer = new Timer(100);
		public var enemyActionTimer:Timer = new Timer(100);
		public var preFightTimer:Timer = new Timer(100);
		public var winTimer:Timer = new Timer(100);
		public var loseTimer:Timer = new Timer(100);
		
		public var isPaused:Boolean;
		public var isMuted:Boolean;
		public var playerAttack:Boolean;//isAttacking 
		public var gamePlaying:Boolean = false;
		
		public var playerWasHit:Boolean;//hit the player
		public var enemyWasHit:Boolean;//hit the enemy
		
		public var enemyDead:Boolean;
		
		public var playStage:Stage;
		
		public var gameTime:uint; //Game time, in ms
		
		public var gameBackground:MovieClip;
		
		public var pauseText:TextField = new TextField();
		private var gameStartTime:uint;
		private var gameTimeField:TextField;
		
		private var readyText:MovieClip = new ReadyText();
		private var fightText:MovieClip = new FightText();
		private var winText:MovieClip = new WinText();
		
		private var screenCleared:Boolean = false;
		
		public function KnightStage(parentStage:Stage, tempPlayerType:String) 
		{
			isPaused = false;
			isMuted = false;
			enemyWasHit = false;
			enemyDead = false;
			playStage = parentStage;
			playerType = tempPlayerType;
			
			if (playerType == "Samurai")
				player = new Samurai();
				
			else if (playerType == "Duelist")
				player = new Duelist();
			
			else
				player = new Knight();
			
			enemy = new Enemy(new KnightIcon());
			gameBackground = new KnightBackground();
			
			playStage.addChild(gameBackground);//Index 1
			
			playStage.addChild(player); //Index 2 
			playStage.addChild(player.playerIcon); //Index 3	
			
			playStage.addChild(enemy); //Index 4
			playStage.addChild(enemy.enemyIcon); //Index 5
			
			gameTimeField = new TextField();
			gameTimeField.width = 300;
			gameTimeField.height = 150;
			gameTimeField.x = playStage.stageWidth/2 - 150;
			
			var timeTextFormat:TextFormat = new TextFormat();
			timeTextFormat.font = "Arial";
			timeTextFormat.align = "center";
			timeTextFormat.size = 24;
			timeTextFormat.color = 0xffffff;
			gameTimeField.defaultTextFormat = timeTextFormat;
			
			playStage.addChild(gameTimeField); //Index 6
			
			readyText.gotoAndStop(1);
			readyText.visible = false;
			
			fightText.gotoAndStop(1);
			fightText.visible = false;
			
			playStage.addChild(readyText); //Index 7
			playStage.addChild(fightText); //Index 8
				
			playStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown); //adds a keydown listener
			playStage.addEventListener(KeyboardEvent.KEY_UP, keyUp); //adds a keyup listener
			
			gameTimer.addEventListener(TimerEvent.TIMER, update );
			playStage.addEventListener(Event.ENTER_FRAME, showTime);
			playStage.addEventListener(Event.ENTER_FRAME, preFight);
			playStage.addEventListener(Event.ENTER_FRAME, winFight);
			playStage.addEventListener(Event.ENTER_FRAME, loseFight);
			
			playStage.setChildIndex(gameBackground, 1);
		}
		
		public function update(e)
		{
			if (!playerWasHit) //Updates the player's listeners while they're still alive.
			{
				playerActionTimer = player.playerActionTimer;
				playerAttack = player.playerAttack;
				player.Update(keys);
				player.Attack(keys);
				player.Block(keys);
			}
			
			if (!enemyDead && !playerWasHit) //Updates the enemy if the player isn't dead.
				enemy.Update(player);
			
			if (!playerWasHit) //Checks if the player has been hit before updating animations
			{
				if(player.playerAttack && player.playerIcon.currentFrame == 6)
				{
					player.playerIcon.stop();
					player.playerAttack = false;
					enemyWasHit = false;
					player.playerActionTimer.start();
				}
				
				if(player.playerBlock && player.playerIcon.currentFrame == 10)
				{
					player.playerIcon.stop();
					player.playerBlock = false;
					player.playerActionTimer.start();
				}
				
				// && enemyWasHit != true
				if(player.playerBlock && player.playerIcon.currentFrame == 10)
				{
					player.playerIcon.stop();
					player.playerBlock = false;
					playerActionTimer.start();
				}
				if(playerAttack && player.playerIcon.currentFrame == 6)
				{
					player.playerIcon.stop();
					playerAttack = false;
					enemyWasHit = false;
					playerActionTimer.start();
				}
				
				if(enemy.enemyIcon.currentFrame == 6)
				{
					enemy.enemyIcon.stop();
					enemy.enemyAttack = false;
					enemyWasHit = false;
					enemyActionTimer.start();
				}
			}
			
			if (!enemyDead) //Checks if the enemy is dead before checking hits.
			{
				if(playerAttack && player.playerIcon.sword1.hitTestObject(enemy.enemyIcon) && !enemyWasHit) 
				{
					if(enemy.isBlocking)
					{
						player.playerIcon.gotoAndStop(6);
						//trace("Attack was Blocked");
					}
					else
					{
						player.playerIcon.gotoAndStop(0);
						enemyDead = true;
					}
					gamePlaying = false;
					gameTimer.stop();
					playerActionTimer.stop();
					enemyActionTimer.stop();
					winTimer.start();
				}
			
				
				if(enemy.enemyAttack && enemy.enemyIcon.sword1.hitTestObject(player.playerIcon) && !enemyWasHit)
				{
					if(player.playerBlock)
					{
						enemy.enemyIcon.gotoAndStop(6);
						//trace("Blocked");
						//enemActionTimer.delay = 200;
					
					}
					else
					{
						gamePlaying = false;
						gameTimer.stop();
						playerActionTimer.stop();
						enemyActionTimer.stop();
						loseTimer.start();
					}
				}
			
				if(playerAttack && player.playerIcon.sword1.hitTestObject(enemy.enemyIcon) && enemy.enemyAttack == true)
				{
					player.playerIcon.x -= 50;
					enemy.enemyIcon.x += 50;
					trace("repel");
				}
			
				if(enemyActionTimer.currentCount >= 10)
				{
					EnemyAttack();
				}
			}
		}
		
		public function keyDown(e) // Activates when a key is pressed down
		{
			keys[e.keyCode] = true; //Sets the value of key to two things--the keycode of the key being pressed, and the value "true".
			
			if (keys[80] && !isPaused)
			{
				gameTimer.stop();
				
				pauseText.text = "Paused";
				isPaused = true;
			}
			
			else if (keys[80] && isPaused)
			{
				gameTimer.start();
				pauseText.text = "";
				isPaused = false;
			}
			
			if (keys[77] && !isMuted)
			{
				isMuted = true;
			}
			
			else if (keys[77] && isMuted)
			{
				isMuted = false;
			}
		}
		
		public function keyUp(e) //Activates when a key is released.
		{
			keys[e.keyCode] = false; //Sets the value of key to two things--the keycode of the key being released, and the value "false".
		}
		
		public function EnemyAttack()
		{
			enemy.enemyAttack = true;
			enemy.enemyIcon.gotoAndPlay(2);
			enemyActionTimer.reset();
		}
	
		
		public function clearScreen()
		{
			if (!screenCleared)
			{
				playStage.removeChild(gameBackground);
				playStage.removeChild(gameTimeField);
				playStage.removeChild(player.playerIcon);
				playStage.removeChild(player);
				playStage.removeChild(enemy.enemyIcon);
				playStage.removeChild(enemy);
				playStage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				playStage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
				screenCleared = true;
			}
		}
		
		public function showTime(event:Event) 
		{
			if (gamePlaying && !isPaused)
			{
				gameTime = getTimer()-gameStartTime;
				gameTimeField.text = "Time: "+clockTime(gameTime);
			}
		}
		
		public function clockTime(ms:int) 
		{
			if (gamePlaying && !isPaused)
			{
				var seconds:int = Math.floor(ms/1000);
				var minutes:int = Math.floor(seconds/60);
				seconds -= minutes*60;
				var timeString:String = minutes+":"+String(seconds+100).substr(1,2);
				return timeString;
			}
		}
		
		public function preFight(e)
		{
			//Set ready text position.
			readyText.x = playStage.stageWidth/2;
			readyText.y = playStage.stageHeight/2;
			
			//Set fight text position.
			fightText.x = playStage.stageWidth/2;
			fightText.y = playStage.stageHeight/2;
			
			//Start prefight timer.
			preFightTimer.start();
			
			//Display "READY?"
			if(preFightTimer.currentCount == 5)
			{
				readyText.visible = true;
				readyText.play();
			}
			
			//Hide ready text
			else if(preFightTimer.currentCount == 25)
			{
				readyText.visible = false;
			}
			
			//Show fight text
			else if(preFightTimer.currentCount == 35)
			{
				fightText.visible = true;
				fightText.play();
			}
			
			//Hide fight text
			else if(preFightTimer.currentCount == 50)
			{
				fightText.visible = false;
				gameTimer.start();
				playerActionTimer.start();
				enemyActionTimer.start();
				gameStartTime = getTimer();
				gameTime = 0;
				gamePlaying = true;
				playStage.removeChild(fightText);
				playStage.removeChild(readyText);
				preFightTimer.stop();
				playStage.removeEventListener(Event.ENTER_FRAME, preFight);
			}
		}
		
		public function winFight(e)
		{
			if (winTimer.currentCount == 5)
			{
				winText.x = playStage.stageWidth/2 - winText.width;
				winText.y = playStage.stageHeight/2 - winText.height;
				//playStage.addChild(winText);
			}
			
			else if (winTimer.currentCount == 50)
			{
				dispatchEvent( new NavigationEvent(NavigationEvent.NEXTSTAGE ));
				clearScreen();
			}
		}
		
		public function loseFight(e)
		{
			if (loseTimer.currentCount == 5)
			{
				//winText.x = playStage.stageWidth/2 - winText.width;
				//winText.y = playStage.stageHeight/2 - winText.height;
				//playStage.addChild(winText);
			}
			
			else if (loseTimer.currentCount == 50)
			{
				dispatchEvent( new PlayerEvent(PlayerEvent.DEAD ));
				clearScreen();
			}
		}
	}
}