package  {
	
	public class EventDefinitions {
		[Embed(source = "XML/BladeAndBelly.xml", mimeType = "application/octet-stream")]
		private static var BladeAndBelly:Class;
		public static const BLADE_AND_BELLY:XML = new XML(new BladeAndBelly());
		
		[Embed(source = "XML/Ano1.xml", mimeType = "application/octet-stream")]
		private static var Ano1:Class;
		public static const ANO_1:XML = new XML(new Ano1());
		
		[Embed(source = "XML/PsychicImmortality.xml", mimeType = "application/octet-stream")]
		private static var PsychicImmortality:Class;
		public static const PSYCHICIMMORTALITY:XML = new XML(new PsychicImmortality());
	}
}