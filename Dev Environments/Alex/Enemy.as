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
		var speed;
		var actionDelay;
		
		public function Enemy(tempIcon:MovieClip) 
		{
			// constructor code
			difficulty = 5;
			actionDelay = 12;
			enemyIcon = tempIcon;
			enemyIcon.x = 380;
			enemyIcon.y = 380;
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
					isBlocking = false;
					actionDelay = 48;
					trace("Stopped Blocking");
				}
			
				else if(canBlock != true)
				{
					canBlock = true;
					actionDelay = 12;
					trace("Can Now Block");
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
					trace("Failed to block")
				}
				
			}
		}
		public function Distance(playerOb:MovieClip):Number
		{
			
			var s = Math.sqrt(((enemyIcon.x-playerOb.x)*(enemyIcon.x-playerOb.x))+((enemyIcon.y-playerOb.y)*(enemyIcon.y-playerOb.y)));//(((enemyIcon.x – playerOb.x) * (enemyIcon.x - playerOb.x )) + ((enemyIcon.y - playerOb.y ) * (enemyIcon.y - playerOb.y )));
			return s;
		}

	}
	
}
