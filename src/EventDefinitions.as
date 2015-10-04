package  {
	
	public class EventDefinitions {
		//{ Blade and Belly
		public static const BLADE_AND_BELLY:XML =
<event name="Blade and Belly" repeatable="false">
	<dialog id="0">
		<text check="loc:2,3">
As you step over the rough cobblestone, you hear a quiet sobbing from around the corner. Do you approach the voice?
		</text>
		<options>
			<option id="1">Yes</option>
			<option id="3">No</option>
		</options>
	</dialog>
	<dialog id="1">
		<text check="loc:2,3">
Whoever it is that is crying, they need help. You rush around the corner and nearly collide with a rather plump mouse as you do so. She gasps momentarily, before ducking her head down and wiping the tears from her snout.
"Please forgive my good [sir/madam]," she starts, "It’s just... I’m so hungry. I have had nothing to eat since second lunch, and I fear I may die of hunger!" Looking over the woman, you note that she isn’t wasting away in any sense of the word. Rather, she appears to be quite overweight! Her hips are starting to fray the fabric of her plain dress, her belly seems to be stretching the threads to their limit, as you can see the downy white fur peaking through the strained garment. Finally, it appears that her breasts have made an impromptu window of the woman’s torso. "If it isn’t too much trouble... could you bring me some food? I don’t have money for the restaurant, but I have just enough for you to buy a simple weapon. There are an enormous number of boars that have cropped up just to the east of the city. If you could bring me five haunches of pork, I’d be ever so grateful!" Her stomach grumbles, and she adds, "The faster, the better!"
Do you accept?
		</text>
		<options>
			<option id="2" action="addQuest;gold:+15">Yes</option>
			<option id="4">No</option>
		</options>
	</dialog>
	<dialog id="2" end="true">
		<text state="5">
She shakes your hand, thanking you heartily, the various fatty bits of her jiggling furiously as she does so. "Oh... I’m Shara, by the way." She blushes slightly before offering you a handful of gold pieces. "The blacksmith is on the [direction] side of town, just [direction] of the [location]. This should be enough to buy a simple weapon to help you hunt. Thanks again!"
		</text>
		<log>Shara's been loitering by the restaurant, starving, and apparently unable to afford any food for herself, but she gave you some gold to buy a weapon and hunt 5 pork haunches for her. Head over to the blacksmith and arm yourself against the wild boars outside town.</log>
	</dialog>
	<dialog id="3" end="true">
		<text>
You decide that you have enough problems of your own without having to deal with another’s at the moment. You continue on your way, the sobbing slowly growing fainter as you leave the corner.
		</text>
	</dialog>
	<dialog id="4" end="true">
		<text>
She looks rather forlorn, her stomach growling again as she clutches it. "Well, thanks anyway. Have a good day, sir." She wipes her wet snout one more time before ambling away, quickly turning the corner as she leaves.
		</text>
	</dialog>
	<dialog id="5" end="true">
		<text check="loc:2,3">
As you walk around a corner you come across Shara, still quietly sobbing and holding her stomach, even as she eats what must not be her first meal of today. She whimpers a little as she notices you, but tries to smile, hopeful.
You really should go back to finding those haunches for her.
		</text>
		<text check="loc:2,3;item:Pork Haunch-5" action="dropItem:Pork Haunch-5;gold:+3;exp:25;rmvQuest" override="true">
Wandering through the streets of the city, it takes some time, and a bit of asking after her, but you finally find Shara as she is resting on a bench, next to the street. She perks up as she sees you, her eyes drawn to your bulging pack. She jumps up, rushing forward to greet you.
"Oh, welcome back!" She smiles, her face lighting up, though one hand seems to be constantly on her expansive gut. Her smile only widens as you give her the haunches of pork. "You’re a life saver, [sir/madam]." She suddenly lurches forward, wrapping her soft arms around you and pulling you into a warm hug. "Unfortunately, I can only offer you my friendship and a few more gold pieces, but thank you! If I see you again, maybe I can hire you again! I’ve been so hungry these last few weeks, I wonder why..." She looks concerned for a moment before the bloody smell of the haunches reach her. "Whatever it is, I need to get these cooked! Have a good day!" Quickly handing you another handful of gold, the rotund mouse ambles off, the haunches weighing her weak frame down as she hobbles away, her wide hips sashaying pleasantly as she does so.
		</text>
	</dialog>
</event>
		//}
		
		//{ Ano 1
		public static const ANO_1:XML =
<event name="Ano 1" repeatable="false">
	<dialog id="0">
		<text check="loc:3,6">
As you make your way along the side streets of Staphshire you are perturbed by a ruckus in a nearby shop.
"Stop! Thief!" an old man screams as a definetively shady character jumps out of an open window.
Landing right in front of you, the accused thief is covered in a long dark cloak, which seems to hide several bulky objects, and dons a mask that makes clear to everyone his profession.
"Someone catch that ruffian!" the old man screams again, to which the thief responds by immediately scampering into an alley.
		</text>
		<options>
			<option id="1" action="loc:4,6">Follow him</option>
			<option id="5">Talk to the man</option>
			<option id="6">Mind your own business</option>
		</options>
	</dialog>
	<dialog id="1">
		<text>
You quickly dash around the alleyway, jumping over crates and barreling through pedestrians as you make your way in hot pursuit of the thief. He soon notices your chase and leaves his reasonably inconspicuous jog in exchange for a mad run for his dear life.
		</text>
		<options>
			<option id="2">Keep chasing</option>
			<option id="4">Give up</option>
		</options>
	</dialog>
	<dialog id="2">
		<text check="agi:0,19" goto="3"></text>
		<text check="agi:20" action="endEvent;loc:6,5" end="true">
You give the masked rogue a good chase, going through boltholes and narrow passageways that no one but the darkest individuals would ever know existed in the streets of Staphshire. Finally, the crook seems to escape by swinging from a clothesline into the loft of a very, very startled woman, leaving you to stare at his daring escape from the rooftop across. Too bad for you that it’s garbage day, and the bins are all full of foodstuffs waiting collection. You mutter a swear under your breath as you plummet two stories into the fetid, partially eaten food.
With only your eyes showing through a helmet that is a half-eaten watermelon, you wait in silence for the criminal to make his way out the front doors of the building before you. As he leaves, as inconspicuously as he can, you notice several loaves of bread stuffed inside his cloak. He moves toward the end of the street and knocks one, two, three times on the back door of a very suspicious establishment before being let in. Above said door reads "Greater Future Society" in big capital letters.
		</text>
	</dialog>
	<dialog id="3" end="true">
		<text action="loc:5,6">
Try as you might you soon feel yourself falling behind in this chase. At every corner, the thief seems to escape further and further away from you, disappearing into the crowds of multicolored fur. Finally, he vanishes over a fence with an acrobatic feat you are certainly in no physical condition to replicate. Maybe you should come to terms that you're just too slow and and hope for better next time.
		</text>
	</dialog>
	<dialog id="4" end="true">
		<text>
Panting to catch your breath, you double over and rest your paws on your knees. Meanwhile, your target flees into the distance down the streets, escaping scot-free. With a dejected sigh, you give up the chase and pick yourself up before continuing on your way.
		</text>
	</dialog>
	<dialog id="5" end="true">
		<text>
You talk to the frantic man and ask what happened as you try to calm him down. The old bulldog mutters to himself about being way too old for this kind of thing, which the sagging folds of his face seem to agree with.
"One can't even have a snack break these days!" complains the old man exasperatedly. "Here was I, going to the backroom of the bakery for five minutes of relaxation and a couple of sweets," he says as he takes a seat and pats his bulging gut which suggests to you that he might have had much more than a couple and for much longer than 5 minutes, "and when I come back, I see this devilish rogue, masked and caped and all, messing with my bread display and running off with what seems a whole batch snuck inside his coat pocket!"
You try to calm the old man and make sure to call for guards. While you wait with the old coot, you ask the man what has to be done and he points toward a clipboard by the strongbox. "There is the inventory. We have to find out exactly how much that devil stole, so we can punish him accordingly! The kids these day have no discipline. One year for each eclair is what I will demand!"
		</text>
		<text check="int:0,19">
You try to understand the marks on the clipboard, but your feeble mind cannot begin to make heads or tails of them. Numbers and foreign names just roll off your mind like water on a very, very clueless duck. The old man's calligraphy is not helping either. You just look at the chicken scratch and nod, trying not to let the bulldog notice you have no idea what you are doing.
As you hear the guards approaching, you let out a sigh of relief and quietly slink out of the bakery while nobody is looking in order to save yourself any further embarrassment.
		</text>
		<text check="int:20" action="endEvent;lootItem:Doughnut-10">
You take the clipboard and begin counting. Bagels, croissants, muffins, cupcakes and eclairs. This bakery seems to specialize in diversity as it seems to hold an exquisite selection in incredible amounts. You almost cannot make sense of everything, but eventually you tally all the contents of the display. You notice something strange, but just as you are about to say something, the guards arrive.
Out of breath and sweating through their mail, the guards ask the old man for his story but seem to place far less attention on him than on the sweets in the display. "Don't worry, old man Jenkins! We’ll get to the bottom of this! How else would we get through the day without one of our daily donuts? About them... could we have a few more for the guys at the quarters?"
"Of course, lad," said old Jenkins heartely. "Always glad to help the law around these parts. Just make sure they reach the quarters this time. And this," he hands you a few bags as well, "is for being such a nice lad. We need more kids like you these days."
He waves you and the guards goodbye, and you make your way back into the crowded streets. As you walk along, you go back to pondering on what you found out. There we no items missing from the inventory; there was extra.
		</text>
	</dialog>
	<dialog id="6" end="true">
		<text>
You continue along your way as if nothing is happening. Sometimes it’s best not to meddle in others’ problems, lest they become your own.
		</text>
	</dialog>
</event>
		//}
	}
}