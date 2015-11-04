package  {
	
	public class EventDefinitions {
		/*public static const definitions:Object {
			"Blade and Belly"			: BLADE_AND_BELLY,
			"Ano 1"						: ANO_1
		};
		
		public static function getEvent(name:String):XML {
			return definitions[name];
		}*/
		
		[Embed(source = "XML/BladeAndBelly.xml", mimeType = "application/octet-stream")]
		private static var BladeAndBelly:Class;
		public static const BLADE_AND_BELLY:XML = new XML(new BladeAndBelly());
		
		[Embed(source = "XML/Ano1.xml", mimeType = "application/octet-stream")]
		private static var Ano1:Class;
		public static const ANO_1:XML = new XML(new Ano1());
	}
}