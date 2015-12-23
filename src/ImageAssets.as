package  {
	import flash.display.Bitmap;
	import flash.utils.describeType;
	
	public class ImageAssets {
		[Embed(source = "Images/Shara.png")]
		private static var Shara:Class;
		public static const SHARA:Bitmap = new Shara() as Bitmap;
		SHARA.x = 20;
		SHARA.y = 20;
		
		[Embed(source = "Images/poring.png")]
		private static var Slime:Class;
		public static const SLIME:Bitmap = new Slime() as Bitmap;
		SLIME.x = 20;
		SLIME.y = 20;
	}
}