package  
{
	import flash.events.*;
	
	public class PlayerEvent extends Event 
	{
		public static const ATTACK:String = "attacking";
		public static const MOVE:String = "movement";
		public static const DEAD:String = "dead";
		
		public function PlayerEvent( type:String )
		{
 			super( type );
		}
	}
}