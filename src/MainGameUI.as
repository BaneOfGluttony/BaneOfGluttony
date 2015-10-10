package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
	import flash.geom.ColorTransform;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import Quests.Test;
	
	/**
	 * All of the code that was previously on the Timeline
	 * @author Kazan Fatzan, refactor by Serule Blue
	 */
	public class MainGameUI 
	{
		public var game:MovieClip;		// MainGame.swc
		public var main:Main;			// Main.as
		public var debug:Boolean = true;
		
		public const WIDTH:int = 800;
		public const HEIGHT:int = 600;
		
		public var btnIndex:int = 0
		public var scrollIndex:int = 0;
		public var menuIndex:int = 0;

		public var state:String = "navigate";

		public var menuItemSelected:Boolean = false;
		public var selectedItem:Item = null;

		public var btnArray:Array;
		
		public const faURL:String = "http://www.furaffinity.net/user/";
						
		public function MainGameUI(_main:Main) {
			main = _main;

			game = new MainGame();

			game.addEventListener(Event.ADDED_TO_STAGE, init);
			main.runner.addChild(game);
			
			game.mainUI.debugConsole.visible = debug;
		}
		
		private function init(e:Event):void {
			game.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			main.runner.stage.showDefaultContextMenu = false;
			
			btnArray = new Array(game.btnsUI.btn1, game.btnsUI.btn2, game.btnsUI.btn3,
							     game.btnsUI.btn4, game.btnsUI.btn5, game.btnsUI.btn6,
								 game.btnsUI.btn7, game.btnsUI.btn8, game.btnsUI.btn9);
			
			game.lvlupUI.visible = false;
			game.mainUI.bigMap.visible = false;		
			game.mainUI.bigMarker.visible = false;	
			game.btnsUI.upBtn.visible = false;
			game.btnsUI.downBtn.visible = false;
			game.combatUI.visible = false;
			
			updateMaps();
			
			game.optionsBtn.stop();
			game.menuUI.appearanceBtn.stop();
			game.menuUI.inventoryBtn.stop();
			game.menuUI.skillsBtn.stop();
			game.menuUI.questsBtn.stop();

			game.combatUI.attackBtn.stop();
			game.combatUI.inventoryBtn.stop();
			game.combatUI.skillsBtn.stop();
			game.combatUI.runBtn.stop();
			game.combatUI.devourBtn.stop();
			game.combatUI.surrenderBtn.stop();

			//Menus
			game.optionsBtn.buttonMode = true;
			game.optionsBtn.mouseChildren = false;
			game.optionsBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.optionsBtn); });
			game.optionsBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.optionsBtn); });
			game.optionsBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.optionsBtn); });

			game.menuUI.appearanceBtn.buttonMode = true;
			game.menuUI.appearanceBtn.mouseChildren = false;
			game.menuUI.appearanceBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.menuUI.appearanceBtn); });
			game.menuUI.appearanceBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.menuUI.appearanceBtn); });
			game.menuUI.appearanceBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.menuUI.appearanceBtn); });

			game.menuUI.inventoryBtn.buttonMode = true;
			game.menuUI.inventoryBtn.mouseChildren = false;
			game.menuUI.inventoryBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.menuUI.inventoryBtn); });
			game.menuUI.inventoryBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.menuUI.inventoryBtn); });
			game.menuUI.inventoryBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.menuUI.inventoryBtn); });

			game.menuUI.skillsBtn.buttonMode = true;
			game.menuUI.skillsBtn.mouseChildren = false;
			game.menuUI.skillsBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.menuUI.skillsBtn); });
			game.menuUI.skillsBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.menuUI.skillsBtn); });
			game.menuUI.skillsBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.menuUI.skillsBtn); });

			game.menuUI.questsBtn.buttonMode = true;
			game.menuUI.questsBtn.mouseChildren = false;
			game.menuUI.questsBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.menuUI.questsBtn); });
			game.menuUI.questsBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.menuUI.questsBtn); });
			game.menuUI.questsBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.menuUI.questsBtn); });

			game.mainUI.zoneBtn.buttonMode = true;
			game.mainUI.zoneBtn.mouseChildren = false;
			game.mainUI.zoneBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.mainUI.zoneBtn); });
			game.mainUI.zoneBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.mainUI.zoneBtn); });
			game.mainUI.zoneBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.mainUI.zoneBtn); });

			game.menuUI.saveBtn.buttonMode = true;
			game.menuUI.saveBtn.mouseChildren = false;
			game.menuUI.saveBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.menuUI.saveBtn); });
			game.menuUI.saveBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.menuUI.saveBtn); });
			game.menuUI.saveBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.menuUI.saveBtn); });

			game.menuUI.loadBtn.buttonMode = true;
			game.menuUI.loadBtn.mouseChildren = false;
			game.menuUI.loadBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.menuUI.loadBtn); });
			game.menuUI.loadBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.menuUI.loadBtn); });
			game.menuUI.loadBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.menuUI.loadBtn); });
			
			//Navigation
			game.btnsUI.btn1.buttonMode = true;
			game.btnsUI.btn1.mouseChildren = false;
			game.btnsUI.btn1.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.btnsUI.btn1); });
			game.btnsUI.btn1.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.btnsUI.btn1); });
			game.btnsUI.btn1.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.btnsUI.btn1); });

			game.btnsUI.btn2.buttonMode = true;
			game.btnsUI.btn2.mouseChildren = false;
			game.btnsUI.btn2.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.btnsUI.btn2); });
			game.btnsUI.btn2.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.btnsUI.btn2); });
			game.btnsUI.btn2.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.btnsUI.btn2); });

			game.btnsUI.btn3.buttonMode = true;
			game.btnsUI.btn3.mouseChildren = false;
			game.btnsUI.btn3.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.btnsUI.btn3); });
			game.btnsUI.btn3.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.btnsUI.btn3); });
			game.btnsUI.btn3.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.btnsUI.btn3); });

			game.btnsUI.btn4.buttonMode = true;
			game.btnsUI.btn4.mouseChildren = false;
			game.btnsUI.btn4.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.btnsUI.btn4); });
			game.btnsUI.btn4.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.btnsUI.btn4); });
			game.btnsUI.btn4.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.btnsUI.btn4); });

			game.btnsUI.btn5.buttonMode = true;
			game.btnsUI.btn5.mouseChildren = false;
			game.btnsUI.btn5.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.btnsUI.btn5); });
			game.btnsUI.btn5.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.btnsUI.btn5); });
			game.btnsUI.btn5.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.btnsUI.btn5); });

			game.btnsUI.btn6.buttonMode = true;
			game.btnsUI.btn6.mouseChildren = false;
			game.btnsUI.btn6.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.btnsUI.btn6); });
			game.btnsUI.btn6.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.btnsUI.btn6); });
			game.btnsUI.btn6.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.btnsUI.btn6); });

			game.btnsUI.btn7.buttonMode = true;
			game.btnsUI.btn7.mouseChildren = false;
			game.btnsUI.btn7.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.btnsUI.btn7); });
			game.btnsUI.btn7.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.btnsUI.btn7); });
			game.btnsUI.btn7.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.btnsUI.btn7); });

			game.btnsUI.btn8.buttonMode = true;
			game.btnsUI.btn8.mouseChildren = false;
			game.btnsUI.btn8.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.btnsUI.btn8); });
			game.btnsUI.btn8.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.btnsUI.btn8); });
			game.btnsUI.btn8.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.btnsUI.btn8); });

			game.btnsUI.btn9.buttonMode = true;
			game.btnsUI.btn9.mouseChildren = false;
			game.btnsUI.btn9.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.btnsUI.btn9); });
			game.btnsUI.btn9.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.btnsUI.btn9); });
			game.btnsUI.btn9.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.btnsUI.btn9); });

			game.btnsUI.upBtn.buttonMode = true;
			game.btnsUI.upBtn.mouseChildren = false;
			game.btnsUI.upBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.btnsUI.upBtn); });
			game.btnsUI.upBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.btnsUI.upBtn); });
			game.btnsUI.upBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.btnsUI.upBtn); });

			game.btnsUI.downBtn.buttonMode = true;
			game.btnsUI.downBtn.mouseChildren = false;
			game.btnsUI.downBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.btnsUI.downBtn); });
			game.btnsUI.downBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.btnsUI.downBtn); });
			game.btnsUI.downBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.btnsUI.downBtn); });
			
			//Combat
			game.combatUI.attackBtn.buttonMode = true;
			game.combatUI.attackBtn.mouseChildren = false;
			game.combatUI.attackBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.combatUI.attackBtn); });
			game.combatUI.attackBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.combatUI.attackBtn); });
			game.combatUI.attackBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.combatUI.attackBtn); });

			game.combatUI.inventoryBtn.buttonMode = true;
			game.combatUI.inventoryBtn.mouseChildren = false;
			game.combatUI.inventoryBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.combatUI.inventoryBtn); });
			game.combatUI.inventoryBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.combatUI.inventoryBtn); });
			game.combatUI.inventoryBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.combatUI.inventoryBtn); });

			game.combatUI.skillsBtn.buttonMode = true;
			game.combatUI.skillsBtn.mouseChildren = false;
			game.combatUI.skillsBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.combatUI.skillsBtn); });
			game.combatUI.skillsBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.combatUI.skillsBtn); });
			game.combatUI.skillsBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.combatUI.skillsBtn); });

			game.combatUI.runBtn.buttonMode = true;
			game.combatUI.runBtn.mouseChildren = false;
			game.combatUI.runBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.combatUI.runBtn); });
			game.combatUI.runBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.combatUI.runBtn); });
			game.combatUI.runBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.combatUI.runBtn); } );
			
			game.combatUI.devourBtn.buttonMode = true;
			game.combatUI.devourBtn.mouseChildren = false;
			game.combatUI.devourBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.combatUI.devourBtn); });
			game.combatUI.devourBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.combatUI.devourBtn); });
			game.combatUI.devourBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.combatUI.devourBtn); });

			game.combatUI.surrenderBtn.buttonMode = true;
			game.combatUI.surrenderBtn.mouseChildren = false;
			game.combatUI.surrenderBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.combatUI.surrenderBtn); });
			game.combatUI.surrenderBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.combatUI.surrenderBtn); });
			game.combatUI.surrenderBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.combatUI.surrenderBtn); });
			
			//Level up
			game.lvlupUI.strBtn.buttonMode = true;
			game.lvlupUI.strBtn.mouseChildren = false;
			game.lvlupUI.strBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.lvlupUI.strBtn); });
			game.lvlupUI.strBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.lvlupUI.strBtn); });
			game.lvlupUI.strBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.lvlupUI.strBtn); } );
			
			game.lvlupUI.agiBtn.buttonMode = true;
			game.lvlupUI.agiBtn.mouseChildren = false;
			game.lvlupUI.agiBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.lvlupUI.agiBtn); });
			game.lvlupUI.agiBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.lvlupUI.agiBtn); });
			game.lvlupUI.agiBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.lvlupUI.agiBtn); } );
			
			game.lvlupUI.vitBtn.buttonMode = true;
			game.lvlupUI.vitBtn.mouseChildren = false;
			game.lvlupUI.vitBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.lvlupUI.vitBtn); });
			game.lvlupUI.vitBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.lvlupUI.vitBtn); });
			game.lvlupUI.vitBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.lvlupUI.vitBtn); } );
			
			game.lvlupUI.intBtn.buttonMode = true;
			game.lvlupUI.intBtn.mouseChildren = false;
			game.lvlupUI.intBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.lvlupUI.intBtn); });
			game.lvlupUI.intBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.lvlupUI.intBtn); });
			game.lvlupUI.intBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.lvlupUI.intBtn); } );
			
			game.lvlupUI.dexBtn.buttonMode = true;
			game.lvlupUI.dexBtn.mouseChildren = false;
			game.lvlupUI.dexBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.lvlupUI.dexBtn); });
			game.lvlupUI.dexBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.lvlupUI.dexBtn); });
			game.lvlupUI.dexBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.lvlupUI.dexBtn); } );
			
			game.lvlupUI.vorBtn.buttonMode = true;
			game.lvlupUI.vorBtn.mouseChildren = false;
			game.lvlupUI.vorBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.lvlupUI.vorBtn); });
			game.lvlupUI.vorBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.lvlupUI.vorBtn); });
			game.lvlupUI.vorBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.lvlupUI.vorBtn); });
			
			//Listeners
			game.mainUI.textField.addEventListener(TextEvent.LINK, linkClicked);
			game.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyReleased);
			
			game.optionsBtn.addEventListener(MouseEvent.CLICK, clickOptions);
			game.menuUI.appearanceBtn.addEventListener(MouseEvent.CLICK, clickAppearance);
			game.menuUI.inventoryBtn.addEventListener(MouseEvent.CLICK, clickInventory);
			game.menuUI.skillsBtn.addEventListener(MouseEvent.CLICK, clickSkills);
			game.menuUI.questsBtn.addEventListener(MouseEvent.CLICK, clickQuests);
			game.mainUI.zoneBtn.addEventListener(MouseEvent.CLICK, clickMap);
			game.menuUI.saveBtn.addEventListener(MouseEvent.CLICK, clickSave);
			game.menuUI.loadBtn.addEventListener(MouseEvent.CLICK, clickLoad);
			game.btnsUI.upBtn.addEventListener(MouseEvent.CLICK, clickUpBtn);
			game.btnsUI.downBtn.addEventListener(MouseEvent.CLICK, clickDownBtn);
			
			game.btnsUI.btn1.addEventListener(MouseEvent.CLICK, clickNW);
			game.btnsUI.btn2.addEventListener(MouseEvent.CLICK, clickN);
			game.btnsUI.btn3.addEventListener(MouseEvent.CLICK, clickNE);
			game.btnsUI.btn4.addEventListener(MouseEvent.CLICK, clickW);
			game.btnsUI.btn5.addEventListener(MouseEvent.CLICK, clickCenter);
			game.btnsUI.btn6.addEventListener(MouseEvent.CLICK, clickE);
			game.btnsUI.btn7.addEventListener(MouseEvent.CLICK, clickSW);
			game.btnsUI.btn8.addEventListener(MouseEvent.CLICK, clickS);
			game.btnsUI.btn9.addEventListener(MouseEvent.CLICK, clickSE);
			
			game.combatUI.attackBtn.addEventListener(MouseEvent.CLICK, combatAttack);
			game.combatUI.inventoryBtn.addEventListener(MouseEvent.CLICK, combatInventory);
			game.combatUI.skillsBtn.addEventListener(MouseEvent.CLICK, combatSkills);
			game.combatUI.runBtn.addEventListener(MouseEvent.CLICK, combatRun);
			game.combatUI.devourBtn.addEventListener(MouseEvent.CLICK, combatDevour);
			game.combatUI.surrenderBtn.addEventListener(MouseEvent.CLICK, combatSurrender);
			
			game.lvlupUI.strBtn.addEventListener(MouseEvent.CLICK, incStat("str"));
			game.lvlupUI.agiBtn.addEventListener(MouseEvent.CLICK, incStat("agi"));
			game.lvlupUI.vitBtn.addEventListener(MouseEvent.CLICK, incStat("vit"));
			game.lvlupUI.intBtn.addEventListener(MouseEvent.CLICK, incStat("int"));
			game.lvlupUI.dexBtn.addEventListener(MouseEvent.CLICK, incStat("dex"));
			game.lvlupUI.vorBtn.addEventListener(MouseEvent.CLICK, incStat("vor"));
			
			// now allow Main to finish initalizing
			if (!main.mainMC)
				main.mainMC = this;
			main.firstInit();
		}

		public function down(btn:MovieClip):void {
			btn.scaleX = 0.9;
			btn.scaleY = 0.9;
		}

		public function up(btn:MovieClip):void {
			btn.scaleX = 1;
			btn.scaleY = 1;
		}

		public function hideBtnArray():void {
			for each (var btn:MovieClip in btnArray)
					btn.visible = false;
		}

		//{ Update functions
		public function update():void {
			updateMenuBtns();
			updateNavBtns();
			updateMaps();
			
			var enemy:Enemy = checkEnemy();
			if (enemy != null) {
				main.startCombat(enemy);
			} else {
				/*if (main.player.resources["currCapacity"] <= 0) {
					main.addResource("Health", -0.05 * main.player.resources["maxHealth"], 0);
					if (main.player.resources["currHealth"] <= 0)
						main.gameOver(2);
				}*/
				if (main.player.resources["currCapacity"] > main.player.resources["maxCapacity"]) {
					var overflow:int = main.player.resources["currCapacity"] - main.player.resources["maxCapacity"];
					main.addResource("Capacity", 0, 0.5 * overflow);
					main.addText("Clutching your aching, grossly swollen gut, it's blatantly obvious that you've been overindulging your appetite, literally playing Iroshan Roulette with your stomach. With a worried groan accompanied by quick short pants, you're caught off guard by the fact that you can't quite decide whether or not you like this oddly enjoyable sensation. The burning pain of your belly's innards stretching to accommodate the boulder-like mass contained within is, deep down, thoroughly satisfying.");
				}
				
				var capDrained:int;
				if (main.player.stats["vit"] <= 0.8 * main.player.resources["maxCapacity"])
					capDrained = Math.round(0.03 * (main.player.resources["maxCapacity"] - main.player.stats["vit"]));
				else
					capDrained = Math.round(0.01 * main.player.resources["maxCapacity"]);
				
				if (capDrained > main.player.resources["currCapacity"]) {
					capDrained = main.player.resources["currCapacity"];
					main.setResource("Capacity", 0, -1);
				} else
					main.addResource("Capacity", -capDrained, 0);
				
				main.addFat(0.1 * capDrained);
			}
			
			
			//main.updateStats();
			updateQuests();
		}

		public function checkBounds(x:int, y:int):Boolean {
			if (x < 0 || x > World.rows - 1 || y < 0 || y > World.cols - 1) {
				//main.addText("Edge of the world.");
				return false;
			} else if (World.world[x][y].name == "Wall") {
				//main.addText("You can't go there");
				return false;
			} else {
				return true;
			}
		}

		public function updateQuests():void {
			var existingEvent:Boolean = false;
			var currLoc:Zone = World.world[main.player.x][main.player.y];
			
			for each (var quest:GameEvent in main.player.quests) {
				existingEvent = quest.setDialog(quest.state);
			}
			
			if (!existingEvent && currLoc.events != null) {
				for each (var event:Array in currLoc.events) {
					/*if (EventDefinitions.definitions[event[0]].available && Math.random() < event[1])
						EventDefinitions.startEvent(event[0]);*/
					trace(event[0] in main.player.eventRecord);
					if ((!(event[0] in main.player.eventRecord) || main.player.eventRecord[event[0]] == true) && Math.random() < event[1])
						var exec:GameEvent = new GameEvent(main, main.player, event[0]);
				}
			}
		}
		
		public function checkEnemy():Enemy {
			var ret:Enemy = null;
			var enemies:Array = World.world[main.player.x][main.player.y].enemies;
			
			if (enemies != null) {
				var possibleEnemites:Array = [];
				var probs:Array = [];
				for each (var enemy:Array in enemies) {
					var prob:Number = Math.random();
					if (prob < enemy[1]) {
						enemy[1] = prob;
						possibleEnemites.push(EnemyDefinitions.getEnemy(enemy[0]));
						probs.push(prob);
					}
				}
				
				var min:Number = Math.min.apply(null, probs);
				var minIndex:int = probs.indexOf(min);
				ret = possibleEnemites[minIndex];
			}
			
			return ret;
		}

		public function updateMenuBtns():void {
			//trace("state = " + state);
			game.optionsBtn.visible = true;
			game.menuUI.visible = true;
			game.menuUI.appearanceBtn.visible = true;
			game.menuUI.inventoryBtn.visible = true;
			game.menuUI.skillsBtn.visible = true;
			game.menuUI.questsBtn.visible = true;
			game.menuUI.saveBtn.visible = true;
			game.menuUI.loadBtn.visible = true;
			
			switch (state) {
				case "navigate" :
					if (World.world[main.player.x][main.player.y].save) {
						game.menuUI.saveBtn.visible = true;
						game.menuUI.loadBtn.visible = true;
					} else {
						game.menuUI.saveBtn.visible = false;
						game.menuUI.loadBtn.visible = true;
					}
					game.menuUI.loadBtn.btnText.text = "Load";
					break;
				case "options" :
					game.menuUI.appearanceBtn.visible = false;
					game.menuUI.inventoryBtn.visible = false;
					game.menuUI.skillsBtn.visible = false;
					game.menuUI.questsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = true;
					game.menuUI.loadBtn.btnText.text = "Back";
					break;
				case "inventory" :
					game.optionsBtn.visible = false;
					game.menuUI.appearanceBtn.visible = false;
					game.menuUI.skillsBtn.visible = false;
					game.menuUI.questsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = true;
					game.menuUI.loadBtn.btnText.text = "Back";
					break;
				case "appearance" :
					game.optionsBtn.visible = false;
					game.menuUI.inventoryBtn.visible = false;
					game.menuUI.skillsBtn.visible = false;
					game.menuUI.questsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = true;
					game.menuUI.loadBtn.btnText.text = "Back";
					break;
				case "skills" :
					game.optionsBtn.visible = false;
					game.menuUI.appearanceBtn.visible = false;
					game.menuUI.inventoryBtn.visible = false;
					game.menuUI.questsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = true;
					game.menuUI.loadBtn.btnText.text = "Back";
					break;
				case "quests" :
					game.optionsBtn.visible = false;
					game.menuUI.appearanceBtn.visible = false;
					game.menuUI.inventoryBtn.visible = false;
					game.menuUI.skillsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = true;
					game.menuUI.loadBtn.btnText.text = "Back";
					break;
				case "shop" :
				case "buying" :
				case "selling" :
					game.optionsBtn.visible = false;
					game.menuUI.appearanceBtn.visible = false;
					game.menuUI.inventoryBtn.visible = false;
					game.menuUI.questsBtn.visible = false;
					game.menuUI.skillsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = true;
					game.menuUI.loadBtn.btnText.text = "Back";
					break;
				case "map" :
					game.optionsBtn.visible = false;
					game.menuUI.appearanceBtn.visible = false;
					game.menuUI.inventoryBtn.visible = false;
					game.menuUI.skillsBtn.visible = false;
					game.menuUI.questsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = false;
					break;
				case "combat" :
					game.optionsBtn.visible = false;
					game.menuUI.appearanceBtn.visible = false;
					game.menuUI.inventoryBtn.visible = false;
					game.menuUI.skillsBtn.visible = false;
					game.menuUI.questsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = false;
					break;
				case "combatInventory" :
				case "combatSkills" :
					game.optionsBtn.visible = false;
					game.menuUI.appearanceBtn.visible = false;
					game.menuUI.inventoryBtn.visible = false;
					game.menuUI.skillsBtn.visible = false;
					game.menuUI.questsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = true;
					game.menuUI.loadBtn.btnText.text = "Back";
					break;
				case "gameover" :
					game.combatUI.attackBtn.visible = false;
					game.combatUI.inventoryBtn.visible = false;
					game.combatUI.skillsBtn.visible = false;
					game.combatUI.runBtn.visible = false;
					game.combatUI.devourBtn.visible = false;
					game.combatUI.surrenderBtn.visible = false;
					game.optionsBtn.visible = false;
					game.menuUI.visible = true;
					game.menuUI.appearanceBtn.visible = false;
					game.menuUI.inventoryBtn.visible = false;
					game.menuUI.skillsBtn.visible = false;
					game.menuUI.questsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = true;
					game.menuUI.loadBtn.btnText.text = "Load";
					break;
				default :
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = false;
					break;
			}
		}

		public function updateNavBtns():void {
			var x:int = main.player.x;
			var y:int = main.player.y;
			
			game.btnsUI.btn5.visible = false;
			game.mainUI.zoneBtn.zoneName.text = World.world[main.player.x][main.player.y].name;
			
			if (!checkBounds(main.player.x - 1, main.player.y - 1) ||
					World.world[main.player.x - 1][main.player.y - 1] == null) {
				game.btnsUI.btn1.visible = false;
			} else {
				game.btnsUI.btn1.visible = true;
				game.btnsUI.btn1.btnText.text = World.world[main.player.x - 1][main.player.y - 1].name;
			}
			
			if (!checkBounds(main.player.x, main.player.y - 1) ||
					World.world[main.player.x][main.player.y - 1] == null) {
				game.btnsUI.btn2.visible = false;
			} else {
				game.btnsUI.btn2.visible = true;
				game.btnsUI.btn2.btnText.text = World.world[x][y - 1].name;
			}
			
			if (!checkBounds(main.player.x + 1, main.player.y - 1) ||
					World.world[main.player.x + 1][main.player.y - 1] == null) {
				game.btnsUI.btn3.visible = false;
			} else {
				game.btnsUI.btn3.visible = true;
				game.btnsUI.btn3.btnText.text = World.world[main.player.x + 1][main.player.y - 1].name;
			}
			
			if (!checkBounds(main.player.x - 1, main.player.y) ||
					World.world[main.player.x - 1][main.player.y] == null) {
				game.btnsUI.btn4.visible = false;
			} else {
				game.btnsUI.btn4.visible = true;
				game.btnsUI.btn4.btnText.text = World.world[main.player.x - 1][main.player.y].name;
			}
			
			if (World.world[main.player.x][main.player.y].enter) {
				game.btnsUI.btn5.visible = true;
				game.btnsUI.btn5.btnText.text = "Enter";
			}
			
			if (!checkBounds(main.player.x + 1, main.player.y) ||
					World.world[main.player.x + 1][main.player.y] == null) {
				game.btnsUI.btn6.visible = false;
			} else {
				game.btnsUI.btn6.visible = true;
				game.btnsUI.btn6.btnText.text = World.world[main.player.x + 1][main.player.y].name;
			}
			
			if (!checkBounds(main.player.x - 1, main.player.y + 1) ||
					World.world[main.player.x - 1][main.player.y + 1] == null) {
				game.btnsUI.btn7.visible = false;
			} else {
				game.btnsUI.btn7.visible = true;
				game.btnsUI.btn7.btnText.text = World.world[main.player.x - 1][main.player.y + 1].name;
			}
			
			if (!checkBounds(main.player.x, main.player.y + 1) ||
					World.world[main.player.x][main.player.y + 1] == null) {
				game.btnsUI.btn8.visible = false;
			} else {
				game.btnsUI.btn8.visible = true;
				game.btnsUI.btn8.btnText.text = World.world[main.player.x][main.player.y + 1].name;
			}
			
			if (!checkBounds(main.player.x + 1, main.player.y + 1) ||
					World.world[main.player.x + 1][main.player.y + 1] == null) {
				game.btnsUI.btn9.visible = false;
			} else {
				game.btnsUI.btn9.visible = true;
				game.btnsUI.btn9.btnText.text = World.world[main.player.x + 1][main.player.y + 1].name;
			}
		}

		public function updateMaps():void {
			game.mainUI.miniMap.x = 350 + 70 - 35 * main.player.x;
			game.mainUI.miniMap.y = 70 - 35 * main.player.y;
			
			game.mainUI.bigMarker.x = 552 + 62 * main.player.x;
			game.mainUI.bigMarker.y = 62 * main.player.y;
		}
		//}
		
		//{ Keyboard handlers
		public function keyReleased(e:KeyboardEvent):void {
			//{ Menus
			if (e.keyCode == Keyboard.ESCAPE && game.optionsBtn.visible)
				openOptions();
			else if (e.keyCode == Keyboard.U && game.menuUI.visible && game.menuUI.appearanceBtn.visible)
				openAppearance();
			else if (e.keyCode == Keyboard.I && game.menuUI.visible && game.menuUI.inventoryBtn.visible)
				openInventory();
			else if (e.keyCode == Keyboard.J && game.menuUI.visible && game.menuUI.questsBtn.visible)
				openQuests();
			else if (e.keyCode == Keyboard.K && game.menuUI.visible && game.menuUI.skillsBtn.visible)
				openSkills();
			else if (e.keyCode == Keyboard.M && game.menuUI.visible && game.mainUI.zoneBtn.visible)
				toggleMap();
			else if (e.keyCode == Keyboard.BACKSPACE && game.menuUI.loadBtn.visible && game.menuUI.loadBtn.btnText.text == "Back") {
				switch (state) {
					case "gameover" :
					case "navigate" :
						main.loadGame();
						break;
					case "options" :
						openOptions();
						break;
					case "appearance" :
						if (menuItemSelected)
							menuConfirm(selectedItem, -1);
						else
							openAppearance();
						break;
					case "inventory" :
					case "combatInventory" :
						if (menuItemSelected)
							menuConfirm(selectedItem, -1);
						else
							openInventory();
						break;
					case "skills" :
					case "combatSkills" :
						openSkills();
						break;
					case "quests" :
						openQuests();
						break;
					case "shop" :
					case "buying" :
					case "selling" :
						menuConfirm(selectedItem, -1);
						//game.btnsUI.upBtn.visible = false;
						//game.btnsUI.downBtn.visible = false;
						scrollIndex = 0;
						break;
				}
			}
			
			else if (e.keyCode == Keyboard.PAGE_UP && game.btnsUI.upBtn.visible) {
				switch (state) {
					default :
						scrollUp();
						break;
				}
			}
			else if (e.keyCode == Keyboard.PAGE_DOWN && game.btnsUI.downBtn.visible) {
				switch (state) {
					default :
						scrollDown();
						break;
				}
			}
			//}
			
			//{ Movement
			else if (game.btnsUI.btn1.visible && e.keyCode == Keyboard.NUMPAD_7) {
				switch (state) {
					case "navigate"	:
						if (World.world[main.player.x - 1][main.player.y - 1] != null)
							moveNW();
						break;
					case "appearance" :
						if (menuItemSelected)
							menuConfirm(selectedItem, 1);
						break;
					case "inventory" :
					case "combatInventory" :
					case "buying" :
					case "selling" :
						if (menuItemSelected)
							menuConfirm(selectedItem, 1);
						else
							menuSelect(0);
						break;
					case "shop" :
						displayBuying();
						break;
					case "dialog" :
						main.currEvent.setOption(0);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn2.visible && (e.keyCode == Keyboard.NUMPAD_8 || e.keyCode == Keyboard.UP || e.keyCode == Keyboard.W)) {
				switch (state) {
					case "navigate"	:
						if (World.world[main.player.x][main.player.y - 1] != null)
							moveN();
						break;
					case "appearance" :
					case "inventory" :
					case "combatInventory" :
					case "buying" :
					case "selling" :
						menuSelect(1);
						break;
					case "dialog" :
						main.currEvent.setOption(1);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn3.visible && e.keyCode == Keyboard.NUMPAD_9) {
				switch (state) {
					case "navigate"	:
						if (World.world[main.player.x + 1][main.player.y - 1] != null)
							moveNE();
						break;
					case "inventory" :
					case "combatInventory" :
					case "buying" :
					case "selling" :
						if (menuItemSelected)
							menuConfirm(selectedItem, 0);
						else
							menuSelect(2);
						break;
					case "shop" :
						displaySelling();
						break;
					case "dialog" :
						main.currEvent.setOption(2);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn4.visible && (e.keyCode == Keyboard.NUMPAD_4 || e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.A)) {
				switch (state) {
					case "navigate"	:
						if (World.world[main.player.x - 1][main.player.y] != null)
							moveW();
						break;
					case "appearance" :
					case "inventory" :
					case "combatInventory" :
					case "buying" :
					case "selling" :
						menuSelect(3);
						break;
					case "dialog" :
						main.currEvent.setOption(3);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn5.visible && (e.keyCode == Keyboard.NUMPAD_5 || e.keyCode == Keyboard.ENTER)) {
				switch (state) {
					case "navigate"	:
						moveCenter();
						break;
					case "appearance" :
					case "inventory" :
					case "combatInventory" :
					case "buying" :
					case "selling" :
						menuSelect(4);
						break;
					case "dialog" :
						main.currEvent.setOption(4);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn6.visible && (e.keyCode == Keyboard.NUMPAD_6 || e.keyCode == Keyboard.RIGHT || e.keyCode == Keyboard.D)) {
				switch (state) {
					case "navigate"	:
						if (World.world[main.player.x + 1][main.player.y] != null)
							moveE();
						break;
					case "appearance" :
					case "inventory" :
					case "combatInventory" :
					case "buying" :
					case "selling" :
						menuSelect(5);
						break;
					case "dialog" :
						main.currEvent.setOption(5);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn7.visible && e.keyCode == Keyboard.NUMPAD_1) {
				switch (state) {
					case "navigate"	:
						if (World.world[main.player.x - 1][main.player.y + 1] != null)
							moveSW();
						break;
					case "inventory" :
					case "combatInventory" :
					case "buying" :
					case "selling" :
						menuSelect(6);
						break;
					case "shop" :
						state = "navigate";
						updateNavBtns();
						break;
					case "dialog" :
						main.currEvent.setOption(6);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn8.visible && (e.keyCode == Keyboard.NUMPAD_2 || e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.S)) {
				switch (state) {
					case "navigate"	:
						if (World.world[main.player.x][main.player.y + 1] != null)
							moveS();
						break;
					case "appearance" :
					case "inventory" :
					case "combatInventory" :
					case "buying" :
					case "selling" :
						menuSelect(7);
						break;
					case "dialog" :
						main.currEvent.setOption(7);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn9.visible && e.keyCode == Keyboard.NUMPAD_3) {
				switch (state) {
					case "navigate"	:
						if (World.world[main.player.x + 1][main.player.y + 1] != null)
							moveSE();
						break;
					case "appearance" :
					case "inventory" :
					case "combatInventory" :
					case "buying" :
					case "selling" :
						menuSelect(8);
						break;
					case "combat" :
						hideCombat();
						break;
					case "dialog" :
						if (game.btnsUI.btn9.btnText.text == "Continue") {
							state = "navigate";
							updateNavBtns();
							updateMenuBtns();
							travel(main.player.x, main.player.y);
							if (main.player.statPoints > 0)
								game.lvlupUI.visible = true;
						} else {
							main.currEvent.setOption(8);
						}
						break;
					default	:
						break;
				}
			}
			//}
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}
		//}

		//{ Mouse handlers
		public function linkClicked(e:TextEvent):void {
			navigateToURL(new URLRequest(faURL + e.text), "_blank");
		}
		//{ Menus
		public function clickOptions(e:MouseEvent):void {
			openOptions();
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickAppearance(e:MouseEvent):void {
			openAppearance();
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickInventory(e:MouseEvent):void {
			openInventory();
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickSkills(e:MouseEvent):void {
			openSkills();
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickQuests(e:MouseEvent):void {
			openQuests();
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickSave(e:MouseEvent):void {
			//main.saveGame();
			main.addText("Saving and loading are disabled.");
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickLoad(e:MouseEvent):void {	//Make sure to change keyboard handler for backspace too
			switch (state) {
				case "gameover" :
				case "navigate" :
					//main.loadGame();
					main.addText("Saving and loading are disabled.");
					break;
				case "options" :
					openOptions();
					break;
				case "appearance" :
					if (menuItemSelected)
						menuConfirm(selectedItem, -1);
					else
						openAppearance();
					break;
				case "inventory" :
				case "combatInventory" :
					if (menuItemSelected)
						menuConfirm(selectedItem, -1);
					else
						openInventory();
					break;
				case "skills" :
				case "combatSkills" :
					openSkills();
					break;
				case "quests" :
					openQuests();
					break;
				case "shop" :
				case "buying" :
				case "selling" :
					menuConfirm(selectedItem, -1);
					scrollIndex = 0;
					break;
			}
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickMap(e:MouseEvent):void {
			toggleMap();
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickUpBtn(e:MouseEvent):void {
			scrollUp();
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			
		}

		public function clickDownBtn(e:MouseEvent):void {
			scrollDown();
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}
		
		public function combatAttack(e:MouseEvent):void {
			main.combat.turn("attack");
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}
		
		public function combatInventory(e:MouseEvent):void {
			openInventory();
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}
		
		public function combatSkills(e:MouseEvent):void {
			openSkills();
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}
		
		public function combatRun(e:MouseEvent):void {
			main.combat.turn("run");
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}
		
		public function combatDevour(e:MouseEvent):void {
			main.addText("To be implemented.");
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}
		
		public function combatSurrender(e:MouseEvent):void {
			main.combat.turn("surrender");
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}
		//}
		
		//{ Movement
		public function clickNW(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveNW();
					break;
				case "appearance" :
					if (menuItemSelected)
						menuConfirm(selectedItem, 1);
					break;
				case "inventory" :
				case "combatInventory" :
				case "buying" :
				case "selling" :
					if (menuItemSelected)
						menuConfirm(selectedItem, 1);
					else
						menuSelect(0);
					break;
				case "shop" :
					displayBuying();
					break;
				case "dialog" :
					main.currEvent.setOption(0);
					break;
				default :
					break;
			}
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickN(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveN();
					break;
				case "inventory" :
				case "combatInventory" :
				case "buying" :
				case "selling" :
					menuSelect(1);
					break;
				case "appearance" :
					menuSelect(1);
					break;
				case "dialog" :
					main.currEvent.setOption(1);
					break;
				default :
					break;
			}
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickNE(e:MouseEvent):void {
			trace("state = " + state);
			switch (state) {
				case "navigate" :
					moveNE();
					break;
				case "inventory" :
				case "combatInventory" :
				case "buying" :
				case "selling" :
					if (menuItemSelected)
						menuConfirm(selectedItem, 0);
					else
						menuSelect(2);
					break;
				case "shop" :
					displaySelling();
					break;
				case "dialog" :
					main.currEvent.setOption(2);
					break;
				default :
					break;
			}
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickW(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveW();
					break;
				case "inventory" :
				case "combatInventory" :
				case "buying" :
				case "selling" :
					menuSelect(3);
					break;
				case "appearance" :
					menuSelect(3);
					break;
				case "dialog" :
					main.currEvent.setOption(3);
					break;
				default :
					break;
			}
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickCenter(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveCenter();
					break;
				case "inventory" :
				case "combatInventory" :
				case "buying" :
				case "selling" :
					menuSelect(4);
					break;
				case "appearance" :
					menuSelect(4);
					break;
				case "dialog" :
					main.currEvent.setOption(4);
					break;
				default :
					break;
			}
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickE(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveE();
					break;
				case "inventory" :
				case "combatInventory" :
				case "buying" :
				case "selling" :
					menuSelect(5);
					break;
				case "appearance" :
					menuSelect(5);
					break;
				case "dialog" :
					main.currEvent.setOption(5);
					break;
				default :
					break;
			}
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickSW(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveSW();
					break;
				case "inventory" :
				case "combatInventory" :
				case "buying" :
				case "selling" :
					menuSelect(6);
					break;
				case "shop" :
					state = "navigate";
					updateNavBtns();
					break;
				case "dialog" :
					main.currEvent.setOption(6);
					break;
				default :
					break;
			}
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickS(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveS();
					break;
				case "inventory" :
				case "combatInventory" :
				case "buying" :
				case "selling" :
					menuSelect(7);
					break;
				case "appearance" :
					menuSelect(7);
					break;
				case "dialog" :
					main.currEvent.setOption(7);
					break;
				default :
					break;
			}
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}

		public function clickSE(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveSE();
					break;
				case "inventory" :
				case "combatInventory" :
				case "buying" :
				case "selling" :
					menuSelect(8);
					break;
				case "appearance" :
					menuSelect(8);
					break;
				case "combat" :
					hideCombat();
					break;
				case "dialog" :
					if (game.btnsUI.btn9.btnText.text == "Continue") {
						state = "navigate";
						updateNavBtns();
						updateMenuBtns();
						travel(main.player.x, main.player.y);
						if (main.player.statPoints > 0)
							game.lvlupUI.visible = true;
					} else {
						main.currEvent.setOption(7);
					}
					break;
				default :
					break;
			}
			
			trace("\natk = " + main.player.derivedStats["atk"]);
			trace("matk = " + main.player.derivedStats["matk"]);
			trace("def = " + main.player.derivedStats["def"]);
			trace("mdef = " + main.player.derivedStats["mdef"]);
			trace("acc = " + main.player.derivedStats["acc"]);
			trace("dodge = " + main.player.derivedStats["dodge"]);
			trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
			trace("state = " + state);
		}
		//}
		//}
		
		//{ Menu function
		public function scrollUp():void {
			scrollIndex--;
			menuIndex = scrollIndex * 9;
			btnIndex = 0;
			
			switch (state) {
				case "inventory" :
				case "combatInventory" :
					displayInventory();
					break;
				case "buying" :
					displayBuying();
					break;
				case "selling" :
					displaySelling();
					break;
				default :
					break;
			}
		}
		
		public function scrollDown():void {
			scrollIndex++;
			btnIndex = 0;
			
			switch (state) {
				case "inventory" :
				case "combatInventory" :
					displayInventory();
					break;
				case "buying" :
					displayBuying();
					break;
				case "selling" :
					displaySelling();
					break;
				default :
					break;
			}
		}
		
		public function displayInventory():void {
			main.setText(main.writeInventory());
			
			hideBtnArray();
			game.btnsUI.upBtn.visible = false;
			game.btnsUI.downBtn.visible = false;
			btnIndex = 0;
			menuIndex = scrollIndex * 9;
			for (var i:int = menuIndex; i < main.player.inventory.length && btnIndex < 9; i++) {
				btnArray[btnIndex].visible = true;
				btnArray[btnIndex].btnText.text = main.player.inventory[menuIndex].name;
				
				btnIndex++;
				menuIndex++;
			}
			
			if (scrollIndex > 0)
				game.btnsUI.upBtn.visible = true;
			if (main.player.inventory.length > (scrollIndex  + 1) * 9)
				game.btnsUI.downBtn.visible = true;
		}
		
		public function displayAppearance():void {
			main.setText(main.writeAppearance());
			hideBtnArray();
			
			if (main.player.equipment["head"] != null) {
				game.btnsUI.btn2.visible = true;
				game.btnsUI.btn2.btnText.text = main.player.equipment["head"].name;
			}
			if (main.player.equipment["torso"] != null) {
				game.btnsUI.btn5.visible = true;
				game.btnsUI.btn5.btnText.text = main.player.equipment["torso"].name;
			}
			if (main.player.equipment["legs"] != null) {
				game.btnsUI.btn8.visible = true;
				game.btnsUI.btn8.btnText.text = main.player.equipment["legs"].name;
			}
			if (main.player.equipment["feet"] != null) {
				game.btnsUI.btn9.visible = true;
				game.btnsUI.btn9.btnText.text = main.player.equipment["feet"].name;
			}
			if (main.player.equipment["weapon"] != null) {
				game.btnsUI.btn4.visible = true;
				game.btnsUI.btn4.btnText.text = main.player.equipment["weapon"].name;
				if (main.player.equipment["weapon"].twoHanded) {
					game.btnsUI.btn6.visible = true;
					game.btnsUI.btn6.btnText.text = main.player.equipment["weapon"].name;
				}
			}
			if (main.player.equipment["shield"] != null) {
				game.btnsUI.btn6.visible = true;
				game.btnsUI.btn6.btnText.text = main.player.equipment["shield"].name;
			}
		}
		
		public function openOptions():void {
			switch (state) {
				case "gameover" :
				case "map" :
					break;
				case "options" :
					state = "navigate";
					
					if (main.player.statPoints > 0)
						game.lvlupUI.visible = true;	
					game.optionsBtn.gotoAndStop(1);
					main.setText(main.mainText);
					updateMenuBtns();
					updateNavBtns();
					break;
				default :
					state = "options";
					
					game.lvlupUI.visible = false;
					game.menuUI.loadBtn.visible = false;
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					game.optionsBtn.gotoAndStop(2);
					game.menuUI.appearanceBtn.gotoAndStop(1);
					game.menuUI.inventoryBtn.gotoAndStop(1);
					game.menuUI.skillsBtn.gotoAndStop(1);
					game.menuUI.questsBtn.gotoAndStop(1);
					game.mainUI.textField.htmlText = main.optionsText;
					//main.setText(main.optionsText);
					hideBtnArray();
					updateMenuBtns();
					break;
			}
		}
		
		public function openAppearance():void {
			switch (state) {
				case "map" :
					break;
				case "appearance" :
					state = "navigate";
					
					if (main.player.statPoints > 0)
						game.lvlupUI.visible = true;
					game.menuUI.appearanceBtn.gotoAndStop(1);
					main.setText(main.mainText);
					updateMenuBtns();
					updateNavBtns();
					break;
				default :
					state = "appearance";
					
					game.lvlupUI.visible = false;
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					game.optionsBtn.gotoAndStop(1);
					game.menuUI.appearanceBtn.gotoAndStop(2);
					game.menuUI.inventoryBtn.gotoAndStop(1);
					game.menuUI.skillsBtn.gotoAndStop(1);
					game.menuUI.questsBtn.gotoAndStop(1);
					
					updateMenuBtns();
					main.setText(main.writeAppearance());
					displayAppearance();
					break;
			}
		}
		
		public function openInventory():void {
			switch (state) {
				case "map" :
					break;
				case "inventory" :
					state = "navigate";
					btnIndex = 0;
					menuIndex = 0;
					scrollIndex = 0;
					
					if (main.player.statPoints > 0)
						game.lvlupUI.visible = true;
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					game.menuUI.inventoryBtn.gotoAndStop(1);
					main.setText(main.mainText);
					updateMenuBtns();
					updateNavBtns();
					break;
				case "combat" :
					state = "combatInventory";
					
					game.combatUI.attackBtn.visible = false;
					game.combatUI.skillsBtn.visible = false;
					game.combatUI.runBtn.visible = false;
					game.combatUI.devourBtn.visible = false;
					game.combatUI.surrenderBtn.visible = false;
					game.combatUI.inventoryBtn.gotoAndStop(2);
					
					updateMenuBtns();
					btnIndex = 0;
					menuIndex = 0;
					scrollIndex = 0;
					displayInventory();
					break;
				case "combatInventory" :
					state = "combat";
					btnIndex = 0;
					menuIndex = 0;
					scrollIndex = 0;
					
					updateMenuBtns();
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					game.combatUI.attackBtn.visible = true;
					game.combatUI.inventoryBtn.visible = true;
					game.combatUI.skillsBtn.visible = true;
					game.combatUI.runBtn.visible = true;
					game.combatUI.devourBtn.visible = true;
					game.combatUI.surrenderBtn.visible = true;
					game.combatUI.inventoryBtn.gotoAndStop(1);
					hideBtnArray();
					
					main.setText(main.combatText);
					game.mainUI.scrollBar.scrollPosition = game.mainUI.scrollBar.maxScrollPosition;
					game.mainUI.scrollBar.update();
					break;
				default :
					state = "inventory";
					
					game.lvlupUI.visible = false;
					game.optionsBtn.gotoAndStop(1);
					game.menuUI.appearanceBtn.gotoAndStop(1);
					game.menuUI.inventoryBtn.gotoAndStop(2);
					game.menuUI.skillsBtn.gotoAndStop(1);
					game.menuUI.questsBtn.gotoAndStop(1);
					
					updateMenuBtns();
					btnIndex = 0;
					menuIndex = 0;
					scrollIndex = 0;
					displayInventory();
					break;
			}
		}
		
		public function openSkills():void {	//Needs to work like inventory
			switch (state) {
				case "map" :
					break;
				case "skills" :
					state = "navigate";
					
					if (main.player.statPoints > 0)
						game.lvlupUI.visible = true;
					game.menuUI.skillsBtn.gotoAndStop(1);
					updateMenuBtns();
					updateNavBtns();
					main.setText(main.mainText);
					break;
				case "combat" :
					state = "combatSkills";
					
					game.combatUI.attackBtn.visible = false;
					game.combatUI.inventoryBtn.visible = false;
					game.combatUI.runBtn.visible = false;
					game.combatUI.devourBtn.visible = false;
					game.combatUI.surrenderBtn.visible = false;
					game.combatUI.skillsBtn.gotoAndStop(2);
					
					updateMenuBtns();
					btnIndex = 0;
					menuIndex = 0;
					scrollIndex = 0;
					main.setText(main.skillsText);
					break;
				case "combatSkills" :
					state = "combat";
					btnIndex = 0;
					menuIndex = 0;
					scrollIndex = 0;
					
					updateMenuBtns();
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					game.combatUI.attackBtn.visible = true;
					game.combatUI.inventoryBtn.visible = true;
					game.combatUI.skillsBtn.visible = true;
					game.combatUI.runBtn.visible = true;
					game.combatUI.devourBtn.visible = true;
					game.combatUI.surrenderBtn.visible = true;
					game.combatUI.skillsBtn.gotoAndStop(1);
					hideBtnArray();
					
					main.setText(main.combatText);
					game.mainUI.scrollBar.scrollPosition = game.mainUI.scrollBar.maxScrollPosition;
					game.mainUI.scrollBar.update();
					break;
				default :
					state = "skills";
					
					game.lvlupUI.visible = false;
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					game.optionsBtn.gotoAndStop(1);
					game.menuUI.appearanceBtn.gotoAndStop(1);
					game.menuUI.inventoryBtn.gotoAndStop(1);
					game.menuUI.skillsBtn.gotoAndStop(2);
					game.menuUI.questsBtn.gotoAndStop(1);
					hideBtnArray();
					
					updateMenuBtns();
					main.setText(main.skillsText);
					break;
			}
		}
		
		public function openQuests():void {
			switch (state) {
				case "map" :
					break;
				case "quests" :
					state = "navigate";
					
					if (main.player.statPoints > 0)
						game.lvlupUI.visible = true;
					game.menuUI.questsBtn.gotoAndStop(1);
					updateMenuBtns();
					updateNavBtns();
					main.setText(main.mainText);
					break;
				default :
					state = "quests"
					
					game.lvlupUI.visible = false;
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					game.optionsBtn.gotoAndStop(1);
					game.menuUI.appearanceBtn.gotoAndStop(1);
					game.menuUI.inventoryBtn.gotoAndStop(1);
					game.menuUI.skillsBtn.gotoAndStop(1);
					game.menuUI.questsBtn.gotoAndStop(2);
					hideBtnArray();
					
					updateMenuBtns();
					main.setText(main.writeQuests());
					break;
			}
		}
		
		public function toggleMap():void {
			switch (state) {
				case "map" :
					state = "navigate"
					
					if (main.player.statPoints > 0)
						game.lvlupUI.visible = true;
					game.optionsBtn.visible = true;
					game.mainUI.bigMap.visible = false;
					game.mainUI.bigMarker.visible = false;
					game.mainUI.textField.visible = true;
					game.mainUI.scrollBar.visible = true;
					updateNavBtns();
					updateMenuBtns()
					break;
				case "navigate" :
					state = "map";
					
					game.lvlupUI.visible = false;
					game.optionsBtn.visible = false;
					game.mainUI.bigMap.visible = true;
					game.mainUI.bigMarker.visible = true;
					game.mainUI.textField.visible = false;
					game.mainUI.scrollBar.visible = false;
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					updateMenuBtns();
					hideBtnArray();
					break;
				default :
					break;
			}
		}
		
		public function menuSelect(x:int):void {
			var selection:String = btnArray[x].btnText.text;
			
			switch (state) {
				case "appearance" :
					menuItemSelected = true;
					selectedItem = main.player.getItemFromEquipment(selection);
					main.setText(selectedItem.toString("appearanceSelected"));
					//main.setText(selectedItem.name + "\n\n" + selectedItem.effectsText + "\n" + selectedItem.short + " " + selectedItem.long);
					
					hideBtnArray();
					game.btnsUI.btn1.visible = true;
					game.btnsUI.btn1.btnText.text = "Unequip";
					break;
				case "inventory" :
				case "combatInventory" :
					menuItemSelected = true;
					selectedItem = main.player.getItemFromInventory(ItemDefinitions.getItem(selection));
					main.setText(selectedItem.toString("inventorySelected"));
					/*main.setText(selectedItem.name + " -- " + selectedItem.count + "x\n\n" +
						selectedItem.effectsText + "\n" + selectedItem.short + " " + selectedItem.long);*/
					
					hideBtnArray();
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					game.btnsUI.btn1.visible = true;
					if (selectedItem.equip)
						game.btnsUI.btn1.btnText.text = "Equip";
					else
						game.btnsUI.btn1.btnText.text = "Use";
					game.btnsUI.btn3.visible = true;
					game.btnsUI.btn3.btnText.text = "Discard";
					break;
				case "buying" :
					menuItemSelected = true;
					selectedItem = ItemDefinitions.getItem(selection);
					if (main.player.indexOfInventory(selectedItem) != -1)
						selectedItem = main.player.getItemFromInventory(selectedItem);
					
					main.setText(selectedItem.toString("buyingSelected"));
					/*if (main.player.indexOfInventory(selectedItem) != -1) {
						main.setText(selectedItem.name + " -- " + selectedItem.value + " gold ea. -- " +
							main.player.getItemFromInventory(selectedItem).count + selectedItem.toString("buyingSelected"));
					} else {
						main.setText(selectedItem.name + " -- " + selectedItem.value + " gold ea. -- 0" +
							selectedItem.toString("buyingSelected"));
					}*/
					
					hideBtnArray();
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					game.btnsUI.btn1.visible = true;
					game.btnsUI.btn1.btnText.text = "Buy";
					break;
				case "selling" :
					menuItemSelected = true;
					selectedItem = main.player.getItemFromInventory(ItemDefinitions.getItem(selection));
					main.setText(selectedItem.toString("sellingSelected"));
					/*main.setText(selectedItem.name + " -- " + Math.round(0.5 * selectedItem.value) + " gold ea.\n\n" +
						selectedItem.effectsText + "\n" + selectedItem.short + " " + selectedItem.long);*/
					
					hideBtnArray();
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					game.btnsUI.btn1.visible = true;
					game.btnsUI.btn1.btnText.text = "Sell";
					break;
				default :
					break;
			}
			updateMenuBtns();
		}
		
		public function menuConfirm(object:Object, selection:int):void {
			switch (state) {
				case "appearance" :
					var equip:Item = object as Item;
				
					if (selection == 1) {
						main.unequip(equip);
					}
					
					menuItemSelected = false;
					displayAppearance();
					break;
				case "inventory" :
				case "combatInventory" :
					var item:Item = object as Item;
					
					if (selection == 0) {
						main.drop(item, 1);
						//displayInventory();
					} else if (selection == 1) {
						if (state == "inventory") {
							/*if (!main.useItem(item))
								return;
							displayInventory();*/
							main.useItem(item)
						} else {
							if (!main.combat.turn("inventory", item))
								return;
							openInventory();
						}
					} else if (selection == -1) {
						displayInventory();
						menuItemSelected = false;
					}
					//menuItemSelected = false;
					break;
				case "shop" :
					if (selection == -1) {
						state = "navigate";
						main.setText(main.mainText);
						updateMenuBtns();
						updateNavBtns();
						if (main.player.statPoints > 0)
							game.lvlupUI.visible = true;
					}
					break;
				case "buying" :
					var buy:Item = object as Item;
					
					if (selection == -1) {
						if (menuItemSelected) {
							menuItemSelected = false;
							displayBuying();
						} else {
							enterShop(World.world[main.player.x][main.player.y]);
						}
					} else {
						if (!main.buy(buy))
							main.addText("You don't have enough gold to buy that.");
					}
					break;
				case "selling" :
					var sell:Item = object as Item;
					
					if (selection == -1) {
						if (menuItemSelected) {
							menuItemSelected = false;
							displaySelling();
						} else {
							enterShop(World.world[main.player.x][main.player.y]);
						}
					} else {
						if (!main.sell(sell)) {
							if (!sell.canDrop)
								main.addText("You can't sell that.");
							else
								main.addText("You don't have any more to sell.");
						}
					}
					break;
				default :
					break;
			}
			updateMenuBtns();
		}
		//}
		
		//{ Navigation
		public function travel(x:int, y:int):void {
			//var oldX:int = main.player.x;
			//var oldY:int = main.player.y;
			
			main.player.x = x;
			main.player.y = y;
			updateMaps();
			
			if (state == "navigate") {
				main.mainText = "(" + main.player.x + ", " + main.player.y + ")\n" +
					World.world[main.player.x][main.player.y].name + "\n" +
					World.world[main.player.x][main.player.y].text;
				main.setText(main.mainText);
				updateMenuBtns();
				updateNavBtns();
			}
		}

		public function moveNW():void {
			main.player.x--;
			main.player.y--;
			
			main.mainText = "(" + main.player.x + ", " + main.player.y + ")\n" +
				World.world[main.player.x][main.player.y].name + "\n" +
				World.world[main.player.x][main.player.y].text;
			
			main.setText(main.mainText);
			update();
		}

		public function moveN():void {
			main.player.y--;

			main.mainText = "(" + main.player.x + ", " + main.player.y + ")\n" +
				World.world[main.player.x][main.player.y].name + "\n" +
				World.world[main.player.x][main.player.y].text;
			
			main.setText(main.mainText);
			update();
		}

		public function moveNE():void {
			main.player.x++;
			main.player.y--;
			
			main.mainText = "(" + main.player.x + ", " + main.player.y + ")\n" +
				World.world[main.player.x][main.player.y].name + "\n" +
				World.world[main.player.x][main.player.y].text;
			
			main.setText(main.mainText);
			update();
		}

		public function moveW():void {
			main.player.x--;

			main.mainText = "(" + main.player.x + ", " + main.player.y + ")\n" +
				World.world[main.player.x][main.player.y].name + "\n" +
				World.world[main.player.x][main.player.y].text;
			
			main.setText(main.mainText);
			update();
		}

		public function moveCenter():void {
			var zone:Zone = World.world[main.player.x][main.player.y];
			
			if (zone.items != null) {
				enterShop(zone);
			}
		}

		public function moveE():void {
			main.player.x++;

			main.mainText = "(" + main.player.x + ", " + main.player.y + ")\n" +
				World.world[main.player.x][main.player.y].name + "\n" +
				World.world[main.player.x][main.player.y].text;
			
			main.setText(main.mainText);
			update();
		}
		
		public function moveSW():void {
			main.player.x--;
			main.player.y++;
			
			main.mainText = "(" + main.player.x + ", " + main.player.y + ")\n" +
				World.world[main.player.x][main.player.y].name + "\n" +
				World.world[main.player.x][main.player.y].text;
			
			main.setText(main.mainText);
			update();
		}
		
		public function moveS():void {
			main.player.y++;
			
			main.mainText = "(" + main.player.x + ", " + main.player.y + ")\n" +
				World.world[main.player.x][main.player.y].name + "\n" +
				World.world[main.player.x][main.player.y].text;
			
			main.setText(main.mainText);
			update();
		}

		public function moveSE():void {
			main.player.x++;
			main.player.y++;
			
			main.mainText = "(" + main.player.x + ", " + main.player.y + ")\n" +
				World.world[main.player.x][main.player.y].name + "\n" +
				World.world[main.player.x][main.player.y].text;
			
			main.setText(main.mainText);
			update();
		}
		//}
		
		//{ Shop functions
		public function enterShop(zone:Zone):void {
			state = "shop";
			
			main.setText(main.mainText);
			updateMenuBtns();
			
			hideBtnArray();
			game.lvlupUI.visible = false;
			game.btnsUI.upBtn.visible = false;
			game.btnsUI.downBtn.visible = false;
			game.btnsUI.btn1.visible = true;
			game.btnsUI.btn1.btnText.text = "Buy";
			game.btnsUI.btn3.visible = true;
			game.btnsUI.btn3.btnText.text = "Sell";
		}

		public function displayBuying():void {
			state = "buying";
			
			var zone:Zone = World.world[main.player.x][main.player.y];
			main.setText(main.writeStock());
			
			hideBtnArray();
			game.btnsUI.upBtn.visible = false;
			game.btnsUI.downBtn.visible = false;
			btnIndex = 0;
			menuIndex = scrollIndex * 9;
			for (var i:int = menuIndex; i < zone.stock.length && btnIndex < 9; i++) {
				btnArray[btnIndex].visible = true;
				btnArray[btnIndex].btnText.text = zone.stock[menuIndex].name;
				
				btnIndex++;
				menuIndex++;
			}
			
			if (scrollIndex > 0)
				game.btnsUI.upBtn.visible = true;
			if (zone.stock.length > (scrollIndex  + 1) * 9)
				game.btnsUI.downBtn.visible = true;
		}

		public function displaySelling():void {
			state = "selling";
			
			displayInventory();
		}
		//}
		
		//{ Combat functions
		public function displayCombat(enemy:Enemy):void {
			state = "combat";
			hideBtnArray();
			game.optionsBtn.visible = false;
			game.lvlupUI.visible = false;
			game.combatUI.visible = true;
			game.combatUI.enemyLabel.visible = true;
			game.combatUI.healthLabel.visible = true;
			game.combatUI.healthBar.visible = true;
			game.combatUI.attackBtn.visible = true;
			game.combatUI.inventoryBtn.visible = true;
			game.combatUI.skillsBtn.visible = true;
			game.combatUI.runBtn.visible = true;
			game.combatUI.devourBtn.visible = true;
			game.combatUI.surrenderBtn.visible = true;
			updateMenuBtns();
			
			var name:String = enemy.name.charAt().toUpperCase() + enemy.name.substring(1);
			
			if (enemy.name.length <= 15)
				game.combatUI.enemyLabel.text = "\n" + name;
			else
				game.combatUI.enemyLabel.text = name;
			
			updateEnemyHealth();
		}
		
		public function hideCombat():void {
			state = "navigate";
			game.optionsBtn.visible = true;
			if (main.player.statPoints > 0)
				game.lvlupUI.visible = true;
			
			updateMenuBtns();
			updateNavBtns();
			main.setText(main.mainText);
		}
		
		public function updateEnemyHealth():void {
			var colorTF:ColorTransform = new ColorTransform();
			
			if (main.combat.enemy.currHP < 0)
				main.combat.enemy.currHP = 0;
			
			game.combatUI.healthLabel.text = main.combat.enemy.currHP + "/" + main.combat.enemy.maxHP;
			game.combatUI.healthBar.scaleX = main.combat.enemy.currHP / main.combat.enemy.maxHP;
			if (game.combatUI.healthBar.scaleX <= 0.25) {
				colorTF.color = 0xDD0000;
				game.combatUI.healthBar.transform.colorTransform = colorTF;
			} else {
				colorTF.color = 0x009900;
				game.combatUI.healthBar.transform.colorTransform = colorTF;
			}
		}
		//}
		
		public function incStat(stat:String):Function {
			return function(e:MouseEvent):void {
				main.addStat(stat, 1);
				main.player.statPoints--;
				game.lvlupUI.ptsLabel.text = main.player.statPoints;
				
				if (main.player.statPoints <= 0)
					game.lvlupUI.visible = false;
				
				trace("\natk = " + main.player.derivedStats["atk"]);
				trace("matk = " + main.player.derivedStats["matk"]);
				trace("def = " + main.player.derivedStats["def"]);
				trace("mdef = " + main.player.derivedStats["mdef"]);
				trace("acc = " + main.player.derivedStats["acc"]);
				trace("dodge = " + main.player.derivedStats["dodge"]);
				trace("cap = " + main.player.resources["currCapacity"] + " / " + main.player.resources["maxCapacity"] + " (" + main.player.derivedStats["cap"] + ")");
				trace("state = " + state);
			}
		}
	}
}