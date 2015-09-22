package  {
	
	public class EnemyDefinitions {
		public static var definitions:Object = {
			"Slime"				: new Enemy( {	name		: "Slime",
												startText	: "This is a test enemy.",
												endText		: "You have defeated the slime.",
												//surrText	: "You lower your guard and give the slime a look of defeat. Submitting, you allow it to ooze toward you and slowly envelop your form all the way from your feet to your head. With your entire body encased in the slime's mysterious goo, you simply allow the creature to seep through your lips before suddenly realizing it's suffocating you. As you try to gasp for air, a sudden influx of the slime's fruity juices rush into your body and down your throat like a whirlpool. Every labored, oxygen-starved gulp you take makes your throat bulge visibly with the substance before flushing into your stomach, causing it to steadily swell bigger and bigger before your eyes. Before you know it though, you find yourself panting for breath with the slime nowhere to be found, the only evidence of its existence now sloshing and residing in your quivering gut.",
												atkText		: "The slime springs into the air, landing on you with a jiggly thud before reeling back to prepare its next strike.",
												loot		: [ItemDefinitions.getItem("Red Potion")],
												skills		: [SkillDefinitions.definitions["Slime Surrender"], SkillDefinitions.definitions["Slime Feed"]],
												surrType	: 1,
												maxHP		: 30,
												atk			: 25,
												def			: 2,
												agi			: 5,
												dex			: 3,
												exp			: 10,
												gold		: 5})
		};
	}
}
