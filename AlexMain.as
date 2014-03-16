package  {
	
	import flash.display.*;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.events.*;
	import flash.utils.Timer;

	public class AlexMain extends MovieClip {
		
		public var PlayType:String = new String();
		public var EnemType:String = new String();
		public var Buttons:Object = new Object();
		
		
		var testTextBox:TextField = new TextField();
		var testFormat:TextFormat = new TextFormat();
		
		
		var EnemIconTemp:MovieClip;
		var playerIconTemp:MovieClip;
		
		public var numHits:int;
		
		var PlayerObject;
		var playAttack:Boolean;//isAttacking 
		var wasHit:Boolean;//hit the enemy
		var playActionTimer:Timer = new Timer(100);
		
		var EnemyObject;
		var enemActionTimer:Timer = new Timer(100);
		
		//var enemAttack:Boolean;
		
		public function AlexMain() {
			// constructor code
			playActionTimer.start();
			enemActionTimer.start();
			
			
			playAttack = false;
			wasHit = false;
			PlayType = "Samurai";
			EnemType = "Samurai";
			numHits = 0;
			testTextBox.autoSize = TextFieldAutoSize.LEFT;
			testTextBox.x = 100;
			testTextBox.y = 100;
			//testFormat.color = 0xff0000;
			testFormat.size = 20;
			testFormat.font = "Jing Jing";
			testTextBox.defaultTextFormat = testFormat;
			//check types of people, later replace with enum for cleaner code
			stage.addEventListener(Event.ENTER_FRAME, Update);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			if(EnemType == "Samurai")
			{
				EnemIconTemp = new enem();
				//EnemIconTemp.x = 52;
				//EnemIconTemp.y = 300;
			}
			
			if(PlayType == "Samurai")
			{
				playerIconTemp = new player();
			}
			PlayerObject = new AlexPlayer(playerIconTemp);
			stage.addChild(PlayerObject.playIcon);
			EnemyObject = new AlexEnemy(EnemIconTemp);
			stage.addChild(EnemyObject.playIcon);
		}
		public function Update(e)
		{
			testTextBox.text = "Number of Hits ";
			testTextBox.appendText(numHits.toString());
			stage.addChild(testTextBox);
			trace(enemActionTimer.currentCount);
			//if(playAttackTimer.currentCount % 5 == 0)
			//{
				
			//}
			for(var key in Buttons)
			{
				//if the key location is true
				if(Buttons[key])
				{
					trace(key);
					
					//spaceBar
					if(key == 32 && playAttack != true && PlayerObject.isBlocking != true && playActionTimer.currentCount  >= 5)
					{
						PlayerAttack();
	
					}
					if(key == 16 && playAttack != true && PlayerObject.isBlocking != true && playActionTimer.currentCount >= 5)
					{
						PlayerBlock();
					}
				}
			}
			if(enemActionTimer.currentCount >= 10)
			{
				EnemyAttack();
			}
			if(EnemyObject.playIcon.currentFrame == 6)
			{
				EnemyObject.playIcon.stop();
				EnemyObject.enemAttack = false;
				wasHit = false;
				//enemActionTimer= new Timer(100);
				enemActionTimer.start();
			}
			if(EnemyObject.enemAttack && EnemyObject.playIcon.sword2.hitTestObject(PlayerObject.playIcon) && wasHit != true)
			{
				if(PlayerObject.isBlocking)
				{
					EnemyObject.playIcon.gotoAndStop(6);
					trace("Blocked");
					//enemActionTimer.delay = 200;
					
				}
				else
				{
					wasHit = true;
					numHits++;
					
				}
			}// && wasHit != true
			if(PlayerObject.isBlocking && PlayerObject.playIcon.currentFrame == 10)
			{
				PlayerObject.playIcon.stop();
				PlayerObject.isBlocking = false;
				playActionTimer.start();
			}
			if(playAttack && PlayerObject.playIcon.currentFrame == 6)
			{
				PlayerObject.playIcon.stop();
				playAttack = false;
				wasHit = false;
				playActionTimer.start();
			}
			if(playAttack && PlayerObject.playIcon.sword1.hitTestObject(EnemyObject.playIcon) && wasHit != true && EnemyObject.enemAttack != true) 
			{
				//numHits++;
				wasHit = true;
				//remove this later and put in enemyClass
			//	stage.removeChild(EnemyObject.playIcon);
				//EnemyObject.playIcon.x = -200;
				//EnemyObject.playIcon.y = -200;
				//EnemIconTemp.x = -200;
				//EnemIconTemp.y = -200;
			}
			else if(playAttack && PlayerObject.playIcon.sword1.hitTestObject(EnemyObject.playIcon) && EnemyObject.enemAttack == true)
			{
				PlayerObject.playIcon.x -= 50;
				EnemyObject.playIcon.x += 50;
			}
		}
		
		//if a key is down store the currently pressed key
		function keyDown(e)
		{
			Buttons[e.keyCode] = true;
		}
		
		//if the key is up store the key that is no longer pressed
		function keyUp(e)
		{
			Buttons[e.keyCode] = false;
		}
		
		
		public function PlayerAttack()
		{
			playAttack = true;
			PlayerObject.playIcon.gotoAndPlay(2);
			playActionTimer.reset();
			
		}
		public function EnemyAttack()
		{
			EnemyObject.enemAttack = true;
			EnemyObject.playIcon.gotoAndPlay(2);
			enemActionTimer.reset();
		}
		public function PlayerBlock()
		{
			PlayerObject.isBlocking = true;
			PlayerObject.playIcon.gotoAndPlay(7);
			playActionTimer.reset();
			
		}
		
		//if(timer % 5 == 0)
		//{
			
		//}
	}
	
}
