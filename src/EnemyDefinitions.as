package  {
	
	public class EnemyDefinitions {
		public static var definitions:Object = {
			"Slime" : new Enemy({name : "Slime", maxHP : 30, moves : [MoveDefinitions.definition["Basic Attack"]]})
		};
	}
}
