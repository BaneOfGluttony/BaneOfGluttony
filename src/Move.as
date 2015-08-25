package  {
	
	public class Move {
		public var name:String = "Move";
		public var desc:String = "Description";
		public var battleDesc:String = "Battle description";
		public var dmg:int = 0;
		public var effect:Status = new Status({});

		public function Move(properties:Object) {
			for (var name:String in properties) {
				if (this.hasOwnProperty(name)) {
					this[name] = properties[name];
				}
			}
		}
		
		public function execute(player:Player):void {
			
		}
	}
}
