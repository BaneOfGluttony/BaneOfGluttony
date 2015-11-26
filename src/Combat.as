package  {
	import flash.globalization.StringTools;
	
	public class Combat {
		//public var main:Main;
		//public var Player:Player;
		public var enemy:Enemy;
		public var text:String;
		public var enemyIsAlive:Boolean = true;
		//public var PlayerisAlive:Boolean = true;
		
		public function Combat(enemy:Enemy) {
			this.enemy = enemy;
			MainGameUI.state = "combat";
			text = enemy.startText + "\n\n--------------------------------------------------\n"
			Main.combatText = text;
			Main.setText(Main.combatText);
		}
		
		public function turn(cmd:String, item:Item = null, skill:Skill = null):Boolean {
			var ret:Boolean = true;
			Main.combatText = text;
			
			switch (cmd) {
				case "attack" :
					if (Player.stats["agi"] > enemy.agi) {
						PlayerAttack();
						if (Player.isAlive && enemyIsAlive) {
							Main.addText("\n-----\n");
							enemyTurn();
						}
					} else if (Player.stats["agi"] < enemy.agi) {
						enemyTurn();
						if (Player.isAlive && enemyIsAlive) {
							Main.addText("\n-----\n");
							PlayerAttack();
						}
					} else if (Player.stats["agi"] == enemy.agi) {
						if (Math.random() < 0.5) {
							enemyTurn();
							if (Player.isAlive && enemyIsAlive) {
								Main.addText("\n-----\n");
								PlayerAttack();
							}
						} else {
							PlayerAttack();
							if (Player.isAlive && enemyIsAlive) {
								Main.addText("\n-----\n");
								enemyTurn();
							}
						}
					}
					break;
				case "inventory" :
					if (Player.stats["agi"] > enemy.agi) {
						ret = useItem(item);
						if (ret) {
							if (Player.isAlive && enemyIsAlive) {
								Main.addText("\n-----\n");
								ret = enemyTurn();
							}
						}
					} else if (Player.stats["agi"] < enemy.agi) {
						ret = enemyTurn();
						if (ret) {
							Main.addText("\n-----\n");
							ret = useItem(item);
						} /*else {
							ret = false;
							Main.endCombat(false);
							Main.gameOver(0);
						}*/
					} else if (Player.stats["agi"] == enemy.agi) {
						if (Math.random() < 0.5) {
							ret = enemyTurn();
							if (ret) {
								Main.addText("\n-----\n");
								ret = useItem(item);
							} /*else {
								ret = false;
								Main.endCombat(false);
								Main.gameOver(0);
							}*/
						} else {
							ret = useItem(item);
							if (ret) {
								if (Player.isAlive && enemyIsAlive) {
									Main.addText("\n-----\n");
									ret = enemyTurn();
								}
							}
						}
					}
					break;
				case "skills" :
					
					break;
				case "run" :
					if (Player.stats["agi"] > enemy.agi) {
						ret = run();
						if (ret) {
							Main.endCombat(true);
						} else {
							Main.addText("\n-----\n");
							enemyTurn();
						}
					} else if (Player.stats["agi"] < enemy.agi) {
						enemyTurn();
						if (Player.isAlive && enemyIsAlive) {
							Main.addText("\n-----\n");
							ret = run();
							if (ret)
								Main.endCombat(true);
						}
					} else if (Player.stats["agi"] == enemy.agi) {
						if (Math.random() < 0.5) {
							enemyTurn();
							if (Player.isAlive && enemyIsAlive) {
								Main.addText("\n-----\n");
								ret = run();
								if (ret)
									Main.endCombat(true);
							}
						} else {
							ret = run();
							if (ret) {
								Main.endCombat(true);
							} else {
								Main.addText("\n-----\n");
								enemyTurn();
							}
						}
					}
					break;
				case "devour" :
					
					break;
				case "wait" :
					enemyTurn();
					break;
				case "surrender" :
					surrender();
					break;
			}
			
			return ret;
		}
		
		public function PlayerAttack():void {
			//Main.combatText += "\n";
			var text:String = "";
			
			if (Player.equipment["weapon"] != null && Player.equipment["weapon"].wpnText != "Weapon text")
				text += Player.equipment["weapon"].wpnText;
			else
				text += "You lunge at your foe with all your might.";
			
			if (didHit(Player, enemy)) {
				var dmg:int = calcDmg(Player, enemy);
				text += "\n\nYou deal " + dmg + " damage.";
				Main.addText(text);
				enemyDmg(dmg);
			} else {
				text += "\n\nYour attack missed.";
				Main.addText(text);
			}
		}
		
		public function useItem(item:Item):Boolean {
			/*var text:String = "";
			
			if (used && item.equip) {
				text += "You equipped a " + item.name + ".";
			} else if (!used && item.equip) {
				Main.MainMC.openInventory();
				Main.setText(Main.combatText);
				text += "A two-handed weapon and a shield cannot be equipped simultaneously.";
				return false;
			} else if (!item.equip) {
				text += "You use a " + item.name + ".";
			}
			
			text += "\n" + item.effectsText;
			Main.addText(text);
			
			Main.isPlayerAlive();*/
			
			/*if (used) {
				if (item.equip)
					Main.addText("You equipped a " + item.name + ".\n" + item.effectsText);
				else
					Main.addText("You used a " + item.name + ".\n" + item.effectsText);
			}*/
			
			return Main.useItem(item);
		}
		
		public function run():Boolean {
			var x:Number = Player.stats["agi"] / enemy.agi;
			var y:Number = Math.pow(x, 2) / -3 + 1.5 * x - 2 / 3;	//0.674063 ln(2.56896x - 0.5)
			var rand:Number = Math.random();
			var success:Boolean = rand < y;
			
			//Main.combatText += "\n";
			
			if (enemy.canRun && success)
				Main.addText("You ran away from the fight.");
			else
				Main.addText("You couldn't run from the fight.");
			
			//Main.setText(Main.combatText);
			return success;
		}
		
		public function surrender():void {
			//Main.combatText += "\n";
			
			if (enemy.surrType != 0) {
				enemy.skills[0].useSkill(enemy, Player);
				enemyDmg(0);
				/*if (Main.isPlayerAlive())
					Main.endCombat(true);*/
			} else {
				Main.addText("You gave up the fight.");
				Main.gameOver(0);
			}
			
			//Main.setText(Main.combatText);
		}
		
		public function enemyTurn():Boolean {
			//Main.combatText += "\n";
			var dmg:int = 0;
			var text:String = "";
			
			if (enemy.skills.length > 1) {
				var rand:Number = Math.random();
				if (rand < 0.5) {
					if (didHit(enemy, Player)) {
						dmg = calcDmg(enemy, Player);
						text += enemy.atkText + "\n\nYou take " + dmg + " damage.";
					} else {
						text += "The enemy's attack missed.";
				}
				} else {
					var randSkill:int = (Math.random() * (enemy.skills.length - 1)) as int;
					enemy.skills[1 + randSkill].useSkill(enemy, Player);
				}
			} else {
				if (didHit(enemy, Player)) {
					dmg = calcDmg(enemy, Player);
					text += enemy.atkText + "\n\nYou take " + dmg + " damage.";
				} else {
					text += "The enemy's attack missed.";
				}
				
			}
			
			Main.addText(text);
			Main.isPlayerAlive();
			
			if (enemy.currHP <= 0) {
				enemyIsAlive = false;
				return false;
			} else {
				return PlayerDmg(dmg);
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
			
			if (source == Player) {
				sourceDex = Player.stats["dex"];
				targetAgi = target.agi;
			} else {
				sourceDex = source.dex;
				targetAgi = Player.stats["agi"];
			}
			
			var prob:Number = 0.5 * Math.log(8.5 * sourceDex / targetAgi);
			
			return Math.random() < prob;
		}
		
		public function calcDmg(source:Object, target:Object):int {
			var sourceAtk:int;
			var sourceDex:int;
			var targetDef:int;
			var targetAgi:int;
			
			if (source == Player) {
				sourceAtk = Player.derivedStats["atk"];
				sourceDex = Player.stats["dex"];
				targetDef = target.def;
				targetAgi = target.agi;
			} else {
				sourceAtk = source.atk;
				sourceDex = source.dex;
				targetDef = Player.derivedStats["def"];
				targetAgi = Player.stats["agi"];
			}
			
			var ratio:Number = sourceDex / targetAgi;
			if (ratio < 0.5)
				ratio = 0.5;
			else if (ratio > 1)
				ratio = 1;
			
			var dmg:Number = sourceAtk * (ratio + Math.random() * (1 - ratio));
			dmg -= targetDef;
			
			if (dmg < 0)
				dmg = 0;
				
			return Math.round(dmg);
		}
		
		public function PlayerDmg(dmg:int):Boolean {
			Main.addResource("Health", -dmg, 0);
			
			return Main.isPlayerAlive();
		}
		
		public function enemyDmg(dmg:int):void {		
			enemy.currHP -= dmg;
			MainGameUI.updateEnemyHealth();
			
			if (Main.isPlayerAlive() && enemy.currHP <= 0) {
				enemyIsAlive = false;
				
				Main.addText("\n----------");
				Main.addText("\n" + enemy.endText + " You have defeated the " + enemy.name + ".\n");
				
				for each (var item:Item in enemy.loot)
					Main.loot(item, 1);
				
				Main.addGold(enemy.gold);
				Main.addExp(enemy.exp, false);
				Main.endCombat(true);
				//return false;
			} else {
				MainGameUI.updateEnemyHealth();
			}
			
			//return true;
		}
	}
}
