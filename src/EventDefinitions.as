package  {
	
	public class EventDefinitions {
		public static var main:Main;
		
		public static const definitions:Object = {
			"Blade and Belly"						: new GameEvent(main, main.player, "BladeAndBelly")
		};
		
		public static function startEvent(name:String):void {
			definitions[name].setDialog(0);
		}
	}
}