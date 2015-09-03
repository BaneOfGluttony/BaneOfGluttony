package  {
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.display.MovieClip;
	
	public class GameEvent {
		public var main:MovieClip;
		public var player:Player;
		public var xml:XML;
		public var currChild:XMLList;
		public var loader:URLLoader;
		
		public var name:String;
		public var state:int;
		public var text:String;

		public function GameEvent(main:MovieClip, player:Player, fileName:String) {
			this.main = main;
			this.player = player;
			
			try {
				loader = new URLLoader();
			} catch (e:Error) {
				trace("Error in GameEvent loader: " + e);
			}
			
			loader.load(new URLRequest("../src/XML/" + fileName));
			loader.addEventListener(Event.COMPLETE, parseXML);
			
			name = fileName;
			state = 0;
			
			trace("Quest added: " + name);
		}
		
		public function parseXML(e:Event):void {
			xml = new XML(e.target.data)
			text = xml.text;
			main.addText(text);
			currChild = xml.child("choices");
		}
	
		public function getChoice(i:int):void {
			if (currChild.choice[i] == null)
				return;
				
			text = currChild.choice[i].text;
			currChild = currChild.choice[i].child("choices");
			trace(text);
		}
		
		public function checkState():int {
			return -1;	//override
		}
		
		public function finishQuest():void {
			player.quests.splice(player.quests.indexOf(this), 1);
			trace("Quest finished\n" + player.quests);
		}
		
		public function checkResource(resource:String, x:Number):Boolean {
			return (player.resources["min" + resource] / player.resources["max" + resource]) >= x;
		}
		
		public function checkStat(stat:String, x:int):Boolean {
			return player.stats[stat] >= x;
		}
		
		public function checkItem(items:Array):Boolean {
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
	}
}
