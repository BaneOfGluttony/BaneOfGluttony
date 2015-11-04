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
		public var enemies:Array = new Array();
		
		public var itemsText:Array = null;
		public var items:Array = new Array();
		
		public var eventsText:Array = null;
		public var events:Array = new Array();

		public function Zone(properties:Object) {
			for (var name:String in properties) {
				if (this.hasOwnProperty(name)) {
					this[name] = properties[name];
				}
			}
			
			if (enterText == "True" || enterText == "true")
				enter = true;
			
			if (saveText == "True" || saveText == "true")
				save = true;
			
			if (enemiesText != null && enemiesText.length > 1) {
				for (var i:int = 0; i < enemiesText.length; i += 2)
					enemies.push(new Array(enemiesText[i], enemiesText[i + 1]));
			}
			
			if (itemsText != null) {
				for each (var item:String in itemsText)
					items.push(ItemDefinitions.getItem(item));
			}
			
			if (eventsText != null && eventsText.length > 1) {
				for (var i:int = 0; i < eventsText.length; i += 2)
					events.push(new Array(eventsText[i], eventsText[i + 1]));
			}
		}
	}
}
