package  {
	import flash.display.*;
	
	
	public class AlexPlayer extends MovieClip{
		
		public var playIcon:MovieClip = new MovieClip();
		public var isBlocking:Boolean;
		public function AlexPlayer(tempIcon:MovieClip) {
			// constructor code
			playIcon = tempIcon;
			playIcon.x = 0;
			playIcon.y = 300;
			playIcon.stop();
			isBlocking = false;
		}

	}
	
}
