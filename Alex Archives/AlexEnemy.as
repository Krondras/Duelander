package  {
	import flash.display.*;
	public class AlexEnemy extends MovieClip{
		public var playIcon:MovieClip = new MovieClip();
		public var isBlocking:Boolean;
		public var enemAttack:Boolean;
		
		public function AlexEnemy(tempIcon:MovieClip) {
			// constructor code
			playIcon = tempIcon;
			playIcon.x = 130;
			playIcon.y = 300;
			playIcon.stop();
			isBlocking = false;
			enemAttack = false;
		}

	}
	
}
