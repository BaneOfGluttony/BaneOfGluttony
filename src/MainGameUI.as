package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.TextEvent;
	import flash.geom.ColorTransform;
	import flash.net.navigateToURL;
	import flash.net.URLRequest;
	import flash.ui.Keyboard;
	import mx.utils.StringUtil;
	
	/**
	 * All of the code that was previously on the Timeline
	 * @author Kazan Fatzan, refactor by Serule Blue
	 */
	public class MainGameUI 
	{
		public static var game:MovieClip;		// MainGame.swc
		public static const DEBUG:Boolean = true;	//Show debug console
		public static const VERSION:String = "Build v0.8.1-11.10.15";
		
		public static var btnIndex:int = 0
		public static var scrollIndex:int = 0;
		public static var menuIndex:int = 0;

		public static var state:String = "navigate";

		public static var menuItemSelected:Boolean = false;
		public static var selectedItem:Item = null;

		public static var btnArray:Array;
		
		public static const faURL:String = "http://www.furaffinity.net/user/";
						
		public function MainGameUI() {
			game = new MainGame();
			
			game.addEventListener(Event.ADDED_TO_STAGE, init);
			Main.runner.addChild(game);
			
			game.versionText.text = VERSION;
			game.mainUI.debugConsole.visible = DEBUG;
			game.mainUI.debugScrollbar.visible = DEBUG;
		}
		
		private static function init(event:Event):void {
			game.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Main.runner.stage.showDefaultContextMenu = false;
			
			btnArray = new Array(game.btnsUI.btn1, game.btnsUI.btn2, game.btnsUI.btn3,
							     game.btnsUI.btn4, game.btnsUI.btn5, game.btnsUI.btn6,
								 game.btnsUI.btn7, game.btnsUI.btn8, game.btnsUI.btn9);
			
			game.lvlupUI.visible = false;
			game.mainUI.bigMap.visible = false;		
			game.mainUI.bigMarker.visible = false;	
			game.btnsUI.upBtn.visible = false;
			game.btnsUI.downBtn.visible = false;
			game.combatUI.visible = false;
			//game.mainUI.mc_loading.visible = false;
			
			updateMaps();
			
			game.optionsBtn.stop();
			game.menuUI.appearanceBtn.stop();
			game.menuUI.inventoryBtn.stop();
			game.menuUI.skillsBtn.stop();
			game.menuUI.questsBtn.stop();
			game.menuUI.restBtn.stop();

			game.combatUI.attackBtn.stop();
			game.combatUI.inventoryBtn.stop();
			game.combatUI.skillsBtn.stop();
			game.combatUI.runBtn.stop();
			game.combatUI.devourBtn.stop();
			game.combatUI.waitBtn.stop();
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
			game.menuUI.loadBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.menuUI.loadBtn); } );
			
			game.menuUI.restBtn.buttonMode = true;
			game.menuUI.restBtn.mouseChildren = false;
			game.menuUI.restBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.menuUI.restBtn); });
			game.menuUI.restBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.menuUI.restBtn); });
			game.menuUI.restBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.menuUI.restBtn); } );
			
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

			game.combatUI.waitBtn.buttonMode = true;
			game.combatUI.waitBtn.mouseChildren = false;
			game.combatUI.waitBtn.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(game.combatUI.waitBtn); });
			game.combatUI.waitBtn.addEventListener(MouseEvent.MOUSE_UP, function():void { up(game.combatUI.waitBtn); });
			game.combatUI.waitBtn.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(game.combatUI.waitBtn); });
			
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
			game.menuUI.restBtn.addEventListener(MouseEvent.CLICK, clickRest);
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
			game.combatUI.waitBtn.addEventListener(MouseEvent.CLICK, combatWait);
			game.combatUI.surrenderBtn.addEventListener(MouseEvent.CLICK, combatSurrender);
			
			game.lvlupUI.strBtn.addEventListener(MouseEvent.CLICK, incStat("str"));
			game.lvlupUI.agiBtn.addEventListener(MouseEvent.CLICK, incStat("agi"));
			game.lvlupUI.vitBtn.addEventListener(MouseEvent.CLICK, incStat("vit"));
			game.lvlupUI.intBtn.addEventListener(MouseEvent.CLICK, incStat("int"));
			game.lvlupUI.dexBtn.addEventListener(MouseEvent.CLICK, incStat("dex"));
			game.lvlupUI.vorBtn.addEventListener(MouseEvent.CLICK, incStat("vor"));
			
			// now allow Main to finish initalizing
			/*if (!Main.mainMC)
				Main.mainMC = this;*/
			Main.firstInit();
			//container.loadingScreen.visible = false;
		}

		public static function debugTrace():void {
			if (!DEBUG)
				return;
			
			trace("\n" + Clock.toString());
			trace("atk = " + Player.derivedStats["atk"]);
			trace("matk = " + Player.derivedStats["matk"]);
			trace("def = " + Player.derivedStats["def"]);
			trace("mdef = " + Player.derivedStats["mdef"]);
			trace("acc = " + Player.derivedStats["acc"]);
			trace("dodge = " + Player.derivedStats["dodge"]);
			trace("cap = " + Player.resources["currCapacity"] + " / " + Player.resources["maxCapacity"] + " (" + Player.derivedStats["cap"] + ")");
			trace("metabolism = " + Player.metabolism);
			trace("state = " + state);
			if (selectedItem != null)
				trace("selectedItem = " + selectedItem.name);
			else
				trace("selectedItem = null");
		}
		
		public static function down(btn:MovieClip):void {
			btn.scaleX = 0.9;
			btn.scaleY = 0.9;
		}

		public static function up(btn:MovieClip):void {
			btn.scaleX = 1;
			btn.scaleY = 1;
		}

		public static function hideBtnArray():void {
			for each (var btn:MovieClip in btnArray)
					btn.visible = false;
		}

		//{ Update functions
		public static function update():void {
			updateMenuBtns();
			updateNavBtns();
			updateMaps();
			World.updateLoadedRegion();
			
			var enemy:Enemy = checkEnemy();
			if (enemy != null) {
				Main.startCombat(enemy);
			} /*else {
				if (Player.resources["currCapacity"] <= 0) {
					Main.addResource("Health", -0.05 * Player.resources["maxHealth"], 0);
					if (Player.resources["currHealth"] <= 0)
						Main.gameOver(2);
				}*/
				
				/*if (Player.resources["currCapacity"] > Player.resources["maxCapacity"]) {
					var overflow:int = Player.resources["currCapacity"] - Player.resources["maxCapacity"];
					Main.addResource("Capacity", 0, 0.5 * overflow);
					Main.addText("Clutching onto your aching, grossly swollen gut, it's blatantly obvious that you've been overindulging your appetite, literally playing Iroshan Roulette with your stomach. With a worried groan accompanied by quick short pants, you're caught off guard by the fact that you can't quite decide whether or not you like this oddly enjoyable sensation. The burning pain of your belly's innards stretching to accommodate the boulder-like mass contained within is, deep down, thoroughly satisfying.");
				}
				
				var capDrained:int;
				if (Player.stats["vit"] <= 0.8 * Player.resources["maxCapacity"])
					capDrained = Math.round(0.03 * (Player.resources["maxCapacity"] - Player.stats["vit"]));
				else
					capDrained = Math.round(0.01 * Player.resources["maxCapacity"]);
				
				if (capDrained > Player.resources["currCapacity"]) {
					capDrained = Player.resources["currCapacity"];
					Main.setResource("Capacity", 0, -1);
				} else {
					Main.addResource("Capacity", -capDrained, 0);
				}
				
				Main.addFat(0.1 * capDrained);
			}*/
			
			
			//Main.updateStats();
			var event:String = updateQuests();
			if (event != null)
				new GameEvent(event);
		}

		public static function checkBounds(x:int, y:int):Boolean {
			if (x < 0 || x > World.rows - 1 || y < 0 || y > World.cols - 1 || World.world[x][y] == null)
				return false;
			else if (StringUtil.trim(World.world[x][y].name) == "Block" || StringUtil.trim(World.world[x][y].name) == "River")
				return false;
			else
				return true;
		}

		public static function updateQuests(modifier:Number = 1):String {
			var existingEvent:Boolean = false;
			var currLoc:Zone = World.world[Player.x][Player.y];
			
			for each (var quest:GameEvent in Player.quests) {
				if (quest.setDialog(quest.state)) {
					existingEvent = true;
					break;
				}
			}
			
			if (!existingEvent && currLoc.events.length > 0) {
				for each (var event:Array in currLoc.events) {
					//trace(event[0] in Player.eventRecord);
					if ((!(event[0] in Player.eventRecord) || Player.eventRecord[event[0]]) && Math.random() < event[1] * modifier) {
						//var exec:GameEvent = new GameEvent(event[0]);
						return event[0];
					}
				}
			}
			
			return null;
		}
		
		public static function checkEnemy(modifier:Number = 1):Enemy {
			var currLoc:Zone = World.world[Player.x][Player.y];
			
			if (currLoc.enemies.length > 0) {
				var possibleEnemies:Array = [];
				var probs:Array = [];
				for each (var enemy:Array in currLoc.enemies) {
					var enemyCopy:Array = [enemy[0], enemy[1]];
					var prob:Number = Math.random();
					if (prob < enemyCopy[1] * modifier) {
						enemyCopy[1] = prob;
						possibleEnemies.push(EnemyDefinitions.getEnemy(enemyCopy[0]));
						probs.push(prob);
					}
				}
				
				if (possibleEnemies.length > 0) {
					var min:Number = Math.min.apply(null, probs);
					var minIndex:int = probs.indexOf(min);
					return possibleEnemies[minIndex];
				}
			}
			
			return null;
		}

		public static function updateMenuBtns():void {
			//trace("state = " + state);
			game.optionsBtn.visible = true;
			game.menuUI.visible = true;
			game.menuUI.appearanceBtn.visible = true;
			game.menuUI.inventoryBtn.visible = true;
			game.menuUI.skillsBtn.visible = true;
			game.menuUI.questsBtn.visible = true;
			game.menuUI.saveBtn.visible = true;
			game.menuUI.loadBtn.visible = true;
			game.menuUI.restBtn.visible = true;
			
			switch (state) {
				case "navigate" :
					if (World.world[Player.x][Player.y].save) {
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
					game.menuUI.restBtn.visible = false;
					break;
				case "inventory" :
					game.optionsBtn.visible = false;
					game.menuUI.appearanceBtn.visible = false;
					game.menuUI.skillsBtn.visible = false;
					game.menuUI.questsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = true;
					game.menuUI.loadBtn.btnText.text = "Back";
					game.menuUI.restBtn.visible = false;
					break;
				case "appearance" :
					game.optionsBtn.visible = false;
					game.menuUI.inventoryBtn.visible = false;
					game.menuUI.skillsBtn.visible = false;
					game.menuUI.questsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = true;
					game.menuUI.loadBtn.btnText.text = "Back";
					game.menuUI.restBtn.visible = false;
					break;
				case "skills" :
					game.optionsBtn.visible = false;
					game.menuUI.appearanceBtn.visible = false;
					game.menuUI.inventoryBtn.visible = false;
					game.menuUI.questsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = true;
					game.menuUI.loadBtn.btnText.text = "Back";
					game.menuUI.restBtn.visible = false;
					break;
				case "quests" :
					game.optionsBtn.visible = false;
					game.menuUI.appearanceBtn.visible = false;
					game.menuUI.inventoryBtn.visible = false;
					game.menuUI.skillsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = true;
					game.menuUI.loadBtn.btnText.text = "Back";
					game.menuUI.restBtn.visible = false;
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
					game.menuUI.restBtn.visible = false;
					break;
				case "map" :
					game.optionsBtn.visible = false;
					game.menuUI.appearanceBtn.visible = false;
					game.menuUI.inventoryBtn.visible = false;
					game.menuUI.skillsBtn.visible = false;
					game.menuUI.questsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = false;
					game.menuUI.restBtn.visible = false;
					break;
				case "combat" :
					game.optionsBtn.visible = false;
					game.menuUI.appearanceBtn.visible = false;
					game.menuUI.inventoryBtn.visible = false;
					game.menuUI.skillsBtn.visible = false;
					game.menuUI.questsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = false;
					game.menuUI.restBtn.visible = false;
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
					game.menuUI.restBtn.visible = false;
					break;
				case "gameover" :
					game.combatUI.attackBtn.visible = false;
					game.combatUI.inventoryBtn.visible = false;
					game.combatUI.skillsBtn.visible = false;
					game.combatUI.runBtn.visible = false;
					game.combatUI.devourBtn.visible = false;
					game.combatUI.waitBtn.visible = false;
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
					game.menuUI.restBtn.visible = false;
					break;
				default :
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = false;
					break;
			}
		}

		public static function updateNavBtns():void {
			var x:int = Player.x;
			var y:int = Player.y;
			
			game.btnsUI.btn5.visible = false;
			game.mainUI.zoneBtn.zoneName.text = World.world[Player.x][Player.y].name;
			
			if (!checkBounds(Player.x - 1, Player.y - 1) ||
					World.world[Player.x - 1][Player.y - 1] == null) {
				game.btnsUI.btn1.visible = false;
			} else {
				game.btnsUI.btn1.visible = true;
				game.btnsUI.btn1.btnText.text = World.world[Player.x - 1][Player.y - 1].name;
			}
			
			if (!checkBounds(Player.x, Player.y - 1) ||
					World.world[Player.x][Player.y - 1] == null) {
				game.btnsUI.btn2.visible = false;
			} else {
				game.btnsUI.btn2.visible = true;
				game.btnsUI.btn2.btnText.text = World.world[x][y - 1].name;
			}
			
			if (!checkBounds(Player.x + 1, Player.y - 1) ||
					World.world[Player.x + 1][Player.y - 1] == null) {
				game.btnsUI.btn3.visible = false;
			} else {
				game.btnsUI.btn3.visible = true;
				game.btnsUI.btn3.btnText.text = World.world[Player.x + 1][Player.y - 1].name;
			}
			
			if (!checkBounds(Player.x - 1, Player.y) ||
					World.world[Player.x - 1][Player.y] == null) {
				game.btnsUI.btn4.visible = false;
			} else {
				game.btnsUI.btn4.visible = true;
				game.btnsUI.btn4.btnText.text = World.world[Player.x - 1][Player.y].name;
			}
			
			if (World.world[Player.x][Player.y].enter) {
				game.btnsUI.btn5.visible = true;
				game.btnsUI.btn5.btnText.text = "Enter";
			}
			
			if (!checkBounds(Player.x + 1, Player.y) ||
					World.world[Player.x + 1][Player.y] == null) {
				game.btnsUI.btn6.visible = false;
			} else {
				game.btnsUI.btn6.visible = true;
				game.btnsUI.btn6.btnText.text = World.world[Player.x + 1][Player.y].name;
			}
			
			if (!checkBounds(Player.x - 1, Player.y + 1) ||
					World.world[Player.x - 1][Player.y + 1] == null) {
				game.btnsUI.btn7.visible = false;
			} else {
				game.btnsUI.btn7.visible = true;
				game.btnsUI.btn7.btnText.text = World.world[Player.x - 1][Player.y + 1].name;
			}
			
			if (!checkBounds(Player.x, Player.y + 1) ||
					World.world[Player.x][Player.y + 1] == null) {
				game.btnsUI.btn8.visible = false;
			} else {
				game.btnsUI.btn8.visible = true;
				game.btnsUI.btn8.btnText.text = World.world[Player.x][Player.y + 1].name;
			}
			
			if (!checkBounds(Player.x + 1, Player.y + 1) ||
					World.world[Player.x + 1][Player.y + 1] == null) {
				game.btnsUI.btn9.visible = false;
			} else {
				game.btnsUI.btn9.visible = true;
				game.btnsUI.btn9.btnText.text = World.world[Player.x + 1][Player.y + 1].name;
			}
		}

		public static function updateMaps():void {
			game.mainUI.miniMap.x = 350 + 70 - 35 * (Player.x - 39);
			game.mainUI.miniMap.y = 70 - 35 * (Player.y - 40);
			
			game.mainUI.bigMarker.x = 675 + 12 * (Player.x - 39);
			game.mainUI.bigMarker.y = 10 + 12 * (Player.y - 40);
		}
		//}
		
		//{ Keyboard handlers
		public static function keyReleased(e:KeyboardEvent):void {
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
						Main.loadGame();
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
						if (World.world[Player.x - 1][Player.y - 1] != null)
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
						Main.currEvent.setOption(0);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn2.visible && (e.keyCode == Keyboard.NUMPAD_8 || e.keyCode == Keyboard.UP || e.keyCode == Keyboard.W)) {
				switch (state) {
					case "navigate"	:
						if (World.world[Player.x][Player.y - 1] != null)
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
						Main.currEvent.setOption(1);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn3.visible && e.keyCode == Keyboard.NUMPAD_9) {
				switch (state) {
					case "navigate"	:
						if (World.world[Player.x + 1][Player.y - 1] != null)
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
						Main.currEvent.setOption(2);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn4.visible && (e.keyCode == Keyboard.NUMPAD_4 || e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.A)) {
				switch (state) {
					case "navigate"	:
						if (World.world[Player.x - 1][Player.y] != null)
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
						Main.currEvent.setOption(3);
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
						Main.currEvent.setOption(4);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn6.visible && (e.keyCode == Keyboard.NUMPAD_6 || e.keyCode == Keyboard.RIGHT || e.keyCode == Keyboard.D)) {
				switch (state) {
					case "navigate"	:
						if (World.world[Player.x + 1][Player.y] != null)
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
						Main.currEvent.setOption(5);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn7.visible && e.keyCode == Keyboard.NUMPAD_1) {
				switch (state) {
					case "navigate"	:
						if (World.world[Player.x - 1][Player.y + 1] != null)
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
						Main.currEvent.setOption(6);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn8.visible && (e.keyCode == Keyboard.NUMPAD_2 || e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.S)) {
				switch (state) {
					case "navigate"	:
						if (World.world[Player.x][Player.y + 1] != null)
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
						Main.currEvent.setOption(7);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn9.visible && e.keyCode == Keyboard.NUMPAD_3) {
				switch (state) {
					case "navigate"	:
						if (World.world[Player.x + 1][Player.y + 1] != null)
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
						if (Main.currEvent.cont == "end") {
							state = "navigate";
							updateNavBtns();
							updateMenuBtns();
							travel(Player.x, Player.y);
							if (Player.statPoints > 0)
								game.lvlupUI.visible = true;
						} else if (Main.currEvent.cont == "prog") {
							Main.currEvent.setDialog(Main.currEvent.state);	//may be problematic
						} else {
							Main.currEvent.setOption(8);
						}
						break;
					default	:
						break;
				}
			}
			//}
			
			debugTrace();
		}
		//}

		//{ Mouse handlers
		public static function linkClicked(e:TextEvent):void {
			navigateToURL(new URLRequest(faURL + e.text), "_blank");
		}
		//{ Menus
		public static function clickOptions(e:MouseEvent):void {
			openOptions();
			debugTrace();
		}

		public static function clickAppearance(e:MouseEvent):void {
			openAppearance();
			debugTrace();
		}

		public static function clickInventory(e:MouseEvent):void {
			openInventory();
			debugTrace();
		}

		public static function clickSkills(e:MouseEvent):void {
			openSkills();
			debugTrace();
		}

		public static function clickQuests(e:MouseEvent):void {
			openQuests();
			debugTrace();
		}

		public static function clickSave(e:MouseEvent):void {
			Main.saveGame();
			//Main.addText("Saving and loading are disabled.");
			debugTrace();
		}

		public static function clickLoad(e:MouseEvent):void {	//Make sure to change keyboard handler for backspace too
			switch (state) {
				case "gameover" :
				case "navigate" :
					Main.loadGame();
					//Main.addText("Saving and loading are disabled.");
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
			debugTrace();
		}

		public static function clickRest(e:MouseEvent):void {
			Main.mainText = "(" + Player.x + ", " + Player.y + ")\n" +
				World.world[Player.x][Player.y].name + "\n" +
				World.world[Player.x][Player.y].text;
			Main.setText(Main.mainText);
			Main.rest();
			debugTrace();
		}
		
		public static function clickMap(e:MouseEvent):void {
			toggleMap();
			debugTrace();
		}

		public static function clickUpBtn(e:MouseEvent):void {
			scrollUp();
			debugTrace();
		}

		public static function clickDownBtn(e:MouseEvent):void {
			scrollDown();
			debugTrace();
		}
		
		public static function combatAttack(e:MouseEvent):void {
			Main.combat.turn("attack");
			debugTrace();
		}
		
		public static function combatInventory(e:MouseEvent):void {
			openInventory();
			debugTrace();
		}
		
		public static function combatSkills(e:MouseEvent):void {
			openSkills();
			debugTrace();
		}
		
		public static function combatRun(e:MouseEvent):void {
			Main.combat.turn("run");
			debugTrace();
		}
		
		public static function combatDevour(e:MouseEvent):void {
			Main.addText("To be implemented.");
			debugTrace();
		}
		
		public static function combatWait(e:MouseEvent):void {
			Main.combat.turn("wait");
			debugTrace();
		}
		
		public static function combatSurrender(e:MouseEvent):void {
			Main.combat.turn("surrender");
			debugTrace();
		}
		//}
		
		//{ Movement
		public static function clickNW(e:MouseEvent):void {
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
					Main.currEvent.setOption(0);
					break;
				default :
					break;
			}
			debugTrace();
		}

		public static function clickN(e:MouseEvent):void {
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
					Main.currEvent.setOption(1);
					break;
				default :
					break;
			}
			debugTrace();
		}

		public static function clickNE(e:MouseEvent):void {
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
					Main.currEvent.setOption(2);
					break;
				default :
					break;
			}
			debugTrace();
		}

		public static function clickW(e:MouseEvent):void {
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
					Main.currEvent.setOption(3);
					break;
				default :
					break;
			}
			debugTrace();
		}

		public static function clickCenter(e:MouseEvent):void {
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
					Main.currEvent.setOption(4);
					break;
				default :
					break;
			}
			debugTrace();
		}

		public static function clickE(e:MouseEvent):void {
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
					Main.currEvent.setOption(5);
					break;
				default :
					break;
			}
			debugTrace();
		}

		public static function clickSW(e:MouseEvent):void {
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
					Main.currEvent.setOption(6);
					break;
				default :
					break;
			}
			debugTrace();
		}

		public static function clickS(e:MouseEvent):void {
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
					Main.currEvent.setOption(7);
					break;
				default :
					break;
			}
			debugTrace();
		}

		public static function clickSE(e:MouseEvent):void {
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
					if (Main.currEvent.cont == "end") {
						state = "navigate";
						updateNavBtns();
						updateMenuBtns();
						travel(Player.x, Player.y);
						if (Player.statPoints > 0)
							game.lvlupUI.visible = true;
					} else if (Main.currEvent.cont == "prog") {
						Main.currEvent.setDialog(Main.currEvent.state);	//may be problematic
					} else {
						Main.currEvent.setOption(8);
					}
					break;
				default :
					break;
			}
			debugTrace();
		}
		//}
		//}
		
		//{ Menu function
		public static function scrollUp():void {
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
		
		public static function scrollDown():void {
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
		
		public static function displayInventory(scroll:Boolean = false):void {
			if (!scroll)
				Main.setText(Main.writeInventory());
			
			hideBtnArray();
			game.btnsUI.upBtn.visible = false;
			game.btnsUI.downBtn.visible = false;
			btnIndex = 0;
			menuIndex = scrollIndex * 9;
			for (var i:int = menuIndex; i < Player.inventory.length && btnIndex < 9; i++) {
				btnArray[btnIndex].visible = true;
				btnArray[btnIndex].btnText.text = Player.inventory[menuIndex].name;
				
				btnIndex++;
				menuIndex++;
			}
			
			if (scrollIndex > 0)
				game.btnsUI.upBtn.visible = true;
			if (Player.inventory.length > (scrollIndex  + 1) * 9)
				game.btnsUI.downBtn.visible = true;
		}
		
		public static function displayAppearance():void {
			Main.setText(Main.writeAppearance());
			hideBtnArray();
			
			if (Player.equipment["head"] != null) {
				game.btnsUI.btn2.visible = true;
				game.btnsUI.btn2.btnText.text = Player.equipment["head"].name;
			}
			if (Player.equipment["torso"] != null) {
				game.btnsUI.btn5.visible = true;
				game.btnsUI.btn5.btnText.text = Player.equipment["torso"].name;
			}
			if (Player.equipment["legs"] != null) {
				game.btnsUI.btn8.visible = true;
				game.btnsUI.btn8.btnText.text = Player.equipment["legs"].name;
			}
			if (Player.equipment["feet"] != null) {
				game.btnsUI.btn9.visible = true;
				game.btnsUI.btn9.btnText.text = Player.equipment["feet"].name;
			}
			if (Player.equipment["weapon"] != null) {
				game.btnsUI.btn4.visible = true;
				game.btnsUI.btn4.btnText.text = Player.equipment["weapon"].name;
				if (Player.equipment["weapon"].twoHanded) {
					game.btnsUI.btn6.visible = true;
					game.btnsUI.btn6.btnText.text = Player.equipment["weapon"].name;
				}
			}
			if (Player.equipment["shield"] != null) {
				game.btnsUI.btn6.visible = true;
				game.btnsUI.btn6.btnText.text = Player.equipment["shield"].name;
			}
		}
		
		public static function openOptions():void {
			switch (state) {
				case "gameover" :
				case "map" :
					break;
				case "options" :
					state = "navigate";
					
					if (Player.statPoints > 0)
						game.lvlupUI.visible = true;	
					game.optionsBtn.gotoAndStop(1);
					Main.setText(Main.mainText);
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
					game.mainUI.textField.htmlText = Main.optionsText;
					//Main.setText(Main.optionsText);
					hideBtnArray();
					updateMenuBtns();
					break;
			}
		}
		
		public static function openAppearance():void {
			switch (state) {
				case "map" :
					break;
				case "appearance" :
					state = "navigate";
					menuItemSelected = false;
					selectedItem = null;
					
					if (Player.statPoints > 0)
						game.lvlupUI.visible = true;
					game.menuUI.appearanceBtn.gotoAndStop(1);
					Main.setText(Main.mainText);
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
					Main.setText(Main.writeAppearance());
					displayAppearance();
					break;
			}
		}
		
		public static function openInventory():void {
			switch (state) {
				case "map" :
					break;
				case "inventory" :
					state = "navigate";
					menuItemSelected = false;
					selectedItem = null;
					btnIndex = 0;
					menuIndex = 0;
					scrollIndex = 0;
					
					if (Player.statPoints > 0)
						game.lvlupUI.visible = true;
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					game.menuUI.inventoryBtn.gotoAndStop(1);
					Main.setText(Main.mainText);
					updateMenuBtns();
					updateNavBtns();
					break;
				case "combat" :
					state = "combatInventory";
					
					game.combatUI.attackBtn.visible = false;
					game.combatUI.skillsBtn.visible = false;
					game.combatUI.runBtn.visible = false;
					game.combatUI.devourBtn.visible = false;
					game.combatUI.waitBtn.visible = false;
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
					game.combatUI.waitBtn.visible = true;
					game.combatUI.surrenderBtn.visible = true;
					game.combatUI.inventoryBtn.gotoAndStop(1);
					hideBtnArray();
					
					Main.setText(Main.combatText);
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
		
		public static function openSkills():void {	//Needs to work like inventory
			switch (state) {
				case "map" :
					break;
				case "skills" :
					state = "navigate";
					
					if (Player.statPoints > 0)
						game.lvlupUI.visible = true;
					game.menuUI.skillsBtn.gotoAndStop(1);
					updateMenuBtns();
					updateNavBtns();
					Main.setText(Main.mainText);
					break;
				case "combat" :
					state = "combatSkills";
					
					game.combatUI.attackBtn.visible = false;
					game.combatUI.inventoryBtn.visible = false;
					game.combatUI.runBtn.visible = false;
					game.combatUI.devourBtn.visible = false;
					game.combatUI.waitBtn.visible = false;
					game.combatUI.surrenderBtn.visible = false;
					game.combatUI.skillsBtn.gotoAndStop(2);
					
					updateMenuBtns();
					btnIndex = 0;
					menuIndex = 0;
					scrollIndex = 0;
					Main.setText(Main.skillsText);
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
					game.combatUI.waitBtn.visible = true;
					game.combatUI.surrenderBtn.visible = true;
					game.combatUI.skillsBtn.gotoAndStop(1);
					hideBtnArray();
					
					Main.setText(Main.combatText);
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
					Main.setText(Main.skillsText);
					break;
			}
		}
		
		public static function openQuests():void {
			switch (state) {
				case "map" :
					break;
				case "quests" :
					state = "navigate";
					
					if (Player.statPoints > 0)
						game.lvlupUI.visible = true;
					game.menuUI.questsBtn.gotoAndStop(1);
					updateMenuBtns();
					updateNavBtns();
					Main.setText(Main.mainText);
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
					Main.setText(Main.writeQuests());
					break;
			}
		}
		
		public static function toggleMap():void {
			switch (state) {
				case "map" :
					state = "navigate"
					
					if (Player.statPoints > 0)
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
		
		public static function menuSelect(x:int):void {
			var selection:String = btnArray[x].btnText.text;
			
			switch (state) {
				case "appearance" :
					menuItemSelected = true;
					selectedItem = Player.getItemFromEquipment(selection);
					Main.setText(selectedItem.toString("appearanceSelected"));
					//Main.setText(selectedItem.name + "\n\n" + selectedItem.effectsText + "\n" + selectedItem.short + " " + selectedItem.long);
					
					hideBtnArray();
					game.btnsUI.btn1.visible = true;
					game.btnsUI.btn1.btnText.text = "Unequip";
					break;
				case "inventory" :
				case "combatInventory" :
					menuItemSelected = true;
					selectedItem = Player.getItemFromInventory(ItemDefinitions.getItem(selection));
					Main.setText(selectedItem.toString("inventorySelected"));
					/*Main.setText(selectedItem.name + " -- " + selectedItem.count + "x\n\n" +
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
					if (Player.indexOfInventory(selectedItem) != -1)
						selectedItem = Player.getItemFromInventory(selectedItem);
					
					Main.setText(selectedItem.toString("buyingSelected"));
					/*if (Player.indexOfInventory(selectedItem) != -1) {
						Main.setText(selectedItem.name + " -- " + selectedItem.value + " gold ea. -- " +
							Player.getItemFromInventory(selectedItem).count + selectedItem.toString("buyingSelected"));
					} else {
						Main.setText(selectedItem.name + " -- " + selectedItem.value + " gold ea. -- 0" +
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
					selectedItem = Player.getItemFromInventory(ItemDefinitions.getItem(selection));
					Main.setText(selectedItem.toString("sellingSelected"));
					/*Main.setText(selectedItem.name + " -- " + Math.round(0.5 * selectedItem.value) + " gold ea.\n\n" +
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
		
		public static function menuConfirm(object:Object, selection:int):void {
			switch (state) {
				case "appearance" :
					var equip:Item = object as Item;
				
					if (selection == 1) {
						Main.unequip(equip);
					}
					
					menuItemSelected = false;
					selectedItem = null;
					displayAppearance();
					break;
				case "inventory" :
				case "combatInventory" :
					var item:Item = object as Item;
					
					if (selection == 0) {
						Main.drop(item, 1);
						//displayInventory();
					} else if (selection == 1) {
						if (state == "inventory") {
							if (Main.testItem(item)) {
								Main.useItem(item)
							} else {
								return;
							}
						} else {
							if (Main.testItem(item)) {
								openInventory();
								Main.combat.turn("inventory", item);
								menuItemSelected = false;
								selectedItem = null;
							} else {
								return;
							}
						}
					} else if (selection == -1) {
						displayInventory();
						menuItemSelected = false;
						selectedItem = null;
					}
					break;
				case "shop" :
					if (selection == -1) {
						state = "navigate";
						Main.setText(Main.mainText);
						updateMenuBtns();
						updateNavBtns();
						if (Player.statPoints > 0)
							game.lvlupUI.visible = true;
					}
					break;
				case "buying" :
					var buy:Item = object as Item;
					
					if (selection == -1) {
						if (menuItemSelected) {
							menuItemSelected = false;
							selectedItem = null;
							displayBuying();
						} else {
							enterShop(World.world[Player.x][Player.y]);
						}
					} else {
						if (!Main.buy(buy))
							Main.addText("You don't have enough gold to buy that.");
					}
					break;
				case "selling" :
					var sell:Item = object as Item;
					
					if (selection == -1) {
						if (menuItemSelected) {
							menuItemSelected = false;
							selectedItem = null;
							displaySelling();
						} else {
							enterShop(World.world[Player.x][Player.y]);
						}
					} else {
						if (!Main.sell(sell)) {
							if (!sell.canDrop)
								Main.addText("You can't sell that.");
							else
								Main.addText("You don't have any more to sell.");
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
		public static function travel(x:int, y:int):void {
			var dist:Number = Math.sqrt(Math.pow(Player.x - x, 2) + Math.pow(Player.y - y, 2));
			Clock.advTravelTime(dist);
			Player.x = x;
			Player.y = y;
			updateMaps();
			World.updateLoadedRegion();
			
			if (state == "navigate") {
				Main.mainText = "(" + Player.x + ", " + Player.y + ")\n" +
					World.world[Player.x][Player.y].name + "\n" +
					World.world[Player.x][Player.y].text;
				Main.setText(Main.mainText);
				updateMenuBtns();
				updateNavBtns();
			}
		}

		public static function moveNW():void {
			Clock.advTravelTime(Math.sqrt(2));
			Player.x--;
			Player.y--;
			
			Main.mainText = "(" + Player.x + ", " + Player.y + ")\n" +
				World.world[Player.x][Player.y].name + "\n" +
				World.world[Player.x][Player.y].text;
			
			Main.setText(Main.mainText);
			World.travelDir = [false, true, true, false];
			update();
		}

		public static function moveN():void {
			Clock.advTravelTime(1);
			Player.y--;

			Main.mainText = "(" + Player.x + ", " + Player.y + ")\n" +
				World.world[Player.x][Player.y].name + "\n" +
				World.world[Player.x][Player.y].text;
			
			Main.setText(Main.mainText);
			World.travelDir = [false, true, false, false];
			update();
		}

		public static function moveNE():void {
			Clock.advTravelTime(Math.sqrt(2));
			Player.x++;
			Player.y--;
			
			Main.mainText = "(" + Player.x + ", " + Player.y + ")\n" +
				World.world[Player.x][Player.y].name + "\n" +
				World.world[Player.x][Player.y].text;
			
			Main.setText(Main.mainText);
			World.travelDir = [false, true, true, false];
			update();
		}

		public static function moveW():void {
			Clock.advTravelTime(1);
			Player.x--;

			Main.mainText = "(" + Player.x + ", " + Player.y + ")\n" +
				World.world[Player.x][Player.y].name + "\n" +
				World.world[Player.x][Player.y].text;
			
			Main.setText(Main.mainText);
			World.travelDir = [false, false, true, false];
			update();
		}

		public static function moveCenter():void {
			var zone:Zone = World.world[Player.x][Player.y];
			
			if (zone.items.length > 0) {
				enterShop(zone);
			}
			World.travelDir = [false, false, false, false];
		}

		public static function moveE():void {
			Clock.advTravelTime(1);
			Player.x++;

			Main.mainText = "(" + Player.x + ", " + Player.y + ")\n" +
				World.world[Player.x][Player.y].name + "\n" +
				World.world[Player.x][Player.y].text;
			
			Main.setText(Main.mainText);
			World.travelDir = [true, false, false, false];
			update();
		}
		
		public static function moveSW():void {
			Clock.advTravelTime(Math.sqrt(2));
			Player.x--;
			Player.y++;
			
			Main.mainText = "(" + Player.x + ", " + Player.y + ")\n" +
				World.world[Player.x][Player.y].name + "\n" +
				World.world[Player.x][Player.y].text;
			
			Main.setText(Main.mainText);
			update();
			World.travelDir = [true, false, false, true];
		}
		
		public static function moveS():void {
			Clock.advTravelTime(1);
			Player.y++;
			
			Main.mainText = "(" + Player.x + ", " + Player.y + ")\n" +
				World.world[Player.x][Player.y].name + "\n" +
				World.world[Player.x][Player.y].text;
			
			Main.setText(Main.mainText);
			World.travelDir = [false, false, false, true];
			update();
		}

		public static function moveSE():void {
			Clock.advTravelTime(Math.sqrt(2));
			Player.x++;
			Player.y++;
			
			Main.mainText = "(" + Player.x + ", " + Player.y + ")\n" +
				World.world[Player.x][Player.y].name + "\n" +
				World.world[Player.x][Player.y].text;
			
			Main.setText(Main.mainText);
			World.travelDir = [true, false, false, true];
			update();
		}
		//}
		
		//{ Shop functions
		public static function enterShop(zone:Zone):void {
			state = "shop";
			
			Main.setText(Main.mainText);
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

		public static function displayBuying():void {
			state = "buying";
			
			var zone:Zone = World.world[Player.x][Player.y];
			Main.setText(Main.writeStock());
			
			hideBtnArray();
			game.btnsUI.upBtn.visible = false;
			game.btnsUI.downBtn.visible = false;
			btnIndex = 0;
			menuIndex = scrollIndex * 9;
			for (var i:int = menuIndex; i < zone.items.length && btnIndex < 9; i++) {
				btnArray[btnIndex].visible = true;
				btnArray[btnIndex].btnText.text = zone.items[menuIndex].name;
				
				btnIndex++;
				menuIndex++;
			}
			
			if (scrollIndex > 0)
				game.btnsUI.upBtn.visible = true;
			if (zone.items.length > (scrollIndex  + 1) * 9)
				game.btnsUI.downBtn.visible = true;
		}

		public static function displaySelling():void {
			state = "selling";
			
			displayInventory();
		}
		//}
		
		//{ Combat functions
		public static function displayCombat(enemy:Enemy):void {
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
			game.combatUI.waitBtn.visible = true;
			game.combatUI.surrenderBtn.visible = true;
			updateMenuBtns();
			
			var name:String = enemy.name.charAt().toUpperCase() + enemy.name.substring(1);
			
			if (enemy.name.length <= 15)
				game.combatUI.enemyLabel.text = "\n" + name;
			else
				game.combatUI.enemyLabel.text = name;
			
			updateEnemyHealth();
		}
		
		public static function hideCombat():void {
			state = "navigate";
			game.optionsBtn.visible = true;
			if (Player.statPoints > 0)
				game.lvlupUI.visible = true;
			
			updateMenuBtns();
			updateNavBtns();
			Main.setText(Main.mainText);
		}
		
		public static function updateEnemyHealth():void {
			var colorTF:ColorTransform = new ColorTransform();
			
			if (Main.combat.enemy.currHP < 0)
				Main.combat.enemy.currHP = 0;
			
			game.combatUI.healthLabel.text = Main.combat.enemy.currHP + "/" + Main.combat.enemy.maxHP;
			game.combatUI.healthBar.scaleX = Main.combat.enemy.currHP / Main.combat.enemy.maxHP;
			if (game.combatUI.healthBar.scaleX <= 0.25) {
				colorTF.color = 0xDD0000;
				game.combatUI.healthBar.transform.colorTransform = colorTF;
			} else {
				colorTF.color = 0x009900;
				game.combatUI.healthBar.transform.colorTransform = colorTF;
			}
		}
		//}
		
		public static function incStat(stat:String):Function {
			return function(e:MouseEvent):void {
				Main.addStat(stat, 1);
				Player.statPoints--;
				game.lvlupUI.ptsLabel.text = Player.statPoints;
				
				if (Player.statPoints <= 0)
					game.lvlupUI.visible = false;
				
				debugTrace();
			}
		}
	}
}