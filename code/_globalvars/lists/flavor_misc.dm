//Preferences stuff
GLOBAL_LIST_INIT(ethnicities_list, init_ethnicities())

/// Ethnicity - Initialise all /datum/ethnicity into a list indexed by ethnicity name
/proc/init_ethnicities()
	. = list()
	for(var/path in subtypesof(/datum/ethnicity))
		var/datum/ethnicity/E = new path()
		.[E.name] = E

	//Hairstyles
GLOBAL_LIST_EMPTY(hair_styles_list)			//stores /datum/sprite_accessory/hair indexed by name
GLOBAL_LIST_EMPTY(hair_gradients_list)			//stores /datum/sprite_accessory/hair_gradient indexed by name
GLOBAL_LIST_EMPTY(facial_hair_styles_list)	//stores /datum/sprite_accessory/facial_hair indexed by name
	//Underwear
GLOBAL_LIST_EMPTY(underwear_list)		//stores /datum/sprite_accessory/underwear indexed by name
GLOBAL_LIST_INIT(underwear_m, list("Briefs"))
GLOBAL_LIST_INIT(underwear_f, list("Sports bra and briefs", "Bra and brief", "Bra and panties"))
	//Undershirts
GLOBAL_LIST_INIT(undershirt_m, list("None","Black undershirt", "White undershirt", "Beige undershirt", "Fitness shirt", "Beige undershirt(sleeveless)"))
GLOBAL_LIST_INIT(undershirt_f, list("None","Black undershirt", "White undershirt", "Beige undershirt", "Beige undershirt(sleeveless)"))
	//Mutant Human bits
GLOBAL_LIST_EMPTY(moth_wings_list)
GLOBAL_LIST_EMPTY(tails_list_monkey)


GLOBAL_LIST_INIT(ghost_forms_with_directions_list, list("ghost")) //stores the ghost forms that support directional sprites
GLOBAL_LIST_INIT(ghost_forms_with_accessories_list, list("ghost")) //stores the ghost forms that support hair and other such things

GLOBAL_LIST_INIT(ai_core_display_screens, list(
	":thinking:",
	"Alien",
	"Angel",
	"Banned",
	"Bliss",
	"Blue",
	"Clown",
	"Database",
	"Dorf",
	"Firewall",
	"Fuzzy",
	"Gentoo",
	"Glitchman",
	"Gondola",
	"Goon",
	"Hades",
	"Heartline",
	"Helios",
	"House",
	"Inverted",
	"Matrix",
	"Monochrome",
	"Murica",
	"Nanotrasen",
	"Not Malf",
	"President",
	"Random",
	"Rainbow",
	"Red",
	"Red October",
	"Static",
	"Syndicat Meow",
	"Text",
	"Too Deep",
	"Triumvirate",
	"Triumvirate-M",
	"Weird",
	"shodan",
	"shodan_chill",
	"shodan_data",
	"shodan_pulse"))

/proc/resolve_ai_icon(input)
	if(!input || !(input in GLOB.ai_core_display_screens))
		return "ai"
	else
		if(input == "Random")
			input = pick(GLOB.ai_core_display_screens - "Random")
		return "ai-[lowertext(input)]"

	//Backpacks
GLOBAL_LIST_INIT(backpacklist, list("Nothing", "Backpack", "Satchel"))


GLOBAL_LIST_INIT(genders, list(MALE, FEMALE, NEUTER))

GLOBAL_LIST_INIT(playable_icons, list(
	"boiler",
	"bull",
	"captain",
	"carrier",
	"chief_medical",
	"cl",
	"crusher",
	"cse",
	"defender",
	"defiler",
	"drone",
	"fieldcommander",
	"gorger",
	"hivelord",
	"hivemind",
	"hunter",
	"larva",
	"mech_pilot",
	"medical",
	"pilot",
	"praetorian",
	"private",
	"puppeteer",
	"ravager",
	"requisition",
	"researcher",
	"runner",
	"sentinel",
	"spiderling",
	"spitter",
	"st",
	"staffofficer",
	"synth",
	"warlock",
	"warrior",
	"widow",
	"wraith",
	"xenoking",
	"xenominion",
	"xenoqueen",
	"xenoshrike",
))

//like above but autogenerated when a new squad is created
GLOBAL_LIST_INIT(playable_squad_icons, list(
	"private",
	"leader",
	"engi",
	"medic",
	"smartgunner",
))

GLOBAL_LIST_INIT(minimap_icons, init_minimap_icons())

/proc/init_minimap_icons()
	. = list()
	for(var/icon_state in GLOB.playable_icons)
		.[icon_state] = icon2base64(icon('icons/UI_icons/map_blips.dmi', icon_state, frame = 1))
