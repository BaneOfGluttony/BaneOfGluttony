package  {
	
	public class Enemy {
		public var name:String = "Enemy";
		public var desc:String = "Description"
		public var maxHP:int = 100;
		public var currHP:int = maxHP;
		public var moves:Array = new Array();

		public function Enemy(properties:Object) {
			for (var name:String in properties) {
				if (this.hasOwnProperty(name)) {
					this[name] = properties[name];
				}
			}
		}
		
		public function act(player:Player):void {
			var move:Move = moves[Math.random() * moves.length];
			
		}
	}
}
