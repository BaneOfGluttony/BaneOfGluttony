package  {
	
	public class Enemy {
		public var name:String = "Enemy";
		public var startText:String = "Start";
		public var endText:String = "End";
		public var atkText:String = "get fuked m8";
		public var maxHP:int = 100;
		public var currHP:int = 100;
		public var atk:int = 0;
		public var def:int = 0;
		public var agi:int = 0;
		public var exp:int = 0;
		public var gold:int = 0;
		public var loot:Array = new Array();
		public var moves:Array = new Array();

		public function Enemy(properties:Object) {
			for (var name:String in properties) {
				if (this.hasOwnProperty(name)) {
					this[name] = properties[name];
				}
			}
			
			currHP = maxHP;
		}
	}
}
