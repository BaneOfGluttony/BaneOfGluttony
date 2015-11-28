package  {
	import flash.display.MovieClip;
	import flash.utils.IDataInput;
	import flash.utils.IDataOutput;
	import flash.utils.IExternalizable;
	
	public class GameEvent {
		public var xml:XML = new XML();
		
		public var name:String = "";
		public var repeatable:Boolean = false;
		public var state:int = 0;
		public var log:String = "";
		public var loc:Array = [];
		public var cont:String = "";
		
		public function GameEvent(fileName:String = "") {
			name = fileName;
			
			fileName = fileName.replace(/ /g, "_");
			fileName = fileName.toUpperCase();
			
			if (fileName != "")
				parseXML(fileName);
		}
		
		public function parseXML(fileName:String):void {
			xml = EventDefinitions[fileName];
			
			if ("@name" in xml)
				name = xml.@name;
			
			if (xml.@repeatable == "true") {
				repeatable = true;
			} else
				repeatable = false;
			
			setDialog(0);
		}
		
		public function setDialog(x:int):Boolean {
			var ret:Boolean = false;
			var dialog:XMLList = xml.dialog.(@id == x);
			var options:XMLList = dialog.options;
			state = x;
			
			for each (var text:XML in dialog.text) {
				cont = "";
				
				if (check(text)) {
					ret = true;
					MainGameUI.state = "dialog";
					MainGameUI.hideBtnArray();
					MainGameUI.game.menuUI.visible = false;
					MainGameUI.game.optionsBtn.visible = false;
					MainGameUI.game.lvlupUI.visible = false;
					
					if (text == dialog.text[0] || text.@override == "true")
						Main.setText(text);
					else
						Main.addText(text);
					
					if ("@cont" in dialog || "@cont" in text) {
						MainGameUI.btnArray[8].btnText.text = "Continue";
						MainGameUI.btnArray[8].visible = true;
						if ("@cont" in dialog)
							cont = dialog.@cont;
						else
							cont = text.@cont;
					} else {
						var i:int = 0;
						for each (var option:XML in options.option) {
							MainGameUI.btnArray[i].btnText.text = option;
							MainGameUI.btnArray[i].visible = true;
							i++;
						}
					}
					
					if ("@state" in text)
						state = text.@state;
					
					if ("@goto" in text) {
						state = text.@goto;
						cont = "prog";
						setDialog(state);
						break;
					}
					
					doActions(text);
					Main.currEvent = this;
					
					if (cont != "")
						break;
				} else {
					ret = false;
				}
			}
			
			if (dialog.log.length())
				log = dialog.log;
			
			return ret;
		}
	
		public function setOption(i:int):void {
			var option:XML = xml.dialog.(@id == state).options.option[i];
			if (option == null)
				return;
			
			setDialog(option.@id);
			doActions(option);
		}
		
		public function check(node:XML):Boolean {
			var succ:Boolean = true;
			
			if ("@check" in node) {
				var checks:Array = node.@check.split(";");
				var i:int = 0;
				
				for each (var check:String in checks) {
					checks[i] = check.split(":");
					var str:String = checks[i][0];
					var min:Number = 0;
					var max:Number = Number.MAX_VALUE;
					
					var temp:Array = checks[i][1].split(",");
					min = temp[0]
					if (temp.length > 1)
						max = temp[1]
					
					if (str == "loc") {
						if (min == -1 || max == -1) {
							if (loc == null || loc.length == 0) {
								loc = new Array(Player.x, Player.y);
								succ = true;
							} else {
								succ = checkLoc(loc[0], loc[1]);
							}
						} else {
							succ = checkLoc(min, max);
						}
					} else if (Player.resources.hasOwnProperty("curr" + str.charAt(0).toUpperCase() + str.substring(1))) {
						str = str.charAt(0).toUpperCase() + str.substring(1);
						if (str == "Capacity" && min == -1)
							min = (Player.derivedStats["cap"] + 1) / Player.resources["maxCapacity"];
						
						succ = checkResource(str, min, max);
					} else if (Player.stats.hasOwnProperty(str)) {
						succ = checkStat(str, min, max);
					} else if (str == "fat") {
						succ = checkFat(min, max);
					} else if (str == "gold") {
						succ = checkGold(min, max);
					} else if (str == "item") {
						var vals:String = checks[i][1];
						var items:Array = vals.split(",");
						var j:int = 0;
						
						for each (var item:String in items) {
							items[j] = item.split("-");
							var tempItem:Item = ItemDefinitions.getItem(items[j][0]);
							tempItem.count = items[j][1];
							items[j] = tempItem;
							
							j++;
						}
						
						succ = checkItems(items);
					}
					
					i++;
					if (!succ)
						return succ;
				}
			}
			
			return succ;
		}
		
		public function doActions(node:XML):void {
			if ("@action" in node) {
				var actions:Array = node.@action.split(";");
				var i:int = 0;
				
				for each (var action:String in actions) {
					actions[i] = action.split(":");
					var str:String = actions[i][0];
					var val:Object;
					var vals:String;
					var items:Array;
					var item:String;
					var j:int;
					var tempItem:Item;
					
					if (actions[i].length > 1)
						val = actions[i][1];
					
					if (str == "addQuest") {
						addQuest();
					} else if (str == "rmvQuest") {
						rmvQuest();
					} else if (str == "endEvent") {
						endEvent();
					} else if (str == "cmpltEvent") {
						cmpltEvent();
					} else if (str == "loc") {
						var temp:Array = val.split(",");
						MainGameUI.travel(temp[0], temp[1]);
					} else if (Player.resources.hasOwnProperty("curr" + str.charAt(0).toUpperCase() + str.substring(1))) {
						str = str.charAt(0).toUpperCase() + str.substring(1);
						var old:int = Player.resources["curr" + str];
						
						if (val.charAt(0) == "+") {				//add flat
							Main.addResource(str, val.substring(1), 0);
						} else if (val.charAt(0) == "%") {		//add percentage
							Main.addResource(str, Math.round((val.substring(1) / 100) * Player.resources["max" + str]), 0);
						} else if (val.charAt(0) == "*") {		//set percentage
							if (str == "Capacity" && val.substring(1) == "max") {
								Main.setResource(str, Player.derivedStats["cap"], -1);
								continue;
							} else {
								Main.setResource(str, Math.round((val.substring(1) / 100) * Player.resources["max" + str]), -1);
							}
						}
						
						var diff:int = Player.resources["curr" + str] - old;
						
						switch (str) {
							case "Health" :
								str = "HP";
								break;
							case "Mana" :
								str = "MP";
								break;
							case "Energy" :
								str = "EN";
								break;
							case "Capacity" :
								str = "CAP";
								break;
						}
						
						if (diff > 0)
							Main.addText(str + "+" + diff);
						else if (diff < 0)
							Main.addText(str + diff);
					} else if (str == "fat") {
						var oldFat:Number = Player.fat;
						
						if (val.charAt(0) == "+")			//add fat
							Main.addFat(val.substring(1));
						else if (val.charAt(0) == "*")		//scale fat
							Main.setFat(val.substring(1) * Player.fat);
						
						var fatDiff:Number = Player.fat - oldFat;
						if (fatDiff > 0)
							Main.addText("Fat+" + fatDiff);
						else if (diff < 0)
							Main.addText("Fat" + fatDiff);
					} else if (str == "gold") {
						if (val.charAt(0) == "+")			//add gold
							Main.addGold(val.substring(1));
						else if (val.charAt(0) == "*")		//scale gold
							Main.setGold(val.substring(1) * Player.gold);
					} else if (str == "exp") {
						Main.addExp(actions[i][1], false);	//add exp
					} else if (str == "lootItem") {
						vals = actions[i][1];
						items = vals.split(",");
						j = 0;
						
						for each (item in items) {
							items[j] = item.split("-");
							tempItem = ItemDefinitions.getItem(items[j][0]);
							Main.loot(tempItem, items[j][1]);
							j++;
						}
					} else if (str == "dropItem") {
						vals = actions[i][1];
						items = vals.split(",");
						j = 0;
						
						for each (item in items) {
							items[j] = item.split("-");
							tempItem = ItemDefinitions.getItem(items[j][0]);
							Main.drop(tempItem, items[j][1]);
							j++;
						}
					}
					
					i++;
				}
			}
		}
		
		public function addQuest():void {
			Player.quests.push(this);
			Player.eventRecord[name] = false;
			Main.addText("Quests added: " + name);
			trace("Quest added: " + name);
		}
		
		public function rmvQuest():void {
			Main.currEvent = null;
			Player.quests.splice(Player.quests.indexOf(this), 1);
			Player.eventRecord[name] = repeatable;
			Main.addText("Quest complete: " + name);
			trace("Quest complete: " + name);
		}
		
		public function endEvent():void {
			Main.currEvent = null;
		}
		
		public function cmpltEvent():void {
			Main.currEvent = null;
			Player.eventRecord[name] = repeatable;
		}
		
		public function checkLoc(x:Number, y:Number):Boolean {
			return Player.x == x && Player.y == y;
		}
		
		public function checkResource(resource:String, min:Number, max:Number):Boolean {
			return (Player.resources["curr" + resource] / Player.resources["max" + resource]) >= min &&
				(Player.resources["curr" + resource] / Player.resources["max" + resource]) <= max;
		}
		
		public function checkStat(stat:String, min:Number, max:Number):Boolean {
			return Player.stats[stat] >= min && Player.stats[stat] <= max;
		}
		
		public function checkFat(min:Number, max:Number):Boolean {
			return Player.fat >= min && Player.fat <= max;
		}
		
		public function checkGold(min:Number, max:Number):Boolean {
			return Player.gold >= min && Player.gold <= max;
		}
		
		public function checkItems(items:Array):Boolean {
			if (Player.inventory.length == 0)
				return false;
			
			for each (var item:Item in items) {
				for each (var inventoryItem:Item in Player.inventory) {
					if (inventoryItem.name == item.name) {
						if (inventoryItem.count < item.count)
							return false;
						else
							break;
					} else {
						if (inventoryItem == Player.inventory[Player.inventory.length - 1])
							return false;
					}
				}
			}
			
			return true;
		}
	}
}
