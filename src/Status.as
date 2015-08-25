package  {
	
	public class Status {
		public var name:String = "Status effect";
		public var desc:String = "Description";
		public var health:int = 0;
		public var mana:int = 0;
		public var energy:int = 0;
		public var capacity:int = 0;
		public var str:int = 0;
		public var agi:int = 0;
		public var vit:int = 0;
		public var itn:int = 0;
		public var dex:int = 0;
		public var fat:int = 0;

		public function Status(properties:Object) {
			for (var name:String in properties) {
				if (this.hasOwnProperty(name)) {
					this[name] = properties[name];
				}
			}
		}
		
		public function effect():void {
			//Game.addResource("Health", health);
		}
	}
}
