package  {
	
	public class SkillDefinitions {
		public static var main:Main;
		
		/**
		 * Short for "get stat" - gets the given player stat, resource, etc.
		 */
		public static function getStat(stat:String):int {
			if (main == null || main.player == null) {
				trace("WARNING: Main or Player not found when trying to call ItemDefinitions.gs()!");
				return -1;
			}
			return main.player.getStat(stat);
		}
		
		public static const definitions:Object = {
			"Slime Feed"		: new Skill({	name		: "Slime Feed",
												useText		: "The slime lurches for your face, prying your muzzle open and forcing itself in your mouth. It tastes of an oddly fruity flavor, but you can't quite put your tongue on what it is. While you're distracted figuring out what it is, the amorphous blob pumps a portion of itself down your throat before dropping to the ground and reeling back. You feel the glob of slime land heavily in the pit of your stomach with a loud, wobbling gurgle.",
												effects		: [function():Array { return ["currCapacity", Math.round(EnemyDefinitions.definitions["Slime"].atk * EnemyDefinitions.definitions["Slime"].maxHP * 0.1) as int] }] }
		)};
	}
}
