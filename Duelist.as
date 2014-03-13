package  {
	
	import flash.display.*;
	import flash.events.*;
	
	public class Duelist extends Player 
	{

		public function Duelist() 
		{
			super(3, "Duelist", 3);
			movementTimer.addEventListener(TimerEvent.TIMER, Update);
		}
		
		override public function Update(keys:Object)
		{
			if(movementTimer.currentCount % movementTimerInterval == 0)
			{
				Movement(keys);
			}
			
			trace(movementTimer.currentCount);
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
