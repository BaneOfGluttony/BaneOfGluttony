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
		
		public function useSkill(source:Object, target:Object):void {
			this.source = source;
			this.target = target;
			
			writeEffects();
			Main.addText(useText + "\n\n" + effectsText);
			
			if (source is Enemy && target == Player) {
				// proc special effects
				if (targetEffects != null && targetEffects.length > 0) {
					//trace("[Item] " + name + " has special effects!");
					for each (var f:Function in targetEffects) {
						var special:Array = f();		// special will be ["nameOfStat", statValueAsInteger]
						//trace("[Item] " + name + " procs special effect for " + special[0] + " with value " + special[1]);
						changeStat(target, special[0], special[1]);
					}
					//trace("[Item] " + name + " finished adding special effects.");
				}
				
				if (sourceEffects != null && sourceEffects.length > 0) {
					for each (var f:Function in sourceEffects) {
						var special:Array = f();
						changeStat(source, special[0], special[1]);
					}
				}
			}
		}
		
		private function changeStat(subject:Object, stat:String, amount:int):void {
			if (subject == Player) {
				switch (stat) {
					case "currHealth" :
						Main.addResource("Health", amount, 0);
						break;
					case "maxHealth" :
						Main.addResource("Health", 0, amount);
						break;
					case "currMana" :
						Main.addResource("Mana", amount, 0);
						break;
					case "maxMana" :
						Main.addResource("Mana", 0, amount);
						break;
					case "currEnergy" :
						Main.addResource("Energy", amount, 0);
						break;
					case "maxEnergy" :
						Main.addResource("Energy", 0, amount);
						break;
					case "currCapacity" :
						Main.addResource("Capacity", amount, 0);
						break;
					case "maxCapacity" :
						Main.addResource("Capacity", 0, amount);
						break;
					
					case "str" :
					case "agi" :
					case "vit" :
					case "dex" :
					case "int" :
					case "vor" :
						Main.addStat(stat, amount);
						break;
						
					case "atk" :
					case "matk" :
					case "def" :
					case "mdef" :
					case "acc" :
					case "dodge" :
					case "cap" :
						Player.derivedStats[stat] += amount;
						break;
					
					case "fat" :
						Main.addFat(amount);
						break;
						
					case "suicide" :
						Main.setResource("Health", 0, -1);
						Player.isAlive = false;
						break;
				}
				//Main.isPlayerAlive();
			} else if (subject is Enemy) {
				switch (stat) {
					case "currHP" :
						//MainGamUI.updateEnemyHealth();
						Main.combat.enemyDmg(-amount);
						break;
					case "atk" :
					case "def" :
					case "agi" :
					case "dex" :
						subject[stat] += amount;
						if (subject[stat] < 0)
							subject[stat] = 0;
						break;
						
					case "suicide" :
						Main.combat.enemy.currHP = 0;
						MainGameUI.updateEnemyHealth();
						Main.combat.enemyIsAlive = false;
						break;
				}
			}
		}
		
		public function writeEffects():void {
			effectsText = "";
			
			if (target == Player && targetEffects != null && targetEffects.length > 0) {
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
