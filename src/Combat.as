package  {
	import flash.globalization.StringTools;
	
	public class Combat {
		public var main:Main;
		public var player:Player;
		public var enemy:Enemy;
		public var text:String;
		public var enemyIsAlive:Boolean = true;
		//public var playerisAlive:Boolean = true;
		
		public function Combat(main:Main, player:Player, enemy:Enemy) {
			this.main = main;
			this.player = player;
			this.enemy = enemy;
			main.mainMC.state = "combat";
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
						if (player.isAlive && enemyIsAlive) {
							main.addText("\n-----\n");
							enemyTurn();
						}
					} else if (player.stats["agi"] < enemy.agi) {
						enemyTurn();
						if (player.isAlive && enemyIsAlive) {
							main.addText("\n-----\n");
							playerAttack();
						}
					} else if (player.stats["agi"] == enemy.agi) {
						if (Math.random() < 0.5) {
							enemyTurn();
							if (player.isAlive && enemyIsAlive) {
								main.addText("\n-----\n");
								playerAttack();
							}
						} else {
							playerAttack();
							if (player.isAlive && enemyIsAlive) {
								main.addText("\n-----\n");
								enemyTurn();
							}
						}
					}
					break;
				case "inventory" :
					if (player.stats["agi"] > enemy.agi) {
						ret = useItem(item);
						if (ret) {
							if (player.isAlive && enemyIsAlive) {
								main.addText("\n-----\n");
								ret = enemyTurn();
							}
						}
					} else if (player.stats["agi"] < enemy.agi) {
						ret = enemyTurn();
						if (ret) {
							main.addText("\n-----\n");
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
								main.addText("\n-----\n");
								ret = useItem(item);
							} /*else {
								ret = false;
								main.endCombat(false);
								main.gameOver(0);
							}*/
						} else {
							ret = useItem(item);
							if (ret) {
								if (player.isAlive && enemyIsAlive) {
									main.addText("\n-----\n");
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
							main.addText("\n-----\n");
							enemyTurn();
						}
					} else if (player.stats["agi"] < enemy.agi) {
						enemyTurn();
						if (player.isAlive && enemyIsAlive) {
							main.addText("\n-----\n");
							ret = run();
							if (ret)
								main.endCombat(true);
						}
					} else if (player.stats["agi"] == enemy.agi) {
						if (Math.random() < 0.5) {
							enemyTurn();
							if (player.isAlive && enemyIsAlive) {
								main.addText("\n-----\n");
								ret = run();
								if (ret)
									main.endCombat(true);
							}
						} else {
							ret = run();
							if (ret) {
								main.endCombat(true);
							} else {
								main.addText("\n-----\n");
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
			//main.combatText += "\n";
			var text:String = "";
			
			if (player.equipment["weapon"] != null && player.equipment["weapon"].wpnText != "Weapon text")
				text += player.equipment["weapon"].wpnText;
			else
				text += "You lunge at your foe with all your might.";
			
			if (didHit(player, enemy)) {
				var dmg:int = calcDmg(player, enemy);
				text += "\n\nYou deal " + dmg + " damage.";
				enemyDmg(dmg);
			} else {
				text += "\n\nYour attack missed.";
			}
			
			main.addText(text);
		}
		
		public function useItem(item:Item):Boolean {
			/*var used:Boolean = main.useItem(item);
			var text:String = "";
			
			if (used && item.equip) {
				text += "You equipped a " + item.name + ".";
			} else if (!used && item.equip) {
				main.mainMC.openInventory();
				main.setText(main.combatText);
				text += "A two-handed weapon and a shield cannot be equipped simultaneously.";
				return false;
			} else if (!item.equip) {
				text += "You use a " + item.name + ".";
			}
			
			text += "\n" + item.effectsText;
			main.addText(text);
			
			main.isPlayerAlive();*/
			
			return main.useItem(item);
		}
		
		public function run():Boolean {
			var x:Number = player.stats["agi"] / enemy.agi;
			var y:Number = Math.pow(x, 2) / -3 + 1.5 * x - 2 / 3;
			var rand:Number = Math.random();
			var success:Boolean = rand < y;
			
			//main.combatText += "\n";
			
			if (enemy.canRun && success)
				main.addText("You ran away from the fight.");
			else
				main.addText("You couldn't run from the fight.");
			
			//main.setText(main.combatText);
			return success;
		}
		
		public function surrender():void {
			//main.combatText += "\n";
			
			if (enemy.surrType != 0) {
				enemy.skills[0].useSkill(main, enemy, player);
			} else {
				main.gameOver(0);
			}
			
			//main.setText(main.combatText);
			main.isPlayerAlive();
		}
		
		public function enemyTurn():Boolean {
			//main.combatText += "\n";
			var dmg:int = 0;
			var text:String = "";
			
			if (enemy.skills.length > 1) {
				var rand:Number = Math.random();
				if (rand < 0.5) {
					if (didHit(enemy, player)) {
						dmg = calcDmg(enemy, player);
						text += enemy.atkText + "\n\nYou take " + dmg + " damage.";
					} else {
						text += "The enemy's attack missed.";
				}
				} else {
					var randSkill:int = (Math.random() * (enemy.skills.length - 1)) as int;
					enemy.skills[1 + randSkill].useSkill(main, enemy, player);
				}
			} else {
				if (didHit(enemy, player)) {
					dmg = calcDmg(enemy, player);
					text += enemy.atkText + "\n\nYou take " + dmg + " damage.";
				} else {
					text += "The enemy's attack missed.";
				}
				
			}
			
			main.addText(text);
			main.isPlayerAlive();
			
			if (enemy.currHP <= 0) {
				enemyIsAlive = false;
				return false;
			} else {
				return playerDmg(dmg);
			}
		}
		
		public function isEnemyAlive():Boolean {
			var isAlive:Boolean = enemy.currHP > 0;
			if (!isAlive)
				enemyIsAlive = false;
			
			return isAlive;
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
			
			var prob:Number = 0.5 * Math.log(8.5 * sourceDex / targetAgi);
			
			return Math.random() < prob;
		}
		
		public function calcDmg(source:Object, target:Object):int {
			var sourceAtk:int;
			var sourceDex:int;
			var targetDef:int;
			var targetAgi:int;
			
			if (source is Player) {
				sourceAtk = source.derivedStats["atk"];
				sourceDex = source.stats["dex"];
				targetDef = target.def;
				targetAgi = target.agi;
			} else {
				sourceAtk = source.atk;
				sourceDex = source.dex;
				targetDef = target.derivedStats["def"];
				targetAgi = target.stats["agi"];
			}
			
			var ratio:Number = sourceDex / enemy.agi;
			if (ratio < 0.5)
				ratio = 0.5;
			else if (ratio > 1)
				ratio = 1;
			
			var dmg:Number = ratio * sourceAtk + Math.random() * (1 - ratio) * sourceAtk;
			dmg -= targetDef;
			
			if (dmg < 0)
				dmg = 0;
				
			return Math.round(dmg);
		}
		
		public function playerDmg(dmg:int):Boolean {
			main.addResource("Health", -dmg, 0);
			
			return main.isPlayerAlive();
		}
		
		public function enemyDmg(dmg:int):void {		
			enemy.currHP -= dmg;
			
			if (main.isPlayerAlive() && enemy.currHP <= 0) {
				main.mainMC.updateEnemyHealth();
				enemyIsAlive = false;
				
				main.addText("\n----------");
				main.addText("\n" + enemy.endText + " You have defeated the " + enemy.name + ".\n");
				
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
