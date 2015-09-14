package  {
	import flash.geom.Point;
	
	public class Item {
		public var name:String = "Item";
		public var short:String = "Short description";
		public var long:String = "Long description";
		public var wpnText:String = "Weapon text";
		public var canDrop:Boolean = true;
		public var equip:Boolean = false;
		public var count:int = 0;
		public var value:int = 0;
		
		public var twoHanded:Boolean = false;
		public var head:Boolean = false;
		public var torso:Boolean = false;
		public var legs:Boolean = false;
		public var feet:Boolean = false;
		public var shield:Boolean = false;
		public var weapon:Boolean = false;
		
		//public var effect:Effect = new Effect();
		public var effects:Array;						// array of functions that determine added stats
		public var addedStats:Array = [];				// keep track of added derived stats (and use when unproccing)
		public var effectsText:String = "";
		
		/*public var health:int = 0;					// old effect vars
		public var mana:int = 0;
		public var energy:int = 0;
		public var capacity:int = 0;
		
		public var atk:int = 0;
		public var matk:int = 0;
		public var def:int = 0;
		public var mdef:int = 0;
		public var acc:int = 0;
		public var dodge:int = 0;
		public var fat:int = 0;
		public var cap:int = 0;
		
		public var strFlat:int = 0;
		public var agiFlat:int = 0;
		public var vitFlat:int = 0;
		public var intFlat:int = 0;
		public var dexFlat:int = 0;
		public var vorFlat:int = 0;
		
		public var strScale:Number = 0;
		public var agiScale:Number = 0;
		public var vitScale:Number = 0;
		public var dexScale:Number = 0;
		public var intScale:Number = 0;
		public var vorScale:Number = 0;*/
		
		//public var effect:Status = new Status({});
		
		public function Item(properties:Object) {			
			for (var name:String in properties) {
				if (this.hasOwnProperty(name)) {
					this[name] = properties[name];
				}
			}
		}
		
		public function procEffects(main:Main, player:Player):void {				
			/*main.addResource("Health", effect.health, 0);
			main.addResource("Mana", effect.mana, 0);
			main.addResource("Energy", effect.energy, 0);
			main.addResource("Capacity", effect.capacity, 0);
			main.addFat(0.05 * effect.capacity);
			
			main.addStat("str", effect.strFlat);
			main.addStat("agi", effect.agiFlat);
			main.addStat("vit", effect.vitFlat);
			main.addStat("int", effect.intFlat);
			main.addStat("dex", effect.dexFlat);
			main.addStat("vor", effect.vorFlat);
			
			main.addStat("str", Math.round(player.stats["str"] * effect.strScale));
			main.addStat("agi", Math.round(player.stats["agi"] * effect.agiScale));
			main.addStat("vit", Math.round(player.stats["vit"] * effect.vitScale));
			main.addStat("int", Math.round(player.stats["int"] * effect.intScale));
			main.addStat("dex", Math.round(player.stats["dex"] * effect.dexScale));
			main.addStat("vor", Math.round(player.stats["vor"] * effect.vorScale));*/
			
			// proc special effects
			if (effects != null && effects.length > 0) {
				addedStats = [];
				//trace("[Item] " + name + " has special effects!");
				for each (var f:Function in effects) {
					var special:Array = f();		// special will be ["nameOfStat", statValueAsInteger]
					//trace("[Item] " + name + " procs special effect for " + special[0] + " with value " + special[1]);
					changeStat(main, special[0], special[1]);
					if (addedStats.length < effects.length)
						addedStats.push([special[0], special[1]]);
				}
				//trace("[Item] " + name + " finished adding special effects.");
			}
		}
		
		public function deprocEffects(main:Main):void {
			if (addedStats.length == 0)
				return;
			//trace("[Item] " + name + " is deproccing.");
			//for (var i:int = 0; i < addedStats.length; i++ ) {
			for each (var special:Array in addedStats) {
				changeStat(main, special[0], -special[1]);
				addedStats.pop();
				//trace("[Item] " + name + " undoes special effect for " + addedStats[i][0] + " with value " + addedStats[i][1]);
			}
			//trace("[Item] " + name + " finished deproccing.");
		}
		
		private function changeStat(main:Main, stat:String, amount:int):void {
			switch (stat) {
				case "currHealth" :
					main.addResource("Health", amount, 0);
					break;
				case "maxHealth" :
					main.addResource("Health", 0, amount);
					break;
				case "currMana" :
					main.addResource("Mana", amount, 0);
					break;
				case "maxMana" :
					main.addResource("Mana", 0, amount);
					break;
				case "currEnergy" :
					main.addResource("Energy", amount, 0);
					break;
				case "maxEnergy" :
					main.addResource("Energy", 0, amount);
					break;
				case "currCapacity" :
					main.addResource("Capacity", amount, 0);
					break;
				case "maxCapacity" :
					main.addResource("Capacity", 0, amount);
					break;
				
				case "str" :
				case "agi" :
				case "vit" :
				case "dex" :
				case "int" :
				case "vor" :
					main.addStat(stat, amount);
					break;
					
				case "atk" :
				case "matk" :
				case "def" :
				case "mdef" :
				case "acc" :
				case "dodge" :
				case "cap" :
					main.player.derivedStats[stat] += amount;
					break;
				
				case "fat" :
					main.addFat(amount);
					break;
				
				default :
					trace("[Item] " + name + " WARNING: " + stat + " not found.");
					break;
			}
		}
		
		public function writeEffects(main:Main, player:Player):void {
			effectsText = "";
			
			if (effects != null && effects.length > 0) {
				for each (var f:Function in effects) {
					var special:Array = f();
					
					switch (special[0]) {
						case "currHealth" :
							effectsText += "HP+" + special[1] + ", ";
							break;
						case "maxHealth" :
							effectsText += "Max HP+" + special[1] + ", ";
							break;
						case "currMana" :
							effectsText += "MP+" + special[1] + ", ";
							break;
						case "maxMana" :
							effectsText += "Max MP+" + special[1] + ", ";
							break;
						case "currEnergy" :
							effectsText += "EN+" + special[1] + ", ";
							break;
						case "maxEnergy" :
							effectsText += "Max EN+" + special[1] + ", ";
							break;
						case "currCapacity" :
							effectsText += "CAP+" + special[1] + ", ";
							break;
						case "maxCapacity" :
							effectsText += "Max CAP+" + special[1] + ", ";
							break;
						
						case "str" :
						case "agi" :
						case "vit" :
						case "dex" :
						case "int" :
						case "vor" :
						case "atk" :
						case "matk" :
						case "def" :
						case "mdef" :
						case "acc" :
						case "dodge" :
						case "cap" :
						case "fat" :
							effectsText += special[0].toUpperCase() + " + " + special[1] + ", ";
							break;
						
						default :
							trace("[Item] " + name + " WARNING: " + special[0] + " not found.");
							break;
					}
				}
			}
			effectsText = effectsText.slice(0, effectsText.length - 2);
		}
		
		public function toString(state:String):String {
			switch (state) {
				case "appearance" :
					if (effectsText != "")
						return name + "\n" + effectsText + "\n" + short;
					else
						return name + "\n" + short;
				case "appearanceSelected" :
					if (effectsText != "")
						return name + "\n" + effectsText + "\n\n" + short + " " + long;
					else
						return name + "\n" + short + " " + long;
				case "inventory" :
				case "selling" :
					if (effectsText != "")
						return name + " -- x" + count + "\n" + effectsText + "\n" + short;
					else
						return name + " -- x" + count + "\n" + short;
				case "inventorySelected" :
				case "sellingSelected" :
					if (effectsText != "")
						return name + " -- x" + count + "\n\n" + effectsText + "\n" + short + " " + long;
					else
						return name + " -- x" + count + "\n\n" + short + " " + long;
				case "buying" :
					if (effectsText != "")
						return " in inventory\n" + effectsText + "\n" + short + "\n\n";
					else
						return " in inventory\n" + short + "\n\n";
				case "buyingSelected" :
					if (effectsText != "")
						return name + " -- " + value + " gold ea.\n\n" + effectsText + "\n" + short;
					else
						return name + " -- " + value + " gold ea.\n\n" + effectsText + "\n" + short + " " + long;
				default :
					return "";
			}
		}
	}
}
