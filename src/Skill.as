package  {
	
	public class Skill {
		
		public var name:String = "Skill";
		public var desc:String = "Description";
		public var useText:String = "Use description";
		public var enemy:Enemy;
		
		public var effects:Array;						// array of functions that determine added stats
		public var effectsText:String = "";
		
		public function Skill(properties:Object) {
			for (var name:String in properties) {
				if (this.hasOwnProperty(name)) {
					this[name] = properties[name];
				}
			}
		}
		
		public function useOnPlayer(main:Main, player:Player):void {
			// proc special effects
			if (effects != null && effects.length > 0) {
				//trace("[Item] " + name + " has special effects!");
				for each (var f:Function in effects) {
					var special:Array = f();		// special will be ["nameOfStat", statValueAsInteger]
					//trace("[Item] " + name + " procs special effect for " + special[0] + " with value " + special[1]);
					changeStat(main, special[0], special[1]);
				}
				//trace("[Item] " + name + " finished adding special effects.");
			}
			writeEffects(main, player);
			main.combatText += useText + "\n\n" + effectsText;
		}
		
		public function useOnEnemy(enemy:Enemy):void {
			
		}
		
		public function useOutOfCombat(player:Player):void {
			
		}
		
		/*public function procEffects(main:Main, player:Player):void {
			// proc special effects
			if (effects != null && effects.length > 0) {
				addedStats = [];
				//trace("[Item] " + name + " has special effects!");
				for each (var f:Function in effects) {
					var special:Array = f();		// special will be ["nameOfStat", statValueAsInteger]
					//trace("[Item] " + name + " procs special effect for " + special[0] + " with value " + special[1]);
					changeStat(main, special[0], special[1]);
				}
				//trace("[Item] " + name + " finished adding special effects.");
			}
			writeEffects();
			main.combatText += "\n" + effectsText;
		}*/
		
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
	}
}
