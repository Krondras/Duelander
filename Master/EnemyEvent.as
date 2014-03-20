package  
{
	import flash.events.*;
	
	public class EnemyEvent extends Event 
	{
		public static const ATTACK:String = "attacking";
		public static const MOVE:String = "movement";
		public static const DEAD:String = "dead";
		
		public function EnemyEvent( type:String )
		{
 			super( type );
		}
	}
}