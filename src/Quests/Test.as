package Quests {
	import flash.display.MovieClip;
	
	public class Test extends Quest {

		public function Test(main:MovieClip, player:Player, fileName:String) {
			super(main, player, fileName);
		}
		
		override public function checkState():int {
			switch (state) {
				case 2 :
					if (player.x == 7 && player.y == 1) {
						main.addText("You found some wall chicken!");
						main.loot(ItemDefinitions.getItem("Roast Chicken"), 3);
						state++;
					}
					break;
				case 3 :
					if (player.x == 3 && player.y == 6) {
						main.addText("You feel an uncontrollable compulsion to devour the wall chicken.");
						if (checkItems([ItemDefinitions.getItem("Roast Chicken")])) {
							main.useItem(ItemDefinitions.getItem("Roast Chicken"));
							if (player.isAlive)
								finishEvent();
						}
					}
					break;
				default :
					break;
			}
			
			return 0;
		}
	}
}
