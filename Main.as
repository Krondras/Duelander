package  {

	import flash.display.*;
	import flash.utils.*;
	import flash.events.*
	import flash.text.*;
	import flash.media.*;
	
	public class Main extends MovieClip {

		public var player:Player;
		public var keys:Object = new Object(); //Creates an object called keys that will be used to read what keys are being pressed.
		public var mainStage:Stage;
		public var gameTimer:Timer;
		public var isPaused:Boolean;
		public var isMuted:Boolean;
		
		public function Main() 
		{
			isPaused = false;
			isMuted = false;
			
			player = new Knight();
			
			stage.addChild(player);
			
			gameTimer = new Timer( 25 );
			gameTimer.start();
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown); //adds a keydown listener
			stage.addEventListener(KeyboardEvent.KEY_UP, keyUp); //adds a keyup listener
			gameTimer.addEventListener(TimerEvent.TIMER, update );
		}
		
		public function update(e)
		{
			player.Update(keys);
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

	}
	
}
