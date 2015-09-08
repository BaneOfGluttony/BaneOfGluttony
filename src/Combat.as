package  {
	
	public class Combat {
		public var main:Main;
		public var player:Player;
		public var enemy:Enemy;
		public var playerTurn:Boolean;
		
		public function Combat(main:Main, player:Player, enemy:Enemy) {
			this.main = main;
			this.player = player;
			this.enemy = enemy;
			
			if (player.stats["agi"] > enemy.agi) {
				playerTurn = true;
			} else if (player.stats["agi"] < enemy.agi) {
				playerTurn = false;
			} else {
				if (Math.random() < 0.5)
					playerTurn = false;
				else
					playerTurn = true;
			}
		}
		
		public function playerAttack():void {
			var text:String;
			var dmg:int = player.derivedStats["atk"] - enemy.def;
			if (dmg < 0)
				dmg = 0;
			
			if (player.equipment["weapon"] != null && player.equipment["weapon"].wpnText != null)
				text = player.equipment["weapon"].wpnText + " for " + dmg + " damage.";
			else
				text = "You lunge at your foe with all your might.";
			text += "\nYou deal " + dmg + " damage.";
			
			main.addText(text);
			
			if (enemyDmg(dmg))
				enemyTurn();
		}
		
		public function enemyTurn():void {
			var text:String;
			var dmg:int;
			
			if (enemy.moves.length > 0) {
				var rand:Number = Math.random();
				if (rand < 0.5) {
					dmg = enemy.atk - player.derivedStats["def"];
					text = enemy.atkText + "\nYou take " + dmg + " damage.";
				} else {
					var randSkill:int = (Math.random() * enemy.moves.length) as int;
					//useSkill(randSkill);
				}
			} else {
				dmg = enemy.atk - player.derivedStats["def"];
				text = enemy.atkText + "\nYou take " + dmg + " damage.";
			}
			
			main.addText(text);
			playerDmg(dmg);
		}
		
		public function playerDmg(dmg:int):void {
			main.addResource("Health", -dmg, 0);
			if (player.resources["currHealth"] <= 0) {
				main.gameOver(0);
			}
		}
		
		public function enemyDmg(dmg:int):Boolean {
			enemy.currHP -= dmg;
			if (enemy.currHP <= 0) {
				enemy.currHP = 0;
				main.mainMC.updateEnemyHealth();
				main.endCombat();
				return false
			} else {
				main.mainMC.updateEnemyHealth();
				return true;
			}
		}
	}
}
