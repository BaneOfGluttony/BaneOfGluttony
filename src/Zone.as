package  {
	
	public class Zone {
		public var name:String = "Zone";
		public var x:int = -1;
		public var y:int = -1;
		public var text:String = "Text"
		public var enter:Boolean = false;
		public var save:Boolean = false;
		
		public var items:Array = null;
		public var stock:Array = new Array();
		public var events:Array = null;

		public function Zone(properties:Object) {
			for (var name:String in properties) {
				if (this.hasOwnProperty(name)) {
					this[name] = properties[name];
				}
			}
			
			if (items != null) {
				for each (var item:String in items)
					stock.push(ItemDefinitions.getItem(item));
			}
		}
	}
}
