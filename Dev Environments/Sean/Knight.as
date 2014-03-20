package  {
	
	import flash.display.*;
	import flash.events.*;
	
	public class Knight extends Player 
	{

		public function Knight() 
		{
			super(5, "Knight", 10, new KnightIcon()); //Sets the move speed, the character type, and the movement interval of the character.
			movementTimer.addEventListener(TimerEvent.TIMER, Update);
		}
		
	}
}
