package {
	import flash.display.MovieClip;
	
	public class Quest extends GameEvent {
		
		public function Quest(main:MovieClip, player:Player, fileName:String) {
			super(main, player, fileName);
		}
	}
}
