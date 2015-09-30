package  {
	
	public class Skill {
		
		public var name:String = "Skill";
		public var desc:String = "Description";
		public var useText:String = "Use description";
		public var enemy:Enemy;
		
		public var sourceEffects:Array;						// array of functions that determine effects on source
		public var targetEffects:Array;						// array of functions that determine effects on target
		public var effectsText:String = "";
		
		public var source:Object;
		public var target:Object;
		
		public function Skill(properties:Object) {
			for (var name:String in properties) {
				if (this.hasOwnProperty(name)) {
					this[name] = properties[name];
				}
			}
		}
		
		public function useSkill(main:Main, source:Object, target:Object):void {
			this.source = source;
			this.target = target;
			
			writeEffects(main);
			main.addText(useText + "\n\n" + effectsText);
			
			if (source is Enemy && target is Player) {
				// proc special effects
				if (targetEffects != null && targetEffects.length > 0) {
					//trace("[Item] " + name + " has special effects!");
					for each (var f:Function in targetEffects) {
						var special:Array = f();		// special will be ["nameOfStat", statValueAsInteger]
						//trace("[Item] " + name + " procs special effect for " + special[0] + " with value " + special[1]);
						changeStat(main, target, special[0], special[1]);
					}
					//trace("[Item] " + name + " finished adding special effects.");
				}
				
				if (sourceEffects != null && sourceEffects.length > 0) {
					for each (var f:Function in sourceEffects) {
						var special:Array = f();
						changeStat(main, source, special[0], special[1]);
					}
				}
			}
		}
		
		private function changeStat(main:Main, subject:Object, stat:String, amount:int):void {
			if (subject is Player) {
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
				}
				main.isPlayerAlive();
			} else if (subject is Enemy) {
				switch (stat) {
					case "currHP" :
						//main.mainMC.updateEnemyHealth();
						main.combat.enemyDmg(-amount);
						break;
					case "atk" :
					case "def" :
					case "agi" :
					case "dex" :
						subject[stat] += amount;
						if (subject[stat] < 0)
							subject[stat] = 0;
						break;
				}
			}
		}
		
		public function writeEffects(main:Main):void {
			effectsText = "";
			
			if (target is Player && targetEffects != null && targetEffects.length > 0) {
				for each (var f:Function in targetEffects) {
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
					}
				}
			}
			effectsText = effectsText.slice(0, effectsText.length - 2);
		}
	}
}
