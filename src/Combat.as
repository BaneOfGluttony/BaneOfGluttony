package  {
	import flash.globalization.StringTools;
	
	public class Combat {
		public var main:Main;
		public var player:Player;
		public var enemy:Enemy;
		public var text:String;
		public var enemyFirstStrike:Boolean = false;
		public var enemyIsAlive:Boolean = true;
		public var playerIsAlive:Boolean = true;
		
		public function Combat(main:Main, player:Player, enemy:Enemy) {
			this.main = main;
			this.player = player;
			this.enemy = enemy;
			text = enemy.startText + "\n--------------------------------------------------\n"
			main.combatText = text;
			main.setText(main.combatText);
		}
		
		public function turn(cmd:String, item:Item = null, skill:Skill = null):Boolean {
			var ret:Boolean = true;
			main.combatText = text;
			
			switch (cmd) {
				case "attack" :
					if (player.stats["agi"] > enemy.agi) {
						playerAttack();
						if (enemyIsAlive)
							enemyTurn();
					} else if (player.stats["agi"] < enemy.agi) {
						enemyTurn();
						if (playerIsAlive)
							playerAttack();
					} else if (player.stats["agi"] == enemy.agi) {
						if (Math.random() < 0.5) {
							enemyTurn();
							if (playerIsAlive)
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
						if (playerIsAlive)
							ret = useItem(item);
					} else if (player.stats["agi"] == enemy.agi) {
						if (Math.random() < 0.5) {
							enemyTurn();
							if (playerIsAlive)
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
			
			return ret;
		}
		
		public function playerAttack():Boolean {
			main.combatText += "\n";
			var dmg:int = player.derivedStats["atk"] - enemy.def;
			if (dmg < 0)
				dmg = 0;
			
			if (player.equipment["weapon"] != null && player.equipment["weapon"].wpnText != "Weapon text")
				main.combatText += player.equipment["weapon"].wpnText + " for " + dmg + " damage.";
			else
				main.combatText += "You lunge at your foe with all your might.";
			main.combatText += "\nYou deal " + dmg + " damage.";
			main.combatText += "\n-----";
			
			main.setText(main.combatText);
			
			return enemyDmg(dmg);
		}
		
		public function useItem(item:Item):Boolean {
			var used:Boolean = main.useItem(item);
			
			if (item.equip) {
				main.combatText += "\nYou equip a " + item.name + ".";
			} else {
				main.combatText += "\nYou use a " + item.name + ".";
				main.combatText += "\n" + item.effect.listEffects();
			}
			
			main.combatText += "\n-----";
			main.setText(main.combatText);
			
			if (!used) {
				main.gameOver(1);
				playerIsAlive = false;
			}
			
			return used;
		}
		
		public function enemyTurn():Boolean {
			main.combatText += "\n";
			var dmg:int;
			
			if (enemy.moves.length > 0) {
				var rand:Number = Math.random();
				if (rand < 0.5) {
					dmg = enemy.atk - player.derivedStats["def"];
					if (dmg < 0)
						dmg = 0;
						
					main.combatText += enemy.atkText + "\nYou take " + dmg + " damage.";
				} else {
					var randSkill:int = (Math.random() * enemy.moves.length) as int;
					//useSkill(randSkill);
				}
			} else {
				dmg = enemy.atk - player.derivedStats["def"];
				if (dmg < 0)
					dmg = 0;
					
				main.combatText += enemy.atkText + "\nYou take " + dmg + " damage.";
			}
			main.combatText += "\n-----";
			main.setText(main.combatText);
			
			return playerDmg(dmg);
		}
		
		public function playerDmg(dmg:int):Boolean {
			main.addResource("Health", -dmg, 0);
			
			if (player.resources["currHealth"] <= 0) {
				main.gameOver(0);
				playerIsAlive = false;
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
