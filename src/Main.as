package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	//import Quests.*;
	
		
	/**
	 * ...
	 * @author Kazan Fatzan, refactor by Serule Blue
	 */
	public class Main extends MovieClip {
		/// Class containing all of the "timeline" code
		//public static var MainGameUI:MainGameUI;
		
		/// Reference to the main Runner class (use to access stage, etc.)
		public static var runner:Runner;
		
		flash.net.registerClassAlias("Player", Player);
		flash.net.registerClassAlias("Item", Item);
		flash.net.registerClassAlias("GameEvent", GameEvent);
		//flash.net.registerClassAlias("Main", Main);
		
		public static var combat:Combat;
		public static var currEvent:GameEvent;
		
		//{ Text
		public static var optionsText:String = "Options\n\nTo be implemented.\n\nControls should be self-explanatory. In addition to using the mouse, keyboard control is also possible for most functions:\nWASD/Arrow Keys/Numpad - Navigation (numpad can move diagonally)\nU - Open appearance\nI - Open inventory\nJ - Open quests\nK - Open skills\nM - Toggle map\nEnter - Enter a particular area\nBackspace - Go back one menu\nPage Up/Down - Scroll through button menus\nEsc - Options\n\nCredits (FurAffinity usernames unless otherwise noted)\n\nIntroduction Text - PowersNDark\nIdeas - Mysticmightg, Anonymous\nSome Weapon Text - Sinwraith\nAS3 Advisor - Serule\nEverything Else - Kazan.K";
		public static var mainText:String = "While time is the great keeper of all, there will always remain the events and artifacts that even he cannot keep eternal. Expunged from the very world they tried to conquer, the earliest civilizations of Karthund were lost to the ravages of time, and the plague that struck down their people has long since been forgotten. Despite being erased from history itself, the aftermath of this great catastrophe still surfaces and ripples far into the future of generations to come. Unbeknownst to any, the cause of this calamity lives on, trapped in a seal containing the very essence of this powerful force. However, through malicious intent or an unfortunate accident, this seal has been broken.\n\nEvil has spread across the land, contaminating the earth, the water, and everything in its path. Although, perhaps not in the most obvious of ways. Rich and fertile fields, once known for their bountiful crops, had changed in a matter of weeks. Now, seen simply as a miracle by the gods, the soil promotes nothing short of rampant growth in anything it feeds. Never before have forests been more dense and lush, hills and mountains been so overgrown with vegetation, and livestock been fattened to more than double their weight. The boundless abundance of mother nature has seen to it that even the poorest of farmers have begun producing enough to appease the exploding appetites of entire villages.\n\nWhile crops flourish and civilization and wildlife alike gorge upon this newfound bounty, the essence of the ancient seal continues its march across Karthund. The inhabitants of this land are falling prey to this new evil while those afflicted slowly find their world becoming muted and dull as baser instincts take hold of their minds. An insatiable hunger for food will overwhelm them. The unrelenting desires of hedonistic gluttony will drive them to consume all that lie before them – only to leave themselves famished and starving for more, trapped in an endless cycle of ravenous greed.";
		public static var appearanceText:String = "Appearance";
		public static var inventoryText:String = "Inventory";
		public static var skillsText:String = "Skills\n\nTo be implemented.";
		public static var questsText:String = "Quests\n\nTo be implemented.";
		public static var combatText:String = "Combat";
		//}
		
		public static var credits:Array = ["PowersNDark", "Mysticmightg", "Sinwraith", "Serule", "Kazan.K"];
		
		public function Main(_runner:Runner) {
			runner = _runner;
			new MainGameUI();
			//ItemDefinitions.main = this;
			//SkillDefinitions.main = this;
		}
		
		// called by MainGameUI after it is added to the Stage
		public static function firstInit():void {
			for each (var name:String in credits)
				optionsText = optionsText.replace(name, '<u><a href="event:' + name + '">' + name + '</a></u>');
			
			//ItemDefinitions.main = this;
			//SkillDefinitions.main = this;
			new Clock();
			new World();
			reInit();
			
			/*TEST CODE BELOW*/
			/*setResource("Health", 100, -1);
			setResource("Mana", 21, -1);
			setResource("Energy", 84, -1);
			setResource("Capacity", 93, -1);
			setStat("str", 9);
			setStat("agi", 4);
			setStat("vit", 14);
			setStat("int", 6);
			setStat("dex", 10);
			setStat("vor", 26);
			setFat(86);
			addExp(196, false);
			setGold(500);*/
			
			/*loot(ItemDefinitions.getItem("Sword"), 2);
			drop(ItemDefinitions.getItem("Sword"), 1);
			loot(ItemDefinitions.getItem("Red Potion"), 13);
			loot(ItemDefinitions.getItem("Orange Potion"), 6);
			loot(ItemDefinitions.getItem("Yellow Potion"), 4);
			loot(ItemDefinitions.getItem("White Potion"), 2);
			loot(ItemDefinitions.getItem("Blue Potion"), 4);
			drop(ItemDefinitions.getItem("Orange Potion"), 4);
			loot(ItemDefinitions.getItem("Violet Potion"), 1);
			loot(ItemDefinitions.getItem("Knife"), 4);
			loot(ItemDefinitions.getItem("Lance"), 1);
			loot(ItemDefinitions.getItem("Axe"), 2);
			loot(ItemDefinitions.getItem("Cotton Shirt"), 1);
			loot(ItemDefinitions.getItem("Denim Pants"), 1);
			loot(ItemDefinitions.getItem("Shoes"), 1);
			loot(ItemDefinitions.getItem("Guard"), 1);
			loot(ItemDefinitions.getItem("Mutton Loin"), 1);
			loot(ItemDefinitions.getItem("Roast Chicken"), 1);
			loot(ItemDefinitions.getItem("Falchion"), 1);
			loot(ItemDefinitions.getItem("Rapier"), 1);
			loot(ItemDefinitions.getItem("Cutlass"), 1);
			loot(ItemDefinitions.getItem("Katana"), 1);
			loot(ItemDefinitions.getItem("Flamberge"), 1);
			loot(ItemDefinitions.getItem("Flail"), 1);
			loot(ItemDefinitions.getItem("Halberd"), 1);
			loot(ItemDefinitions.getItem("Cerulean Hat"), 1);
			loot(ItemDefinitions.getItem("Hat"), 1);
			loot(ItemDefinitions.getItem("Sword"), 1);
			loot(ItemDefinitions.getItem("Sabre"), 1);
			loot(ItemDefinitions.getItem("Pork Haunch"), 5);*/
			
			//trace(Clock.toString());
		}
		
		public static function reInit():void {
			setResource("Health", Player.resources["currHealth"], Player.resources["maxHealth"]);
			setResource("Mana", Player.resources["currMana"], Player.resources["maxMana"]);
			setResource("Energy", Player.resources["currEnergy"], Player.resources["maxEnergy"]);
			setResource("Capacity", Player.resources["currCapacity"], Player.resources["maxCapacity"]);
			addExp(0, false);
			setStat("str", Player.stats["str"]);
			setStat("agi", Player.stats["agi"]);
			setStat("vit", Player.stats["vit"]);
			setStat("int", Player.stats["int"]);
			setStat("dex", Player.stats["dex"]);
			setStat("vor", Player.stats["vor"]);
			setFat(Player.fat);
			setGold(Player.gold);
			
			MainGameUI.state = "navigate";
			MainGameUI.menuItemSelected = false;
			
			MainGameUI.game.btnsUI.upBtn.visible = false;
			MainGameUI.game.btnsUI.downBtn.visible = false;
			MainGameUI.game.combatUI.visible = false;
			MainGameUI.game.optionsBtn.gotoAndStop(1);
			MainGameUI.game.menuUI.appearanceBtn.gotoAndStop(1);
			MainGameUI.game.menuUI.inventoryBtn.gotoAndStop(1);
			MainGameUI.game.menuUI.skillsBtn.gotoAndStop(1);
			MainGameUI.game.menuUI.questsBtn.gotoAndStop(1);
			
			MainGameUI.updateMenuBtns();
			MainGameUI.updateNavBtns();
			MainGameUI.updateMaps();
			calcStats(true);
			
			trace("\natk = " + Player.derivedStats["atk"]);
			trace("matk = " + Player.derivedStats["matk"]);
			trace("def = " + Player.derivedStats["def"]);
			trace("mdef = " + Player.derivedStats["mdef"]);
			trace("acc = " + Player.derivedStats["acc"]);
			trace("dodge = " + Player.derivedStats["dodge"]);
			trace("cap = " + Player.resources["currCapacity"] + " / " + Player.resources["maxCapacity"] + " (" + Player.derivedStats["cap"] + ")");
			trace("state = " + MainGameUI.state);
		}
		
		public static function addText(txt:String):void {
			if (txt == "")
				return;
			
			switch (MainGameUI.state) {
				case "combat" :
				case "combatInventory" :
				case "combatSkills" :
					combatText += "\n" + txt;
					setText(combatText);
					break;
				case "dialog" :
					MainGameUI.game.mainUI.textField.appendText("\n\n" + txt);
					MainGameUI.game.mainUI.scrollBar.scrollPosition = MainGameUI.game.mainUI.scrollBar.minScrollPosition;
					break;
				case "navigate" :
					mainText += "\n\n" + txt;
				default :
					MainGameUI.game.mainUI.textField.appendText("\n\n" + txt);
					MainGameUI.game.mainUI.scrollBar.scrollPosition = MainGameUI.game.mainUI.scrollBar.maxScrollPosition;
					break;
			}
			
			MainGameUI.game.mainUI.scrollBar.update();
		}
		
		public static function setText(txt:String):void {
			if (txt == "")
				return;
			
			switch (MainGameUI.state) {
				case "navigate" :
					mainText = txt;
				default :
					MainGameUI.game.mainUI.textField.text = txt;
					break;
			}
			
			MainGameUI.game.mainUI.scrollBar.scrollPosition = MainGameUI.game.mainUI.scrollBar.minScrollPosition;
			MainGameUI.game.mainUI.scrollBar.update();
		}
		
		public static function saveGame():void {
			/*try {
				var saveFile:SharedObject = SharedObject.getLocal("GameFile");
				var PlayerData:ByteArray = new ByteArray();
				var equipmentData:ByteArray = new ByteArray();
				var questsData:ByteArray = new ByteArray();
				PlayerData.writeObject(Player);
				equipmentData.writeObject(Player.equipment);
				questsData.writeObject(Player.quests);
				saveFile.data.PlayerData = PlayerData;
				saveFile.data.equipmentData = equipmentData;
				saveFile.data.questsData = questsData;
				
				saveFile.flush();
				trace("Game saved");
				addText("Game saved");
			} catch (e:Error) {
				trace("Game save error: " + e.getStackTrace());
				addText("Could not write save file.");
				MainGameUI.game.mainUI.debugConsole.text += "\n" + e.message + "\n" + e.getStackTrace();
			}*/
		}
		
		public static function loadGame():void {
			/*try {
				var saveFile:SharedObject = SharedObject.getLocal("GameFile");
				var PlayerData:ByteArray = saveFile.data.PlayerData as ByteArray;
				var equipmentData:ByteArray = saveFile.data.equipmentData as ByteArray;
				var questsData:ByteArray = saveFile.data.questsData as ByteArray;
				PlayerData.position = 0;
				Player = PlayerData.readObject() as Player;
				equipmentData.position = 0;
				Player.equipment = equipmentData.readObject() as Object;
				questsData.position = 0;
				Player.quests = questsData.readObject() as Array;
				
				setResource("Health", Player.resources["currHealth"], Player.resources["maxHealth"]);
				setResource("Mana", Player.resources["currMana"], Player.resources["maxMana"]);
				setResource("Energy", Player.resources["currEnergy"], Player.resources["maxEnergy"]);
				setResource("Capacity", Player.resources["currCapacity"], Player.resources["maxCapacity"]);
				setStat("str", Player.stats["str"]);
				setStat("agi", Player.stats["agi"]);
				setStat("vit", Player.stats["vit"]);
				setStat("int", Player.stats["int"]);
				setStat("dex", Player.stats["dex"]);
				setStat("vor", Player.stats["vor"]);
				setFat(Player.fat);
				setGold(Player.gold);
				
				MainGameUI.game.mainUI.expLabel.text = Player.currExp + "/" + Player.maxExp;
				MainGameUI.game.mainUI.expBar.scaleX = Player.currExp / Player.maxExp;
				MainGameUI.game.mainUI.levelLabel.text = Player.level.toString();
				
				reInit();
				
				trace("Game loaded");
				MainGameUI.travel(Player.x, Player.y);
			} catch (e:Error) {
				trace("Could not load save file.\n" + e.getStackTrace());
				addText("Could not load save file.");
				MainGameUI.game.mainUI.debugConsole.text += "\n" + e.message + "\n" + e.getStackTrace();
				return;
			}*/
		}
		
		public static function addResource(resource:String, deltaCurr:Number, deltaMax:Number):void { //use a separate takeDamage/feed method that uses this		
			Player.resources["max" + resource] += deltaMax;
			Player.resources["curr" + resource] += deltaCurr;
			
			if (Player.resources["max" + resource] > 99999) {
				Player.resources["max" + resource] = 99999;
				addText("Stat cap reached.\npls wat r u doing wit ur lyfe?");
			} else if (Player.resources["max" + resource] <= 0)
				Player.resources["max" + resource] = 1;
			var max:int = Player.resources["max" + resource];
			
			if (Player.resources["curr" + resource] > 99999) {
				Player.resources["curr" + resource] = 99999;
				addText("stahp wat hav u done?");
			} else if (Player.resources["curr" + resource] < 0)
				Player.resources["curr" + resource] = 0;
			var curr:int = Player.resources["curr" + resource];
			
			var colorTF:ColorTransform = new ColorTransform();
			
			switch (resource) {
				case "Health":
					if (curr <= max) {
						MainGameUI.game.mainUI.healthBar.scaleX = curr / max;
						if (MainGameUI.game.mainUI.healthBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							MainGameUI.game.mainUI.healthBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0x009900;
							MainGameUI.game.mainUI.healthBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0x009900;
						MainGameUI.game.mainUI.healthBar.transform.colorTransform = colorTF;
						MainGameUI.game.mainUI.healthBar.scaleX = 1;
						curr = max;
						Player.resources["curr" + resource] = curr;
					}
					MainGameUI.game.mainUI.healthLabel.text = curr + "/" + max;
					break;
				case "Mana":
					if (curr <= max) {
						MainGameUI.game.mainUI.manaBar.scaleX = curr / max;
						if (MainGameUI.game.mainUI.manaBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							MainGameUI.game.mainUI.manaBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0x0066FF;
							MainGameUI.game.mainUI.manaBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0x0066FF;
						MainGameUI.game.mainUI.manaBar.transform.colorTransform = colorTF;
						MainGameUI.game.mainUI.manaBar.scaleX = 1;
						curr = max;
						Player.resources["curr" + resource] = curr;
					}
					MainGameUI.game.mainUI.manaLabel.text = curr + "/" + max;
					break;
				case "Energy":
					MainGameUI.game.mainUI.energyLabel.text = curr + "/" + max;
					if (curr <= max) {
						MainGameUI.game.mainUI.energyBar.scaleX = curr / max;
						if (MainGameUI.game.mainUI.energyBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							MainGameUI.game.mainUI.energyBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0xFFFF66;
							MainGameUI.game.mainUI.energyBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0xFFFF66;
						MainGameUI.game.mainUI.energyBar.transform.colorTransform = colorTF;
						MainGameUI.game.mainUI.energyBar.scaleX = 1;
						curr = max;
						Player.resources["curr" + resource] = curr;
					}
					MainGameUI.game.mainUI.energyLabel.text = curr + "/" + max;
					break;
				case "Capacity":
					if (curr <= max) {
						colorTF.color = 0xFF6600;
						MainGameUI.game.mainUI.capacityBar.transform.colorTransform = colorTF;
						MainGameUI.game.mainUI.capacityBar.scaleX = curr / max;
						MainGameUI.game.mainUI.capacityLabel.text = Math.round(MainGameUI.game.mainUI.capacityBar.scaleX * 100) + "%";
					} else {
						colorTF.color = 0xDD0000;
						MainGameUI.game.mainUI.capacityBar.transform.colorTransform = colorTF;
						MainGameUI.game.mainUI.capacityBar.scaleX = 1;
						MainGameUI.game.mainUI.capacityLabel.text = "Danger";
						/*if (Player.resources["currCapacity"] > Player.derivedStats["cap"])
							gameOver(1);*/
					}
					Player.derivedStats["cap"] += deltaMax;
					Player.derivedStats["weight"] += 0.03 * deltaCurr;
					
					break;
			}
			
			/*trace("\natk = " + Player.derivedStats["atk"]);
			trace("matk = " + Player.derivedStats["matk"]);
			trace("def = " + Player.derivedStats["def"]);
			trace("mdef = " + Player.derivedStats["mdef"]);
			trace("acc = " + Player.derivedStats["acc"]);
			trace("dodge = " + Player.derivedStats["dodge"]);*/
		}
		
		public static function setResource(resource:String, deltaCurr:Number, deltaMax:Number):void { //use a separate takeDamage/feed method that uses this
			if (deltaMax < 0)
				deltaMax = Player.resources["max" + resource];
			
			Player.resources["max" + resource] = deltaMax;
			Player.resources["curr" + resource] = deltaCurr;
			
			if (Player.resources["max" + resource] > 99999) {
				Player.resources["max" + resource] = 99999;
				addText("Stat cap reached.\npls wat r u doing wit ur lyfe?");
			} else if (Player.resources["max" + resource] <= 0)
				Player.resources["max" + resource] = 1;
			var max:int = Player.resources["max" + resource];
			
			if (Player.resources["curr" + resource] > 99999) {
				Player.resources["curr" + resource] = 99999;
				addText("stahp wat hav u done?");
			} else if (Player.resources["curr" + resource] < 0)
				Player.resources["curr" + resource] = 0;
			var curr:int = Player.resources["curr" + resource];
			
			var colorTF:ColorTransform = new ColorTransform();
			
			switch (resource) {
				case "Health":
					if (curr <= max) {
						MainGameUI.game.mainUI.healthBar.scaleX = curr / max;
						if (MainGameUI.game.mainUI.healthBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							MainGameUI.game.mainUI.healthBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0x009900;
							MainGameUI.game.mainUI.healthBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0x009900;
						MainGameUI.game.mainUI.healthBar.transform.colorTransform = colorTF;
						MainGameUI.game.mainUI.healthBar.scaleX = 1;
						curr = max;
						Player.resources["curr" + resource] = curr;
					}
					MainGameUI.game.mainUI.healthLabel.text = curr + "/" + max;
					break;
				case "Mana":
					if (curr <= max) {
						MainGameUI.game.mainUI.manaBar.scaleX = curr / max;
						if (MainGameUI.game.mainUI.manaBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							MainGameUI.game.mainUI.manaBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0x0066FF;
							MainGameUI.game.mainUI.manaBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0x0066FF;
						MainGameUI.game.mainUI.manaBar.transform.colorTransform = colorTF;
						MainGameUI.game.mainUI.manaBar.scaleX = 1;
						curr = max;
						Player.resources["curr" + resource] = curr;
					}
					MainGameUI.game.mainUI.manaLabel.text = curr + "/" + max;
					break;
				case "Energy":
					MainGameUI.game.mainUI.energyLabel.text = curr + "/" + max;
					if (curr <= max) {
						MainGameUI.game.mainUI.energyBar.scaleX = curr / max;
						if (MainGameUI.game.mainUI.energyBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							MainGameUI.game.mainUI.energyBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0xFFFF66;
							MainGameUI.game.mainUI.energyBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0xFFFF66;
						MainGameUI.game.mainUI.energyBar.transform.colorTransform = colorTF;
						MainGameUI.game.mainUI.energyBar.scaleX = 1;
						curr = max;
						Player.resources["curr" + resource] = curr;
					}
					MainGameUI.game.mainUI.energyLabel.text = curr + "/" + max;
					break;
				case "Capacity":
					if (curr <= max) {
						colorTF.color = 0xFF6600;
						MainGameUI.game.mainUI.capacityBar.transform.colorTransform = colorTF;
						MainGameUI.game.mainUI.capacityBar.scaleX = curr / max;
						MainGameUI.game.mainUI.capacityLabel.text = Math.round(MainGameUI.game.mainUI.capacityBar.scaleX * 100) + "%";
					} else {
						colorTF.color = 0xDD0000;
						MainGameUI.game.mainUI.capacityBar.transform.colorTransform = colorTF;
						MainGameUI.game.mainUI.capacityBar.scaleX = 1;
						MainGameUI.game.mainUI.capacityLabel.text = "Danger";
						/*if (Player.resources["currCapacity"] > Player.derivedStats["cap"])
							gameOver(1);*/
					}
					break;
			}
			
			calcStats(true);
		}
		
		public static function addStat(stat:String, x:int):void {
			Player.stats[stat] += x;
			
			if (Player.stats[stat] > 99999) {
				Player.stats[stat] = 99999;
				addText("Stat cap reached.\npls wat r u doing wit ur lyfe?");
			}
			
			switch (stat) {
				case "str":
					MainGameUI.game.mainUI.strLabel.text = Player.stats[stat].toString();
					Player.derivedStats["atk"] += x;
					Player.derivedStats["weight"] += 0.5 * x;
					break;
				case "agi":
					MainGameUI.game.mainUI.agiLabel.text = Player.stats[stat].toString();
					Player.derivedStats["dodge"] += x;
					break;
				case "vit":
					MainGameUI.game.mainUI.vitLabel.text = Player.stats[stat].toString();
					Player.derivedStats["def"] += x;
					Player.derivedStats["mdef"] += 0.3 * x;
					break;
				case "int":
					MainGameUI.game.mainUI.intLabel.text = Player.stats[stat].toString();
					Player.derivedStats["matk"] += x;
					Player.derivedStats["mdef"] += 0.7 * x;
					break;
				case "dex":
					MainGameUI.game.mainUI.dexLabel.text = Player.stats[stat].toString();
					Player.derivedStats["acc"] += x;
					Player.derivedStats["dodge"] += 0.2 * x;
					break;
				case "vor":
					MainGameUI.game.mainUI.vorLabel.text = Player.stats[stat].toString();
					Player.derivedStats["cap"] += x;
					break;
			}
			
			/*trace("\natk = " + Player.derivedStats["atk"]);
			trace("matk = " + Player.derivedStats["matk"]);
			trace("def = " + Player.derivedStats["def"]);
			trace("mdef = " + Player.derivedStats["mdef"]);
			trace("acc = " + Player.derivedStats["acc"]);
			trace("dodge = " + Player.derivedStats["dodge"]);*/
		}
		
		public static function setStat(stat:String, x:int):void {
			if (x < 0)
				x = Player.stats[stat];
			
			Player.stats[stat] = x;
			
			if (Player.stats[stat] > 99999) {
				Player.stats[stat] = 99999;
				addText("Stat cap reached.\npls wat r u doing wit ur lyfe?");
			}
			
			x = Player.stats[stat];
			
			switch (stat) {
				case "str":
					MainGameUI.game.mainUI.strLabel.text = x.toString();
					break;
				case "agi":
					MainGameUI.game.mainUI.agiLabel.text = x.toString();
					break;
				case "vit":
					MainGameUI.game.mainUI.vitLabel.text = x.toString();
					break;
				case "int":
					MainGameUI.game.mainUI.intLabel.text = x.toString();
					break;
				case "dex":
					MainGameUI.game.mainUI.dexLabel.text = x.toString();
					break;
				case "vor":
					MainGameUI.game.mainUI.vorLabel.text = x.toString();
					break;
			}
			
			calcStats(true);
		}
		
		public static function addFat(x:Number):void {
			Player.fat += x;
			
			if (Player.fat < 0) {
				Player.fat = 0;
			} else if (Player.fat > 999999999999) {
				Player.fat = 999999999999;
				addText("Max fatness reached.\nHow you're still getting around is beyond me. But hey! You're a giant mountain of fat! 8D");
			}
			
			MainGameUI.game.mainUI.fatLabel.text = Math.round(Player.fat);
		}
		
		public static function setFat(x:Number):void {
			Player.fat = x;
			
			if (Player.fat < 0) {
				Player.fat = 0;
			} else if (Player.fat > 999999999999) {
				Player.fat = 999999999999;
				addText("Max fatness reached.\nHow you're still getting around is beyond me. But hey! You're a giant mountain of fat! 8D");
			}
			
			MainGameUI.game.mainUI.fatLabel.text = Math.round(Player.fat);
		}
		
		public static function addGold(x:Number):void {
			Player.gold += x;
			if (x > 0)
				addText("You got " + x + " gold.");
			else
				addText("You lost " + -x + " gold.");
			
			if (Player.gold > 999999999999) {
				Player.gold = 999999999999;
				addText("Max gold reached.\npls wat r u doing wit ur lyfe?");
			} else if (Player.gold < 0) {
				Player.gold = 0;
			}
			
			MainGameUI.game.mainUI.goldLabel.text = Player.gold;
		}
		
		public static function setGold(x:Number):void {
			var diff:Number = x - Player.gold;
			Player.gold = x;
			if (diff > 0)
				addText("You got " + diff + " gold.");
			else if (diff < 0)
				addText("You lost " + -diff + " gold.");
			
			if (Player.gold > 999999999999) {
				Player.gold = 999999999999;
				addText("Max gold reached.\npls wat r u doing wit ur lyfe?");
			} else if (Player.gold < 0) {
				Player.gold = 0;
			}
			
			MainGameUI.game.mainUI.goldLabel.text = Player.gold;
		}
		
		public static function addExp(x:int, levelup:Boolean):void {
			Player.currExp += x;
			MainGameUI.game.mainUI.expLabel.text = Player.currExp + "/" + Player.maxExp;
			MainGameUI.game.mainUI.expBar.scaleX = Player.currExp / Player.maxExp;
			
			if (x > 0 && !levelup)
				addText("You gained " + x + " experience.");
			
			if (Player.currExp >= Player.maxExp) {
				var overflow:int = Player.levelUp();
				addText("Level up!");
				MainGameUI.game.mainUI.levelLabel.text = Player.level.toString();
				MainGameUI.game.lvlupUI.ptsLabel.text = Player.statPoints;
				MainGameUI.game.lvlupUI.visible = true;
				
				setResource("Health", Player.resources["maxHealth"], -1);
				setResource("Mana", Player.resources["maxMana"], -1);
				setResource("Energy", Player.resources["maxEnergy"], -1);
				
				addExp(overflow, true);
			}
		}
		
		public static function calcStats(flag:Boolean = false):void {
			if (flag)
				removeEquipBonuses();
			
			Player.derivedStats["atk"] = Player.stats["str"];
			Player.derivedStats["matk"] = Player.stats["int"];
			Player.derivedStats["def"] = Player.stats["vit"];
			Player.derivedStats["mdef"] = 0.3 * Player.stats["vit"] + 0.7 * Player.stats["int"];
			Player.derivedStats["acc"] = 0.2 * Player.stats["agi"] + Player.stats["dex"];
			Player.derivedStats["dodge"] = Player.stats["agi"] + 0.2 * Player.stats["dex"];
			Player.derivedStats["cap"] = Player.resources["maxCapacity"] + Player.stats["vor"];
			Player.derivedStats["weight"] = 2.2 * (50 + 2.3 * (Player.height - 60)) + 0.5 * Player.stats["str"] + Player.fat + 0.03 * Player.resources["currCapacity"];
			
			if (flag)
				addEquipBonuses();
		}
		
		public static function updateStats():void {
			Player.derivedStats["atk"] += Player.stats["str"];
			Player.derivedStats["matk"] += Player.stats["int"];
			Player.derivedStats["def"] += Player.stats["vit"];
			Player.derivedStats["mdef"] += 0.3 * Player.stats["vit"] + 0.7 * Player.stats["int"];
			Player.derivedStats["acc"] += 0.2 * Player.stats["agi"] + Player.stats["dex"];
			Player.derivedStats["dodge"] += Player.stats["agi"] + 0.2 * Player.stats["dex"];
			Player.derivedStats["cap"] += Player.resources["maxCapacity"] + Player.stats["vor"];
			Player.derivedStats["weight"] += 2.2 * (50 + 2.3 * (Player.height - 60)) + 0.5 * Player.stats["str"] + Player.fat + 0.03 * Player.resources["currCapacity"];
		}
		
		public static function addEquipBonuses():void {
			for each (var item:Item in Player.equipment) {
				if (item != null) {
					item.deprocEffects();
					item.procEffects();
				}
			}
		}
		
		public static function removeEquipBonuses():void {
			for each (var item:Item in Player.equipment) {
				if (item != null)
					item.deprocEffects();
			}
		}
		
		public static function loot(item:Item, x:int):void {
			var retString:String = "";
			
			if (x == 1)
				retString = "You got a " + item.name + ". ";
			else if (x > 1)
				retString = "You got " + x + " " + item.plural + ". ";
			
			if (x > 0) {
				var index:int = Player.indexOfInventory(item);
				if (index == -1) {
					Player.inventory.push(item);
					index = Player.indexOfInventory(item);
				}
				
				item = Player.inventory[index];
				item.count += x;
				
				retString += "You now have " + Player.inventory[index].count + " ";
				if (Player.inventory[index].count > 1)
					retString += item.plural + ".";
				else
					retString += item.name + ".";
			}
			
			//ItemDefinitions.main = this;		//ItemDefinitions.main is null for some ungodly reason
			
			if (MainGameUI.state == "buying" && MainGameUI.menuItemSelected) {
				retString = item.toString("buyingSelected") + retString;
				setText(retString);
			} else {
				retString = item.toString(MainGameUI.state) + retString;
				addText(retString);
			} 
			
			//if (MainGameUI.state != "buying" && MainGameUI.state != "selling")
				//addText(retString);
		}
		
		public static function drop(item:Item, x:int):void {
			var index:int = Player.indexOfInventory(item);
			var retString:String = "";
			if (MainGameUI.state == "inventory")
				retString = "\n\n";
			
			if (item.canDrop && index != -1) {
				if (Player.inventory[index].count >= x) {
					Player.inventory[index].count -= x;
					
					if (x == 1)
						retString += "You lost a " + item.name + ". ";
					else if (x > 1)
						retString += "You lost " + x + " " + item.plural + ". ";
					
					if (Player.inventory[index].count <= 0) {
						Player.inventory.splice(index, 1);
						retString += "You don't have any more " + item.plural + ".";
					} else {
						retString += "You now have " + Player.inventory[index].count + " ";
						
						if (Player.inventory[index].count > 1)
							retString += item.plural + ".";
						else
							retString += item.name + ".";
					}
				} else
					retString += "You don't have that many " + item.plural + ".";
            } else if (index == -1)
				retString += "You don't have any more " + item.plural + ".";
			else if (!item.canDrop)
				retString += "You can't discard this item.";
			
			if (MainGameUI.state == "selling" && MainGameUI.menuItemSelected) {
				retString = item.toString("sellingSelected") + retString;
				setText(retString);
			} else if (MainGameUI.state == "inventory" && MainGameUI.menuItemSelected) {
				retString = item.toString("inventorySelected") + retString;
				setText(retString);
			} else {
				retString = item.toString(MainGameUI.state) + retString;
				addText(retString);
			}
			
			//if (MainGameUI.state != "buying" && MainGameUI.state != "selling")
				//addText(retString);
		}
		
		public static function useItem(item:Item):Boolean {
			if (Player.getItemFromInventory(item) == null) {
				setText(item.toString("inventorySelected") + "\n\nYou don't have any more " + item.plural + ".");
				return false;
			}
			
			item = Player.getItemFromInventory(item);
			var itemCopy:Item = ItemDefinitions.getItem(item.name);
			
			if (item.equip) {
				if (item.head) {
					if (Player.equipment["head"] != null)
						unequip(Player.equipment["head"]);
					Player.equipment["head"] = itemCopy;
					trace(Player.equipment["head"].name + " equipped.");
				} else if (item.torso) {
					if (Player.equipment["torso"] != null)
						unequip(Player.equipment["torso"]);
					Player.equipment["torso"] = itemCopy;
					trace(Player.equipment["torso"].name + " equipped.");
				} else if (item.legs) {
					if (Player.equipment["legs"] != null)
						unequip(Player.equipment["legs"]);
					Player.equipment["legs"] = itemCopy;
					trace(Player.equipment["legs"].name + " equipped.");
				} else if (item.feet) {
					if (Player.equipment["feet"] != null)
						unequip(Player.equipment["feet"]);
					Player.equipment["feet"] = itemCopy;
					trace(Player.equipment["feet"].name + " equipped.");
				} else if (item.weapon) {
					if (item.twoHanded && Player.equipment["shield"] != null) {
						setText(item.toString("inventorySelected") + "\n\nA two-handed weapon and a shield cannot be equipped simultaneously.");
						return true;
					} else {
						if (Player.equipment["weapon"] != null)
							unequip(Player.equipment["weapon"]);
						Player.equipment["weapon"] = itemCopy;
						trace(Player.equipment["weapon"].name + " equipped.");
					}
				} else if (item.shield) {
					if (Player.equipment["weapon"] == null || !Player.equipment["weapon"].twoHanded) {
						if (Player.equipment["shield"] != null)
							unequip(Player.equipment["shield"]);
						Player.equipment["shield"] = itemCopy;
						trace(Player.equipment["shield"].name + " equipped.");
					} else {
						setText(item.toString("inventorySelected") + "\n\nA two-handed weapon and a shield cannot be equipped simultaneously.");
						return true;
					}
				}
				addEquipBonuses();
			} else {
				itemCopy.procEffects();
				trace(item.name + " used.");
			}
			
			var index:int = Player.indexOfInventory(item);
			
			Player.inventory[index].count--;
			if (Player.inventory[index].count <= 0)
				Player.inventory.splice(index, 1);
			
			if (item.equip)
				setText(item.toString("inventorySelected") + "\n\nYou equipped a " + item.name + ".");
			else
				setText(item.toString("inventorySelected") + "\n\nYou used a " + item.name + ".");
			
			return isPlayerAlive();
		}

		public static function unequip(item:Item):void {
			trace("Unequipping " + item.name);
			item.deprocEffects();		// remove special effects of old item
			if (item.head)
				Player.equipment["head"] = null;
			else if (item.torso)
				Player.equipment["torso"] = null;
			else if (item.legs)
				Player.equipment["legs"] = null;
			else if (item.feet)
				Player.equipment["feet"] = null;
			else if (item.weapon)
				Player.equipment["weapon"] = null;
			else if (item.shield)
				Player.equipment["shield"] = null;
			
			item.count = 0;
			loot(item, 1);
			//updateStats();
			trace(item.name + " unequipped.");
		}

		public static function buy(item:Item):Boolean {
			if (Player.gold >= item.value) {
				loot(item, 1);
				addGold(-item.value);
				return true;
			} else {
				return false;
			}
		}
		
		public static function sell(item:Item):Boolean {
			if (item.canDrop && Player.indexOfInventory(item) != -1) {
				drop(item, 1);
				addGold(Math.round(0.5 * item.value));
				return true;
			} else {
				return false;
			}
		}

		public static function writeAppearance():String {
			appearanceText = Player.name + " -- " + Math.floor(Player.height / 12) + "'" + (Player.height % 12) + "\", " + Math.round(Player.derivedStats["weight"]) + "lbs";
			appearanceText += "\n\n";
			
			if (Player.fat < 50)
				appearanceText += "Your body is about as unremarkable as can be. Neither an ounce of fat nor muscle is evident on your scrawny frame. You aren’t malnourished by any means, but compared to others, you find yourself sticking out of the crowd more and more with each passing day. It seems that, as of late, those around you have begun to set a new norm. Instead of the traditional ideal of a muscular, or at least slim and toned, body, people appear to be shifting toward the opposite end of the spectrum, steadily blimping out with fat as they gorge upon the recent, inexplicable bounty of Mother Nature. Perhaps it’s time you catch on with the crowd and put some much-needed meat on your bones.";
			else if (Player.fat < 100)
				appearanceText += "A layer of pudge has accumulated on your form. It’s nothing particularly notable, but at least you fit in, if only a little. Your face is rounder with cheeks slightly fuller while more than a few pounds have found their way around your middle. Your arms feel heavier and your legs somewhat thicker, causing your thighs to brush against one another every now and again. Even your chest seems a bit more on the perky side than usual. Still, nothing about you is more than a little bulbous. Although your stomach is hardly a subtle bulge at best, it’s a slippery slope from here.";
			else if (Player.fat < 200)
				appearanceText += "You’re fat, and there’s no way around the fact now. Your body has grown heavy with excess flesh, much like those around you, as it’s starting to impede you in doing simple tasks. Your gut, a squishy pot belly that’s beginning to droop over your waistline, jiggles with every step you take, making something as mundane as walking a task in itself. Meanwhile, your arms too are sagging somewhat with fat, biceps wobbling to and fro as you take swings at your enemies. You’re at the cusp of obesity; the second chin around your neck is a telltale sign of what’s to come.";
			else if (Player.fat < 400)
				appearanceText += "With your belly now jutting out over a foot in front of you, it’s clear that you’ve been getting more than your fair share of food lately. Although, your share may be more fair than you’d think. There appears to be an endless supply of food at the local pub, always ready for your, as well as everyone else’s, consumption. As it sits in your lap, rolling over and conforming to the curvature of your swollen thighs, that sloshing table muscle always seems to get its way when it hungers for more. You stop at nothing until your stomach is packed tight and ready to burst, your arms, having grown thick with lard, patiently waiting for the next command.";
			else
				appearanceText += "At this point, you’ve gone beyond what appears to be even the social norm these days. Of course, there are still plenty of people as big as you, or bigger, but even your body is starting to turn a few heads. Your head, with puffy snout and bulging cheeks, almost looks like it’s sinking into the rest of your body, a thick ring of fat swallowing and completely obscuring your stump of a neck. You can barely rest your bulbous arms, their elbows and joints swollen with fat, at forty-five degree angles as they’re permanently propped up by the flab accumulating and drooping down your chest, settling on top of your belly’s massive girth. Even while standing, your enormous tree trunk thighs are only barely visible above knees completely caked in blubber.";
			
			appearanceText += "\n\n";
			var isEmpty:Boolean = true;
			if (Player.equipment["head"] != null) {
				appearanceText += "Head: " + Player.equipment["head"].toString("appearance") + "\n\n";
				//appearanceText += "Head:\n" + Player.equipment["head"].name + " - " + Player.equipment["head"].short + "\n\n";
				isEmpty = false;
			}
			if (Player.equipment["torso"] != null) {
				appearanceText += "Torso: " + Player.equipment["torso"].toString("appearance") + "\n\n";
				//appearanceText += "Torso:\n" + Player.equipment["torso"].name + " - " + Player.equipment["torso"].short + "\n\n";
				isEmpty = false;
			}
			if (Player.equipment["legs"] != null) {
				appearanceText += "Legs: " + Player.equipment["legs"].toString("appearance") + "\n\n";
				//appearanceText += "Legs:\n" + Player.equipment["legs"].name + " - " + Player.equipment["legs"].short + "\n\n";
				isEmpty = false;
			}
			if (Player.equipment["feet"] != null) {
				appearanceText += "Feet: " + Player.equipment["feet"].toString("appearance") + "\n\n";
				//appearanceText += "Feet:\n" + Player.equipment["feet"].name + " - " + Player.equipment["feet"].short + "\n\n";
				isEmpty = false;
			}
			if (Player.equipment["weapon"] != null) {
				appearanceText += "Weapon: " + Player.equipment["weapon"].toString("appearance") + "\n\n";
				//appearanceText += "Weapon:\n" + Player.equipment["weapon"].name + " - " + Player.equipment["weapon"].short + "\n\n";
				isEmpty = false;
			}
			if (Player.equipment["shield"] != null) {
				appearanceText += "Shield: " + Player.equipment["shield"].toString("appearance") + "\n\n";
				//appearanceText += "Shield:\n" + Player.equipment["shield"].name + " - " + Player.equipment["shield"].short + "\n\n";
				isEmpty = false;
			}
			
			if (isEmpty)
				appearanceText += "You are not wearing any equipment.";
			
			return appearanceText;
		}

		public static function writeInventory():String {			
			switch (MainGameUI.state) {
				case "inventory" :
				case "combatInventory" :
					inventoryText = "Inventory\n\n";
					
					if (Player.inventory.length == 0) {
						inventoryText += "Your inventory is empty.";
					} else {
						for each (var item:Item in Player.inventory) {
							inventoryText += item.toString("inventory") + "\n\n";
							/*if (item.effectsText == "")
								inventoryText += item.name + " x" + item.count + "\n" + item.short + "\n\n";
							else
								inventoryText += item.name + " x" + item.count + "\n" + item.effectsText + "\n" + item.short + "\n\n";*/
						}
					}
					break;
				case "selling" :
					inventoryText = "Selling\n\n--------------------------------------------------\n\n";
					
					if (Player.inventory.length == 0) {
						inventoryText += "You have nothing to sell.";
					} else {
						for each (var sell:Item in Player.inventory) {
							inventoryText += sell.toString("selling") + "\n\n";
							/*if (sell.effectsText == "")
								inventoryText += sell.name + " x" + sell.count + " -- " + Math.round(0.5 * sell.value) + " gold ea.\n" +
									sell.short + "\n\n";
							else
								inventoryText += sell.name + " x" + sell.count + " -- " + Math.round(0.5 * sell.value) + " gold ea.\n" +
									item.effectsText + "\n" + sell.short + "\n\n";*/
						}
					}
					break;
				default :
					break;
			}
			
			return inventoryText;
		}
		
		public static function writeQuests():String {
			questsText = "Quests\n\n";
			
			if (Player.quests.length == 0) {
				questsText += "You currently have no quests.";
			} else {
				for each (var quest:GameEvent in Player.quests) {
					questsText += quest.name + "\n" + quest.log + "\n\n";
				}
			}
			
			return questsText;
		}
		
		public static function writeStock():String {
			var text:String = "Buying\n\n--------------------------------------------------\n\n";
			for each (var item:Item in World.world[Player.x][Player.y].stock) {
				text += item.name + " -- " + item.value + " gold ea. -- ";
				
				if (Player.indexOfInventory(item) != -1)
					text += Player.inventory[Player.indexOfInventory(item)].count;
				else
					text += "0";
				
				text += item.toString("buying");
				/*if (item.effectsText == "")
					text += " in inventory\n" + item.short + "\n\n";
				else
					text += " in inventory\n" + item.effectsText + "\n" + item.short + "\n\n";*/
			}
			
			return text;
		}
		
		public static function isPlayerAlive():Boolean {
			if (Player.resources["currCapacity"] > Player.derivedStats["cap"]) {
				endCombat(false);
				Player.isAlive = false;
				gameOver(1);
			} else if (Player.resources["currHealth"] <= 0) {
				endCombat(false);
				Player.isAlive = false;
				gameOver(0);
			}
			
			return Player.isAlive;
		}
		
		public static function startCombat(enemy:Enemy):void {
			combat = new Combat(enemy);
			MainGameUI.displayCombat(enemy);
		}
		
		public static function endCombat(win:Boolean):void {
			if (MainGameUI.state != "combat" && MainGameUI.state != "combatInventory" && MainGameUI.state != "combatSkills")
				return;
			
			MainGameUI.hideBtnArray();
			MainGameUI.game.btnsUI.upBtn.visible = false;
			MainGameUI.game.btnsUI.downBtn.visible = false;
			
			if (win) {
				MainGameUI.game.combatUI.visible = false;
				MainGameUI.game.menuUI.visible = false;
				MainGameUI.btnArray[8].btnText.text = "Continue";
				MainGameUI.btnArray[8].visible = true;
			} else {
				MainGameUI.updateMenuBtns();
				MainGameUI.game.combatUI.attackBtn.visible = false;
				MainGameUI.game.combatUI.inventoryBtn.visible = false;
				MainGameUI.game.combatUI.skillsBtn.visible = false;
				MainGameUI.game.combatUI.runBtn.visible = false;
				MainGameUI.game.combatUI.devourBtn.visible = false;
				MainGameUI.game.combatUI.surrenderBtn.visible = false;
			}
		}
		
		public static function gameOver(cause:int):void {
			MainGameUI.state = "gameover";
			
			Player.isAlive = false;
			MainGameUI.hideBtnArray();
			MainGameUI.menuItemSelected = false;
			MainGameUI.game.btnsUI.upBtn.visible = false;
			MainGameUI.game.btnsUI.downBtn.visible = false;
			MainGameUI.updateMenuBtns();
			setResource("Health", 0, -1);
			
			if (MainGameUI.game.mainUI.textField.text.substring(MainGameUI.game.mainUI.textField.text.length - 27) != "Load your last saved state.") {
				if (cause == 0)
					addText("----------\n\nYou have been slain.");
				else if (cause == 1)
					addText("----------\n\nYou have eaten yourself into a food coma.");
				else if (cause == 2)
					addText("----------\n\nYou have collapsed from exhaustion.");
				else if (cause == 3)
					addText("----------\n\nYou have been devoured.");
				else
					addText("----------\n\nYou died.");
				
				addText("Load your last saved state.");
			}
			
		}
	}
}
