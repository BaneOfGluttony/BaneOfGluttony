﻿package  {
	
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
			"Slime Surrender"	: {	name			: "Slime Surrender",
									useText			: "You lower your guard and give the slime a look of defeat. Submitting, you allow it to ooze toward you and slowly envelop your form all the way from your feet to your head. With your entire body encased in the slime's mysterious goo, you simply allow the creature to seep through your lips before suddenly realizing it's suffocating you. As you try to gasp for air, a sudden influx of the slime's fruity juices rush into your body and down your throat like a whirlpool. Every labored, oxygen-starved gulp you take makes your throat bulge visibly with the substance before flushing into your stomach, causing it to steadily swell bigger and bigger before your eyes. Before you know it though, you find yourself panting for breath with the slime nowhere to be found, the only evidence of its existence now sloshing and residing in your quivering gut.",
									sourceEffects	: [function():Array { return ["currHP", -9999] }],
									targetEffects	: [function():Array { return ["currCapacity", Math.round(100 * (EnemyDefinitions.getEnemy("Slime").currHP / EnemyDefinitions.getEnemy("Slime").maxHP))] }] },
			"Slime Feed"		: {	name			: "Slime Feed",
									useText			: "The slime lurches for your face, prying your muzzle open and forcing itself in your mouth. It tastes of an oddly fruity flavor, but you can't quite put your tongue on what it is. While you're distracted figuring out what it is, the amorphous blob pumps a portion of itself down your throat before dropping to the ground and reeling back. You feel the glob of slime land heavily in the pit of your stomach with a loud, wobbling gurgle.",
									sourceEffects	: [function():Array { return ["currHP", Math.round(-0.5 * (EnemyDefinitions.getEnemy("Slime").atk * 0.5 * EnemyDefinitions.getEnemy("Slime").maxHP * 0.2 - Math.max(0, getStat("str") + getStat("def")))) as int] }],
									targetEffects	: [function():Array { return ["currCapacity", Math.round(EnemyDefinitions.getEnemy("Slime").atk * 0.5 * EnemyDefinitions.getEnemy("Slime").maxHP * 0.2 - Math.max(0, getStat("str") + getStat("def"))) as int] }] }
		};
		
		public static function getSkill(name:String):Skill {
			return new Skill(definitions[name]);
		}
	}
}
