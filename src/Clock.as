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
		
		public static function advTime(t:Number):void {
			time += t;
			interpret();
			updateUI();
		}
		
		public static function advTravelTime(dist:Number):void {
			var rate:Number = 500 * (Player.stats["str"] + Player.stats["agi"]) / Player.derivedStats["weight"];
			if (rate > 800)
				rate = 800;
			
			dist *= 100;
			advTime(dist / rate);
			
			if (Player.metabolism > 1.25)
				Player.metabolism = 1.25;
			else
				Player.metabolism += 0.01 * ((dist / rate) / 60);
			
			Main.digest(dist / rate);
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