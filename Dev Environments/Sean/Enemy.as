package  {
	import flash.display.*;
	
	public class Enemy extends MovieClip
	{
		public var enemyIcon:MovieClip = new MovieClip();
		public var isBlocking:Boolean;
		public var canBlock:Boolean;
		public var isAdvancing:Boolean;
		public var enemyAttack:Boolean;
		public var difficulty:Number;
		public var enemyType:String;
		var speed;
		var actionDelay;
		private var playerBlock:Boolean;
		
		public function Enemy(tempIcon:MovieClip) 
		{
			// constructor code
			difficulty = 5;
			actionDelay = 12;
			enemyIcon = tempIcon;
			enemyIcon.x = 380;
			enemyIcon.y = 370;
			enemyIcon.scaleX *= -1;
			enemyIcon.stop();
			speed = 1;
			isBlocking = false;
			canBlock = true;
			enemyAttack = false;
			isAdvancing = true;
		}
		public function Update(tempPlayer:Player)
		{
			actionDelay -= 1;
			
			if(actionDelay == 0)
			{
				if(isBlocking)
				{
					//isBlocking = false;
					actionDelay = 48;
					//trace("Stopped Blocking");
				}
			
				else if(canBlock != true)
				{
					canBlock = true;
					actionDelay = 12;
					//trace("Can Now Block");
				}
				
			}	
			if(isAdvancing)
			{
				if(Distance(tempPlayer.playerIcon) < 40)
				{
					enemyIcon.x += speed*5;
					isAdvancing = false;
				}
				else if(Distance(tempPlayer.playerIcon) < 150 && tempPlayer.playerAttack != true)
				{
					enemyIcon.x -= speed*5;
				}
				else
				{
					enemyIcon.x -= speed*1;
				}
			}
			else
			{
				if(Distance(tempPlayer.playerIcon) < 100)
				{
					enemyIcon.x += speed*5;
					
				}
				else if(Distance(tempPlayer.playerIcon) > 200)
				{
					enemyIcon.x -= speed*5;
				}
				else
				{
					isAdvancing = true;
				}
				
			}
			if(tempPlayer.playerAttack && canBlock)
			{
				if(Math.random() *5 > 3)
				{
					isBlocking = true;
					canBlock = false;
					actionDelay = 6;
				}
				else
				{
					canBlock = false;
					actionDelay = 6;
					//trace("Failed to block")
				}
				
			}
			EnemySpriteUpdate();
		}
		public function Distance(playerOb:MovieClip):Number
		{
			
			var s = Math.sqrt(((enemyIcon.x-playerOb.x)*(enemyIcon.x-playerOb.x))+((enemyIcon.y-playerOb.y)*(enemyIcon.y-playerOb.y)));//(((enemyIcon.x – playerOb.x) * (enemyIcon.x - playerOb.x )) + ((enemyIcon.y - playerOb.y ) * (enemyIcon.y - playerOb.y )));
			return s;
		}
		public function EnemySpriteUpdate()
		{
			if(enemyType == "Samurai")
			{
				
				if(enemyAttack)
				{
					enemyIcon.sheetSam.y = -160;
					enemyIcon.samuraiMask.width = 72;
					if(enemyIcon.sheetSam.x <= -302)
					{
						enemyIcon.sheetSam.x = -15;
					}
					else
					{
						enemyIcon.sheetSam.x -= 72;
					}
					
					if(enemyIcon.sheetSam.x == -15)
					{
						////moveModTime = 2;
					}
					else if(enemyIcon.sheetSam.x == -303)
					{
						////moveModTime = 10;
						enemyAttack = false;
					}
					else
					{
						//moveModTime = 0;
					}
				}
				else if(isAdvancing)
				{
					enemyIcon.samuraiMask.width = 48;
					enemyIcon.sheetSam.y = -80;
					if(enemyIcon.sheetSam.x <= -202)
					{
						enemyIcon.sheetSam.x = -15;
					}
					else
					{
						enemyIcon.sheetSam.x -= 48;
					}
				}
				else if(playerBlock)
				{
					enemyIcon.samuraiMask.width = 48;
					enemyIcon.sheetSam.y = -240;
					if(enemyIcon.sheetSam.x <= -112)
					{
						
						enemyIcon.sheetSam.x = -15;
						//enemyIcon.sheetSam.x = -111;
					}
					else if(enemyIcon.sheetSam.x == -111)
					{
						//playerBlock = false;
					}
					else
					{
						enemyIcon.sheetSam.x -= 48;
					}
				}
				
				else
				{
					
					enemyIcon.samuraiMask.width = 48;
					enemyIcon.sheetSam.y = -80;
					enemyIcon.sheetSam.x = -15;
					
				}
			}
			else if(enemyType == "Duelist")
			{
				
				if(enemyAttack)
				{
					//enemyIcon.sheetSam.y = -160;
					if(enemyIcon.sheetSam.x < -37.5-(91*4)+1)
					{
						enemyIcon.sheetSam.x = -37.5;
					}
					else
					{
						enemyIcon.sheetSam.x -= 91;
					}
					
					if(enemyIcon.sheetSam.x == -37.5)
					{
						////moveModTime = 2;
					}
					else if(enemyIcon.sheetSam.x == -37.5-(91*4))
					{
						//moveModTime = 10;
						enemyAttack = false;
					}
					else
					{
						////moveModTime = 0;
					}
				}
				else if(isAdvancing)
				{
					enemyIcon.sheetSam.y = -67.5;
					enemyIcon.duelistMask.width = 75;
					if(enemyIcon.sheetSam.x <= -202)
					{
						enemyIcon.sheetSam.x = -37.5;
					}
					else
					{
						enemyIcon.sheetSam.x -= 78;
					}
				}
				else if(playerBlock)
				{
					enemyIcon.duelistMask.width = 90;
					
					
					if(enemyIcon.sheetSam.x < -37.5-(91*2))
					{
						
						enemyIcon.sheetSam.x = -37.5;
						//enemyIcon.sheetSam.x = -111;
					}
					else if(enemyIcon.sheetSam.x == -37.5-(91*2))
					{
						//playerBlock = false;
						trace("Got here");
						//enemyIcon.sheetSam.x = -37.5;
					}
					else
					{
						enemyIcon.sheetSam.x -= 91;
					}
				}
				else
				{
					enemyIcon.duelistMask.width = 75;
					enemyIcon.sheetSam.y = -67.5;
					enemyIcon.sheetSam.x = -37.5;
					//moveModTime = 0;
				}
			}
			if(enemyType == "Knight")
			{
				if(enemyAttack)
				{
					enemyIcon.sheetSam.y = -152;
					//enemyIcon.sheetSam.y = -160;
					enemyIcon.knightMask.width = 310/3.5;
					enemyIcon.knightMask.height = 350/3.5;
					if(enemyIcon.sheetSam.x < -1550/3.5 - 35-85)
					{
						enemyIcon.sheetSam.x = -35;
					}
					else
					{
						enemyIcon.sheetSam.x -= 85;
					}
					
					if(enemyIcon.sheetSam.x == -0-35)
					{
						////moveModTime = 2;
					}
					else if(enemyIcon.sheetSam.x <=-1550/3.5 - 35-85)//-35 -(85*5))
					{
						////moveModTime = 10;
						enemyAttack = false;
						//enemyIcon.knightMask.y += 5;
					}
					else
					{
						////moveModTime = 0;
					}
				}
				else if(isBlocking)
				{
					enemyIcon.sheetSam.y = -255;
					enemyIcon.knightMask.width = 400/3.5;
					enemyIcon.knightMask.height = 250/3.5;
					
					
					if(enemyIcon.sheetSam.x < -119*2-35)
					{
						
						enemyIcon.sheetSam.x = 0-35;
						//enemyIcon.sheetSam.x = -111;
					}
					else if(enemyIcon.sheetSam.x <= -119*2 -35)
					{
						isBlocking = false;
						trace("Got here");
						enemyIcon.sheetSam.x = -37.5;
						enemyIcon.sheetSam.y = -70;
					}
					else
					{
						enemyIcon.sheetSam.x -= 119;
					}
				}
				else
				{
					enemyIcon.sheetSam.y = -62.15;
					enemyIcon.knightMask.width = 250/3.5;
					enemyIcon.knightMask.height = 250/3.5;
					if(enemyIcon.sheetSam.x < -1000/3.5 -34)
					{
						enemyIcon.sheetSam.x = 0-35;
					}
					else
					{
						enemyIcon.sheetSam.x -= 250/3.5;
					}
				}
				
				
				}
				//else
				//{
					//enemyIcon.knightMask.width = 250/3.5;
					//enemyIcon.knightMask.height = 250/3.5;
					//enemyIcon.sheetSam.y = 0 -70;
					//enemyIcon.sheetSam.x = 0 -35;
					////moveModTime = 0;
				//}
			}
		}

	}
	

