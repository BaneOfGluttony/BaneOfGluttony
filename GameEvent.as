package  {
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class GameEvent {
		public var player:Player;
		public var xml:XML;
		public var currChild:XMLList;
		public var loader:URLLoader = new URLLoader();
		public var text:String;

		public function GameEvent(player:Player, fileName:String) {
			this.player = player;
			loader.load(new URLRequest("Text/" + fileName));
			loader.addEventListener(Event.COMPLETE, parseXML);
		}
		
		public function parseXML(e:Event):void {
			xml = new XML(e.target.data)
			text = xml.text;
			trace(text);
			currChild = xml.child("choices");
			
			getChoice(0);
			getChoice(1);
			getChoice(1);
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
	}
}
