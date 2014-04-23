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
		public static const NEXTSTAGE:String = "next stage";
		public static const CONTINUE:String = "continue";
		public static const TOSUBMIT:String = "to score submit screen";
		public static const SUBMITTED:String = "score submitted";
		
		public function NavigationEvent( type:String )
		{
			super( type );
		}
	}
}