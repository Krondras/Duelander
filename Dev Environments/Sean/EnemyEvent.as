package  
{
	import flash.events.*;
	
	public class EnemyEvent extends Event 
	{
		public static const ENEMYATTACK:String = "enemy attacking";
		public static const ENEMYMOVE:String = "enemy movement";
		public static const ENEMYDEAD:String = "enemy dead";
		
		public function EnemyEvent( type:String )
		{
 			super( type );
		}
	}
}