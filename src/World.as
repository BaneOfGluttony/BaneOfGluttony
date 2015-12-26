package  {
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import mx.utils.StringUtil;
	import flash.utils.getTimer;
	
	public class World {
		public static const WORLD_ROWS:int = 100;
		public static const WORLD_COLS:int = 100;
		
		public static const BARRO_ROWS:int = 38;
		public static const BARRO_COLS:int = 43;
		
		private static const RANGE_INIT:int = 10;	// radius from which to load XML at the very start
		private static const RANGE:int = 5;			// radius from which to load XML
		private static const TRIGGER_RANGE:int = 2;	// if player gets within this number of tiles from an edge, trigger a load
		private static var children:XMLList;
		/// Keeps track of which direction(s) the Player moved last; 0 = E, 1 = N, 2 = W, 3 = S
		public static var travelDir:Array = [false, false, false, false];
		public static var textLoader:URLLoader;
		
		public static var world:Array = [WORLD_ROWS];
		public static var barro:Array = [BARRO_ROWS];
		
		//private static const SAVE_XML:Boolean = true;
		//WORLD, BARRO
		private static const SAVE_XML:String = "";
		
		private static var xml:XML = new XML();
		if (SAVE_XML != "WORLD") {
			[Embed(source = "XML/WORLD.xml", mimeType = "application/octet-stream")]
			private static var worldXML:Class;
		}
		if (SAVE_XML != "BARRO") {
			[Embed(source = "XML/BARRO.xml", mimeType = "application/octet-stream")]
			private static var barroXML:Class;
		}
		
		private static var file:FileReference;
		private static var bytes:ByteArray;
		
		public function World() {
			for (var y:int = 0; y < WORLD_ROWS; y++) {
				world[y] = [WORLD_COLS];
				for (var x:int = 0; x < WORLD_COLS; x++)
					world[y][x] = new Zone({});
			}
			
			if (SAVE_XML != "") {
				file = new FileReference();
				bytes = new ByteArray();
				textLoader = new URLLoader();
				textLoader.addEventListener(Event.COMPLETE, writeXML);
				xml = <{SAVE_XML.toLowerCase()}></{SAVE_XML.toLowerCase()}>;
				/*xml = <world></world>;
				file = new FileReference();
				bytes = new ByteArray();
				textLoader = new URLLoader();
				textLoader.addEventListener(Event.COMPLETE, writeXML);*/
				textLoader.load(new URLRequest(SAVE_XML + ".txt"));
			} else {
				xml = new XML(new worldXML());
				parseXML();
			}
		}
		
		public static function writeXML(e:Event):void {	
			var out:String = "";
			var lines:Array = e.target.data.split("\n");
			
			for (var i:int = 0; i < getDefinitionByName("World")[SAVE_XML + "_ROWS"]; i++) {
				var cell:Array = lines[i].split("\t");
				for (var j:int = 0; j < getDefinitionByName("World")[SAVE_XML + "_COLS"]; j++) {
					//Region - Name - Text - Enter (false) - Save (false) - Enemies (null) - Items (null) - Events (null)
					var data:Array = cell[j].split("-");	//Do NOT use hyphens/dashes, commas, or semi-colons in map text
					data = (StringUtil.trimArrayElements(data.join("*"), "*")).split("*");
					
					var region:String = data[0];
					var name:String = "";
					var text:String = "";
					var enter:Boolean = false;
					var save:Boolean = false;
					var enemies:Array = new Array();
					var items:Array = new Array();
					var events:Array = new Array();
					
					var temp:Array;
					var entry:Array;
					var k:int;
					
					switch (region) {
						case "St":
							region = "Staphshire";
							break;
						case "Di":
							region = "Diraq";
							break;
						case "Ta":
							region = "Tarboro";
							break;
						case "E":
							region = "Elyndar";
							break;
						case "Di":
							region = "Diraq";
							break;
						case "Ar":
							region = "Aroshar";
							break;
						case "P":
							region = "Plains";
							break;
						case "Fa":
							region = "Farmlands";
							break;
						case "F":
							region = "Forest";
							break;
						case "My":
							region = "Myseer Islands";
							break;
						case "H":
							region = "Hills";
							break;
						case "D":
							region = "Desert";
							break;
						case "M":
							region = "Mountains";
							break;
						case "Ro":
							region = "Road";
							break;
						case "R":
							region = "River";
							break;
						case "L":
							region = "Lake";
							break;
						case "Br":
							region = "Bridge";
							break;
						case "S":
							region = "Sea";
							break;
						case "Sa":
							region = "Savannah";
							break;
						case "Mo":
							region = "Monastery";
							break;
						case "O":
							region = "Oasis";
							break;
						case "Cl":
							region = "Clearing";
							break;
						case "Sw":
							region = "Swamp";
							break;
						case "Po":
							region = "Port";
							break;
						case "Ga":
							region = "Gaians";
							break;
						case "Ws":
							region = "Wyrmstead";
							break;
						case "Or":
							region = "Ori";
							break;
						case "B":
							region = "Beach";
							break;
						case "Dr":
							region = "Dirt";
							break;
						case "Ba":
							region = "Barro";
							break;
						case "G":
							region = "Gate";
							break;
					}
						
					if (data[1] != null && data[1] != "")
						name = StringUtil.trim(data[1]);
					
					if (data[2] != null && data[2] != "")
						text = StringUtil.trim(data[2]);
					
					if (data[3] != null && data[3] != "") {
						if (StringUtil.trim(data[3]) == "True" || StringUtil.trim(data[3]) == "true")
							enter = true;
					}
					
					if (data[4] != null && data[4] != "") {
						if (StringUtil.trim(data[4]) == "True" || StringUtil.trim(data[4]) == "true")
							save = true;
					}
					
					if (data[5] != null && data[5] != "") {
						temp = data[5].split(";");
						k = 0;
						
						for each (var enemy:String in temp) {
							temp[k] = enemy.split(",");
							entry = new Array(StringUtil.trim(temp[k][0]), StringUtil.trim(temp[k][1]));
							enemies.push(entry);
							k++;
						}
					}
					
					if (data[6] != null && data[6] != "") {
						items = StringUtil.trim(data[6]).split(",");
						items = (StringUtil.trimArrayElements(items.join("*"), "*")).split("*");
						for each (var item:String in items)
							item = StringUtil.trim(item);
					}
					
					if (data[7] != null && data[7] != "") {
						temp = data[7].split(";");
						k = 0;
						
						for each (var event:String in temp) {
							temp[k] = event.split(",");
							entry = new Array(StringUtil.trim(temp[k][0]), Number(StringUtil.trim(temp[k][1])));
							events.push(entry);
							k++;
						}
					}
					
					if (name == "")
						name = region;
					
					xml.appendChild( < cell name = { name } x = { j } y = { i } region = { region } enter = { enter } 
									save = { save } enemies = { enemies } items = { items } events = { events } > { text }</cell>);
				}
			}
			bytes.writeUTFBytes(xml);
			
			try {
				file.save(bytes, SAVE_XML + ".xml");
			} catch (e:Error) {
				//Ignore this. This is just so it doesn't spit out an error.
			}
			
			//if (SAVE_XML != "WORLD")
				//xml = new XML(new worldXML());
			parseXML();
			MainGameUI.updateNavBtns();
		}
		
		public static function parseXML():void {
			var rows:int = getDefinitionByName("World")[Player.region.toUpperCase() + "_ROWS"];
			var cols:int = getDefinitionByName("World")[Player.region.toUpperCase() + "_COLS"];
			var region:Array = getDefinitionByName("World")[Player.region.toLowerCase()];
			
			if (region.length <= 1) {
				for (var y:int = 0; y < rows; y++) {
					region[y] = [WORLD_COLS];
					for (var x:int = 0; x < cols; x++)
						region[y][x] = new Zone({});
				}
			}
			
			var ClassReference:Class = getDefinitionByName("World")[Player.region.toLowerCase() + "XML"] as Class;
			xml = new XML(new ClassReference());
			/*switch (Player.region) {
				case "BARRO" :
					xml = new XML(new barroXML());
					break;
				default :
					xml = new XML(new worldXML());
					break;
			}*/
			
			children = xml.children();
			trace("[World] parseXML called.");
			
			var cStart:int = Math.max(Player.x - RANGE_INIT, 0);
			//var cEnd:int  = Math.min(Player.x + RANGE_INIT, WORLD_COLS - 1);
			var cEnd:int  = Math.min(Player.x + RANGE_INIT, cols - 1);
			var rStart:int = Math.max(Player.y - RANGE_INIT, 0);
			//var rEnd:int  = Math.min(Player.y + RANGE_INIT, WORLD_ROWS - 1);
			var rEnd:int  = Math.min(Player.y + RANGE_INIT, rows - 1);
			
			var entry:XML;
			for (var r:int = rStart; r <= rEnd; r++)
				for (var c:int = cStart; c <= cEnd; c++) {
					//entry = xml.cell[int(r * WORLD_ROWS + c)];
					entry = xml.cell[int(r * cols + c)];
					//world[c][r] = new Zone( { name : entry.@name, x : c, y : r, region : entry.@region, text : entry,
					region[c][r] = new Zone( { name : entry.@name, x : c, y : r, region : entry.@region, text : entry,
											  enterText : entry.@enter, saveText : entry.@save, enemiesText : entry.@enemies.split(","),
											  itemsText : entry.@items.split(","), eventsText : entry.@events.split(",")} );
				}
			
			trace("[World] Player at " + Player.x + "," + Player.y);
			trace("[World] Initial loaded region is from (" + rStart + "," + cStart + ") to (" +
															  rEnd + "," + cEnd + ")");
		}

		public static function updateLoadedRegion():void {
			var rows:int = getDefinitionByName("World")[Player.region.toUpperCase() + "_ROWS"];
			var cols:int = getDefinitionByName("World")[Player.region.toUpperCase() + "_COLS"];
			var region:Array = getDefinitionByName("World")[Player.region.toLowerCase()];
			
			var checkW:int = Math.max(Player.x - TRIGGER_RANGE, 0);
			//var checkE:int = Math.min(Player.x + TRIGGER_RANGE, worldCols - 1);
			var checkE:int = Math.min(Player.x + TRIGGER_RANGE, cols - 1);
			var checkS:int = Math.max(Player.y - TRIGGER_RANGE, 0);
			//var checkN:int = Math.min(Player.y + TRIGGER_RANGE, worldRows - 1);
			var checkN:int = Math.min(Player.y + TRIGGER_RANGE, rows - 1);
			
			if (SAVE_XML != "") {
				var ClassReference:Class = getDefinitionByName("World")[Player.region.toLowerCase() + "XML"] as Class;
				xml = new XML(new ClassReference());
			}
			
			
			//if (world[Player.x][Player.y].x == -1 ||
			if (region[Player.x][Player.y].x == -1 ||
				//world[checkW][Player.y].x == -1 || world[checkE][Player.y].x == -1 ||
				region[checkW][Player.y].x == -1 || region[checkE][Player.y].x == -1 ||
				//world[Player.x][checkS].x == -1 || world[Player.x][checkN].x == -1) {
				region[Player.x][checkS].x == -1 || region[Player.x][checkN].x == -1) {
					trace("[World] Approaching world edge; loading more of the world.");
					var currentTime:int = getTimer();
					
					//MainGameUI.game.mainUI.mc_loading.visible = true;		// TODO fix or just remove

					var originX:int = Player.x + (travelDir[0] ? TRIGGER_RANGE : 0) - (travelDir[2] ? TRIGGER_RANGE : 0);
					var originY:int = Player.y + (travelDir[3] ? TRIGGER_RANGE : 0) - (travelDir[1] ? TRIGGER_RANGE : 0);
					
					// pick the 'center' of the region from which to load ahead of where the Player is moving towards
					var cStart:int = Math.max(originX - RANGE, 0);
					//var cEnd:int = Math.min(originX + RANGE, worldCols - 1);
					var cEnd:int = Math.min(originX + RANGE, cols - 1);
					var rStart:int = Math.max(originY - RANGE, 0);
					//var rEnd:int = Math.min(originY + RANGE, worldRows - 1);
					var rEnd:int = Math.min(originY + RANGE, rows - 1);
					
					var loaded:int;		// benchmarking
					var entry:XML;
					for (var r:int = rStart; r <= rEnd; r++)
						for (var c:int = cStart; c <= cEnd; c++) {
							//if (world[c][r].x != -1)
							if (region[c][r].x != -1)
								continue;
							loaded++;
							//entry = xml.cell[int(r * worldRows + c)];
							entry = xml.cell[int(r * cols + c)];
							//world[c][r] = new Zone( { name : entry.@name, x : c, y : r, region : entry.@region, text : entry,
							region[c][r] = new Zone( { name : entry.@name, x : c, y : r, region : entry.@region, text : entry,
													  enterText : entry.@enter, saveText : entry.@save, enemiesText : entry.@enemies.split(","),
													  itemsText : entry.@items.split(","), eventsText : entry.@events.split(",")} );
						}
					
					//MainGameUI.game.mainUI.mc_loading.visible = false;
					
					var elapsedTime:int = getTimer() - currentTime;
					trace("[World]\tPlayer at (" + Player.x + "," + Player.y + ").");
					trace("[World]\tLoaded a " + RANGE + "x" + RANGE + " region around (" + originX + "," + originY + ").");
					trace("[World]\tTime elapsed: " + int(elapsedTime / 1000) + "." + ((elapsedTime % 1000 < 100 ? "0" : "")) + (elapsedTime % 1000) + "s" +
						  "\t\tIterations: " + ((rEnd - rStart + 1) * (cEnd - cStart + 1)) + " tiles, of which " + loaded + " were new.");
				} else {	
					//trace("[World] Nothing to update.");
				}
		}
		
		public static function loadSubRegion(region:String):void {
			/*for (var y:int = 0; y < rows; y++) {
				world[y] = [cols];
				for (var x:int = 0; x < cols; x++)
					world[y][x] = new Zone({});
			}*/
		}
		
		/*public static function createWorld():void {
			for (var x:int = 0; x < rows; x++)
				world[x] = new Array(cols);
			
			//-----------------------------------------------------------------------------
			
			world[0][0] = new Zone({name	: "Field"							, x : 0, y : 0, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[0][1] = new Zone({name	: "Field"							, x : 0, y : 1, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[0][2] = new Zone({name	: "Field"							, x : 0, y : 2, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[0][3] = new Zone({name	: "Field"							, x : 0, y : 3, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[0][4] = new Zone({name	: "Desert Entrance"				, x : 0, y : 4, 
									text	: "Ahead lies the desert.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[0][5] = new Zone({name	: "Field"							, x : 0, y : 5, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[0][6] = new Zone({name	: "Field"							, x : 0, y : 6, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[0][7] = new Zone({name	: "Field"							, x : 0, y : 7, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[0][8] = new Zone({name	: "Field"							, x : 0, y : 8, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
								   
			//-----------------------------------------------------------------------------
			
			world[1][0] = new Zone({name	: "Field"							, x : 1, y : 0, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[1][1] = new Zone({name	: "Field"							, x : 1, y : 1, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[1][2] = new Zone({name	: "Wall"});
			world[1][3] = new Zone({name	: "Wall"});
			world[1][4] = new Zone({name	: "West Gate"						, x : 1, y : 4, 
									text	: "The town's western entrance."});
			world[1][5] = new Zone({name	: "Wall"});
			world[1][6] = new Zone({name	: "Wall"});
			world[1][7] = new Zone({name	: "Field"							, x : 1, y : 7, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[1][8] = new Zone({name	: "Field"							, x : 1, y : 8, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
								   
			//-----------------------------------------------------------------------------
			
			world[2][0] = new Zone({name	: "Field"							, x : 2, y : 0, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[2][1] = new Zone({name	: "Wall"});
			world[2][2] = new Zone({name	: "Wall"});
			world[2][3] = new Zone({name	: "Test"						, x : 2, y : 3, 
									text	: "This is a test zone.",
									events	: [["Blade and Belly", 0.5]]});
			world[2][4] = new Zone({name	: "West Road"						, x : 2, y : 4, 
									text	: "This road leads to the western gates."});
			world[2][5] = new Zone({name	: "Home"							, x : 2, y : 5, save : true,
									text 	: "Home sweet home. Here you can save games."});
			world[2][6] = new Zone({name	: "Wall"});
			world[2][7] = new Zone({name	: "Wall"});
			world[2][8] = new Zone({name	: "Field"							, x : 2, y : 8, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
								   
			//-----------------------------------------------------------------------------
			
			world[3][0] = new Zone({name	: "Field"							, x : 3, y : 0, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[3][1] = new Zone({name	: "Wall"});
			world[3][2] = new Zone({name	: "Restaurant"						, x : 3, y : 2, enter : true,
									text	: "A place to fill your belly with some good ol' fashioned home cooking.",
									items	: new Array("Mutton Loin", "Roast Chicken")});
			world[3][3] = new Zone({name	: "NW Pavilion"					, x : 3, y : 3, 
									text	: "The northwestern pavilion."});
			world[3][4] = new Zone({name	: "West Square"					, x : 3, y : 4, 
									text	: "Town square's western wing."});
			world[3][5] = new Zone({name	: "SW Pavilion"					, x : 3, y : 5, 
									text	: "The southwestern pavilion."});
			world[3][6] = new Zone({name	: "Test"							, x : 3, y : 6, 
									text	: "This is a test zone.",
									events	: [["Ano 1", 0.25]]});
			world[3][7] = new Zone({name	: "Wall"});
			world[3][8] = new Zone({name	: "Field"							, x : 3, y : 8, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
								   
			//-----------------------------------------------------------------------------
			
			world[4][0] = new Zone({name	: "Mountains Entrance"				, x : 4, y : 0, 
									text	: "Ahead lie the mountains.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[4][1] = new Zone({name	: "North Gate"						, x : 4, y : 1, 
									text	: "The town's northern entrance."});
			world[4][2] = new Zone({name	: "North Road"						, x : 4, y : 2, 
									text	: "This road leads to the northern gates."});
			world[4][3] = new Zone({name	: "North Square"					, x : 4, y : 3, 
									text	: "Town square's northern wing."});
			world[4][4] = new Zone({name	: "Town Square"					, x : 4, y : 4, 
									text	: "This is the town center."});
			world[4][5] = new Zone({name	: "South Square"					, x : 4, y : 5, 
									text	: "Town square's southern wing."});
			world[4][6] = new Zone({name	: "South Road"						, x : 4, y : 6, 
									text	: "This road leads to the southern gates."});
			world[4][7] = new Zone({name	: "South Gate"						, x : 4, y : 7, 
									text 	: "The town's southern entrance."});
			world[4][8] = new Zone({name	: "Forest Entrance"				, x : 4, y : 8, 
									text	: "Ahead lies the forest.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			
			//-----------------------------------------------------------------------------
			
			world[5][0] = new Zone({name	: "Field"							, x : 5, y : 0, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[5][1] = new Zone({name	: "Wall"});
			world[5][2] = new Zone({name	: "Apothecary"						, x : 5, y : 2, enter : true, 
									text	: "Potions of all kinds",
									items	: new Array("Red Potion", "Orange Potion", "Yellow Potion", "White Potion", "Blue Potion", "Violet Potion")});
			world[5][3] = new Zone({name	: "NE Pavilion"					, x : 5, y : 3, 
									text	: "The northeastern pavilion."});
			world[5][4] = new Zone({name	: "East Square"					, x : 5, y : 4, 
									text	: "Town square's eastern wing."});
			world[5][5] = new Zone({name	: "SE Pavilion"					, x : 5, y : 5, 
									text	: "The southeastern pavilion."});
			world[5][6] = new Zone({name	: "Armorsmith"						, x : 5, y : 6, 
									text	: "Ye Olde Big and Tall Smithy: For all your specially proportioned needs.\n\nOut for lunch. May or may not return any time soon."});
			world[5][7] = new Zone({name	: "Wall"});
			world[5][8] = new Zone({name	: "Field"							, x : 5, y : 8, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
								   
			//-----------------------------------------------------------------------------
			
			world[6][0] = new Zone({name	: "Field"							, x : 6, y : 0, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[6][1] = new Zone({name	: "Wall"});
			world[6][2] = new Zone({name	: "Wall"});
			world[6][3] = new Zone({name	: "Armory"							, x : 6, y : 3, enter : true, 
									text	: "Weapons and armor",
									items	: new Array("Knife", "Sword", "Axe", "Hat", "Cotton Shirt", "Denim Pants", "Shoes", "Guard", "Falchion", "Sabre")});
			world[6][4] = new Zone({name	: "East Road"						, x : 6, y : 4, 
									text	: "This road leads to the eastern gates."});
			world[6][5] = new Zone({name	: "Blacksmith"						, x : 6, y : 5, enter : true,
									text	: "Forger of specilized and powerful weapons.",
									items	: new Array("Falchion", "Rapier", "Sabre", "Cutlass", "Katana", "Flamberge", "Lance", "Halberd")});
			world[6][6] = new Zone({name	: "Wall"});
			world[6][7] = new Zone({name	: "Wall"});
			world[6][8] = new Zone({name	: "Field"							, x : 6, y : 8, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			
			//-----------------------------------------------------------------------------
			
			world[7][0] = new Zone({name	: "Field"							, x : 7, y : 0, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[7][1] = new Zone({name	: "Field"							, x : 7, y : 1, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[7][2] = new Zone({name	: "Wall"});
			world[7][3] = new Zone({name	: "Wall"});
			world[7][4] = new Zone({name	: "East Gate"						, x : 7, y : 4, 
									text	: "The town's eastern entrance."});
			world[7][5] = new Zone({name	: "Wall"});
			world[7][6] = new Zone({name	: "Wall"});
			world[7][7] = new Zone({name	: "Field"							, x : 7, y : 7, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[7][8] = new Zone({name	: "Field"							, x : 7, y : 8, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			
			//-----------------------------------------------------------------------------
			
			world[8][0] = new Zone({name	: "Field"							, x : 8, y : 0, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[8][1] = new Zone({name	: "Field"							, x : 8, y : 1, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[8][2] = new Zone({name	: "Field"							, x : 8, y : 2, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[8][3] = new Zone({name	: "Field"							, x : 8, y : 3, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[8][4] = new Zone({name	: "Beach Entrance"					, x : 8, y : 4, 
									text	: "Ahead lies the beach.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[8][5] = new Zone({name	: "Field"							, x : 8, y : 5, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[8][6] = new Zone({name	: "Field"							, x : 8, y : 6, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[8][7] = new Zone({name	: "Field"							, x : 8, y : 7, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
			world[8][8] = new Zone({name	: "Field"							, x : 8, y : 8, 
									text	: "This is a test zone.",
									enemies	: [["Boar", 0.25], ["Slime", 0.25]]});
		}*/
	}
}
