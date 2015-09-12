package  {
	
	public class Skill {
		public var name:String = "Skill";
		public var desc:String = "Description";
		public var atkText:String = "Battle description";
		public var dmg:int = 0;
		public var effect:Effect = new Effect();

		public function Skill(properties:Object) {
			for (var name:String in properties) {
				if (this.hasOwnProperty(name)) {
					this[name] = properties[name];
				}
			}
		}
		
		public function useOnPlayer(player:Player):void {
			
		}
		
		public function useOnEnemy(enemy:Enemy):void {
			
		}
		
		public function useOutOfCombat(player:Player):void {
			
		}
	}
}
