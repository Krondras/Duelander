package  {
	
	import flash.display.*;
	import flash.events.*;
	
	public class Samurai extends Player 
	{

		public function Samurai() 
		{
			super(10, "Samurai", 10, new SamuraiIcon()); //Sets the move speed, the character type, and the movement interval of the character.
			movementTimer.addEventListener(TimerEvent.TIMER, Update);
		}
	}
}
