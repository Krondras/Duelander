package  {

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*
	import flash.text.*;
	import flash.media.*;
	
	public class Main extends MovieClip 
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
		
		public var isPaused:Boolean;
		public var isMuted:Boolean;
		public var playerAttack:Boolean;//isAttacking 
		public var enemyWasHit:Boolean;//hit the enemy
		public var enemyDead:Boolean;
		
		public function Main() 
		{
			isPaused = false;
			isMuted = false;
			enemyWasHit = false;
			enemyDead = false;
			
			playerType = "Samurai";
			
			player = new Samurai();
			enemy = new Enemy(new DuelistIcon());
			
			stage.addChild(player);
			stage.addChild(player.playerIcon);	
			
			stage.addChild(enemy);
			stage.addChild(enemy.enemyIcon);	
			
			gameTimer.start();
			playerActionTimer.start();
			enemyActionTimer.start();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown); //adds a keydown listener
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp); //adds a keyup listener
			gameTimer.addEventListener(TimerEvent.TIMER, update );
			changePlayerBtn.addEventListener(MouseEvent.CLICK, changeCharacter);
		}
		
		public function update(e)
		{
			playerActionTimer = player.playerActionTimer;
			playerAttack = player.playerAttack;
			player.Update(keys);
			player.Attack(keys);
			player.Block(keys);
			enemy.Update(player);
			
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
			
			if (!enemyDead)
			{
				if(playerAttack && player.playerIcon.sword1.hitTestObject(enemy.enemyIcon) && !enemyWasHit) 
				{
					if(enemy.isBlocking)
					{
						player.playerIcon.gotoAndStop(6);
						trace("Attack was Blocked");
					}
					else
					{
						enemyWasHit = true;
						enemyDead = true;
						//remove this later and put in enemyClass
						stage.removeChild(enemy.enemyIcon);
						stage.removeChild(enemy);
					}
					
				}
			
			
				if(enemy.enemyAttack && enemy.enemyIcon.sword1.hitTestObject(player.playerIcon) && !enemyWasHit)
				{
					if(player.playerBlock)
					{
						enemy.enemyIcon.gotoAndStop(6);
						trace("Blocked");
						//enemActionTimer.delay = 200;
					
					}
					else
					{
					
						stage.removeChild(player.playerIcon);
						stage.removeChild(player);
						enemyWasHit = true;
						//numHits++;
					}
				}
			
				if(playerAttack && player.playerIcon.sword1.hitTestObject(enemy.enemyIcon) && enemy.enemyAttack == true)
				{
					player.playerIcon.x -= 50;
					enemy.enemyIcon.x += 50;
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
				//pauseText.text = "Paused";
				isPaused = true;
			}
			
			else if (keys[80] && isPaused)
			{
				gameTimer.start();
				//pauseText.text = "";
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
			stage.removeChild(player.playerIcon);
			stage.removeChild(player);
				
			if (player.playerType == "Samurai")
			{
				player = new Duelist();
				stage.addChild(player);
				stage.addChild(player.playerIcon);
			}
				
			else if (player.playerType == "Duelist")
			{
				player = new Knight();
				stage.addChild(player);
				stage.addChild(player.playerIcon);
			}
				
			else
			{
				player = new Samurai();
				stage.addChild(player);
				stage.addChild(player.playerIcon);
			}
		}
		
		public function EnemyAttack()
		{
			enemy.enemyAttack = true;
			enemy.enemyIcon.gotoAndPlay(2);
			enemyActionTimer.reset();
		}
		
	}
}
