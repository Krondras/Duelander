package  {
	
	import flash.display.*;
	import flash.events.*;
	
	public class Duelist extends Player 
	{

		public function Duelist() 
		{
			super(3, "Duelist", 3, new DuelistIcon());
			movementTimer.addEventListener(TimerEvent.TIMER, Update);
		}
		
	}
}
