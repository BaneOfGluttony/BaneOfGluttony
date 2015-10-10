package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	
	import Quests.*;
	
		
	/**
	 * ...
	 * @author Kazan Fatzan, refactor by Serule Blue
	 */
	public class Main extends MovieClip {
		/// Class containing all of the "timeline" code
		public var mainMC:MainGameUI;
		
		/// Reference to the main Runner class (use to access stage, etc.)
		public var runner:Runner;
		
		flash.net.registerClassAlias("Player", Player);
		flash.net.registerClassAlias("Item", Item);
		flash.net.registerClassAlias("GameEvent", GameEvent);
		//flash.net.registerClassAlias("Main", Main);
		
		public var player:Player = new Player();
		public var combat:Combat;
		public var currEvent:GameEvent;
		
		//{ Text
		public var optionsText:String = "Options\n\nTo be implemented.\n\nControls should be self-explanatory. In addition to using the mouse, keyboard control is also possible for most functions:\nWASD/Arrow Keys/Numpad - Navigation (numpad can move diagonally)\nU - Open appearance\nI - Open inventory\nJ - Open quests\nK - Open skills\nM - Toggle map\nEnter - Enter a particular area\nBackspace - Go back one menu\nPage Up/Down - Scroll through button menus\nEsc - Options\n\nCredits (FurAffinity usernames unless otherwise noted)\n\nIntroduction Text - PowersNDark\nIdeas - Mysticmightg, Anonymous\nSome Weapon Text - Sinwraith\nAS3 Advisor - Serule\nEverything Else - Kazan.K";
		public var mainText:String = "While time is the great keeper of all, there will always remain the events and artifacts that even he cannot keep eternal. Expunged from the very world they tried to conquer, the earliest civilizations of Karthund were lost to the ravages of time, and the plague that struck down their people has long since been forgotten. Despite being erased from history itself, the aftermath of this great catastrophe still surfaces and ripples far into the future of generations to come. Unbeknownst to any, the cause of this calamity lives on, trapped in a seal containing the very essence of this powerful force. However, through malicious intent or an unfortunate accident, this seal has been broken.\n\nEvil has spread across the land, contaminating the earth, the water, and everything in its path. Although, perhaps not in the most obvious of ways. Rich and fertile fields, once known for their bountiful crops, had changed in a matter of weeks. Now, seen simply as a miracle by the gods, the soil promotes nothing short of rampant growth in anything it feeds. Never before have forests been more dense and lush, hills and mountains been so overgrown with vegetation, and livestock been fattened to more than double their weight. The boundless abundance of mother nature has seen to it that even the poorest of farmers have begun producing enough to appease the exploding appetites of entire villages.\n\nWhile crops flourish and civilization and wildlife alike gorge upon this newfound bounty, the essence of the ancient seal continues its march across Karthund. The inhabitants of this land are falling prey to this new evil while those afflicted slowly find their world becoming muted and dull as baser instincts take hold of their minds. An insatiable hunger for food will overwhelm them. The unrelenting desires of hedonistic gluttony will drive them to consume all that lie before them – only to leave themselves famished and starving for more, trapped in an endless cycle of ravenous greed.";
		public var appearanceText:String = "Appearance";
		public var inventoryText:String = "Inventory";
		public var skillsText:String = "Skills\n\nTo be implemented.";
		public var questsText:String = "Quests\n\nTo be implemented.";
		public var combatText:String = "Combat";
		//}
		
		public var credits:Array = ["PowersNDark", "Mysticmightg", "Sinwraith", "Serule", "Kazan.K"];
		
		public function Main(_runner:Runner) {
			runner = _runner;
			mainMC = new MainGameUI(this);
			//ItemDefinitions.main = this;
			//SkillDefinitions.main = this;
		}
		
		// called by MainGameUI after it is added to the Stage
		public function firstInit():void {
			for each (var name:String in credits)
				optionsText = optionsText.replace(name, '<u><a href="event:' + name + '">' + name + '</a></u>');
			
			ItemDefinitions.main = this;
			SkillDefinitions.main = this;
			
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
		}
		
		public function reInit():void {
			setResource("Health", player.resources["currHealth"], player.resources["maxHealth"]);
			setResource("Mana", player.resources["currMana"], player.resources["maxMana"]);
			setResource("Energy", player.resources["currEnergy"], player.resources["maxEnergy"]);
			setResource("Capacity", player.resources["currCapacity"], player.resources["maxCapacity"]);
			addExp(0, false);
			setStat("str", player.stats["str"]);
			setStat("agi", player.stats["agi"]);
			setStat("vit", player.stats["vit"]);
			setStat("int", player.stats["int"]);
			setStat("dex", player.stats["dex"]);
			setStat("vor", player.stats["vor"]);
			setFat(player.fat);
			setGold(player.gold);
			
			mainMC.state = "navigate";
			mainMC.menuItemSelected = false;
			
			mainMC.game.btnsUI.upBtn.visible = false;
			mainMC.game.btnsUI.downBtn.visible = false;
			mainMC.game.combatUI.visible = false;
			mainMC.game.optionsBtn.gotoAndStop(1);
			mainMC.game.menuUI.appearanceBtn.gotoAndStop(1);
			mainMC.game.menuUI.inventoryBtn.gotoAndStop(1);
			mainMC.game.menuUI.skillsBtn.gotoAndStop(1);
			mainMC.game.menuUI.questsBtn.gotoAndStop(1);
			
			mainMC.updateMenuBtns();
			mainMC.updateNavBtns();
			mainMC.updateMaps();
			calcStats(true);
			
			trace("\natk = " + player.derivedStats["atk"]);
			trace("matk = " + player.derivedStats["matk"]);
			trace("def = " + player.derivedStats["def"]);
			trace("mdef = " + player.derivedStats["mdef"]);
			trace("acc = " + player.derivedStats["acc"]);
			trace("dodge = " + player.derivedStats["dodge"]);
			trace("cap = " + player.resources["currCapacity"] + " / " + player.resources["maxCapacity"] + " (" + player.derivedStats["cap"] + ")");
			trace("state = " + mainMC.state);
		}
		
		public function addText(txt:String):void {
			if (txt == "")
				return;
			
			switch (mainMC.state) {
				case "combat" :
				case "combatInventory" :
				case "combatSkills" :
					combatText += "\n" + txt;
					setText(combatText);
					break;
				case "dialog" :
					mainMC.game.mainUI.textField.appendText("\n\n" + txt);
					mainMC.game.mainUI.scrollBar.scrollPosition = mainMC.game.mainUI.scrollBar.minScrollPosition;
					break;
				case "navigate" :
					mainText += "\n\n" + txt;
				default :
					mainMC.game.mainUI.textField.appendText("\n\n" + txt);
					mainMC.game.mainUI.scrollBar.scrollPosition = mainMC.game.mainUI.scrollBar.maxScrollPosition;
					break;
			}
			
			mainMC.game.mainUI.scrollBar.update();
		}
		
		public function setText(txt:String):void {
			if (txt == "")
				return;
			
			switch (mainMC.state) {
				case "navigate" :
					mainText = txt;
				default :
					mainMC.game.mainUI.textField.text = txt;
					break;
			}
			
			mainMC.game.mainUI.scrollBar.scrollPosition = mainMC.game.mainUI.scrollBar.minScrollPosition;
			mainMC.game.mainUI.scrollBar.update();
		}
		
		public function saveGame():void {
			try {
				var saveFile:SharedObject = SharedObject.getLocal("GameFile");
				var playerData:ByteArray = new ByteArray();
				var equipmentData:ByteArray = new ByteArray();
				var questsData:ByteArray = new ByteArray();
				playerData.writeObject(player);
				equipmentData.writeObject(player.equipment);
				questsData.writeObject(player.quests);
				saveFile.data.playerData = playerData;
				saveFile.data.equipmentData = equipmentData;
				saveFile.data.questsData = questsData;
				
				saveFile.flush();
				trace("Game saved");
				addText("Game saved");
			} catch (e:Error) {
				trace("Game save error: " + e.getStackTrace());
				addText("Could not write save file.");
				mainMC.game.mainUI.debugConsole.text += "\n" + e.message + "\n" + e.getStackTrace();
			}
		}
		
		public function loadGame():void {
			try {
				var saveFile:SharedObject = SharedObject.getLocal("GameFile");
				var playerData:ByteArray = saveFile.data.playerData as ByteArray;
				var equipmentData:ByteArray = saveFile.data.equipmentData as ByteArray;
				var questsData:ByteArray = saveFile.data.questsData as ByteArray;
				playerData.position = 0;
				player = playerData.readObject() as Player;
				equipmentData.position = 0;
				player.equipment = equipmentData.readObject() as Object;
				questsData.position = 0;
				player.quests = questsData.readObject() as Array;
				
				setResource("Health", player.resources["currHealth"], player.resources["maxHealth"]);
				setResource("Mana", player.resources["currMana"], player.resources["maxMana"]);
				setResource("Energy", player.resources["currEnergy"], player.resources["maxEnergy"]);
				setResource("Capacity", player.resources["currCapacity"], player.resources["maxCapacity"]);
				setStat("str", player.stats["str"]);
				setStat("agi", player.stats["agi"]);
				setStat("vit", player.stats["vit"]);
				setStat("int", player.stats["int"]);
				setStat("dex", player.stats["dex"]);
				setStat("vor", player.stats["vor"]);
				setFat(player.fat);
				setGold(player.gold);
				
				mainMC.game.mainUI.expLabel.text = player.currExp + "/" + player.maxExp;
				mainMC.game.mainUI.expBar.scaleX = player.currExp / player.maxExp;
				mainMC.game.mainUI.levelLabel.text = player.level.toString();
				
				reInit();
				
				trace("Game loaded");
				mainMC.travel(player.x, player.y);
			} catch (e:Error) {
				trace("Could not load save file.\n" + e.getStackTrace());
				addText("Could not load save file.");
				mainMC.game.mainUI.debugConsole.text += "\n" + e.message + "\n" + e.getStackTrace();
				return;
			}
		}
		
		public function addResource(resource:String, deltaCurr:Number, deltaMax:Number):void { //use a separate takeDamage/feed method that uses this		
			player.resources["max" + resource] += deltaMax;
			player.resources["curr" + resource] += deltaCurr;
			
			if (player.resources["max" + resource] > 99999) {
				player.resources["max" + resource] = 99999;
				addText("Stat cap reached.\npls wat r u doing wit ur lyfe?");
			} else if (player.resources["max" + resource] <= 0)
				player.resources["max" + resource] = 1;
			var max:int = player.resources["max" + resource];
			
			if (player.resources["curr" + resource] > 99999) {
				player.resources["curr" + resource] = 99999;
				addText("stahp wat hav u done?");
			} else if (player.resources["curr" + resource] < 0)
				player.resources["curr" + resource] = 0;
			var curr:int = player.resources["curr" + resource];
			
			var colorTF:ColorTransform = new ColorTransform();
			
			switch (resource) {
				case "Health":
					if (curr <= max) {
						mainMC.game.mainUI.healthBar.scaleX = curr / max;
						if (mainMC.game.mainUI.healthBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							mainMC.game.mainUI.healthBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0x009900;
							mainMC.game.mainUI.healthBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0x009900;
						mainMC.game.mainUI.healthBar.transform.colorTransform = colorTF;
						mainMC.game.mainUI.healthBar.scaleX = 1;
						curr = max;
						player.resources["curr" + resource] = curr;
					}
					mainMC.game.mainUI.healthLabel.text = curr + "/" + max;
					break;
				case "Mana":
					if (curr <= max) {
						mainMC.game.mainUI.manaBar.scaleX = curr / max;
						if (mainMC.game.mainUI.manaBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							mainMC.game.mainUI.manaBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0x0066FF;
							mainMC.game.mainUI.manaBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0x0066FF;
						mainMC.game.mainUI.manaBar.transform.colorTransform = colorTF;
						mainMC.game.mainUI.manaBar.scaleX = 1;
						curr = max;
						player.resources["curr" + resource] = curr;
					}
					mainMC.game.mainUI.manaLabel.text = curr + "/" + max;
					break;
				case "Energy":
					mainMC.game.mainUI.energyLabel.text = curr + "/" + max;
					if (curr <= max) {
						mainMC.game.mainUI.energyBar.scaleX = curr / max;
						if (mainMC.game.mainUI.energyBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							mainMC.game.mainUI.energyBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0xFFFF66;
							mainMC.game.mainUI.energyBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0xFFFF66;
						mainMC.game.mainUI.energyBar.transform.colorTransform = colorTF;
						mainMC.game.mainUI.energyBar.scaleX = 1;
						curr = max;
						player.resources["curr" + resource] = curr;
					}
					mainMC.game.mainUI.energyLabel.text = curr + "/" + max;
					break;
				case "Capacity":
					if (curr <= max) {
						colorTF.color = 0xFF6600;
						mainMC.game.mainUI.capacityBar.transform.colorTransform = colorTF;
						mainMC.game.mainUI.capacityBar.scaleX = curr / max;
						mainMC.game.mainUI.capacityLabel.text = Math.round(mainMC.game.mainUI.capacityBar.scaleX * 100) + "%";
					} else {
						colorTF.color = 0xDD0000;
						mainMC.game.mainUI.capacityBar.transform.colorTransform = colorTF;
						mainMC.game.mainUI.capacityBar.scaleX = 1;
						mainMC.game.mainUI.capacityLabel.text = "Danger";
						/*if (player.resources["currCapacity"] > player.derivedStats["cap"])
							gameOver(1);*/
					}
					player.derivedStats["cap"] += deltaMax;
					player.derivedStats["weight"] += 0.03 * deltaCurr;
					
					break;
			}
			
			/*trace("\natk = " + player.derivedStats["atk"]);
			trace("matk = " + player.derivedStats["matk"]);
			trace("def = " + player.derivedStats["def"]);
			trace("mdef = " + player.derivedStats["mdef"]);
			trace("acc = " + player.derivedStats["acc"]);
			trace("dodge = " + player.derivedStats["dodge"]);*/
		}
		
		public function setResource(resource:String, deltaCurr:Number, deltaMax:Number):void { //use a separate takeDamage/feed method that uses this
			if (deltaMax < 0)
				deltaMax = player.resources["max" + resource];
			
			player.resources["max" + resource] = deltaMax;
			player.resources["curr" + resource] = deltaCurr;
			
			if (player.resources["max" + resource] > 99999) {
				player.resources["max" + resource] = 99999;
				addText("Stat cap reached.\npls wat r u doing wit ur lyfe?");
			} else if (player.resources["max" + resource] <= 0)
				player.resources["max" + resource] = 1;
			var max:int = player.resources["max" + resource];
			
			if (player.resources["curr" + resource] > 99999) {
				player.resources["curr" + resource] = 99999;
				addText("stahp wat hav u done?");
			} else if (player.resources["curr" + resource] < 0)
				player.resources["curr" + resource] = 0;
			var curr:int = player.resources["curr" + resource];
			
			var colorTF:ColorTransform = new ColorTransform();
			
			switch (resource) {
				case "Health":
					if (curr <= max) {
						mainMC.game.mainUI.healthBar.scaleX = curr / max;
						if (mainMC.game.mainUI.healthBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							mainMC.game.mainUI.healthBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0x009900;
							mainMC.game.mainUI.healthBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0x009900;
						mainMC.game.mainUI.healthBar.transform.colorTransform = colorTF;
						mainMC.game.mainUI.healthBar.scaleX = 1;
						curr = max;
						player.resources["curr" + resource] = curr;
					}
					mainMC.game.mainUI.healthLabel.text = curr + "/" + max;
					break;
				case "Mana":
					if (curr <= max) {
						mainMC.game.mainUI.manaBar.scaleX = curr / max;
						if (mainMC.game.mainUI.manaBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							mainMC.game.mainUI.manaBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0x0066FF;
							mainMC.game.mainUI.manaBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0x0066FF;
						mainMC.game.mainUI.manaBar.transform.colorTransform = colorTF;
						mainMC.game.mainUI.manaBar.scaleX = 1;
						curr = max;
						player.resources["curr" + resource] = curr;
					}
					mainMC.game.mainUI.manaLabel.text = curr + "/" + max;
					break;
				case "Energy":
					mainMC.game.mainUI.energyLabel.text = curr + "/" + max;
					if (curr <= max) {
						mainMC.game.mainUI.energyBar.scaleX = curr / max;
						if (mainMC.game.mainUI.energyBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							mainMC.game.mainUI.energyBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0xFFFF66;
							mainMC.game.mainUI.energyBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0xFFFF66;
						mainMC.game.mainUI.energyBar.transform.colorTransform = colorTF;
						mainMC.game.mainUI.energyBar.scaleX = 1;
						curr = max;
						player.resources["curr" + resource] = curr;
					}
					mainMC.game.mainUI.energyLabel.text = curr + "/" + max;
					break;
				case "Capacity":
					if (curr <= max) {
						colorTF.color = 0xFF6600;
						mainMC.game.mainUI.capacityBar.transform.colorTransform = colorTF;
						mainMC.game.mainUI.capacityBar.scaleX = curr / max;
						mainMC.game.mainUI.capacityLabel.text = Math.round(mainMC.game.mainUI.capacityBar.scaleX * 100) + "%";
					} else {
						colorTF.color = 0xDD0000;
						mainMC.game.mainUI.capacityBar.transform.colorTransform = colorTF;
						mainMC.game.mainUI.capacityBar.scaleX = 1;
						mainMC.game.mainUI.capacityLabel.text = "Danger";
						/*if (player.resources["currCapacity"] > player.derivedStats["cap"])
							gameOver(1);*/
					}
					break;
			}
			
			calcStats(true);
		}
		
		public function addStat(stat:String, x:int):void {
			player.stats[stat] += x;
			
			if (player.stats[stat] > 99999) {
				player.stats[stat] = 99999;
				addText("Stat cap reached.\npls wat r u doing wit ur lyfe?");
			}
			
			switch (stat) {
				case "str":
					mainMC.game.mainUI.strLabel.text = player.stats[stat].toString();
					player.derivedStats["atk"] += x;
					player.derivedStats["weight"] += 0.5 * x;
					break;
				case "agi":
					mainMC.game.mainUI.agiLabel.text = player.stats[stat].toString();
					player.derivedStats["dodge"] += x;
					break;
				case "vit":
					mainMC.game.mainUI.vitLabel.text = player.stats[stat].toString();
					player.derivedStats["def"] += x;
					player.derivedStats["mdef"] += 0.3 * x;
					break;
				case "int":
					mainMC.game.mainUI.intLabel.text = player.stats[stat].toString();
					player.derivedStats["matk"] += x;
					player.derivedStats["mdef"] += 0.7 * x;
					break;
				case "dex":
					mainMC.game.mainUI.dexLabel.text = player.stats[stat].toString();
					player.derivedStats["acc"] += x;
					player.derivedStats["dodge"] += 0.2 * x;
					break;
				case "vor":
					mainMC.game.mainUI.vorLabel.text = player.stats[stat].toString();
					player.derivedStats["cap"] += x;
					break;
			}
			
			/*trace("\natk = " + player.derivedStats["atk"]);
			trace("matk = " + player.derivedStats["matk"]);
			trace("def = " + player.derivedStats["def"]);
			trace("mdef = " + player.derivedStats["mdef"]);
			trace("acc = " + player.derivedStats["acc"]);
			trace("dodge = " + player.derivedStats["dodge"]);*/
		}
		
		public function setStat(stat:String, x:int):void {
			if (x < 0)
				x = player.stats[stat];
			
			player.stats[stat] = x;
			
			if (player.stats[stat] > 99999) {
				player.stats[stat] = 99999;
				addText("Stat cap reached.\npls wat r u doing wit ur lyfe?");
			}
			
			x = player.stats[stat];
			
			switch (stat) {
				case "str":
					mainMC.game.mainUI.strLabel.text = x.toString();
					break;
				case "agi":
					mainMC.game.mainUI.agiLabel.text = x.toString();
					break;
				case "vit":
					mainMC.game.mainUI.vitLabel.text = x.toString();
					break;
				case "int":
					mainMC.game.mainUI.intLabel.text = x.toString();
					break;
				case "dex":
					mainMC.game.mainUI.dexLabel.text = x.toString();
					break;
				case "vor":
					mainMC.game.mainUI.vorLabel.text = x.toString();
					break;
			}
			
			calcStats(true);
		}
		
		public function addFat(x:Number):void {
			player.fat += x;
			
			if (player.fat < 0) {
				player.fat = 0;
			} else if (player.fat > 999999999999) {
				player.fat = 999999999999;
				addText("Max fatness reached.\nHow you're still getting around is beyond me. But hey! You're a giant mountain of fat! 8D");
			}
			
			mainMC.game.mainUI.fatLabel.text = Math.round(player.fat);
		}
		
		public function setFat(x:Number):void {
			player.fat = x;
			
			if (player.fat < 0) {
				player.fat = 0;
			} else if (player.fat > 999999999999) {
				player.fat = 999999999999;
				addText("Max fatness reached.\nHow you're still getting around is beyond me. But hey! You're a giant mountain of fat! 8D");
			}
			
			mainMC.game.mainUI.fatLabel.text = Math.round(player.fat);
		}
		
		public function addGold(x:Number):void {
			player.gold += x;
			if (x > 0)
				addText("You got " + x + " gold.");
			else
				addText("You lost " + -x + " gold.");
			
			if (player.gold > 999999999999) {
				player.gold = 999999999999;
				addText("Max gold reached.\npls wat r u doing wit ur lyfe?");
			} else if (player.gold < 0) {
				player.gold = 0;
			}
			
			mainMC.game.mainUI.goldLabel.text = player.gold;
		}
		
		public function setGold(x:Number):void {
			var diff:Number = x - player.gold;
			player.gold = x;
			if (diff > 0)
				addText("You got " + diff + " gold.");
			else if (diff < 0)
				addText("You lost " + -diff + " gold.");
			
			if (player.gold > 999999999999) {
				player.gold = 999999999999;
				addText("Max gold reached.\npls wat r u doing wit ur lyfe?");
			} else if (player.gold < 0) {
				player.gold = 0;
			}
			
			mainMC.game.mainUI.goldLabel.text = player.gold;
		}
		
		public function addExp(x:int, levelup:Boolean):void {
			player.currExp += x;
			mainMC.game.mainUI.expLabel.text = player.currExp + "/" + player.maxExp;
			mainMC.game.mainUI.expBar.scaleX = player.currExp / player.maxExp;
			
			if (x > 0 && !levelup)
				addText("You gained " + x + " experience.");
			
			if (player.currExp >= player.maxExp) {
				var overflow:int = player.levelUp();
				addText("Level up!");
				mainMC.game.mainUI.levelLabel.text = player.level.toString();
				mainMC.game.lvlupUI.ptsLabel.text = player.statPoints;
				mainMC.game.lvlupUI.visible = true;
				
				setResource("Health", player.resources["maxHealth"], -1);
				setResource("Mana", player.resources["maxMana"], -1);
				setResource("Energy", player.resources["maxEnergy"], -1);
				
				addExp(overflow, true);
			}
		}
		
		public function calcStats(flag:Boolean = false):void {
			if (flag)
				removeEquipBonuses();
			
			player.derivedStats["atk"] = player.stats["str"];
			player.derivedStats["matk"] = player.stats["int"];
			player.derivedStats["def"] = player.stats["vit"];
			player.derivedStats["mdef"] = 0.3 * player.stats["vit"] + 0.7 * player.stats["int"];
			player.derivedStats["acc"] = 0.2 * player.stats["agi"] + player.stats["dex"];
			player.derivedStats["dodge"] = player.stats["agi"] + 0.2 * player.stats["dex"];
			player.derivedStats["cap"] = player.resources["maxCapacity"] + player.stats["vor"];
			player.derivedStats["weight"] = 2.2 * (50 + 2.3 * (player.height - 60)) + 0.5 * player.stats["str"] + player.fat + 0.03 * player.resources["currCapacity"];
			
			if (flag)
				addEquipBonuses();
		}
		
		public function updateStats():void {
			player.derivedStats["atk"] += player.stats["str"];
			player.derivedStats["matk"] += player.stats["int"];
			player.derivedStats["def"] += player.stats["vit"];
			player.derivedStats["mdef"] += 0.3 * player.stats["vit"] + 0.7 * player.stats["int"];
			player.derivedStats["acc"] += 0.2 * player.stats["agi"] + player.stats["dex"];
			player.derivedStats["dodge"] += player.stats["agi"] + 0.2 * player.stats["dex"];
			player.derivedStats["cap"] += player.resources["maxCapacity"] + player.stats["vor"];
			player.derivedStats["weight"] += 2.2 * (50 + 2.3 * (player.height - 60)) + 0.5 * player.stats["str"] + player.fat + 0.03 * player.resources["currCapacity"];
		}
		
		public function addEquipBonuses():void {
			for each (var item:Item in player.equipment) {
				if (item != null) {
					item.deprocEffects(this);
					item.procEffects(this);
				}
			}
		}
		
		public function removeEquipBonuses():void {
			for each (var item:Item in player.equipment) {
				if (item != null)
					item.deprocEffects(this);
			}
		}
		
		public function loot(item:Item, x:int):void {
			var retString:String = "";
			
			if (x == 1)
				retString = "You got a " + item.name + ". ";
			else if (x > 1)
				retString = "You got " + x + " " + item.plural + ". ";
			
			if (x > 0) {
				var index:int = player.indexOfInventory(item);
				if (index == -1) {
					player.inventory.push(item);
					index = player.indexOfInventory(item);
				}
				
				item = player.inventory[index];
				item.count += x;
				
				retString += "You now have " + player.inventory[index].count + " ";
				if (player.inventory[index].count > 1)
					retString += item.plural + ".";
				else
					retString += item.name + ".";
			}
			
			//ItemDefinitions.main = this;		//ItemDefinitions.main is null for some ungodly reason
			
			if (mainMC.state == "buying" && mainMC.menuItemSelected) {
				retString = item.toString("buyingSelected") + retString;
				setText(retString);
			} else {
				retString = item.toString(mainMC.state) + retString;
				addText(retString);
			} 
			
			//if (mainMC.state != "buying" && mainMC.state != "selling")
				//addText(retString);
		}
		
		public function drop(item:Item, x:int):void {
			var index:int = player.indexOfInventory(item);
			var retString:String = "";
			if (mainMC.state == "inventory")
				retString = "\n\n";
			
			if (item.canDrop && index != -1) {
				if (player.inventory[index].count >= x) {
					player.inventory[index].count -= x;
					
					if (x == 1)
						retString += "You lost a " + item.name + ". ";
					else if (x > 1)
						retString += "You lost " + x + " " + item.plural + ". ";
					
					if (player.inventory[index].count <= 0) {
						player.inventory.splice(index, 1);
						retString += "You don't have any more " + item.plural + ".";
					} else {
						retString += "You now have " + player.inventory[index].count + " ";
						
						if (player.inventory[index].count > 1)
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
			
			if (mainMC.state == "selling" && mainMC.menuItemSelected) {
				retString = item.toString("sellingSelected") + retString;
				setText(retString);
			} else if (mainMC.state == "inventory" && mainMC.menuItemSelected) {
				retString = item.toString("inventorySelected") + retString;
				setText(retString);
			} else {
				retString = item.toString(mainMC.state) + retString;
				addText(retString);
			}
			
			//if (mainMC.state != "buying" && mainMC.state != "selling")
				//addText(retString);
		}
		
		public function useItem(item:Item):Boolean {
			if (player.getItemFromInventory(item) == null) {
				setText(item.toString("inventorySelected") + "\n\nYou don't have any more " + item.plural + ".");
				return false;
			}
			
			item = player.getItemFromInventory(item);
			var itemCopy:Item = ItemDefinitions.getItem(item.name);
			
			if (item.equip) {
				if (item.head) {
					if (player.equipment["head"] != null)
						unequip(player.equipment["head"]);
					player.equipment["head"] = itemCopy;
					trace(player.equipment["head"].name + " equipped.");
				} else if (item.torso) {
					if (player.equipment["torso"] != null)
						unequip(player.equipment["torso"]);
					player.equipment["torso"] = itemCopy;
					trace(player.equipment["torso"].name + " equipped.");
				} else if (item.legs) {
					if (player.equipment["legs"] != null)
						unequip(player.equipment["legs"]);
					player.equipment["legs"] = itemCopy;
					trace(player.equipment["legs"].name + " equipped.");
				} else if (item.feet) {
					if (player.equipment["feet"] != null)
						unequip(player.equipment["feet"]);
					player.equipment["feet"] = itemCopy;
					trace(player.equipment["feet"].name + " equipped.");
				} else if (item.weapon) {
					if (item.twoHanded && player.equipment["shield"] != null) {
						setText(item.toString("inventorySelected") + "\n\nA two-handed weapon and a shield cannot be equipped simultaneously.");
						return true;
					} else {
						if (player.equipment["weapon"] != null)
							unequip(player.equipment["weapon"]);
						player.equipment["weapon"] = itemCopy;
						trace(player.equipment["weapon"].name + " equipped.");
					}
				} else if (item.shield) {
					if (player.equipment["weapon"] == null || !player.equipment["weapon"].twoHanded) {
						if (player.equipment["shield"] != null)
							unequip(player.equipment["shield"]);
						player.equipment["shield"] = itemCopy;
						trace(player.equipment["shield"].name + " equipped.");
					} else {
						setText(item.toString("inventorySelected") + "\n\nA two-handed weapon and a shield cannot be equipped simultaneously.");
						return true;
					}
				}
				addEquipBonuses();
			} else {
				itemCopy.procEffects(this);
				trace(item.name + " used.");
			}
			
			var index:int = player.indexOfInventory(item);
			
			player.inventory[index].count--;
			if (player.inventory[index].count <= 0)
				player.inventory.splice(index, 1);
			
			if (item.equip)
				setText(item.toString("inventorySelected") + "\n\nYou equipped a " + item.name + ".");
			else
				setText(item.toString("inventorySelected") + "\n\nYou used a " + item.name + ".");
			
			return isPlayerAlive();
		}

		public function unequip(item:Item):void {
			trace("Unequipping " + item.name);
			item.deprocEffects(this);		// remove special effects of old item
			if (item.head)
				player.equipment["head"] = null;
			else if (item.torso)
				player.equipment["torso"] = null;
			else if (item.legs)
				player.equipment["legs"] = null;
			else if (item.feet)
				player.equipment["feet"] = null;
			else if (item.weapon)
				player.equipment["weapon"] = null;
			else if (item.shield)
				player.equipment["shield"] = null;
			
			item.count = 0;
			loot(item, 1);
			//updateStats();
			trace(item.name + " unequipped.");
		}

		public function buy(item:Item):Boolean {
			if (player.gold >= item.value) {
				loot(item, 1);
				addGold(-item.value);
				return true;
			} else {
				return false;
			}
		}
		
		public function sell(item:Item):Boolean {
			if (item.canDrop && player.indexOfInventory(item) != -1) {
				drop(item, 1);
				addGold(Math.round(0.5 * item.value));
				return true;
			} else {
				return false;
			}
		}

		public function writeAppearance():String {
			appearanceText = player.name + " -- " + Math.floor(player.height / 12) + "'" + (player.height % 12) + "\", " + Math.round(player.derivedStats["weight"]) + "lbs";
			appearanceText += "\n\n";
			
			if (player.fat < 50)
				appearanceText += "Your body is about as unremarkable as can be. Neither an ounce of fat nor muscle is evident on your scrawny frame. You aren’t malnourished by any means, but compared to others, you find yourself sticking out of the crowd more and more with each passing day. It seems that, as of late, those around you have begun to set a new norm. Instead of the traditional ideal of a muscular, or at least slim and toned, body, people appear to be shifting toward the opposite end of the spectrum, steadily blimping out with fat as they gorge upon the recent, inexplicable bounty of Mother Nature. Perhaps it’s time you catch on with the crowd and put some much-needed meat on your bones.";
			else if (player.fat < 100)
				appearanceText += "A layer of pudge has accumulated on your form. It’s nothing particularly notable, but at least you fit in, if only a little. Your face is rounder with cheeks slightly fuller while more than a few pounds have found their way around your middle. Your arms feel heavier and your legs somewhat thicker, causing your thighs to brush against one another every now and again. Even your chest seems a bit more on the perky side than usual. Still, nothing about you is more than a little bulbous. Although your stomach is hardly a subtle bulge at best, it’s a slippery slope from here.";
			else if (player.fat < 200)
				appearanceText += "You’re fat, and there’s no way around the fact now. Your body has grown heavy with excess flesh, much like those around you, as it’s starting to impede you in doing simple tasks. Your gut, a squishy pot belly that’s beginning to droop over your waistline, jiggles with every step you take, making something as mundane as walking a task in itself. Meanwhile, your arms too are sagging somewhat with fat, biceps wobbling to and fro as you take swings at your enemies. You’re at the cusp of obesity; the second chin around your neck is a telltale sign of what’s to come.";
			else if (player.fat < 400)
				appearanceText += "With your belly now jutting out over a foot in front of you, it’s clear that you’ve been getting more than your fair share of food lately. Although, your share may be more fair than you’d think. There appears to be an endless supply of food at the local pub, always ready for your, as well as everyone else’s, consumption. As it sits in your lap, rolling over and conforming to the curvature of your swollen thighs, that sloshing table muscle always seems to get its way when it hungers for more. You stop at nothing until your stomach is packed tight and ready to burst, your arms, having grown thick with lard, patiently waiting for the next command.";
			else
				appearanceText += "At this point, you’ve gone beyond what appears to be even the social norm these days. Of course, there are still plenty of people as big as you, or bigger, but even your body is starting to turn a few heads. Your head, with puffy snout and bulging cheeks, almost looks like it’s sinking into the rest of your body, a thick ring of fat swallowing and completely obscuring your stump of a neck. You can barely rest your bulbous arms, their elbows and joints swollen with fat, at forty-five degree angles as they’re permanently propped up by the flab accumulating and drooping down your chest, settling on top of your belly’s massive girth. Even while standing, your enormous tree trunk thighs are only barely visible above knees completely caked in blubber.";
			
			appearanceText += "\n\n";
			var isEmpty:Boolean = true;
			if (player.equipment["head"] != null) {
				appearanceText += "Head: " + player.equipment["head"].toString("appearance") + "\n\n";
				//appearanceText += "Head:\n" + player.equipment["head"].name + " - " + player.equipment["head"].short + "\n\n";
				isEmpty = false;
			}
			if (player.equipment["torso"] != null) {
				appearanceText += "Torso: " + player.equipment["torso"].toString("appearance") + "\n\n";
				//appearanceText += "Torso:\n" + player.equipment["torso"].name + " - " + player.equipment["torso"].short + "\n\n";
				isEmpty = false;
			}
			if (player.equipment["legs"] != null) {
				appearanceText += "Legs: " + player.equipment["legs"].toString("appearance") + "\n\n";
				//appearanceText += "Legs:\n" + player.equipment["legs"].name + " - " + player.equipment["legs"].short + "\n\n";
				isEmpty = false;
			}
			if (player.equipment["feet"] != null) {
				appearanceText += "Feet: " + player.equipment["feet"].toString("appearance") + "\n\n";
				//appearanceText += "Feet:\n" + player.equipment["feet"].name + " - " + player.equipment["feet"].short + "\n\n";
				isEmpty = false;
			}
			if (player.equipment["weapon"] != null) {
				appearanceText += "Weapon: " + player.equipment["weapon"].toString("appearance") + "\n\n";
				//appearanceText += "Weapon:\n" + player.equipment["weapon"].name + " - " + player.equipment["weapon"].short + "\n\n";
				isEmpty = false;
			}
			if (player.equipment["shield"] != null) {
				appearanceText += "Shield: " + player.equipment["shield"].toString("appearance") + "\n\n";
				//appearanceText += "Shield:\n" + player.equipment["shield"].name + " - " + player.equipment["shield"].short + "\n\n";
				isEmpty = false;
			}
			
			if (isEmpty)
				appearanceText += "You are not wearing any equipment.";
			
			return appearanceText;
		}

		public function writeInventory():String {			
			switch (mainMC.state) {
				case "inventory" :
				case "combatInventory" :
					inventoryText = "Inventory\n\n";
					
					if (player.inventory.length == 0) {
						inventoryText += "Your inventory is empty.";
					} else {
						for each (var item:Item in player.inventory) {
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
					
					if (player.inventory.length == 0) {
						inventoryText += "You have nothing to sell.";
					} else {
						for each (var sell:Item in player.inventory) {
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
		
		public function writeQuests():String {
			questsText = "Quests\n\n";
			
			if (player.quests.length == 0) {
				questsText += "You currently have no quests.";
			} else {
				for each (var quest:GameEvent in player.quests) {
					questsText += quest.name + "\n" + quest.log + "\n\n";
				}
			}
			
			return questsText;
		}
		
		public function writeStock():String {
			var text:String = "Buying\n\n--------------------------------------------------\n\n";
			for each (var item:Item in World.world[player.x][player.y].stock) {
				text += item.name + " -- " + item.value + " gold ea. -- ";
				
				if (player.indexOfInventory(item) != -1)
					text += player.inventory[player.indexOfInventory(item)].count;
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
		
		public function isPlayerAlive():Boolean {
			if (player.resources["currCapacity"] > player.derivedStats["cap"]) {
				endCombat(false);
				player.isAlive = false;
				gameOver(1);
			} else if (player.resources["currHealth"] <= 0) {
				endCombat(false);
				player.isAlive = false;
				gameOver(0);
			}
			
			return player.isAlive;
		}
		
		public function startCombat(enemy:Enemy):void {
			combat = new Combat(this, player, enemy);
			mainMC.displayCombat(enemy);
		}
		
		public function endCombat(win:Boolean):void {
			if (mainMC.state != "combat" && mainMC.state != "combatInventory" && mainMC.state != "combatSkills")
				return;
			
			mainMC.hideBtnArray();
			mainMC.game.btnsUI.upBtn.visible = false;
			mainMC.game.btnsUI.downBtn.visible = false;
			
			if (win) {
				mainMC.game.combatUI.visible = false;
				mainMC.game.menuUI.visible = false;
				mainMC.btnArray[8].btnText.text = "Continue";
				mainMC.btnArray[8].visible = true;
			} else {
				mainMC.updateMenuBtns();
				mainMC.game.combatUI.attackBtn.visible = false;
				mainMC.game.combatUI.inventoryBtn.visible = false;
				mainMC.game.combatUI.skillsBtn.visible = false;
				mainMC.game.combatUI.runBtn.visible = false;
				mainMC.game.combatUI.devourBtn.visible = false;
				mainMC.game.combatUI.surrenderBtn.visible = false;
			}
		}
		
		public function gameOver(cause:int):void {
			mainMC.state = "gameover";
			
			player.isAlive = false;
			mainMC.hideBtnArray();
			mainMC.menuItemSelected = false;
			mainMC.game.btnsUI.upBtn.visible = false;
			mainMC.game.btnsUI.downBtn.visible = false;
			mainMC.updateMenuBtns();
			setResource("Health", 0, -1);
			
			if (mainMC.game.mainUI.textField.text.substring(mainMC.game.mainUI.textField.text.length - 27) != "Load your last saved state.") {
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
