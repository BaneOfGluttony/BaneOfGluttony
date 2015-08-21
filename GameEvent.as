package  {
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	
	public class GameEvent {
		var player:Player;
		var xml:XML;
		var loader:URLLoader = new URLLoader();

		public function GameEvent(player:Player, fileName:String) {
			this.player = player;
			loader.load(new URLRequest("Text/" + fileName));
			loader.addEventListener(Event.COMPLETE, parseXML);
		}
		
		public function parseXML(e:Event):void {
			xml = new XML(e.target.data);
			trace(xml.text);
		}
		
		public function checkResource(resource:String, x:Number):Boolean {
			if (player.resources["min" + resource] / player.resources["max" + resource] >= x)
				return true;
			
			return false;
		}
		
		public function checkStat(stat:String, x:int):Boolean {
			if (player.stats[stat] > x)
				return true;
			
			return false;
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
