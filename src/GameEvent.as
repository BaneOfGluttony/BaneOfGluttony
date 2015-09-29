package  {
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class GameEvent {
		public var main:MovieClip;
		public var player:Player;
		public var xml:XML;
		//public var currDialog:XMLList;
		public var loader:URLLoader;
		
		public var name:String;
		public var state:int;
		public var text:String;

		public function GameEvent(main:MovieClip, player:Player, fileName:String) {
			this.main = main;
			this.player = player;
			state = 0;
			
			try {
				loader = new URLLoader();
			} catch (e:Error) {
				trace("Error in GameEvent loader: " + e);
			}
			
			loader.load(new URLRequest("src/XML/" + fileName + ".xml"));
			loader.addEventListener(Event.COMPLETE, parseXML);
		}
		
		public function parseXML(e:Event):void {
			xml = new XML(e.target.data)
			text = xml.text;
			main.addText(text);	
			name = xml.@name;
			
			setDialog(0);
		}
		
		public function setDialog(x:int):Boolean {
			var ret:Boolean = false;
			var dialog:XMLList = xml.dialog.(@id == x);
			var options:XMLList = dialog.options;
			state = x;
			
			for each (var text:XML in dialog.text) {
				if (check(text)) {
					ret = true;
					main.mainMC.state = "dialog";
					main.mainMC.hideBtnArray();
					main.mainMC.game.menuUI.visible = false;
					
					if (text == dialog.text[0])
						main.setText(text);
					else
						main.addText(text);
					
					if (dialog.@end == "true") {
						main.mainMC.btnArray[8].btnText.text = "Continue";
						main.mainMC.btnArray[8].visible = true;
						
						if (dialog.@goto != "") {
							
							main.event = this;
						} else {
							main.event = null;
						}
					} else {
						var i:int = 0;
						for each (var option:XML in options.option) {
							main.mainMC.btnArray[i].btnText.text = option;
							main.mainMC.btnArray[i].visible = true;
							i++;
						}
						main.event = this;
					}
				}
			}
			
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
			var raw:String = node.@check;

			if (raw != "") {
				var checks:Array = raw.split(";");
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
						succ = checkLoc(min, max);
					} else if (player.resources.hasOwnProperty(str)) {
						succ = checkResource(str, min, max);
					} else if (player.stats.hasOwnProperty(str)) {
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
			var raw:String = node.@action;

			if (raw != "") {
				var actions:Array = raw.split(";");
				var i:int = 0;
				
				for each (var action:String in actions) {
					actions[i] = action.split(":");
					var str:String = actions[i][0];
					var val:Object;
					if (actions[i].length > 1)
						val = actions[i][1];
					
					if (str == "addQuest") {
						player.quests.push(this);
						trace("Quest added: " + this.name);
					} else if (player.resources.hasOwnProperty(str)) {
						if (val.charAt(0) == "+")			//add percentage
							main.addResource(str, val.substring(1) * player.resources["max" + str], 0);
						else if (val.charAt(0) == "*")		//set percentage
							main.setResource(str, val.substring(1) * player.resources["max" + str], 0);
					} else if (str == "fat") {
						if (val.charAt(0) == "+")			//add fat
							main.addFat(val.substring(1));
						else if (val.charAt(0) == "*")		//scale fat
							main.setFat(val.substring(1) * player.fat);
					} else if (str == "gold") {
						if (val.charAt(0) == "+")			//add gold
							main.addGold(val.substring(1));
						else if (val.charAt(0) == "*")		//scale gold
							main.setGold(val.substring(1) * player.gold);
					} else if (str == "item") {
						var vals:String = actions[i][1];
						var items:Array = vals.split(",");
						var j:int = 0;
						
						for each (var item:String in items) {
							items[j] = item.split("-");
							var tempItem:Item = ItemDefinitions.getItem(items[j][0]);
							main.loot(tempItem, items[j][1]);
							
							j++;
						}
					}
					
					i++;
				}
			}
		}
		
		public function checkState():int {
			return -1;	//override
		}
		
		public function finishEvent():void {
			player.quests.splice(player.quests.indexOf(this), 1);
			main.addText("Quest complete!");
			trace("Quest finished\n" + player.quests);
		}
		
		public function checkLoc(x:int, y:int):Boolean {
			return player.x == x && player.y == y;
		}
		
		public function checkResource(resource:String, min:Number, max:Number):Boolean {
			return (player.resources["min" + resource] / player.resources["max" + resource]) >= min &&
				(player.resources["min" + resource] / player.resources["max" + resource]) <= max;
		}
		
		public function checkStat(stat:String, min:int, max:int):Boolean {
			return player.stats[stat] >= min && player.stats[stat] <= max;
		}
		
		public function checkFat(min:Number, max:Number):Boolean {
			return player.fat >= min && player.fat <= max;
		}
		
		public function checkGold(min:Number, max:Number):Boolean {
			return player.gold >= min && player.gold <= max;
		}
		
		public function checkItems(items:Array):Boolean {
			if (player.inventory.length == 0)
				return false;
			
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
					}
				}
			}
			
			return true;
		}
	}
}
