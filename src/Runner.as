package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * Entry point
	 * @author Serule Blue
	 */
	[SWF(width="800", height="710", backgroundColor="#E2C38C", framerate="30")] //Height = 600
	public class Runner extends Sprite {
		private var mainGame:MovieClip;
		
		public function Runner():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			trace("--------------------------------------------");
			trace("[Runner] Creating mainGame.");
			mainGame = new Main(this);
			if (mainGame)
				trace("[Runner] Done. Thanks, Serule!");
			else
				trace("[Runner] Damn, mainGame failed! mainGame = " + mainGame);
		}
	}
}