package  {
	
	public class Item {
		public var name:String = "Item";
		public var short:String = "Short description";
		public var long:String = "Long description";
		public var canDrop:Boolean = true;
		public var equip:Boolean = false;
		public var count:int = 0;
		public var value:int = 0;
		
		public var twoHanded:Boolean = false;
		public var head:Boolean = false;
		public var torso:Boolean = false;
		public var legs:Boolean = false;
		public var feet:Boolean = false;
		public var shield:Boolean = false;
		public var weapon:Boolean = false;
		
		public var health:int = 0;
		public var mana:int = 0;
		public var energy:int = 0;
		public var capacity:int = 0;
		
		public var str:int = 0;
		public var agi:int = 0;
		public var vit:int = 0;
		public var itn:int = 0;
		public var dex:int = 0;
		public var vor:int = 0;
		
		public var atk:int = 0;
		public var matk:int = 0;
		public var def:int = 0;
		public var mdef:int = 0;
		public var acc:int = 0;
		public var dodge:int = 0;
		public var fat:int = 0;
		public var cap:int = 0;
		
		//public var effect:Status = new Status({});

		public function Item(properties:Object = null) {
			for (var name:String in properties) {
				if (this.hasOwnProperty(name)) {
					this[name] = properties[name];
				}
			}
		}
		
		/*public function Item(name:String, short:String, long:String, canDrop:Boolean) {
			this.name = name;
			this.short = short;
			this.long = long;
			this.canDrop = canDrop;
		}*/
		
		public function toString():String {
			return count + "x " + name + " - " + long;
		}
	}
}
