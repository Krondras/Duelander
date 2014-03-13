package  {
	
	import flash.display.*;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.events.*;
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
		var playAttack:Boolean;
		var wasHit:Boolean;
		
		public function AlexMain() {
			// constructor code
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
				EnemIconTemp.x = 50;
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
			for(var key in Buttons)
			{
				//if the key location is true
				if(Buttons[key])
				{
					trace(key);
					if(key == 32)
					{
						PlayerAttack();
	
					}
				}
			}
			if(playAttack && PlayerObject.playIcon.currentFrame == 6)
			{
				PlayerObject.playIcon.stop();
				playAttack = false;
				wasHit = false;
			}
			if(playAttack && PlayerObject.playIcon.sword1.hitTestObject(EnemIconTemp) && wasHit != true) 
			{
				numHits++;
				wasHit = true;
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
			
		}
		public function EnemyAttack()
		{
			
		}
		
		//if(timer % 5 == 0)
		//{
			
		//}
	}
	
}
