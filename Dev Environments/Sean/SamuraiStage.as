package  {
	
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
		public var playerHitbox:MovieClip;
		public var playerSwordHitbox:MovieClip;
		public var playerGuardHitbox:MovieClip;
		
		public var enemy:Enemy;
		public var enemyType:String;
		public var enemyHitbox:MovieClip;
		public var enemySwordHitbox:MovieClip;
		public var enemyGuardHitbox:MovieClip;
		
		public var keys:Object = new Object(); //Creates an object called keys that will be used to read what keys are being pressed.
		
		public var mainStage:Stage;
		
		public var timerValue:Number;
		private var startTimeValue:Number;
		
		public var gameTimer:Timer = new Timer(25);
		public var playerActionTimer:Timer = new Timer(100);
		public var enemyActionTimer:Timer = new Timer(100);
		public var preFightTimer:Timer = new Timer(100);
		public var countdownTimer:Timer = new Timer(1000, timerValue + 1);
		public var winTimer:Timer = new Timer(100);
		public var loseTimer:Timer = new Timer(100);
		
		public var attackButtonTimer:Timer = new Timer(1000);
		public var blockButtonTimer:Timer = new Timer(1000);
		
		public var isPaused:Boolean;
		public var isMuted:Boolean;
		public var playerAttack:Boolean = false;;//isAttacking 
		public var gamePlaying:Boolean = false;
		
		public var playerWasHit:Boolean;//hit the player
		public var enemyWasHit:Boolean;//hit the enemy
		
		public var enemyDead:Boolean;
		
		public var playStage:Stage;
		
		public var gameTime:uint; //Game time, in ms
		
		public var gameBackground:MovieClip;
		public var blood:MovieClip;
		public var pauseText:TextField = new TextField();
		
		public var duelistSwing:DuelistSwingSound = new DuelistSwingSound();
		public var samuraiSwing:SamuraiSwingSound = new SamuraiSwingSound();
		public var knightSwing:KnightSwingSound = new KnightSwingSound();
		public var duelistCut:DuelistCutSound = new DuelistCutSound();
		public var samuraiCut:SamuraiCutSound = new SamuraiCutSound();
		public var knightCut:KnightCutSound = new KnightCutSound();
		public var duelistAttack:DuelistAttack = new DuelistAttack();
		public var samuraiAttack:SamuraiAttack = new SamuraiAttack();
		public var knightAttack:KnightAttack = new KnightAttack();
		public var duelistKO:DuelistKO = new DuelistKO();
		public var samuraiKO:SamuraiKO = new SamuraiKO();
		public var knightKO:KnightKO = new KnightKO();
		public var parrySound:ParrySound = new ParrySound();
		
		public var sfxSoundChannel:SoundChannel;	//sfx for Sound FX
		public var voiceSoundChannel:SoundChannel; //voices
		
		private var gameStartTime:uint;
		private var gameTimeField:TextField;
		
		private var readyText:MovieClip = new ReadyText();
		private var fightText:MovieClip = new FightText();
		private var winText:MovieClip = new WinText();
		
		private var screenCleared:Boolean = false;
		
		private var attackButtonPressed:Boolean = false; //checks to see if the attack button has been pressed
		private var blockButtonPressed:Boolean = false; //checks to see if the block button has been pressed
		
		public function SamuraiStage(parentStage:Stage, tempPlayerType:String, tempTimerValue:Number) 
		{
			isPaused = false;
			isMuted = false;
			playerWasHit = false;
			
			enemyWasHit = false;
			enemyDead = false;
			playStage = parentStage;
			playerType = tempPlayerType;
			
			if (playerType == "Samurai")
			{
				player = new Samurai();
				playerHitbox = player.playerIcon.hitbox;
				playerSwordHitbox = player.playerIcon.attackHitbox;
				playerGuardHitbox = player.playerIcon.guardHitbox;
			}
				
			else if (playerType == "Duelist")
			{
				player = new Duelist();
				playerHitbox = player.playerIcon.hitbox;
				playerSwordHitbox = player.playerIcon.attackHitbox;
				playerGuardHitbox = player.playerIcon.guardHitbox;
			}
			
			else
			{
				player = new Knight();
				playerHitbox = player.playerIcon.hitbox;
				playerSwordHitbox = player.playerIcon.attackHitbox;
				playerGuardHitbox = player.playerIcon.guardHitbox;
			}
			
			enemy = new Enemy(new SamuraiIcon());
			enemy.enemyType = "Samurai";
			enemyHitbox = enemy.enemyIcon.hitbox;
			enemySwordHitbox = enemy.enemyIcon.attackHitbox;
			enemyGuardHitbox = enemy.enemyIcon.guardHitbox;
				blood = new Blood();
			blood.width = 20;
			blood.height = 20;
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
			timeTextFormat.color = 0xff0000;
			gameTimeField.defaultTextFormat = timeTextFormat;
			pauseText.defaultTextFormat = timeTextFormat;
			pauseText.x = 225;
			pauseText.y = 200;
			playStage.addChild(pauseText);
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
			countdownTimer.addEventListener(TimerEvent.TIMER, countdown);
			attackButtonTimer.addEventListener(TimerEvent.TIMER, attackButtonTimeout);
			blockButtonTimer.addEventListener(TimerEvent.TIMER, blockButtonTimeout);
			
			playStage.addEventListener(Event.ENTER_FRAME, preFight);
			playStage.addEventListener(Event.ENTER_FRAME, winFight);
			playStage.addEventListener(Event.ENTER_FRAME, loseFight);
			
			playStage.setChildIndex(gameBackground, 1);
			
			startTimeValue = tempTimerValue;
			timerValue = tempTimerValue;
		}
		
		public function update(e)
		{
			displayTimer();
			//trace(blockButtonPressed);
			
			if (!playerWasHit) //Updates the player's listeners while they're still alive.
			{
				playerActionTimer = player.playerActionTimer;
				playerAttack = player.playerAttack;
				player.Update(keys);
				//player.Attack(keys);
				//player.Block(keys);
			}
			
			if (!enemyDead && !playerWasHit) //Updates the enemy if the player isn't dead.
				enemy.Update(player);
			
			if (!playerWasHit && gamePlaying) //Checks if the player has been hit before updating animations
			{
				if(playerAttack && player.playerIcon.currentFrame == 6)
				{
					//player.playerIcon.stop();
					player.playerActionTimer.start();
				}
				
				if(player.playerBlock && player.playerIcon.currentFrame == 10)
				{
					//player.playerIcon.stop();
					player.playerBlock = false;
					player.playerActionTimer.start();
				}
				
				if(player.playerBlock && player.playerIcon.currentFrame == 10)
				{
					//player.playerIcon.stop();
					player.playerBlock = false;
					playerActionTimer.start();
				}
				if(playerAttack && player.playerIcon.currentFrame == 6)
				{
					//player.playerIcon.stop();
					playerActionTimer.start();
				}
				
				if(enemy.enemyAttack == false)
				{
					enemy.enemyIcon.stop();
					enemy.enemyAttack = false;
					enemyActionTimer.start();
				}
			}
			
			if (!enemyDead) //Checks if the enemy is dead before checking hits.
			{
				if(playerAttack && playerSwordHitbox.hitTestObject(enemySwordHitbox) && enemy.enemyAttack)
				{
					var isRepelling:Boolean = true
					
					if(isRepelling)
					{
						player.playerIcon.x -= 50;
						enemy.enemyIcon.x += 50;
						trace("repel");
						sfxSoundChannel = parrySound.play();
						isRepelling = false;
						enemy.enemyAttack = false;
					}
				}
				if(playerSwordHitbox.hitTestObject(enemyHitbox) && !enemyWasHit && playerAttack) 
				{
						trace("Enemy killed")
						playStage.addChild(blood)
						blood.x = enemyHitbox.x+ 250;
						blood.y = enemyHitbox.y+ 200;
						blood.play();
						sfxSoundChannel = samuraiKO.play();
						if(playerType == "Duelist")
							sfxSoundChannel = duelistCut.play();
						else if(playerType == "Samurai")
							sfxSoundChannel = samuraiCut.play();
						else
							sfxSoundChannel = knightCut.play();
							
						player.playerIcon.gotoAndStop(0);
						enemyDead = true;
						gamePlaying = false;
						gameTimer.stop();
						countdownTimer.stop();
						enemyWasHit = true;
						playerActionTimer.stop();
						enemyActionTimer.stop();
						winTimer.start();
						player.isMoving = false;
				}
				
				if(enemySwordHitbox.hitTestObject(playerGuardHitbox) && player.playerBlock && enemy.enemyAttack)
				{
					enemy.enemyIcon.gotoAndStop(6);
				}
				
				else if(enemySwordHitbox.hitTestObject(playerHitbox) && !playerWasHit && enemy.enemyAttack) 
				{
						playerWasHit = true;
						trace("Player died");
						playStage.addChild(blood)
						blood.x = playerHitbox.x+ 200;
						blood.y = playerHitbox.y+ 250;
						blood.play();
						sfxSoundChannel = samuraiCut.play();
						if(playerType == "Duelist")
							sfxSoundChannel = duelistKO.play();
						else if(playerType == "Samurai")
							sfxSoundChannel = samuraiKO.play();
						else
							sfxSoundChannel = knightKO.play();
						
						playStage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
						playStage.removeEventListener(KeyboardEvent.KEY_UP, keyUp);
						gamePlaying = false;
						gameTimer.stop();
						countdownTimer.stop();
						playerActionTimer.stop();
						enemyActionTimer.stop();
						loseTimer.start();
						player.isMoving = false;
				}
				
				if(enemyActionTimer.currentCount >= 10)
				{
					sfxSoundChannel = samuraiSwing.play();
					sfxSoundChannel = samuraiAttack.play();
					EnemyAttack();
				}
			}
		}
		
		public function keyDown(e) // Activates when a key is pressed down
		{
			keys[e.keyCode] = true; //Sets the value of key to two things--the keycode of the key being pressed, and the value "true".
			
			if(keys[32] && !attackButtonPressed)
			{
				attackButtonPressed = true;
				attackButtonTimer.start();
				
				if(playerType == "Duelist")
					sfxSoundChannel = duelistSwing.play();
				else if(playerType == "Samurai")
					sfxSoundChannel = samuraiSwing.play();
				else
					sfxSoundChannel = knightSwing.play();
				
				if(playerType == "Duelist")
					sfxSoundChannel = duelistAttack.play();
				else if(playerType == "Samurai")
					sfxSoundChannel = samuraiAttack.play();
				else
					sfxSoundChannel = knightAttack.play();
					
				player.Attack(keys);
			}
			
			if(keys[16] && !blockButtonPressed)
			{
				blockButtonPressed = true;
				blockButtonTimer.start();
				player.Block(keys);
			}
			
			if (keys[80] && gamePlaying && !isPaused)
			{
				gameTimer.stop();
				
				pauseText.text = "Paused";
				isPaused = true;
			}
			
			else if (keys[80] && gamePlaying && isPaused)
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
			//enemy.enemyIcon.sheetSam.y = -152;
			//enemy.enemyIcon.sheetSam.x = -35;
			//enemy.enemyIcon.gotoAndPlay(2);
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
				countdownTimer.start();
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
		
		function displayTimer()
		{
			gameTimeField.text = String(timerValue);
		}
		
		function countdown(event:TimerEvent):void 
		{
			if(!isPaused)
			{
				timerValue -= 1;
			}
			
			if (timerValue == 0)
			{
				playerWasHit = true;
				trace("Player died");
				gamePlaying = false;
				gameTimer.stop();
				countdownTimer.stop();
				playerActionTimer.stop();
				enemyActionTimer.stop();
				loseTimer.start();
			}
		}
		
		function getRemainingTime()
		{
			return (timerValue);
		}
		
		function getTimeElapsed()
		{
			return (startTimeValue - timerValue);
		}
		
		function attackButtonTimeout(event:TimerEvent):void
		{
			if (!keys[32])
			{
				attackButtonPressed = false;
				attackButtonTimer.stop();
			}
		}
		
		function blockButtonTimeout(event:TimerEvent):void
		{
			if (!keys[16])
			{
				blockButtonPressed = false;
				blockButtonTimer.stop();
			}
		}
	}
}
