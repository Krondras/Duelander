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
		public var isStepping:Boolean;
		public var playerAttack:Boolean = false;
		public var playerAttackTimer:Timer;
		public var playerIcon:MovieClip;
		
		public function Player(tempMoveSpeed:Number, tempPlayerType:String, tempMovementTimerInterval:Number, tempIcon:MovieClip) 
		{
			playerIcon = tempIcon;
			moveSpeed = tempMoveSpeed;
			playerType = tempPlayerType;
			movementTimerInterval = tempMovementTimerInterval;
			isStepping = false; 
			
			playerAttackTimer = new Timer(100);
			movementTimer = new Timer(100); //Fires the movement timer every 1/10th of a second.
			
			movementTimer.start();
			playerAttackTimer.start();
			
			isAlive = true;
			playerIcon.x = 420;
			playerIcon.y = 300;
			playerIcon.stop();
		}
		
		public function Update(keys:Object)
		{
			//When the movement timer has reached a value cleanly divisible by the movementTimer interval,
			//run movement
			if(movementTimer.currentCount % movementTimerInterval == 0)
			{
				Movement(keys);
			}
			
			trace(movementTimer.currentCount % movementTimerInterval);
		}
		
		public function Movement(keys:Object)
		{
			for(var currentKeys in keys) //Starts a for loop that will trace the keys being pressed in every frame.
			{
				if (keys[currentKeys])
				{
					if(currentKeys == 37 && playerIcon.x - playerIcon.width/2 > 0)
						playerIcon.x -= moveSpeed;
						
					if(currentKeys == 39 && playerIcon.x + playerIcon.width/2 < stage.stageWidth)
						playerIcon.x += moveSpeed;
				}
			}
		}
		
		public function Attack(keys:Object)
		{
			for(var currentKeys in keys) //Starts a for loop that will trace the keys being pressed in every frame.
			{
				if (keys[currentKeys])
				{
					if(currentKeys == 32 && playerAttack != true && playerAttackTimer.currentCount  >= 5)
					{
						playerAttack = true;
						playerIcon.gotoAndPlay(1);
						playerAttackTimer.reset();
					}
				}
			}
		}
	}
}
