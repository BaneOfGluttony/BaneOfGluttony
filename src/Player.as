package  {
	
	public class Player {
		public var name:String = "Player Name";
		public var isAlive:Boolean = true;
		public var x:int = 4;
		public var y:int = 4;
		public var maxExp:int = 50;
		public var currExp:int = 0;
		public var level:int = 1;
		public var fat:Number = 0;
		public var gold:Number = 50;
		public var height:int = 70;
		public var quests:Array = [];
		public var inventory:Array = [];
		public var equipment:Object = {head : null, torso : null, legs: null, feet : null, weapon : null, shield : null};
		public var resources:Object = {
			maxHealth : 100, currHealth : 0, maxMana : 100, currMana : 0, 
			maxEnergy : 100, currEnergy : 0, maxCapacity : 100, currCapacity : 0};
		public var stats:Object = {str : 5, agi : 5, vit : 5, "int" : 5, dex : 5, vor : 5};
		public var derivedStats:Object = {atk : 0, matk : 0, def : 0, mdef : 0, acc : 0, dodge : 0, cap : 0, weight: 0};
		
		public function Player() {
			
		}
		
		public function getItemFromInventory(item:Item):Item {
			return inventory[indexOfInventory(item)];
		}
		
		public function indexOfInventory(item:Item):int {
			for (var i:int = 0; i < inventory.length; i++) {
				if (inventory[i].name == item.name)
					return i;
			}
			
			return -1;
		}
		
		public function getStat(stat:String):int {
			switch (stat) {
				case "currHealth" :
				case "maxHealth" :
				case "currMana" :
				case "maxMana" :
				case "currEnergy" :
				case "maxEnergy" :
				case "currCapacity" :
				case "maxCapacity" :
					return resources[stat];
				
				case "str" :
				case "agi" :
				case "vit" :
				case "int" :
				case "dex" :
				case "vor" :
					return stats[stat];
				
				case "atk" :
				case "matk" :
				case "def" :
				case "mdef" :
				case "acc" :
				case "dodge" :
				case "cap" :
				case "weight" :
					return derivedStats[stat];
				
				default :
					trace("WARNING: Player.getStat(" + stat + ") is not valid!");
					return -1;
			}
		}
		
		public function levelUp():int {
			var overflow:int = currExp - maxExp;
			level++;
			maxExp *= 1.2;
			currExp = 0;
			
			return overflow;
		}
	}
}
