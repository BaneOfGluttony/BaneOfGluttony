﻿package  {
	
	public class Item {
		public var name:String = "Item";
		public var short:String = "Short description";
		public var long:String = "Long description";
		public var wpnText:String = "Weapon text";
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
		
		public var effect:Effect = new Effect();
		
		/*public var health:int = 0;
		public var mana:int = 0;
		public var energy:int = 0;
		public var capacity:int = 0;
		
		public var atk:int = 0;
		public var matk:int = 0;
		public var def:int = 0;
		public var mdef:int = 0;
		public var acc:int = 0;
		public var dodge:int = 0;
		public var fat:int = 0;
		public var cap:int = 0;
		
		public var strFlat:int = 0;
		public var agiFlat:int = 0;
		public var vitFlat:int = 0;
		public var intFlat:int = 0;
		public var dexFlat:int = 0;
		public var vorFlat:int = 0;
		
		public var strScale:Number = 0;
		public var agiScale:Number = 0;
		public var vitScale:Number = 0;
		public var dexScale:Number = 0;
		public var intScale:Number = 0;
		public var vorScale:Number = 0;*/
		
		//public var effect:Status = new Status({});

		public function Item(properties:Object = null) {
			for (var name:String in properties) {
				if (this.hasOwnProperty(name)) {
					this[name] = properties[name];
				}
			}
		}
		
		public function procEffects(main:Main, player:Player):void {
			main.addResource("Health", effect.health, 0);
			main.addResource("Mana", effect.mana, 0);
			main.addResource("Energy", effect.energy, 0);
			main.addResource("Capacity", effect.capacity, 0);
			main.addFat(0.05 * effect.capacity);
			
			main.addStat("str", effect.strFlat);
			main.addStat("agi", effect.agiFlat);
			main.addStat("vit", effect.vitFlat);
			main.addStat("int", effect.intFlat);
			main.addStat("dex", effect.dexFlat);
			main.addStat("vor", effect.vorFlat);
			
			/*main.addStat("str", Math.round(player.stats["str"] * effect.strScale));
			main.addStat("agi", Math.round(player.stats["agi"] * effect.agiScale));
			main.addStat("vit", Math.round(player.stats["vit"] * effect.vitScale));
			main.addStat("int", Math.round(player.stats["int"] * effect.intScale));
			main.addStat("dex", Math.round(player.stats["dex"] * effect.dexScale));
			main.addStat("vor", Math.round(player.stats["vor"] * effect.vorScale));*/
		}
		
		public function toString():String {
			return count + "x " + name + " - " + long;
		}
	}
}
