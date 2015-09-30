package  {
	
	public class EnemyDefinitions {
		public static const definitions:Object = {
			"Slime"				: {	name		: "Slime",
									startText	: "A translucent sludge-like substance oozes out of the ground before you. As it begins to take shape as an amorphous blob, it steadily grows bigger and bigger before stopping just above your waist. A guttural hiss sounds from within the creature, spewing out bits and pieces of itself as it engages you.",
									endText		: "The sticky remains of the slime collect in small puddles on the ground.",
									//surrText	: "You lower your guard and give the slime a look of defeat. Submitting, you allow it to ooze toward you and slowly envelop your form all the way from your feet to your head. With your entire body encased in the slime's mysterious goo, you simply allow the creature to seep through your lips before suddenly realizing it's suffocating you. As you try to gasp for air, a sudden influx of the slime's fruity juices rush into your body and down your throat like a whirlpool. Every labored, oxygen-starved gulp you take makes your throat bulge visibly with the substance before flushing into your stomach, causing it to steadily swell bigger and bigger before your eyes. Before you know it though, you find yourself panting for breath with the slime nowhere to be found, the only evidence of its existence now sloshing and residing in your quivering gut.",
									atkText		: "The slime springs into the air, landing on you with a jiggly thud before reeling back to prepare its next strike.",
									loot		: [ItemDefinitions.getItem("Red Potion")],
									skills		: [SkillDefinitions.getSkill("Slime Surrender"), SkillDefinitions.getSkill("Slime Feed")],
									surrType	: 1,
									maxHP		: 30,
									atk			: 10,
									def			: 2,
									agi			: 5,
									dex			: 3,
									exp			: 10,
									gold		: 5 },
			"Boar"				: {	name		: "Boar",
									startText	: "You hear a snorting about as you traverse the verdant luxury of the central farms. As you near the interesting sound, you find yourself confronted by its source, a giant boar!",
									endText		: "The boar sways from side to side, before falling on its fattened side.",
									atkText		: "With a menacing glare, the boar digs a hoof into the ground and charges at you with a speed that belies its size, its massive underbelly undulating with each earth-shaking step the boar takes.",
									loot		: [ItemDefinitions.getItem("Pork Haunch")],
									maxHP		: 50,
									atk			: 15,
									def			: 5,
									agi			: 7,
									dex			: 3,
									exp			: 20,
									gold		: 8	}
		};
		
		public static function getEnemy(name:String):Enemy {
			return new Enemy(definitions[name]);
		}
	}
}
