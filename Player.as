package  
{
	import flash.display.*;
	import flash.utils.*;
	
	public class Player extends MovieClip 
	{
		public var moveSpeed:Number;
		public var playerType:String;
		public var movementTimerInterval:Number;
		public var isAlive:Boolean;
		public var movementTimer:Timer;
		public var isStepping;
		
		public function Player(tempMoveSpeed:Number, tempPlayerType:String, tempMovementTimerInterval:Number) 
		{
			moveSpeed = tempMoveSpeed;
			playerType = tempPlayerType;
			movementTimerInterval = tempMovementTimerInterval;
			isStepping = false; 
			
			movementTimer = new Timer(100); //Fires the movement timer every 1/10th of a second.
			movementTimer.start();
			
			isAlive = true;
			this.x = 320;
			this.y = 400;
		}
		
		public function Update(keys:Object)
		{
		}
		
		public function Movement(keys:Object)
		{
		}
	}
}
