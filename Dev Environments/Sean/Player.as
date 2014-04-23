package  
{
	
	//To-do: find a different way to reset the timer.
	
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
		public var actionTimerReset:Boolean = false;
		
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
			playerIcon.y = 370;
			playerIcon.stop();
		}
		
		public function Update(keys:Object)
		{
			//When the movement timer has reached a value cleanly divisible by the movementTimer interval,
			//run movement
			//if(movementTimer.currentCount % movementTimerInterval == 0)
			//{
				Movement(keys);
				if(moveModTime <= 0)
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
					
					if(currentKeys == 37 && playerIcon.x > 0)
					{
						playerIcon.x -= moveSpeed;
						isMoving = true;
					}
						
					else if(currentKeys == 39 && playerIcon.x < stage.stageWidth)
					{
						playerIcon.x += moveSpeed;
						isMoving = true;
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
						if(playerType == "Samurai")
						{
							playerIcon.sheetSam.x = -303;
							playerIcon.sheetSam.y = -160;
							playerIcon.samuraiMask.width = 72;
						}
						else if(playerType == "Duelist")
						{
							playerIcon.sheetSam.x = -37.5-91*4;
							playerIcon.sheetSam.y = -144.8;
							playerIcon.duelistMask.width = 90;
						}
						else if(playerType == "Knight")
						{
							playerIcon.sheetSam.x = -35;
							playerIcon.sheetSam.y = -152;
							playerIcon.knightMask.y -= 5;
							playerIcon.sheetSam.y -= 5;
						}
						else
						{
							trace("WHAT THE HECK");
						}
						
						/*if(actionTimerReset == false)
						{
							trace(actionTimerReset);
							playerActionTimer.reset();
							actionTimerReset = true;
						}*/
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
						if(playerType == "Duelist")
						{
							playerIcon.sheetSam.x = -37.5;
							playerIcon.sheetSam.y = -222.2;
						}
						else if(playerType == "Samurai")
						{
							playerIcon.sheetSam.y = -240;
							playerIcon.sheetSam.x = -15;
						}
						else if(playerType == "Knight")
						{
							playerIcon.sheetSam.y = -255;
							playerIcon.sheetSam.x = -35;
						}
						//playerIcon.sheetSam.x = 0;
						//playerIcon.samuraiMask.width = 48;
						//playerActionTimer.reset();	
						
					}
				}
			}
		}
		
		//updates spritesheet for additional componenets when moved
		public function spriteUpdate()
		{
			if(playerType == "Samurai")
			{
				
				if(playerAttack)
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
				else if(isMoving)
				{
					playerIcon.samuraiMask.width = 48;
					playerIcon.sheetSam.y = -80;
					if(playerIcon.sheetSam.x <= -202)
					{
						playerIcon.sheetSam.x = -15;
					}
					else
					{
						playerIcon.sheetSam.x -= 48;
					}
				}
				else if(playerBlock)
				{
					playerIcon.samuraiMask.width = 48;
					
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
			else if(playerType == "Duelist")
			{
				
				if(playerAttack)
				{
					//playerIcon.sheetSam.y = -160;
					if(playerIcon.sheetSam.x < -37.5-(91*4)+1)
					{
						playerIcon.sheetSam.x = -37.5;
					}
					else
					{
						playerIcon.sheetSam.x -= 91;
					}
					
					if(playerIcon.sheetSam.x == -37.5)
					{
						moveModTime = 2;
					}
					else if(playerIcon.sheetSam.x == -37.5-(91*4))
					{
						moveModTime = 10;
						playerAttack = false;
					}
					else
					{
						moveModTime = 0;

					}
				}
				else if(isMoving)
				{
					playerIcon.sheetSam.y = -67.5;
					playerIcon.duelistMask.width = 75;
					if(playerIcon.sheetSam.x <= -202)
					{
						playerIcon.sheetSam.x = -37.5;
					}
					else
					{
						playerIcon.sheetSam.x -= 78;
					}
				}
				else if(playerBlock)
				{
					playerIcon.duelistMask.width = 90;
					
					
					if(playerIcon.sheetSam.x < -37.5-(91*2))
					{
						
						playerIcon.sheetSam.x = -37.5;
						//playerIcon.sheetSam.x = -111;
					}
					else if(playerIcon.sheetSam.x == -37.5-(91*2))
					{
						playerBlock = false;
						trace("Got here");
						//playerIcon.sheetSam.x = -37.5;
					}
					else
					{
						playerIcon.sheetSam.x -= 91;
					}
				}
				else
				{
					playerIcon.duelistMask.width = 75;
					playerIcon.sheetSam.y = -67.5;
					playerIcon.sheetSam.x = -37.5;
					moveModTime = 0;
				}
			}
			else if(playerType == "Knight")
			{
				
				if(playerAttack)
				{
					
					//playerIcon.sheetSam.y = -160;
					playerIcon.knightMask.width = 310/3.5;
					playerIcon.knightMask.height = 350/3.5;
					if(playerIcon.sheetSam.x < -1550/3.5 - 35)
					{
						playerIcon.sheetSam.x = -35;
					}
					else
					{
						playerIcon.sheetSam.x -= 85;
					}
					
					if(playerIcon.sheetSam.x == -0-35)
					{
						moveModTime = 2;
					}
					else if(playerIcon.sheetSam.x == -35 -(85*5))
					{
						moveModTime = 10;
						playerAttack = false;
						playerIcon.knightMask.y += 5;
					}
					else
					{
						moveModTime = 0;
					}
				}
				else if(isMoving)
				{
					playerIcon.knightMask.width = 250/3.5;
					playerIcon.knightMask.height = 250/3.5;
					playerIcon.sheetSam.y = -70;
					if(playerIcon.sheetSam.x < -1000/3.5 -34)
					{
						playerIcon.sheetSam.x = 0-35;
					}
					else
					{
						playerIcon.sheetSam.x -= 250/3.5;
					}
				}
				else if(playerBlock)
				{
					playerIcon.knightMask.width = 400/3.5;
					playerIcon.knightMask.height = 250/3.5;
					
					
					if(playerIcon.sheetSam.x < -119*2-35)
					{
						
						playerIcon.sheetSam.x = 0-35;
						//playerIcon.sheetSam.x = -111;
					}
					else if(playerIcon.sheetSam.x <= -119*2 -35)
					{
						playerBlock = false;
						trace("Got here");
						playerIcon.sheetSam.x = -37.5;
						playerIcon.sheetSam.y = -70;
					}
					else
					{
						playerIcon.sheetSam.x -= 119;
					}
				}
				else
				{
					playerIcon.knightMask.width = 250/3.5;
					playerIcon.knightMask.height = 250/3.5;
					playerIcon.sheetSam.y = 0 -70;
					playerIcon.sheetSam.x = 0 -35;
					moveModTime = 0;
				}
			}
			else
			{
				trace("WHAT THE BLEEDING NONSENSE. YOU DON'T HAVE A PLAYER TYPE");
			}
			
		}
		
	}
}
