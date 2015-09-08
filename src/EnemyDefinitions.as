package  {
	
	public class EnemyDefinitions {
		public static var definitions:Object = {
			"Slime"				: new Enemy( {	name	: "Slime",
												desc	: "This is a test enemy.",
												atkText	: "The slime springs into the air, landing on you with a jiggly thud.",
												loot	: [ItemDefinitions.getItem("Red Potion")],
												maxHP	: 30,
												atk		: 500,
												def		: 2,
												agi		: 1,
												exp		: 10,
												gold	: 5})
		};
	}
}
