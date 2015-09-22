package  {
	import flash.globalization.StringTools;
	
	public class Combat {
		public var main:Main;
		public var player:Player;
		public var enemy:Enemy;
		public var text:String;
		public var enemyFirstStrike:Boolean = false;
		public var enemyIsAlive:Boolean = true;
		//public var playerisAlive:Boolean = true;
		
		public function Combat(main:Main, player:Player, enemy:Enemy) {
			this.main = main;
			this.player = player;
			this.enemy = enemy;
			text = enemy.startText + "\n\n--------------------------------------------------\n"
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
						if (enemyIsAlive) {
							main.combatText += "\n\n-----\n";
							enemyTurn();
						}
					} else if (player.stats["agi"] < enemy.agi) {
						enemyTurn();
						if (main.isPlayerAlive()) {
							main.combatText += "\n\n-----\n";
							playerAttack();
						}
					} else if (player.stats["agi"] == enemy.agi) {
						if (Math.random() < 0.5) {
							enemyTurn();
							if (main.isPlayerAlive()) {
								main.combatText += "\n\n-----\n";
								playerAttack();
							}
						} else {
							playerAttack();
							if (enemyIsAlive) {
								main.combatText += "\n\n-----\n";
								enemyTurn();
							}
						}
					}
					break;
				case "inventory" :
					if (player.stats["agi"] > enemy.agi) {
						ret = useItem(item);
						if (ret) {
							if (enemyIsAlive) {
								main.combatText += "\n\n-----\n";
								ret = enemyTurn();
							}
						}
					} else if (player.stats["agi"] < enemy.agi) {
						ret = enemyTurn();
						if (ret) {
							main.combatText += "\n\n-----\n";
							ret = useItem(item);
						} /*else {
							ret = false;
							main.endCombat(false);
							main.gameOver(0);
						}*/
					} else if (player.stats["agi"] == enemy.agi) {
						if (Math.random() < 0.5) {
							ret = enemyTurn();
							if (ret) {
								main.combatText += "\n\n-----\n";
								ret = useItem(item);
							} /*else {
								ret = false;
								main.endCombat(false);
								main.gameOver(0);
							}*/
						} else {
							ret = useItem(item);
							if (ret) {
								if (enemyIsAlive) {
									main.combatText += "\n\n-----\n";
									ret = enemyTurn();
								}
							}
						}
					}
					break;
				case "skills" :
					
					break;
				case "run" :
					if (player.stats["agi"] > enemy.agi) {
						ret = run();
						if (ret) {
							main.endCombat(true);
						} else {
							main.combatText += "\n\n-----\n";
							enemyTurn();
						}
					} else if (player.stats["agi"] < enemy.agi) {
						enemyTurn();
						if (main.isPlayerAlive()) {
							main.combatText += "\n\n-----\n";
							ret = run();
							if (ret)
								main.endCombat(true);
						}
					} else if (player.stats["agi"] == enemy.agi) {
						if (Math.random() < 0.5) {
							enemyTurn();
							if (main.isPlayerAlive()) {
								main.combatText += "\nn-----\n";
								ret = run();
								if (ret)
									main.endCombat(true);
							}
						} else {
							ret = run();
							if (ret) {
								main.endCombat(true);
							} else {
								main.combatText += "\n\n-----\n";
								enemyTurn();
							}
						}
					}
					break;
				case "devour" :
					
					break;
				case "surrender" :
					
					break;
			}
			
			return ret;
		}
		
		public function playerAttack():void {
			main.combatText += "\n";
			
			var dmg:int = player.derivedStats["atk"] - enemy.def;
			if (dmg < 0)
				dmg = 0;
			
			if (player.equipment["weapon"] != null && player.equipment["weapon"].wpnText != "Weapon text")
				main.combatText += player.equipment["weapon"].wpnText;
			else
				main.combatText += "You lunge at your foe with all your might.";
			
			if (didHit(player, enemy)) {
				main.combatText += "\n\nYou deal " + dmg + " damage.";
				enemyDmg(-dmg);
			} else {
				main.combatText += "\n\nUnfortunately, your attack missed.";
			}
			//main.combatText += "\n-----";
			main.setText(main.combatText);
		}
		
		public function useItem(item:Item):Boolean {
			var used:Boolean = main.useItem(item);
			
			if (used && item.equip) {
				main.combatText += "\nYou equip a " + item.name + ".";
			} else if (!used && item.equip) {
				main.mainMC.openInventory();
				main.setText(main.combatText);
				main.addText("A two-handed weapon and a shield cannot be equipped simultaneously.");
				return false;
			} else if (!item.equip) {
				main.combatText += "\nYou use a " + item.name + ".";
				//player.isAlive = false;
			}
			
			main.combatText += "\n\n" + item.effectsText;
			
			//main.combatText += "\n-----";
			main.setText(main.combatText);
			
			/*if (player.resources["currCapacity"] > player.derivedStats["cap"])
				main.gameOver(1);
			else if (player.resources["currHealth"] <= 0)
				main.gameOver(0);*/
			
			main.isPlayerAlive();
			
			return used;
		}
		
		public function run():Boolean {
			var x:Number = player.stats["agi"] / enemy.agi;
			var y:Number = Math.pow(x, 2) / -3 + 1.5 * x - 2 / 3;
			var rand:Number = Math.random();
			var success:Boolean = rand <= y;
			
			main.combatText += "\n";
			
			if (enemy.canRun && success) {
				main.combatText += "You ran away from the fight.";
			} else {
				main.combatText += "You couldn't run from the fight.";
			}
			
			main.setText(main.combatText);
			return success;
		}
		
		public function surrender():void {
			main.combatText += "\n";
			enemy.skills[0].useSkill(main, enemy, player);
			main.setText(main.combatText);
			main.isPlayerAlive();
		}
		
		public function enemyTurn():Boolean {
			main.combatText += "\n";
			var dmg:int;
			
			if (enemy.skills.length > 1) {
				var rand:Number = Math.random();
				if (rand < 0) { //0.5
					dmg = enemy.atk - player.derivedStats["def"];
					if (dmg < 0)
						dmg = 0;
						
					main.combatText += enemy.atkText + "\n\nYou take " + dmg + " damage.";
				} else {
					var randSkill:int = (Math.random() * (enemy.skills.length - 1)) as int;
					enemy.skills[1 + randSkill].useSkill(main, enemy, player);
				}
			} else {
				dmg = enemy.atk - player.derivedStats["def"];
				if (dmg < 0)
					dmg = 0;
					
				main.combatText += enemy.atkText + "\n\nYou take " + dmg + " damage.";
			}
			
			main.setText(main.combatText);
			main.isPlayerAlive();
			
			if (enemy.currHP <= 0) {
				enemyIsAlive = false;
				return false;
			} else {
				return playerDmg(dmg);
			}
		}
		
		public function didHit(source:Object, target:Object):Boolean {
			var sourceDex:int;
			var targetAgi:int;
			
			if (source is Player) {
				sourceDex = source.stats["dex"];
				targetAgi = target.agi;
			} else {
				sourceDex = source.dex;
				targetAgi = target.stats["agi"];
			}
			
			return sourceDex > targetAgi;
		}
		
		public function playerDmg(dmg:int):Boolean {
			main.addResource("Health", -dmg, 0);
			
			/*if (player.resources["currHealth"] <= 0) {
				main.gameOver(0);
				player.isAlive = false;
				return false;
			}
			
			return true;*/
			return main.isPlayerAlive();
		}
		
		public function enemyDmg(dmg:int):void {		
			enemy.currHP += dmg;
			
			if (main.isPlayerAlive() && enemy.currHP <= 0) {
				main.mainMC.updateEnemyHealth();
				enemyIsAlive = false;
				
				main.combatText += "\n----------";
				main.combatText += "\n\n" + enemy.endText;
				
				for each (var item:Item in enemy.loot)
					main.loot(item, 1);
				
				main.addGold(enemy.gold);
				main.addExp(enemy.exp);
				main.endCombat(true);
				//return false;
			} else {
				main.mainMC.updateEnemyHealth();
			}
			
			//return true;
		}
	}
}
