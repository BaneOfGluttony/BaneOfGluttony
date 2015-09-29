package  {
	
	public class World {
		public static var rows:int = 9;
		public static var cols:int = 9;
		public static var world:Array = new Array(rows);
		createWorld();
		
		public function World() {
			
		}
		
		public static function createWorld():void {
			for (var x:int = 0; x < rows; x++)
				world[x] = new Array(cols);
			
			//-----------------------------------------------------------------------------
			
			world[0][0] = new Zone({name	: "Field"							, x : 0, y : 0, 
									text	: "This is a test zone."});
			world[0][1] = new Zone({name	: "Field"							, x : 0, y : 1, 
									text	: "This is a test zone."});
			world[0][2] = new Zone({name	: "Field"							, x : 0, y : 2, 
									text	: "This is a test zone."});
			world[0][3] = new Zone({name	: "Field"							, x : 0, y : 3, 
									text	: "This is a test zone."});
			world[0][4] = new Zone({name	: "Desert Entrance"				, x : 0, y : 4, 
									text	: "Ahead lies the desert."});
			world[0][5] = new Zone({name	: "Field"							, x : 0, y : 5, 
									text	: "This is a test zone."});
			world[0][6] = new Zone({name	: "Field"							, x : 0, y : 6, 
									text	: "This is a test zone."});
			world[0][7] = new Zone({name	: "Field"							, x : 0, y : 7, 
									text	: "This is a test zone."});
			world[0][8] = new Zone({name	: "Field"							, x : 0, y : 8, 
									text	: "This is a test zone."});
								   
			//-----------------------------------------------------------------------------
			
			world[1][0] = new Zone({name	: "Field"							, x : 1, y : 0, 
									text	: "This is a test zone."});
			world[1][1] = new Zone({name	: "Field"							, x : 1, y : 1, 
									text	: "This is a test zone."});
			world[1][2] = new Zone({name	: "Wall"});
			world[1][3] = new Zone({name	: "Wall"});
			world[1][4] = new Zone({name	: "West Gate"						, x : 1, y : 4, 
									text	: "The town's western entrance."});
			world[1][5] = new Zone({name	: "Wall"});
			world[1][6] = new Zone({name	: "Wall"});
			world[1][7] = new Zone({name	: "Field"							, x : 1, y : 7, 
									text	: "This is a test zone."});
			world[1][8] = new Zone({name	: "Field"							, x : 1, y : 8, 
									text	: "This is a test zone."});
								   
			//-----------------------------------------------------------------------------
			
			world[2][0] = new Zone({name	: "Field"							, x : 2, y : 0, 
									text	: "This is a test zone."});
			world[2][1] = new Zone({name	: "Wall"});
			world[2][2] = new Zone({name	: "Wall"});
			world[2][3] = new Zone({name	: "Test"						, x : 2, y : 3, 
									events	: [["BladeAndBelly", 1, true]],
									text	: "This is a test zone."});
			world[2][4] = new Zone({name	: "West Road"						, x : 2, y : 4, 
									text	: "This road leads to the western gates."});
			world[2][5] = new Zone({name	: "Home"							, x : 2, y : 5, save : true,
									text 	: "Home sweet home. Here you can save games."});
			world[2][6] = new Zone({name	: "Wall"});
			world[2][7] = new Zone({name	: "Wall"});
			world[2][8] = new Zone({name	: "Field"							, x : 2, y : 8, 
									text	: "This is a test zone."});
								   
			//-----------------------------------------------------------------------------
			
			world[3][0] = new Zone({name	: "Field"							, x : 3, y : 0, 
									text	: "This is a test zone."});
			world[3][1] = new Zone({name	: "Wall"});
			world[3][2] = new Zone({name	: "Restaurant"						, x : 3, y : 2, enter : true,
									items	: new Array("Mutton Loin", "Roast Chicken"),
									text	: "A place to fill your belly with some good ol' fashioned home cooking."});
			world[3][3] = new Zone({name	: "NW Pavilion"					, x : 3, y : 3, 
									text	: "The northwestern pavilion."});
			world[3][4] = new Zone({name	: "West Square"					, x : 3, y : 4, 
									text	: "Town square's western wing."});
			world[3][5] = new Zone({name	: "SW Pavilion"					, x : 3, y : 5, 
									text	: "The southwestern pavilion."});
			world[3][6] = new Zone({name	: "Test"							, x : 3, y : 6, 
									text	: "This is a test zone."});
			world[3][7] = new Zone({name	: "Wall"});
			world[3][8] = new Zone({name	: "Field"							, x : 3, y : 8, 
									text	: "This is a test zone."});
								   
			//-----------------------------------------------------------------------------
			
			world[4][0] = new Zone({name	: "Mountains Entrance"				, x : 4, y : 0, 
									text	: "Ahead lie the mountains."});
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
									text	: "Ahead lies the forest."});
			
			//-----------------------------------------------------------------------------
			
			world[5][0] = new Zone({name	: "Field"							, x : 5, y : 0, 
									text	: "This is a test zone."});
			world[5][1] = new Zone({name	: "Wall"});
			world[5][2] = new Zone({name	: "Apothecary"						, x : 5, y : 2, enter : true, 
									items	: new Array("Red Potion", "Orange Potion", "Yellow Potion", "White Potion", "Blue Potion", "Violet Potion"),
									text	: "Potions of all kinds"});
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
									text	: "This is a test zone."});
								   
			//-----------------------------------------------------------------------------
			
			world[6][0] = new Zone({name	: "Field"							, x : 6, y : 0, 
									text	: "This is a test zone."});
			world[6][1] = new Zone({name	: "Wall"});
			world[6][2] = new Zone({name	: "Wall"});
			world[6][3] = new Zone({name	: "Armory"							, x : 6, y : 3, enter : true, 
									items	: new Array("Knife", "Sword", "Axe", "Hat", "Cotton Shirt", "Denim Pants", "Shoes", "Guard", "Falchion", "Sabre"),
									text	: "Weapons and armor"});
			world[6][4] = new Zone({name	: "East Road"						, x : 6, y : 4, 
									text	: "This road leads to the eastern gates."});
			world[6][5] = new Zone({name	: "Blacksmith"						, x : 6, y : 5, enter : true,
									items	: new Array("Falchion", "Rapier", "Sabre", "Cutlass", "Katana", "Flamberge", "Lance", "Halberd"),
									text	: "Forger of specilized and powerful weapons."});
			world[6][6] = new Zone({name	: "Wall"});
			world[6][7] = new Zone({name	: "Wall"});
			world[6][8] = new Zone({name	: "Field"							, x : 6, y : 8, 
									text	: "This is a test zone."});
			
			//-----------------------------------------------------------------------------
			
			world[7][0] = new Zone({name	: "Field"							, x : 7, y : 0, 
									text	: "This is a test zone."});
			world[7][1] = new Zone({name	: "Field"							, x : 7, y : 1, 
									text	: "This is a test zone."});
			world[7][2] = new Zone({name	: "Wall"});
			world[7][3] = new Zone({name	: "Wall"});
			world[7][4] = new Zone({name	: "East Gate"						, x : 7, y : 4, 
									text	: "The town's eastern entrance."});
			world[7][5] = new Zone({name	: "Wall"});
			world[7][6] = new Zone({name	: "Wall"});
			world[7][7] = new Zone({name	: "Field"							, x : 7, y : 7, 
									text	: "This is a test zone."});
			world[7][8] = new Zone({name	: "Field"							, x : 7, y : 8, 
									text	: "This is a test zone."});
			
			//-----------------------------------------------------------------------------
			
			world[8][0] = new Zone({name	: "Field"							, x : 8, y : 0, 
									text	: "This is a test zone."});
			world[8][1] = new Zone({name	: "Field"							, x : 8, y : 1, 
									text	: "This is a test zone."});
			world[8][2] = new Zone({name	: "Field"							, x : 8, y : 2, 
									text	: "This is a test zone."});
			world[8][3] = new Zone({name	: "Field"							, x : 8, y : 3, 
									text	: "This is a test zone."});
			world[8][4] = new Zone({name	: "Beach Entrance"					, x : 8, y : 4, 
									text	: "Ahead lies the beach."});
			world[8][5] = new Zone({name	: "Field"							, x : 8, y : 5, 
									text	: "This is a test zone."});
			world[8][6] = new Zone({name	: "Field"							, x : 8, y : 6, 
									text	: "This is a test zone."});
			world[8][7] = new Zone({name	: "Field"							, x : 8, y : 7, 
									text	: "This is a test zone."});
			world[8][8] = new Zone({name	: "Field"							, x : 8, y : 8, 
									text	: "This is a test zone."});
		}
	}
}
