package  {
	
	public class EnemyDefinitions {
		public static var definitions:Object = {
			"Slime"				: new Enemy( {	name		: "Slime",
												startText	: "This is a test enemy.",
												endText		: "You have defeated the slime.",
												atkText		: "The slime springs into the air, landing on you with a jiggly thud before reeling back to prepare its next strike.",
												loot		: [ItemDefinitions.getItem("Red Potion")],
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
