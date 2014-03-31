package  {

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
	
	public class SamuraiStage extends MovieClip 
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
		
		public var isPaused:Boolean;
		public var isMuted:Boolean;
		public var playerAttack:Boolean;//isAttacking 
		public var gamePlaying:Boolean = false;
		
		public var playerWasHit:Boolean;//hit the player
		public var enemyWasHit:Boolean;//hit the enemy
		
		public var enemyDead:Boolean;
		
		public var playStage:Stage;
		
		public var gameBackground:MovieClip;
		
		public var gameTime:uint; //Game time, in ms
		
		public var pauseText:TextField = new TextField();
		
		private var gameStartTime:uint;
		private var gameTimeField:TextField;
		
		private var readyText:MovieClip = new ReadyText();
		private var fightText:MovieClip = new FightText();
		
		private var screenCleared:Boolean = false;
		
		private var enemyPicker:int;
		
		public function SamuraiStage(parentStage:Stage, tempPlayerType:String) 
		{
			isPaused = false;
			isMuted = false;
			enemyWasHit = false;
			enemyDead = false;
			pauseText.text = "";
			playStage = parentStage;
			playerType = tempPlayerType;
			
			if (playerType == "Samurai")
				player = new Samurai();
				
			else if (playerType == "Duelist")
				player = new Duelist();
			
			else
				player = new Knight();
			
			enemy = new Enemy(new SamuraiIcon());
			gameBackground = new SamuraiBackground();
			
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
			
			pauseText.defaultTextFormat = timeTextFormat;
			
			playStage.addChild(gameTimeField); //Index 6
			playStage.addChild(pauseText); //Index 7
			
			readyText.gotoAndStop(1);
			readyText.visible = false;
			
			fightText.gotoAndStop(1);
			fightText.visible = false;
			
			playStage.addChild(readyText); //Index 8
			playStage.addChild(fightText); //Index 9
				
			playStage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown); //adds a keydown listener
			playStage.addEventListener(KeyboardEvent.KEY_UP, keyUp); //adds a keyup listener
			
			gameTimer.addEventListener(TimerEvent.TIMER, update );
			playStage.addEventListener(Event.ENTER_FRAME,showTime);
			playStage.addEventListener(Event.ENTER_FRAME, preFight);
			
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
						enemyDead = true;
						playStage.removeChild(enemy.enemyIcon);
						playStage.removeChild(enemy);
						
						enemyDead = false;
						
						enemyPicker = Math.random()*2;
			
						if (enemyPicker == 0)
						{
							enemy = new Enemy(new KnightIcon());
							gameBackground = new KnightBackground();
						}
						
						else if (enemyPicker == 1)
						{
							enemy = new Enemy(new DuelistIcon());
							gameBackground = new DuelistBackground();
						}
						
						else
						{
							enemy = new Enemy(new SamuraiIcon());
							gameBackground = new SamuraiBackground();
						}
						
						//playStage.addChild(gameBackground);
						playStage.addChild(enemy);
						playStage.addChild(enemy.enemyIcon);	
						//dispatchEvent(new EnemyEvent(EnemyEvent.ENEMYDEAD));
					}
					
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
						playerWasHit = true;
						screenClear();
						dispatchEvent( new PlayerEvent(PlayerEvent.DEAD ));
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
		
		public function changeCharacter(e)
		{
			playStage.removeChild(player.playerIcon);
			playStage.removeChild(player);
				
			if (player.playerType == "Samurai")
			{
				player = new Duelist();
				playStage.addChild(player);
				playStage.addChild(player.playerIcon);
			}
				
			else if (player.playerType == "Duelist")
			{
				player = new Knight();
				playStage.addChild(player);
				playStage.addChild(player.playerIcon);
			}
				
			else
			{
				player = new Samurai();
				playStage.addChild(player);
				playStage.addChild(player.playerIcon);
			}
		}
		
		public function EnemyAttack()
		{
			enemy.enemyAttack = true;
			enemy.enemyIcon.gotoAndPlay(2);
			enemyActionTimer.reset();
		}
		
		public function screenClear()
		{
			if (!screenCleared)
			{
				gameTimer.stop();
				playerActionTimer.stop();
				enemyActionTimer.stop();
				playStage.removeChild(gameBackground);
				playStage.removeChild(player.playerIcon);
				playStage.removeChild(player);
				playStage.removeChild(enemy.enemyIcon);
				playStage.removeChild(enemy);
				playStage.removeChild(gameTimeField);
				playStage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				playStage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
				screenCleared = true;
			}
		}
		
		public function showTime(event:Event) 
		{
			if (gamePlaying)
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
			readyText.x = playStage.stageWidth/2;
			readyText.y = playStage.stageHeight/2;
			
			fightText.x = playStage.stageWidth/2;
			fightText.y = playStage.stageHeight/2;
			
			preFightTimer.start();
			//trace(preFightTimer.currentCount);
			
			
			if(preFightTimer.currentCount == 5)
			{
				readyText.visible = true;
				readyText.play();
			}
			
			else if(preFightTimer.currentCount == 25)
			{
				readyText.visible = false;
			}
			
			else if(preFightTimer.currentCount == 35)
			{
				fightText.visible = true;
				fightText.play();
			}
			
			else if(preFightTimer.currentCount == 50)
			{
				fightText.visible = false;
				gameTimer.start();
				playerActionTimer.start();
				enemyActionTimer.start();
				gameStartTime = getTimer();
				gameTime = 0;
				gamePlaying = true;
				preFightTimer.stop();
				playStage.removeEventListener(Event.ENTER_FRAME, preFight);
			}
			
		}
	}
}
