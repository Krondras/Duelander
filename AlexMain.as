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
		var playAttackTimer:Timer = new Timer(100);
		
		
		public function AlexMain() {
			// constructor code
			playAttackTimer.start();
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
				EnemIconTemp.x = 52;
				EnemIconTemp.y = 300;
			}
			
			if(PlayType == "Samurai")
			{
				playerIconTemp = new player();
			}
			PlayerObject = new AlexPlayer(playerIconTemp);
			stage.addChild(PlayerObject.playIcon);
			stage.addChild(EnemIconTemp);
		}
		public function Update(e)
		{
			testTextBox.text = "Number of Hits ";
			testTextBox.appendText(numHits.toString());
			stage.addChild(testTextBox);
			trace(playAttackTimer.currentCount);
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
					if(key == 32 && playAttack != true && playAttackTimer.currentCount  >= 5)
					{
						PlayerAttack();
	
					}
					if(key == 16)
					{
						//PlayerBlock();
					}
				}
			}
			if(playAttack && PlayerObject.playIcon.currentFrame == 6)
			{
				PlayerObject.playIcon.stop();
				playAttack = false;
				wasHit = false;
				playAttackTimer.start();
			}
			if(playAttack && PlayerObject.playIcon.sword1.hitTestObject(EnemIconTemp) && wasHit != true) 
			{
				numHits++;
				wasHit = true;
				//remove this later and put in enemyClass
				stage.removeChild(EnemIconTemp);
				EnemIconTemp.x = -200;
				EnemIconTemp.y = -200;
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
			playAttackTimer.reset();
			
		}
		public function EnemyAttack()
		{
			
		}
		
		//if(timer % 5 == 0)
		//{
			
		//}
	}
	
}
