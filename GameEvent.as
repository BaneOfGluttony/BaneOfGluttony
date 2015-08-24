package  {
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class GameEvent {
		public var player:Player;
		public var xml:XML;
		public var currChild:XMLList;
		public var loader:URLLoader = new URLLoader();
		public var text:String;

		public function GameEvent(main:MovieClip, player:Player, fileName:String) {
			this.player = player;
			loader.load(new URLRequest("XML/" + fileName));
			loader.addEventListener(Event.COMPLETE, parseXML);
		}
		
		public function parseXML(e:Event):void {
			xml = new XML(e.target.data)
			text = xml.text;
			trace(text);
			currChild = xml.child("choices");
		}
	
		public function getChoice(i:int):void {
			text = currChild.choice[i].text;
			currChild = currChild.choice[i].child("choices");
			trace(text);
		}
		
		public function checkResource(resource:String, x:Number):Boolean {
			return (player.resources["min" + resource] / player.resources["max" + resource]) >= x;
		}
		
		public function checkStat(stat:String, x:int):Boolean {
			return player.stats[stat] >= x;
		}
		
		public function checkItem(items:Array) {
			var itemFound:Boolean = false;
			
			for each (var item:Item in items) {
				for each (var inventoryItem:Item in player.inventory) {
					if (inventoryItem.name == item.name) {
						if (inventoryItem.count < item.count)
							return false;
						else
							break;
					} else {
						if (inventoryItem == player.inventory[player.inventory.length - 1])
							return false;
						else
							continue;
					}
				}
			}
			
			return true;
		}
		
		//Modify below
		/*public function addResource(resource:String, curr:int, max:int):void { //use a separate takeDamage/feed method that uses this
			player.resources["max" + resource] += max;
			player.resources["curr" + resource] += curr;
			
			if (player.resources["max" + resource] > 99999) {
				player.resources["max" + resource] = 99999;
				addText("Stat cap reached.\npls wat r u doing wit ur lyfe?");
			} else if (player.resources["max" + resource] <= 0)
				player.resources["max" + resource] = 1;
			max = player.resources["max" + resource];
			
			if (player.resources["curr" + resource] > 99999) {
				player.resources["curr" + resource] = 99999;
				addText("stahp wat hav u done?");
			} else if (player.resources["curr" + resource] < 0)
				player.resources["curr" + resource] = 0;
			curr = player.resources["curr" + resource];
			
			var colorTF:ColorTransform = new ColorTransform();
			
			switch (resource) {
				case "Health":
					if (curr <= max) {
						mainUI.healthBar.scaleX = curr / max;
						if (mainUI.healthBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							mainUI.healthBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0x009900;
							mainUI.healthBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0x009900;
						mainUI.healthBar.transform.colorTransform = colorTF;
						mainUI.healthBar.scaleX = 1;
						curr = max;
						player.resources["curr" + resource] = curr;
					}
					mainUI.healthLabel.text = curr + "/" + max;
					break;
				case "Mana":
					if (curr <= max) {
						mainUI.manaBar.scaleX = curr / max;
						if (mainUI.manaBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							mainUI.manaBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0x0066FF;
							mainUI.manaBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0x0066FF;
						mainUI.manaBar.transform.colorTransform = colorTF;
						mainUI.manaBar.scaleX = 1;
						curr = max;
						player.resources["curr" + resource] = curr;
					}
					mainUI.manaLabel.text = curr + "/" + max;
					break;
				case "Energy":
					mainUI.energyLabel.text = curr + "/" + max;
					if (curr <= max) {
						mainUI.energyBar.scaleX = curr / max;
						if (mainUI.energyBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							mainUI.energyBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0xFFFF66;
							mainUI.energyBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0xFFFF66;
						mainUI.energyBar.transform.colorTransform = colorTF;
						mainUI.energyBar.scaleX = 1;
						curr = max;
						player.resources["curr" + resource] = curr;
					}
					mainUI.energyLabel.text = curr + "/" + max;
					break;
				case "Capacity":
					if (curr <= max) {
						colorTF.color = 0xFF6600;
						mainUI.capacityBar.transform.colorTransform = colorTF;
						mainUI.capacityBar.scaleX = curr / max;
						mainUI.capacityLabel.text = Math.round(mainUI.capacityBar.scaleX * 100) + "%";
					} else {
						colorTF.color = 0xDD0000;
						mainUI.capacityBar.transform.colorTransform = colorTF;
						mainUI.capacityBar.scaleX = 1;
						mainUI.capacityLabel.text = "Danger";
					}
					break;
			}
			
			updateStats();
		}
		
		public function setResource(resource:String, curr:int, max:int):void { //use a separate takeDamage/feed method that uses this
			player.resources["max" + resource] = max;
			player.resources["curr" + resource] = curr;
			
			if (player.resources["max" + resource] > 99999) {
				player.resources["max" + resource] = 99999;
				addText("Stat cap reached.\npls wat r u doing wit ur lyfe?");
			} else if (player.resources["max" + resource] <= 0)
				player.resources["max" + resource] = 1;
			max = player.resources["max" + resource];
			
			if (player.resources["curr" + resource] > 99999) {
				player.resources["curr" + resource] = 99999;
				addText("stahp wat hav u done?");

			} else if (player.resources["curr" + resource] < 0)
				player.resources["curr" + resource] = 0;
			curr = player.resources["curr" + resource];
			
			var colorTF:ColorTransform = new ColorTransform();
			
			switch (resource) {
				case "Health":
					if (curr <= max) {
						mainUI.healthBar.scaleX = curr / max;
						if (mainUI.healthBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							mainUI.healthBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0x009900;
							mainUI.healthBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0x009900;
						mainUI.healthBar.transform.colorTransform = colorTF;
						mainUI.healthBar.scaleX = 1;
						curr = max;
						player.resources["curr" + resource] = curr;
					}
					mainUI.healthLabel.text = curr + "/" + max;
					break;
				case "Mana":
					if (curr <= max) {
						mainUI.manaBar.scaleX = curr / max;
						if (mainUI.manaBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							mainUI.manaBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0x0066FF;
							mainUI.manaBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0x0066FF;
						mainUI.manaBar.transform.colorTransform = colorTF;
						mainUI.manaBar.scaleX = 1;
						curr = max;
						player.resources["curr" + resource] = curr;
					}
					mainUI.manaLabel.text = curr + "/" + max;
					break;
				case "Energy":
					mainUI.energyLabel.text = curr + "/" + max;
					if (curr <= max) {
						mainUI.energyBar.scaleX = curr / max;
						if (mainUI.energyBar.scaleX <= 0.25) {
							colorTF.color = 0xDD0000;
							mainUI.energyBar.transform.colorTransform = colorTF;
						} else {
							colorTF.color = 0xFFFF66;
							mainUI.energyBar.transform.colorTransform = colorTF;
						}
					} else {
						colorTF.color = 0xFFFF66;
						mainUI.energyBar.transform.colorTransform = colorTF;
						mainUI.energyBar.scaleX = 1;
						curr = max;
						player.resources["curr" + resource] = curr;
					}
					mainUI.energyLabel.text = curr + "/" + max;
					break;
				case "Capacity":
					if (curr <= max) {
						colorTF.color = 0xFF6600;
						mainUI.capacityBar.transform.colorTransform = colorTF;
						mainUI.capacityBar.scaleX = curr / max;
						mainUI.capacityLabel.text = Math.round(mainUI.capacityBar.scaleX * 100) + "%";
					} else {
						colorTF.color = 0xDD0000;
						mainUI.capacityBar.transform.colorTransform = colorTF;
						mainUI.capacityBar.scaleX = 1;
						mainUI.capacityLabel.text = "Danger";
					}
					break;
			}
			
			updateStats();
		}
		
		public function addStat(stat:String, x:int):void {
			player.stats[stat] += x;
			
			if (player.stats[stat] > 99999) {
				player.stats[stat] = 99999;
				addText("Stat cap reached.\npls wat r u doing wit ur lyfe?");
			}
			
			x = player.stats[stat];
			
			switch (stat) {
				case "str":
					mainUI.strLabel.text = x.toString();
					break;
				case "agi":
					mainUI.agiLabel.text = x.toString();
					break;
				case "vit":
					mainUI.vitLabel.text = x.toString();
					break;
				case "int":
					mainUI.intLabel.text = x.toString();
					break;
				case "dex":
					mainUI.dexLabel.text = x.toString();
					break;
				case "vor":
					mainUI.vorLabel.text = x.toString();
					break;
			}
			
			updateStats();
		}
		
		public function setStat(stat:String, x:int):void {
			player.stats[stat] = x;
			
			if (player.stats[stat] > 99999) {
				player.stats[stat] = 99999;
				addText("Stat cap reached.\npls wat r u doing wit ur lyfe?");
			}
			
			x = player.stats[stat];
			
			switch (stat) {
				case "str":
					mainUI.strLabel.text = x.toString();
					break;
				case "agi":
					mainUI.agiLabel.text = x.toString();
					break;
				case "vit":
					mainUI.vitLabel.text = x.toString();
					break;
				case "int":
					mainUI.intLabel.text = x.toString();
					break;
				case "dex":
					mainUI.dexLabel.text = x.toString();
					break;
				case "vor":
					mainUI.vorLabel.text = x.toString();
					break;
			}
			
			updateStats();
		}
		
		public function addFat(x:Number):void {
			player.fat += x;
			
			if (player.fat < 0) {
				player.fat = 0;
			} else if (player.fat > 999999999999) {
				player.fat = 999999999999;
				addText("Max fatness reached.\nHow you're still getting around is beyond me. But hey! You're a giant mountain of fat! 8D");
			}
			
			mainUI.fatLabel.text = Math.round(player.fat);
		}
		
		public function setFat(x:int):void {
			player.fat = x;
			
			if (player.fat < 0) {
				player.fat = 0;
			} else if (player.fat > 999999999999) {
				player.fat = 999999999999;
				addText("Max fatness reached.\nHow you're still getting around is beyond me. But hey! You're a giant mountain of fat! 8D");
			}
			
			mainUI.fatLabel.text = Math.round(player.fat);
		}
		
		public function loot(item:Item, x:int):void {
			var retString:String = "";
			if (x == 1)
				retString = "You picked up a " + item.name + ". ";
			else if (x > 1)
				retString = "You picked up " + x + " " + item.name + "s. ";
			
			if (x > 0) {
				var index:int = player.indexOfInventory(item);
				if (index == -1) {
					player.inventory.push(item);
					index = player.indexOfInventory(item);
				}
					
				player.inventory[index].count += x;
				
				retString += "You now have " + player.inventory[index].count + " " + item.name;
				if (player.inventory[index].count > 1)
					retString += "s.";
				else
					retString += ".";
			}
			
			addText(retString);
		}
		
		public function drop(item:Item, x:int):void {
			var index:int = player.indexOfInventory(item);
			var retString:String = "";
			if (item.canDrop && index != -1) {
				if (player.inventory[index].count >= x) {
					player.inventory[index].count -= x;
					
					if (x == 1)
						retString = "You dropped a " + item.name + ". ";
					else if (x > 1)
						retString = "You dropped " + x + " " + item.name + "s. ";
					
					if (player.inventory[index].count <= 0) {
						player.inventory.splice(index, 1);
						retString += "You no longer have any " + item.name + "s.";
					} else {
						retString += "You now have " + player.inventory[index].count + " " + item.name;
						
						if (player.inventory[index].count > 1)
							retString += "s.";
						else
							retString += ".";
					}
				} else
					retString = "You don't have that many " + item.name + "s.";
            } else if (index == -1)
				retString = "You don't have this item in your inventory.";
			else if (!item.canDrop)
				retString = "You can't drop this item.";
			
			
			addText(retString);
		}
		
		public function addGold(x:Number):void {
			player.gold += x;
			
			if (player.gold > 999999999999) {
				player.gold = 999999999999;
				addText("Max gold reached.\npls wat r u doing wit ur lyfe?");
			}
			
			mainUI.goldLabel.text = player.gold;
		}
		
		public function setGold(x:Number):void {
			player.gold = x;
			
			if (player.gold > 999999999999) {
				player.gold = 999999999999;
				addText("Max gold reached.\npls wat r u doing wit ur lyfe?");
			}
			
			mainUI.goldLabel.text = player.gold;
		}
		
		public function addExp(x:int):void {
			player.currExp += x;
			mainUI.expLabel.text = player.currExp + "/" + player.maxExp;
			mainUI.expBar.scaleX = player.currExp / player.maxExp;
			
			if (player.currExp > player.maxExp) {
				var overflow:int = player.levelUp();
				mainUI.levelLabel.text = player.level.toString();
				addExp(overflow);
			}
		}*/
	}
}
