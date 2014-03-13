package  {
	
	import flash.display.*;
	import flash.events.*;
	
	public class Samurai extends Player 
	{

		public function Samurai() 
		{
			super(10, "Samurai", 10); //Sets the move speed, the character type, and the movement interval of the character.
			movementTimer.addEventListener(TimerEvent.TIMER, Update);
		}
		
		override public function Update(keys:Object)
		{
			//When the movement timer has reached a value cleanly divisible by the movementTimer interval,
			//run movement
			if(movementTimer.currentCount % movementTimerInterval == 0)
			{
				Movement(keys);
			}
			
			trace(movementTimer.currentCount % movementTimerInterval);
		}
		
		override public function Movement(keys:Object)
		{
			for(var currentKeys in keys) //Starts a for loop that will trace the keys being pressed in every frame.
			{
				if (keys[currentKeys])
				{
					if(currentKeys == 37 && this.x - this.width/2 > 0)
					{
						this.x -= moveSpeed;
					}
						
					if(currentKeys == 39 && this.x + this.width/2 < stage.stageWidth)
						this.x += moveSpeed;
				}
			}
		}
	}
}
