package  
{
	import flash.events.Event;
	public class NavigationEvent extends Event 
	{
 		public static const START:String = "start";
		public static const CHARSELECT:String = "character select";
		public static const RESTART:String = "restart";
		public static const CLOSEGAME:String = "close game";
		public static const TOMENU:String = "to menu";
		
		public function NavigationEvent( type:String )
		{
			super( type );
		}
	}
}