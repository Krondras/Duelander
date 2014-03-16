package  {
	import flash.display.*;
	
	public class Enemy extends MovieClip
	{
		public var enemyIcon:MovieClip = new MovieClip();
		public var isBlocking:Boolean;
		public var enemyAttack:Boolean;
		
		public function Enemy(tempIcon:MovieClip) 
		{
			// constructor code
			enemyIcon = tempIcon;
			enemyIcon.x = 380;
			enemyIcon.y = 380;
			enemyIcon.scaleX *= -1;
			enemyIcon.stop();
			isBlocking = false;
			enemyAttack = false;
		}

	}
	
}
