package  {
	
	public class Effect {
		public var name:String = "Status effect";
		public var desc:String = "Description";
		public var properties:Object;
		
		public var health:int = 0;
		public var mana:int = 0;
		public var energy:int = 0;
		public var capacity:int = 0;
		
		public var strFlat:int = 0;
		public var agiFlat:int = 0;
		public var vitFlat:int = 0;
		public var intFlat:int = 0;
		public var dexFlat:int = 0;
		public var vorFlat:int = 0;
		
		/*public var strScale:Number = 0;
		public var agiScale:Number = 0;
		public var vitScale:Number = 0;
		public var intScale:Number = 0;
		public var dexScale:Number = 0;
		public var vorScale:Number = 0;*/
		
		public var atk:int = 0;
		public var matk:int = 0;
		public var def:int = 0;
		public var mdef:int = 0;
		public var acc:int = 0;
		public var dodge:int = 0;
		public var fat:int = 0;
		public var cap:int = 0;
		
		public function Effect(properties:Object = null) {
			this.properties = properties;
			
			for (var name:String in properties) {
				if (this.hasOwnProperty(name)) {
					this[name] = properties[name];
				}
			}
		}
		
		public function listEffects():String {
			var text:String = "";
			
			for (var name:String in properties) {
				if (name == "health")
					text += "HP + " + properties[name] + ", ";
				else if (name == "mana")
					text += "MP + " + properties[name] + ", ";
				else if (name == "energy")
					text += "EN + " + properties[name] + ", ";
				else if (name == "strFlat")
					text += "STR + " + properties[name] + ", ";
				else if (name == "agiFlat")
					text += "AGI + " + properties[name] + ", ";
				else if (name == "vitFlat")
					text += "VIT + " + properties[name] + ", ";
				else if (name == "intFlat")
					text += "INT + " + properties[name] + ", ";
				else if (name == "dexFlat")
					text += "DEX + " + properties[name] + ", ";
				else if (name == "vorFlat")
					text += "VOR + " + properties[name] + ", ";
				/*else if (name == "strScale")
					text += "STR x " + properties[name] + ", ";
				else if (name == "agiScale")
					text += "AGI x " + properties[name] + ", ";
				else if (name == "vitScale")
					text += "VIT x " + properties[name] + ", ";
				else if (name == "intScale")
					text += "INT x " + properties[name] + ", ";
				else if (name == "dexScale")
					text += "DEX x " + properties[name] + ", ";
				else if (name == "vorScale")
					text += "VOR x " + properties[name] + ", ";*/
				else if (name == "atk")
					text += "ATK + " + properties[name] + ", ";
				else if (name == "matk")
					text += "MATK + " + properties[name] + ", ";
				else if (name == "def")
					text += "DEF + " + properties[name] + ", ";
				else if (name == "mdef")
					text += "MDEF + " + properties[name] + ", ";
				else if (name == "acc")
					text += "ACC + " + properties[name] + ", ";
				else if (name == "dodge")
					text += "DODGE + " + properties[name] + ", ";
				else if (name == "fat")
					text += "FAT + " + properties[name] + ", ";
				else if (name == "cap")
					text += "CAP + " + properties[name] + ", ";
			}
			trace(text);
			return text.slice(0, text.length - 2);
		}
	}
}
