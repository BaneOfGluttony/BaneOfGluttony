package  {
	
	public class Player {
		public static var name:String = "Player Name";
		public static var isAlive:Boolean = true;
		public static var x:int = 4;
		public static var y:int = 4;
		public static var maxExp:int = 50;
		public static var currExp:int = 0;
		public static var level:int = 1;
		public static var statPoints:int = 0;
		public static var fat:Number = 15;
		public static var gold:Number = 25;
		public static var height:int = 70;
		public static var quests:Array = [];
		public static var eventRecord:Object = {};
		public static var inventory:Array = [];
		public static var equipment:Object = {head : null, torso : null, legs: null, feet : null, weapon : null, shield : null};
		public static var resources:Object = {
			maxHealth : 100, currHealth : 100, maxMana : 100, currMana : 100, 
			maxEnergy : 100, currEnergy : 100, maxCapacity : 100, currCapacity : 50};
		public static var stats:Object = {str : 5, agi : 5, vit : 5, "int" : 5, dex : 5, vor : 5};
		public static var derivedStats:Object = {atk : 0, matk : 0, def : 0, mdef : 0, acc : 0, dodge : 0, cap : 0, weight: 0};
		
		public function Player() {
			
		}
		
		public static function getItemFromInventory(item:Item):Item {
			return inventory[indexOfInventory(item)];
		}
		
		public static function getItemFromEquipment(itemName:String):Item {
			for each (var equip:Item in equipment) {
				if (equip != null && itemName == equip.name)
					return equip;
			}
			
			return null;
		}
		
		public static function indexOfInventory(item:Item):int {
			for (var i:int = 0; i < inventory.length; i++) {
				if (inventory[i].name == item.name)
					return i;
			}
			
			return -1;
		}
		
		public static function getStat(stat:String):int {
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
		
		public static function levelUp():int {
			var overflow:int = currExp - maxExp;
			level++;
			maxExp *= 1.2;
			currExp = 0;
			statPoints += 5;
			
			return overflow;
		}
	}
}
