package  {
	
	public class Clock {
		public static var time:Number;
		public static var minute:int;
		public static var hour:int;
		public static var day:int;
		public static var year:int;
		public static var h12:Boolean = true;
		/*public static var dayOfWeek:int = 0;
		public static const WEEK:Array = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];*/
		
		public function Clock(t:Number = 540) {
			time = t;
			interpret();
			updateUI();
		}
		
		public static function advTime(dist:Number, str:int, agi:int, weight:Number):void {
			var rate:Number = 500 * (str + agi) / weight;
			if (rate > 800)
				rate = 800;
			
			dist *= 100;
			time += dist / rate;
			interpret();
			updateUI();
			digest(dist / rate);
		}
		
		public static function rest(m:int = 0, h:int = 1):void {
			minute += m;
			hour += h;
			updateUI();
			digest(m + h * 60, true);
		}
		
		public static function digest(m:int = 60, rest:Boolean = false):void {
			var hours:Number = m / 60;
			
			if (Player.resources["currCapacity"] > Player.resources["maxCapacity"]) {
				var overflow:int = Player.resources["currCapacity"] - Player.resources["maxCapacity"];
				Main.addResource("Capacity", 0, 0.5 * overflow);
				Main.addText("Clutching onto your aching, grossly swollen gut, it's blatantly obvious that you've been overindulging your appetite, literally playing Iroshan Roulette with your stomach. With a worried groan accompanied by quick short pants, you're caught off guard by the fact that you can't quite decide whether or not you like this oddly enjoyable sensation. The burning pain of your belly's innards stretching to accommodate the boulder-like mass contained within is, deep down, thoroughly satisfying.");
			}
			
			var capDrained:int;
			if (Player.stats["vit"] <= 0.8 * Player.resources["maxCapacity"])
				capDrained = Math.round(hours * (Player.resources["maxCapacity"] - Player.stats["vit"]));
			else
				capDrained = Math.round(hours * Player.resources["maxCapacity"]);
			
			if (capDrained > Player.resources["currCapacity"]) {
				capDrained = Player.resources["currCapacity"];
				Main.setResource("Capacity", 0, -1);
			} else {
				Main.addResource("Capacity", -capDrained, 0);
			}
			
			if (rest)
				Main.addFat(0.15 * capDrained);
			else
				Main.addFat(0.1 * capDrained);
		}
		
		public static function interpret():void {
			var tempTime:Number = time;
			
			year = 1 + tempTime / 525600;
			tempTime %= 525600;
			
			day = 1 + tempTime / 1440;
			tempTime %= 1440;
			
			hour = tempTime / 60;
			tempTime %= 60;
			
			minute = tempTime;
		}
		
		public static function padZero(n:Number):String {
			var ret:String = n.toString();
			if (ret.length < 2)
				ret = "0" + ret;
			return ret;
		}
		
		public static function updateUI():void {
			MainGameUI.game.mainUI.timeLabel.text = toString();
		}
		
		public static function toString():String {
			if (h12) {
				if (hour < 12) {
					if (hour == 0)
						return "Year " + year + ", Day " + day + " - 12:" + padZero(minute) + "AM";
					else
						return "Year " + year + ", Day " + day + " - " + hour + ":" + padZero(minute) + "AM";
				} else {
					if (hour == 12)
						return "Year " + year + ", Day " + day + " - 12:" + padZero(minute) + "PM";
					else
						return "Year " + year + ", Day " + day + " - " + (hour - 12) + ":" + padZero(minute) + "PM";
				}
			} else
				return "Year " + year + ", Day " + day + " - " + padZero(hour) + ":" + padZero(minute);
		}
	}
}