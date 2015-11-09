package  {
	
	public class Zone {
		public var name:String = "Zone";
		public var x:int = -1;
		public var y:int = -1;
		public var region:String = "Region";
		public var text:String = "Text"
		
		public var enterText:String = "";
		public var enter:Boolean = false;
		
		public var saveText:String = "";
		public var save:Boolean = false;
		
		public var enemiesText:Array = null;
		public var enemies:Array = [];			// [] is faster than new Array()
		
		public var itemsText:Array = null;
		public var items:Array = [];
		
		public var eventsText:Array = null;
		public var events:Array = [];

		public function Zone(properties:Object) {
			// negligible gain
			/*if (properties["name"])
				name = properties["name"];
			if (properties["x"])
				x = properties["x"];
			if (properties["y"])
				y = properties["y"];
			if (properties["region"])
				region = properties["region"];
			if (properties["text"])
				text = properties["text"];
			if (properties["enterText"])
				enterText = properties["enterText"];
			if (properties["saveText"])
				saveText = properties["saveText"];
			if (properties["enemiesText"])
				enemiesText = properties["enemiesText"];
			if (properties["itemsText"])
				itemsText = properties["itemsText"];
			if (properties["eventsText"])
				eventsText = properties["eventsText"];*/
				
			for (var name:String in properties) {
				if (this.hasOwnProperty(name)) {
					this[name] = properties[name];
				}
			}
			
			if (enterText == "True" || enterText == "true")
				enter = true;
			
			if (saveText == "True" || saveText == "true")
				save = true;

			var i:int;		// iterative index
			var n:int;		// array length
			var l:int = 0;	// current index
			if (enemiesText != null) {
				n = enemiesText.length;
				if (n > 1)
					for (i = 0; i < n; i += 2)
						enemies[l++] = [enemiesText[i], enemiesText[i + 1]];
			}
			
			// this code ~1s slower
			/*if (enemiesText != null && enemiesText.length > 1) {
				for (var i:int = 0; i < enemiesText.length; i += 2)
					enemies.push(new Array(enemiesText[i], enemiesText[i + 1]));
			}*/
			
			if (itemsText != null) {
				n = itemsText.length;
				l = 0;
				for (i = 0; i < n; i++)
					items[l++] = ItemDefinitions.getItem(itemsText[i]);
				
				// this code ~1s slower
				/*for each (var item:String in itemsText)
					items.push(ItemDefinitions.getItem(item));*/
			}
			
			if (eventsText != null) {
				n = eventsText.length;
				if (n > 1) {
					l = 0;
					for (i = 0; i < n; i += 2)
						events[l++] = [eventsText[i], eventsText[i + 1]];
				}
			}
			
			// this code <1s slower
			/*if (eventsText != null && eventsText.length > 1) {
				for (var i:int = 0; i < eventsText.length; i += 2)
					events.push(new Array(eventsText[i], eventsText[i + 1]));
			}*/
		}
	}
}
