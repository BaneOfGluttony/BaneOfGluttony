package  {
	import flash.globalization.StringTools;
	
	public class Combat {
		public var main:Main;
		public var player:Player;
		public var enemy:Enemy;
		public var text:String = "";
		public var enemyFirstStrike:Boolean = false;
		public var enemyIsAlive:Boolean = true;
		
		public function Combat(main:Main, player:Player, enemy:Enemy) {
			this.main = main;
			this.player = player;
			this.enemy = enemy;
			main.combatText = enemy.startText + "\n--------------------------------------------------\n";
			main.setText(main.combatText);
		}
		
		public function turn(cmd:String, item:Item = null, skill:Skill = null):Boolean {
			var ret:Boolean = true;
			
			switch (cmd) {
				case "attack" :
					if (player.stats["agi"] > enemy.agi) {
						playerAttack();
						if (enemyIsAlive)
							enemyTurn();
					} else if (player.stats["agi"] < enemy.agi) {
						enemyTurn();
						playerAttack();
					} else if (player.stats["agi"] == enemy.agi) {
						if (Math.random() < 0.5) {
							enemyTurn();
							playerAttack();
						} else {
							playerAttack();
							if (enemyIsAlive)
								enemyTurn();
						}
					}
					break;
				case "inventory" :
					if (player.stats["agi"] > enemy.agi) {
						ret = useItem(item);
						if (enemyIsAlive)
							enemyTurn();
					} else if (player.stats["agi"] < enemy.agi) {
						enemyTurn();
						ret = useItem(item);
					} else if (player.stats["agi"] == enemy.agi) {
						if (Math.random() < 0.5) {
							enemyTurn();
							ret = useItem(item);
						} else {
							ret = useItem(item);
							if (enemyIsAlive)
								enemyTurn();
						}
					}
					break;
				case "skills" :
					
					break;
				case "run" :
					
					break;
				case "devour" :
					
					break;
				case "surrender" :
					
					break;
			}
			
			text = "";
			return ret;
		}
		
		public function playerAttack():Boolean {
			text += "\n";
			var dmg:int = player.derivedStats["atk"] - enemy.def;
			if (dmg < 0)
				dmg = 0;
			
			if (player.equipment["weapon"] != null && player.equipment["weapon"].wpnText != "Weapon text")
				text += player.equipment["weapon"].wpnText + " for " + dmg + " damage.";
			else
				text += "You lunge at your foe with all your might.";
			text += "\nYou deal " + dmg + " damage.";
			text += "\n-----";
			
			main.setText(main.combatText + text);
			
			return enemyDmg(dmg);
		}
		
		public function useItem(item:Item):Boolean {
			var used:Boolean = main.useItem(item);
			
			if (item.equip) {
				text += "\nYou equip a " + item.name + ".";
			} else {
				text += "\nYou use a " + item.name + ".";
				text += "\n" + item.effect.listEffects();
			}
			
			text += "\n-----";
			main.setText(main.combatText + text);
			
			return used;
		}
		
		public function enemyTurn():Boolean {
			text += "\n";
			var dmg:int;
			
			if (enemy.moves.length > 0) {
				var rand:Number = Math.random();
				if (rand < 0.5) {
					dmg = enemy.atk - player.derivedStats["def"];
					if (dmg < 0)
						dmg = 0;
						
					text += enemy.atkText + "\nYou take " + dmg + " damage.";
				} else {
					var randSkill:int = (Math.random() * enemy.moves.length) as int;
					//useSkill(randSkill);
				}
			} else {
				dmg = enemy.atk - player.derivedStats["def"];
				if (dmg < 0)
					dmg = 0;
					
				text += enemy.atkText + "\nYou take " + dmg + " damage.";
			}
			text += "\n-----";
			main.setText(main.combatText + text);
			
			return playerDmg(dmg);
		}
		
		public function playerDmg(dmg:int):Boolean {
			main.addResource("Health", -dmg, 0);
			
			if (player.resources["currHealth"] <= 0) {
				main.gameOver(0);
				return false;
			}
			
			return true;
		}
		
		public function enemyDmg(dmg:int):Boolean {		
			enemy.currHP -= dmg;
			
			if (enemy.currHP <= 0) {
				enemy.currHP = 0;
				main.mainMC.updateEnemyHealth();
				enemyIsAlive = false;
				main.endCombat(true);
				return false;
			} else {
				main.mainMC.updateEnemyHealth();
			}
			
			return true;
		}
	}
}
