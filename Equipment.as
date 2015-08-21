package  {
	
	public class Equipment extends Item {

		public function Equipment(name:String, short:String, long:String, canDrop:Boolean, properties:Object) {
			super(name, short, long, canDrop);
			
			for (var name:String in properties) {
				if (this.hasOwnProperty(name)) {
					this[name] = properties[name];
				}
			}
		}
	}
}
