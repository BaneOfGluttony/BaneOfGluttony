package Quests {
	import flash.display.MovieClip;
	
	public class Test extends GameEvent {

		public function Test(main:MovieClip, player:Player, fileName:String) {
			super(main, player, fileName);
			player.quests.push(this);
		}
		
		override public function checkState():int {
			switch (state) {
				case 0 :
					if (player.x == 7 && player.y == 1) {
						main.loot(ItemDefinitions.getItem("Roast Chicken"), 3);
						state++;
					}
					break;
				case 1 :
					if (player.x == 3 && player.y == 6) {
						if (player.indexOfInventory(ItemDefinitions.getItem("Roast Chicken")) != -1) {
							main.useItem(ItemDefinitions.getItem("Roast Chicken"));
							finishQuest();
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
