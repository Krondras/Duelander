package  
{
	import flash.display.*;
	import flash.utils.*;
	
	public class Player extends MovieClip 
	{
		public var moveSpeed:Number;
		public var playerType:String;
		
		public var movementTimerInterval:Number;
		public var movementTimer:Timer;
		public var playerActionTimer:Timer;
		
		public var isAlive:Boolean;
		public var playerBlock:Boolean;
		public var playerAttack:Boolean = false;
		public var moveModTime:Number;
		public var isMoving:Boolean;
		
		public var playerIcon:MovieClip;
		
		public function Player(tempMoveSpeed:Number, tempPlayerType:String, tempMovementTimerInterval:Number, tempIcon:MovieClip) 
		{
			playerIcon = tempIcon;
			moveSpeed = tempMoveSpeed;
			playerType = tempPlayerType;
			movementTimerInterval = tempMovementTimerInterval;
			
			playerActionTimer = new Timer(100);
			movementTimer = new Timer(100); 
			moveModTime = 2;//Fires the movement timer every 1/10th of a second.
			
			movementTimer.start();
			playerActionTimer.start();
			
			isAlive = true;
			isMoving = false;
			playerIcon.x = 120;
			playerIcon.y = 380;
			playerIcon.stop();
		}
		
		public function Update(keys:Object)
		{
			//When the movement timer has reached a value cleanly divisible by the movementTimer interval,
			//run movement
			
			//if(movementTimer.currentCount % movementTimerInterval == 0)
			//{
				Movement(keys);
				if(moveModTime == 0)
				{
					spriteUpdate();
					
				}
				else
				{
					moveModTime -= 1;
				}
				
			//}
		}
		
		public function Movement(keys:Object)
		{
			for(var currentKeys in keys) //Starts a for loop that will trace the keys being pressed in every frame.
			{
				if (keys[currentKeys])
				{
					
					if(currentKeys == 37 && playerIcon.x - playerIcon.width/2 > 0)
					{
						
						if(movementTimer.currentCount % movementTimerInterval == 0)
						{
						
							playerIcon.x -= moveSpeed;
							isMoving = true;
						//spriteUpdate();
						}
						
					}
						
					else if(currentKeys == 39 && playerIcon.x + playerIcon.width/2 < stage.stageWidth)
					{
						if(movementTimer.currentCount % movementTimerInterval == 0)
						{
							playerIcon.x += moveSpeed;
							isMoving = true;
						//spriteUpdate();
						}
					}
					else
					{
						isMoving = false;
					}
				}
			}
		}
		
		public function Attack(keys:Object)
		{
			for(var currentKeys in keys) //Starts a for loop that will trace the keys being pressed in every frame.
			{
				if (keys[currentKeys])
				{
					if(currentKeys == 32 && !playerAttack && playerActionTimer.currentCount  >= 5)
					{
						playerAttack = true;
						playerIcon.gotoAndPlay(1);
						playerIcon.sheetSam.x = -303;
						playerIcon.sheetSam.y = -160;
						playerIcon.samuraiMask.width = 72;
						playerActionTimer.reset();
					}
				}
			}
		}
		
		public function Block(keys:Object)
		{
			for(var currentKeys in keys) //Starts a for loop that will trace the keys being pressed in every frame.
			{
				if (keys[currentKeys])
				{
					if(currentKeys == 16 && !playerBlock && playerActionTimer.currentCount  >= 5)
					{
						playerBlock = true;
						//playerIcon.gotoAndPlay(7);
						playerIcon.sheetSam.y = -240;
						//playerIcon.sheetSam.x = 0;
						playerIcon.samuraiMask.width = 48;
						playerActionTimer.reset();	
						
					}
				}
			}
		}
		
		//updates spritesheet for additional componenets when moved
		public function spriteUpdate()
		{
			if(isMoving)
			{
				playerIcon.samuraiMask.width = 48;
				if(playerIcon.sheetSam.x <= -202)
				{
					playerIcon.sheetSam.x = -15;
				}
				else
				{
					playerIcon.sheetSam.x -= 48;
				}
			}
			else if(playerAttack)
			{
				playerIcon.sheetSam.y = -160;
				if(playerIcon.sheetSam.x <= -302)
				{
					playerIcon.sheetSam.x = -15;
				}
				else
				{
					playerIcon.sheetSam.x -= 72;
				}
				
				if(playerIcon.sheetSam.x == -15)
				{
					moveModTime = 2;
				}
				else if(playerIcon.sheetSam.x == -303)
				{
					moveModTime = 10;
					playerAttack = false;
				}
				else
				{
					moveModTime = 0;
				}
			}
			else if(playerBlock)
			{
				playerIcon.samuraiMask.width = 48;
				playerIcon.sheetSam.y = -240;
				if(playerIcon.sheetSam.x <= -112)
				{
					
					playerIcon.sheetSam.x = -15;
					//playerIcon.sheetSam.x = -111;
				}
				else if(playerIcon.sheetSam.x == -111)
				{
					playerBlock = false;
				}
				else
				{
					playerIcon.sheetSam.x -= 48;
				}
			}
			else
			{
				
				playerIcon.samuraiMask.width = 48;
				playerIcon.sheetSam.y = -80;
				playerIcon.sheetSam.x = -15;
				
			}
		}
		
	}
}
