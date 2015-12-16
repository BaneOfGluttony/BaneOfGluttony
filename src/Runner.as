package 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
	/**
	 * Entry point
	 * @author Serule Blue
	 */
	[SWF(width = "800", height = "710", backgroundColor = "#E2C38C", framerate = "30")] //non-debug height = 600, debug height = 710
	//[Frame(factoryClass="Preloader")]
	public class Runner extends Sprite {
		private var mainGame:MovieClip;
		public var container:MovieClip;
		
		public function Runner():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			new World();
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			trace("--------------------------------------------");
			trace("[Runner] Creating mainGame.");
			
			var currentTime:int = getTimer();
			trace("[Runner] A whole new Wooooooorld.");
			new World();
			var elapsedTime:int = getTimer() - currentTime;
			trace("[Runner] World created.");
			trace("[Runner] Time elapsed: " + int(elapsedTime / 1000) + "." + (elapsedTime % 1000) + "s");
			
			mainGame = new Main(this);
			if (mainGame)
				trace("[Runner] Done. Thanks, Serule!");
			else
				trace("[Runner] Damn, mainGame failed! mainGame = " + mainGame);
		}
	}
}