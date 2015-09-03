package  
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TextEvent;
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
		
		public const WIDTH:int = 800;
		public const HEIGHT:int = 600;
		
		public var btnIndex:int = 0
		public var scrollIndex:int = 0;
		public var menuIndex:int = 0;

		public var state:String = "navigate";

		public var menuItemSelected:Boolean = false;
		public var selectedItem:Item = null;

		public var btnArray:Array;
		public var player:Player;
		
		public const faURL:String = "http://www.furaffinity.net/user/";
						
		public function MainGameUI(_main:Main) 
		{
			main = _main;
			player = main.player;

			game = new MainGame();

			game.addEventListener(Event.ADDED_TO_STAGE, init);
			main.runner.addChild(game);
		}
		
		private function init(e:Event):void
		{
			game.removeEventListener(Event.ADDED_TO_STAGE, init);
			
			main.runner.stage.showDefaultContextMenu = false;
			
			btnArray = new Array(game.btnsUI.btn1, game.btnsUI.btn2, game.btnsUI.btn3,
							     game.btnsUI.btn4, game.btnsUI.btn5, game.btnsUI.btn6,
								 game.btnsUI.btn7, game.btnsUI.btn8, game.btnsUI.btn9);

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

			//Button handling
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
			combatUI.btn1.mouseChildren = false;
			combatUI.btn1.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(combatUI.btn1); });
			combatUI.btn1.addEventListener(MouseEvent.MOUSE_UP, function():void { up(combatUI.btn1); });
			combatUI.btn1.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(combatUI.btn1); });

			combatUI.btn2.buttonMode = true;
			combatUI.btn2.mouseChildren = false;
			combatUI.btn2.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(combatUI.btn2); });
			combatUI.btn2.addEventListener(MouseEvent.MOUSE_UP, function():void { up(combatUI.btn2); });
			combatUI.btn2.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(combatUI.btn2); });

			combatUI.btn3.buttonMode = true;
			combatUI.btn3.mouseChildren = false;
			combatUI.btn3.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(combatUI.btn3); });
			combatUI.btn3.addEventListener(MouseEvent.MOUSE_UP, function():void { up(combatUI.btn3); });
			combatUI.btn3.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(combatUI.btn3); });

			combatUI.btn4.buttonMode = true;
			combatUI.btn4.mouseChildren = false;
			combatUI.btn4.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(combatUI.btn4); });
			combatUI.btn4.addEventListener(MouseEvent.MOUSE_UP, function():void { up(combatUI.btn4); });
			combatUI.btn4.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(combatUI.btn4); });

			combatUI.btn5.buttonMode = true;
			combatUI.btn5.mouseChildren = false;
			combatUI.btn5.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(combatUI.btn5); });
			combatUI.btn5.addEventListener(MouseEvent.MOUSE_UP, function():void { up(combatUI.btn5); });
			combatUI.btn5.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(combatUI.btn5); });

			combatUI.btn6.buttonMode = true;
			combatUI.btn6.mouseChildren = false;
			combatUI.btn6.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(combatUI.btn6); });
			combatUI.btn6.addEventListener(MouseEvent.MOUSE_UP, function():void { up(combatUI.btn6); });
			combatUI.btn6.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(combatUI.btn6); });

			combatUI.btn7.buttonMode = true;
			combatUI.btn7.mouseChildren = false;
			combatUI.btn7.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(combatUI.btn7); });
			combatUI.btn7.addEventListener(MouseEvent.MOUSE_UP, function():void { up(combatUI.btn7); });
			combatUI.btn7.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(combatUI.btn7); });

			combatUI.btn8.buttonMode = true;
			combatUI.btn8.mouseChildren = false;
			combatUI.btn8.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(combatUI.btn8); });
			combatUI.btn8.addEventListener(MouseEvent.MOUSE_UP, function():void { up(combatUI.btn8); });
			combatUI.btn8.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(combatUI.btn8); });

			combatUI.btn9.buttonMode = true;
			combatUI.btn9.mouseChildren = false;
			combatUI.btn9.addEventListener(MouseEvent.MOUSE_DOWN, function():void { down(combatUI.btn9); });
			combatUI.btn9.addEventListener(MouseEvent.MOUSE_UP, function():void { up(combatUI.btn9); });
			combatUI.btn9.addEventListener(MouseEvent.MOUSE_OUT, function():void { up(combatUI.btn9); });*/

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

		//Update public functions
		public function update():void {
			updateMenuBtns();
			updateNavBtns();
			updateMaps();
			
			if (player.resources["currCapacity"] <= 0) {
				main.addResource("Health", -0.05 * player.resources["maxHealth"], 0);
				if (player.resources["currHealth"] <= 0)
					main.gameOver(2);
			}
			
			var capDrained:int;
			if (player.stats["vit"] <= 0.8 * player.resources["maxCapacity"])
				capDrained = Math.round(0.05 * (player.resources["maxCapacity"] - player.stats["vit"]));
			else
				capDrained = Math.round(0.01 * player.resources["maxCapacity"]);
			
			if (capDrained > player.resources["currCapacity"]) {
				capDrained = player.resources["currCapacity"] - capDrained;
				main.setResource("Capacity", 0, player.resources["maxCapacity"]);
			} else
				main.addResource("Capacity", -capDrained, 0);
			
			main.addFat(0.03 * capDrained);
			main.updateStats();
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
			for each (var quest:GameEvent in player.quests) {
				quest.checkState();
			}
		}

		public function updateMenuBtns():void {
			if (menuItemSelected || state == "shop" || state == "buying" || state == "selling") {
				game.menuUI.saveBtn.visible = false;
				game.menuUI.loadBtn.visible = true;
				game.menuUI.loadBtn.btnText.text = "Back";
			} else if (World.world[player.x][player.y].save) {
				game.menuUI.saveBtn.visible = true;
				game.menuUI.loadBtn.visible = true;
			} else if (state == "gameover" || state == "navigate") {
				game.menuUI.saveBtn.visible = false;
				game.menuUI.loadBtn.visible = true;
				game.menuUI.loadBtn.btnText.text = "Load";
			} else {
				game.menuUI.saveBtn.visible = false;
				game.menuUI.loadBtn.visible = false;
			}
		}

		public function updateNavBtns():void {
			var x:int = player.x;
			var y:int = player.y;
			
			game.btnsUI.btn5.visible = false;
			game.mainUI.zoneBtn.zoneName.text = World.world[player.x][player.y].name;
			
			if (!checkBounds(player.x - 1, player.y - 1) ||
					World.world[player.x - 1][player.y - 1] == null) {
				game.btnsUI.btn1.visible = false;
			} else {
				game.btnsUI.btn1.visible = true;
				game.btnsUI.btn1.btnText.text = World.world[player.x - 1][player.y - 1].name;
			}
			
			if (!checkBounds(player.x, player.y - 1) ||
					World.world[player.x][player.y - 1] == null) {
				game.btnsUI.btn2.visible = false;
			} else {
				game.btnsUI.btn2.visible = true;
				game.btnsUI.btn2.btnText.text = World.world[x][y - 1].name;
			}
			
			if (!checkBounds(player.x + 1, player.y - 1) ||
					World.world[player.x + 1][player.y - 1] == null) {
				game.btnsUI.btn3.visible = false;
			} else {
				game.btnsUI.btn3.visible = true;
				game.btnsUI.btn3.btnText.text = World.world[player.x + 1][player.y - 1].name;
			}
			
			if (!checkBounds(player.x - 1, player.y) ||
					World.world[player.x - 1][player.y] == null) {
				game.btnsUI.btn4.visible = false;
			} else {
				game.btnsUI.btn4.visible = true;
				game.btnsUI.btn4.btnText.text = World.world[player.x - 1][player.y].name;
			}
			
			if (World.world[player.x][player.y].enter) {
				game.btnsUI.btn5.visible = true;
				game.btnsUI.btn5.btnText.text = "Enter";
			}
			
			if (!checkBounds(player.x + 1, player.y) ||
					World.world[player.x + 1][player.y] == null) {
				game.btnsUI.btn6.visible = false;
			} else {
				game.btnsUI.btn6.visible = true;
				game.btnsUI.btn6.btnText.text = World.world[player.x + 1][player.y].name;
			}
			
			if (!checkBounds(player.x - 1, player.y + 1) ||
					World.world[player.x - 1][player.y + 1] == null) {
				game.btnsUI.btn7.visible = false;
			} else {
				game.btnsUI.btn7.visible = true;
				game.btnsUI.btn7.btnText.text = World.world[player.x - 1][player.y + 1].name;
			}
			
			if (!checkBounds(player.x, player.y + 1) ||
					World.world[player.x][player.y + 1] == null) {
				game.btnsUI.btn8.visible = false;
			} else {
				game.btnsUI.btn8.visible = true;
				game.btnsUI.btn8.btnText.text = World.world[player.x][player.y + 1].name;
			}
			
			if (!checkBounds(player.x + 1, player.y + 1) ||
					World.world[player.x + 1][player.y + 1] == null) {
				game.btnsUI.btn9.visible = false;
			} else {
				game.btnsUI.btn9.visible = true;
				game.btnsUI.btn9.btnText.text = World.world[player.x + 1][player.y + 1].name;
			}
		}

		public function updateMaps():void {
			game.mainUI.miniMap.x = 350 + 70 - 35 * player.x;
			game.mainUI.miniMap.y = 70 - 35 * player.y;
			
			game.mainUI.bigMarker.x = 552 + 62 * player.x;
			game.mainUI.bigMarker.y = 62 * player.y;
		}

		public function linkClicked(e:TextEvent):void {
			navigateToURL(new URLRequest(faURL + e.text), "_blank");
		}
		
		//Keyboard handlers
		public function keyReleased(e:KeyboardEvent):void {
			/*if (e.keyCode == Keyboard.C)
				test.getChoice(0);
			else if (e.keyCode == Keyboard.V)
				test.getChoice(1);*/
			
			//Menus
			if (e.keyCode == Keyboard.ESCAPE || e.keyCode == Keyboard.EQUAL)
				openOptions();
			else if (e.keyCode == Keyboard.U)
				openAppearance();
			else if (e.keyCode == Keyboard.I)
				openInventory();
			else if (e.keyCode == Keyboard.J)
				openQuests();
			else if (e.keyCode == Keyboard.K)
				openSkills();
			else if (e.keyCode == Keyboard.M)
				toggleMap();
			else if ((e.keyCode == Keyboard.BACKSPACE || e.keyCode == Keyboard.MINUS) &&
					 game.menuUI.loadBtn.visible && game.menuUI.loadBtn.btnText.text == "Back") {
				switch (state) {
					case "appearance" :
					case "inventory" :
						if (menuItemSelected)
							menuConfirm(selectedItem, -1);
						break;
					case "shop" :
					case "buying" :
					case "selling" :
						menuConfirm(selectedItem, -1);
						game.btnsUI.upBtn.visible = false;
						game.btnsUI.downBtn.visible = false;
						scrollIndex = 0;
						break;
				}
			}
			
			else if ((e.keyCode == Keyboard.PAGE_UP || e.keyCode == Keyboard.LEFTBRACKET) &&
					game.btnsUI.upBtn.visible) {
				switch (state) {
					case "inventory" :
					case "buying" :
					case "selling" :
						scrollUp();
						break;
					default :
						break;
				}
			}
			else if ((e.keyCode == Keyboard.PAGE_DOWN || e.keyCode == Keyboard.QUOTE) &&
					game.btnsUI.downBtn.visible) {
				switch (state) {
					case "inventory" :
					case "buying" :
					case "selling" :
						scrollDown();
						break;
					default :
						break;
				}
			}
			
			//Movement
			else if (game.btnsUI.btn1.visible && e.keyCode == Keyboard.NUMPAD_7) {
				switch (state) {
					case "navigate"	:
						if (World.world[player.x - 1][player.y - 1] != null)
							moveNW();
						break;
					case "appearance" :
						if (menuItemSelected)
							menuConfirm(selectedItem, 1);
						break;
					case "inventory" :
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
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn2.visible && (e.keyCode == Keyboard.NUMPAD_8 || e.keyCode == Keyboard.UP || e.keyCode == Keyboard.W)) {
				switch (state) {
					case "navigate"	:
						if (World.world[player.x][player.y - 1] != null)
							moveN();
						break;
					case "appearance" :
						menuSelect(1);
						break;
					case "inventory" :
					case "buying" :
					case "selling" :
						menuSelect(1);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn3.visible && e.keyCode == Keyboard.NUMPAD_9) {
				switch (state) {
					case "navigate"	:
						if (World.world[player.x + 1][player.y - 1] != null)
							moveNE();
						break;
					case "inventory" :
					case "buying" :
					case "selling" :
						if (menuItemSelected)
							menuConfirm(selectedItem, 0);
						else
							menuSelect(2);
						break;
					case "shop" :
						displaySelling();
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn4.visible && (e.keyCode == Keyboard.NUMPAD_4 || e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.A)) {
				switch (state) {
					case "navigate"	:
						if (World.world[player.x - 1][player.y] != null)
							moveW();
						break;
					case "appearance" :
						menuSelect(3);
						break;
					case "inventory" :
					case "buying" :
					case "selling" :
						menuSelect(3);
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
						menuSelect(4);
						break;
					case "inventory" :
					case "buying" :
					case "selling" :
						menuSelect(4);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn6.visible && (e.keyCode == Keyboard.NUMPAD_6 || e.keyCode == Keyboard.RIGHT || e.keyCode == Keyboard.D)) {
				switch (state) {
					case "navigate"	:
						if (World.world[player.x + 1][player.y] != null)
							moveE();
						break;
					case "appearance" :
						menuSelect(5);
						break;
					case "inventory" :
					case "buying" :
					case "selling" :
						menuSelect(5);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn7.visible && e.keyCode == Keyboard.NUMPAD_1) {
				switch (state) {
					case "navigate"	:
						if (World.world[player.x - 1][player.y + 1] != null)
							moveSW();
						break;
					case "inventory" :
					case "buying" :
					case "selling" :
						menuSelect(6);
						break;
					case "shop" :
						state = "navigate";
						updateNavBtns();
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn8.visible && (e.keyCode == Keyboard.NUMPAD_2 || e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.S)) {
				switch (state) {
					case "navigate"	:
						if (World.world[player.x][player.y + 1] != null)
							moveS();
						break;
					case "appearance" :
						menuSelect(7);
						break;
					case "inventory" :
					case "buying" :
					case "selling" :
						menuSelect(7);
						break;
					default	:
						break;
				}
			}
			else if (game.btnsUI.btn9.visible && e.keyCode == Keyboard.NUMPAD_3) {
				switch (state) {
					case "navigate"	:
						if (World.world[player.x + 1][player.y + 1] != null)
							moveSE();
						break;
					case "appearance" :
						menuSelect(8);
						break;
					case "inventory" :
					case "buying" :
					case "selling" :
						menuSelect(8);
						break;
					default	:
						break;
				}
			}
		}

		//Mouse handlers
		//Menus
		public function clickOptions(e:MouseEvent):void {
			openOptions();
		}

		public function clickAppearance(e:MouseEvent):void {
			openAppearance();
		}

		public function clickInventory(e:MouseEvent):void {
			openInventory();
		}

		public function clickSkills(e:MouseEvent):void {
			openSkills();
		}

		public function clickQuests(e:MouseEvent):void {
			openQuests();
		}

		public function clickSave(e:MouseEvent):void {
			main.saveGame();
		}

		public function clickLoad(e:MouseEvent):void {
			switch (state) {
				case "gameover" :
				case "navigate" :
					main.loadGame();
					break;
				case "appearance" :
				case "inventory" :
					if (menuItemSelected)
						menuConfirm(selectedItem, -1);
					break;
				case "shop" :
				case "buying" :
				case "selling" :
					menuConfirm(selectedItem, -1);
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					scrollIndex = 0;
					break;
			}
		}

		public function clickMap(e:MouseEvent):void {
			toggleMap();
		}

		public function clickUpBtn(e:MouseEvent):void {
			scrollUp();
		}

		public function clickDownBtn(e:MouseEvent):void {
			scrollDown();
		}

		//Movement
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
				default :
					break;
			}
		}

		public function clickN(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveN();
					break;
				case "inventory" :
				case "buying" :
				case "selling" :
					menuSelect(1);
					break;
				case "appearance" :
					menuSelect(1);
					break;
				default :
					break;
			}
		}

		public function clickNE(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveNE();
					break;
				case "inventory" :
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
				default :
					break;
			}
		}

		public function clickW(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveW();
					break;
				case "inventory" :
				case "buying" :
				case "selling" :
					menuSelect(3);
					break;
				case "appearance" :
					menuSelect(3);
					break;
				default :
					break;
			}
		}

		public function clickCenter(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveCenter();
					break;
				case "inventory" :
				case "buying" :
				case "selling" :
					menuSelect(4);
					break;
				case "appearance" :
					menuSelect(4);
					break;
				default :
					break;
			}
		}

		public function clickE(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveE();
					break;
				case "inventory" :
				case "buying" :
				case "selling" :
					menuSelect(5);
					break;
				case "appearance" :
					menuSelect(5);
					break;
				default :
					break;
			}
		}

		public function clickSW(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveSW();
					break;
				case "inventory" :
				case "buying" :
				case "selling" :
					menuSelect(6);
					break;
				case "shop" :
					state = "navigate";
					updateNavBtns();
					break;
				default :
					break;
			}
		}

		public function clickS(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveS();
					break;
				case "inventory" :
				case "buying" :
				case "selling" :
					menuSelect(7);
					break;
				case "appearance" :
					menuSelect(7);
					break;
				default :
					break;
			}
		}

		public function clickSE(e:MouseEvent):void {
			switch (state) {
				case "navigate" :
					moveSE();
					break;
				case "inventory" :
				case "buying" :
				case "selling" :
					menuSelect(8);
					break;
				case "appearance" :
					menuSelect(8);
					break;
				default :
					break;
			}
		}

		//Menu public function
		public function scrollUp():void {
			scrollIndex--;
			menuIndex = scrollIndex * 9;
			btnIndex = 0;
			
			switch (state) {
				case "inventory" :
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
			for (var i:int = menuIndex; i < player.inventory.length; i++) {
				btnArray[btnIndex].visible = true;
				btnArray[btnIndex].btnText.text = player.inventory[menuIndex].count + "x " + player.inventory[menuIndex].name;
				
				btnIndex++;
				menuIndex++;
				if (btnIndex > 8)
					break;
			}
			
			if (scrollIndex > 0)
				game.btnsUI.upBtn.visible = true;
			if (player.inventory.length > (scrollIndex  + 1) * 9)
				game.btnsUI.downBtn.visible = true;
		}

		public function displayAppearance():void {
			main.setText(main.writeAppearance());
			hideBtnArray();
			
			if (player.equipment["head"] != null) {
				game.btnsUI.btn2.visible = true;
				game.btnsUI.btn2.btnText.text = player.equipment["head"].name;
			}
			if (player.equipment["torso"] != null) {
				game.btnsUI.btn5.visible = true;
				game.btnsUI.btn5.btnText.text = player.equipment["torso"].name;
			}
			if (player.equipment["legs"] != null) {
				game.btnsUI.btn8.visible = true;
				game.btnsUI.btn8.btnText.text = player.equipment["legs"].name;
			}
			if (player.equipment["feet"] != null) {
				game.btnsUI.btn9.visible = true;
				game.btnsUI.btn9.btnText.text = player.equipment["feet"].name;
			}
			if (player.equipment["weapon"] != null) {
				game.btnsUI.btn4.visible = true;
				game.btnsUI.btn4.btnText.text = player.equipment["weapon"].name;
				if (player.equipment["weapon"].twoHanded) {
					game.btnsUI.btn6.visible = true;
					game.btnsUI.btn6.btnText.text = player.equipment["weapon"].name;
				}
			}
			if (player.equipment["shield"] != null) {
				game.btnsUI.btn6.visible = true;
				game.btnsUI.btn6.btnText.text = player.equipment["shield"].name;
			}
		}

		public function openOptions():void {
			switch (state) {
				case "gameover" :
				case "map" :
					break;
				case "options" :
					state = "navigate";
					
					game.optionsBtn.gotoAndStop(1);
					main.setText(main.mainText);
					updateMenuBtns();
					updateNavBtns();
					break;
				default :
					state = "options";
					
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
					
					game.menuUI.appearanceBtn.gotoAndStop(1);
					main.setText(main.mainText);
					updateMenuBtns();
					updateNavBtns();
					break;
				default :
					state = "appearance";
					
					game.menuUI.loadBtn.visible = false;
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
					btnIndex = 0;
					menuIndex = 0;
					scrollIndex = 0;
					
					state = "navigate";
					
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					game.menuUI.inventoryBtn.gotoAndStop(1);
					main.setText(main.mainText);
					updateMenuBtns();
					updateNavBtns();
					break;
				default :
					state = "inventory";
					
					game.menuUI.loadBtn.visible = false;
					game.optionsBtn.gotoAndStop(1);
					game.menuUI.appearanceBtn.gotoAndStop(1);
					game.menuUI.inventoryBtn.gotoAndStop(2);
					game.menuUI.skillsBtn.gotoAndStop(1);
					game.menuUI.questsBtn.gotoAndStop(1);
					
					updateMenuBtns();
					main.setText(main.writeInventory());
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
					
					game.menuUI.skillsBtn.gotoAndStop(1);
					updateMenuBtns();
					updateNavBtns();
					main.setText(main.mainText);
					break;
				default :
					state = "skills";
					
					game.menuUI.loadBtn.visible = false;
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
					
					game.menuUI.questsBtn.gotoAndStop(1);
					updateMenuBtns();
					updateNavBtns();
					main.setText(main.mainText);
					break;
				default :
					state = "quests"
					
					game.menuUI.loadBtn.visible = false;
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					game.optionsBtn.gotoAndStop(1);
					game.menuUI.appearanceBtn.gotoAndStop(1);
					game.menuUI.inventoryBtn.gotoAndStop(1);
					game.menuUI.skillsBtn.gotoAndStop(1);
					game.menuUI.questsBtn.gotoAndStop(2);
					hideBtnArray();
					
					updateMenuBtns();
					main.setText(main.questsText);
					break;
			}
		}

		public function toggleMap():void {
			switch (state) {
				case "map" :
					state = "navigate"
					
					game.optionsBtn.visible = true;
					game.mainUI.bigMap.visible = false;
					game.mainUI.bigMarker.visible = false;
					game.mainUI.textField.visible = true;
					game.mainUI.scrollBar.visible = true;
					game.menuUI.appearanceBtn.visible = true;
					game.menuUI.inventoryBtn.visible = true;
					game.menuUI.skillsBtn.visible = true;
					game.menuUI.questsBtn.visible = true;
					updateNavBtns();
					updateMenuBtns()
					break;
				case "navigate" :
					state = "map";
					
					game.menuUI.loadBtn.visible = false;
					game.optionsBtn.visible = false;
					game.mainUI.bigMap.visible = true;
					game.mainUI.bigMarker.visible = true;
					game.mainUI.textField.visible = false;
					game.mainUI.scrollBar.visible = false;
					game.menuUI.appearanceBtn.visible = false;
					game.menuUI.inventoryBtn.visible = false;
					game.menuUI.skillsBtn.visible = false;
					game.menuUI.questsBtn.visible = false;
					game.menuUI.saveBtn.visible = false;
					game.menuUI.loadBtn.visible = false;
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
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
					var equip:Item = ItemDefinitions.getItem(selection);
					main.setText(equip.name + "\n\n" + equip.short + " " + equip.long);
					selectedItem = equip;
					
					hideBtnArray();
					game.btnsUI.btn1.visible = true;
					game.btnsUI.btn1.btnText.text = "Unequip";
					break;
				case "inventory" :
					menuItemSelected = true;
					selection = selection.substring(selection.indexOf("x") + 2);
					var item:Item = player.inventory[player.indexOfInventory(ItemDefinitions.getItem(selection))];
					main.setText(item.name + " -- " + item.count + "x\n\n" + item.short + " " + item.long);
					selectedItem = item;
					
					hideBtnArray();
					game.btnsUI.upBtn.visible = false;
					game.btnsUI.downBtn.visible = false;
					game.btnsUI.btn1.visible = true;
					if (item.equip)
						game.btnsUI.btn1.btnText.text = "Equip";
					else
						game.btnsUI.btn1.btnText.text = "Use";
					game.btnsUI.btn3.visible = true;
					game.btnsUI.btn3.btnText.text = "Discard";
					break;
				case "buying" :
					menuItemSelected = false;
					var buying:Item = ItemDefinitions.getItem(selection);
					
					if (main.buy(buying))
						main.setText(main.writeStock());
					else
						main.addText("You don't have enough gold to buy that.");
					break;
				case "selling" :
					menuItemSelected = false;
					selection = selection.substring(selection.indexOf("x") + 2);
					var selling:Item = player.inventory[player.indexOfInventory(ItemDefinitions.getItem(selection))];
					
					if (main.sell(selling)) {
						main.setText(main.writeInventory());
						displaySelling();
					} else
						main.addText("You can't sell that.");
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
					var item:Item = object as Item;
					
					menuItemSelected = false;
					if (selection == 0) {
						main.drop(item, 1);
					} else if (selection == 1) {
						if (!main.useItem(item))
							return;
					}
					
					displayInventory();
					break;
				case "shop" :
					state = "navigate";
					main.setText(main.mainText);
					updateMenuBtns();
					updateNavBtns();
					break;
				case "buying" :
				case "selling" :
					state = "shop";
					enterShop(World.world[player.x][player.y]);
					break;
				default :
					break;
			}
			updateMenuBtns();
		}

		//Navigation
		public function travel(x:int, y:int):void {
			var oldX:int = player.x;
			var oldY:int = player.y;
			
			player.x = x;
			player.y = y;
			main.mainText = "(" + player.x + ", " + player.y + ")\n" +
				World.world[player.x][player.y].name + "\n" +
				World.world[player.x][player.y].text;
			
			main.setText(main.mainText);
			updateMenuBtns();
			updateNavBtns();
			updateMaps();
		}

		public function moveNW():void {
			player.x--;
			player.y--;
			
			main.mainText = "(" + player.x + ", " + player.y + ")\n" +
				World.world[player.x][player.y].name + "\n" +
				World.world[player.x][player.y].text;
			
			main.setText(main.mainText);
			update();
		}

		public function moveN():void {
			player.y--;

			main.mainText = "(" + player.x + ", " + player.y + ")\n" +
				World.world[player.x][player.y].name + "\n" +
				World.world[player.x][player.y].text;
			
			main.setText(main.mainText);
			update();
		}

		public function moveNE():void {
			player.x++;
			player.y--;
			
			main.mainText = "(" + player.x + ", " + player.y + ")\n" +
				World.world[player.x][player.y].name + "\n" +
				World.world[player.x][player.y].text;
			
			main.setText(main.mainText);
			update();
		}

		public function moveW():void {
			player.x--;

			main.mainText = "(" + player.x + ", " + player.y + ")\n" +
				World.world[player.x][player.y].name + "\n" +
				World.world[player.x][player.y].text;
			
			main.setText(main.mainText);
			update();
		}

		public function moveCenter():void {
			var zone:Zone = World.world[player.x][player.y];
			
			if (zone.items != null) {
				enterShop(zone);
			}
		}

		public function moveE():void {
			player.x++;

			main.mainText = "(" + player.x + ", " + player.y + ")\n" +
				World.world[player.x][player.y].name + "\n" +
				World.world[player.x][player.y].text;
			
			main.setText(main.mainText);
			update();
		}

		public function moveSW():void {
			player.x--;
			player.y++;
			
			main.mainText = "(" + player.x + ", " + player.y + ")\n" +
				World.world[player.x][player.y].name + "\n" +
				World.world[player.x][player.y].text;
			
			main.setText(main.mainText);
			update();
		}

		public function moveS():void {
			player.y++;

			main.mainText = "(" + player.x + ", " + player.y + ")\n" +
				World.world[player.x][player.y].name + "\n" +
				World.world[player.x][player.y].text;
			
			main.setText(main.mainText);
			update();
		}

		public function moveSE():void {
			player.x++;
			player.y++;
			
			main.mainText = "(" + player.x + ", " + player.y + ")\n" +
				World.world[player.x][player.y].name + "\n" +
				World.world[player.x][player.y].text;
			
			main.setText(main.mainText);
			update();
		}

		//Shop public functions
		public function enterShop(zone:Zone):void {
			state = "shop";
			
			main.setText(main.mainText);
			updateMenuBtns();
			
			hideBtnArray();
			game.btnsUI.btn1.visible = true;
			game.btnsUI.btn1.btnText.text = "Buy";
			game.btnsUI.btn3.visible = true;
			game.btnsUI.btn3.btnText.text = "Sell";
		}

		public function displayBuying():void {
			state = "buying";
			
			var zone:Zone = World.world[player.x][player.y];
			main.setText(main.writeStock());
			
			hideBtnArray();
			game.btnsUI.upBtn.visible = false;
			game.btnsUI.downBtn.visible = false;
			btnIndex = 0;
			menuIndex = scrollIndex * 9;
			for (var i:int = menuIndex; i < zone.stock.length; i++) {
				btnArray[btnIndex].visible = true;
				btnArray[btnIndex].btnText.text = zone.stock[menuIndex].name;
				
				btnIndex++;
				menuIndex++;
				if (btnIndex > 8)
					break;
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

		//Combat functions
		public function startCombat(enemy:Enemy):void {
			state = "combat";
			hideBtnArray();
			game.menuUI.visible = false;
			game.combatUI.visible = true;
			
			if (enemy.name.length <= 15)
				game.combatUI.enemyLabel.text = "\n" + enemy.name;
			else
				game.combatUI.enemyLabel.text = enemy.name;
			
			main.setText(enemy.desc + "\n--------------------------------------------------");
			
		}
	}
}