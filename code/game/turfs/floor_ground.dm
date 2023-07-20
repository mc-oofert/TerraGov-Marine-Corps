/**********************Planet**************************/

/turf/open/floor/plating/ground //Basic groundmap turf parent
	name = "ground dirt"
	icon = 'icons/turf/ground_map.dmi'
	icon_state = "desert"

/turf/open/floor/plating/ground/broken_states()
	return icon_state

/turf/open/floor/plating/ground/burnt_states()
	return icon_state

/turf/open/floor/plating/ground/fire_act(exposed_temperature, exposed_volume)
	return

/turf/open/floor/plating/ground/dirt
	name = "dirt"
	icon_state = "desert"
	shoefootstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	mediumxenofootstep = FOOTSTEP_SAND
	minimap_color = MINIMAP_DIRT

/turf/open/floor/plating/ground/dirt/dug
	icon_state = "desert_dug"

/turf/open/floor/plating/ground/dirt/typezero
	icon_state = "desert0"

/turf/open/floor/plating/ground/dirt/typeone
	icon_state = "desert1"

/turf/open/floor/plating/ground/dirt/typetwo
	icon_state = "desert2"

/turf/open/floor/plating/ground/dirt/typethree
	icon_state = "desert3"

/turf/open/floor/plating/ground/dirt/Initialize(mapload)
	. = ..()
	if(rand(0,15) == 0)
		icon_state = "desert[pick("0","1","2","3")]"

/turf/open/floor/plating/ground/dirt/desert
	name = "desert"
	icon_state = "desert5"

/turf/open/floor/plating/ground/dirt/desert/Initialize(mapload)
	. = ..()
	icon_state = "desert[pick("5","6")]"

/turf/open/floor/plating/ground/dirtgrassborder
	name = "grass"
	icon_state = "grassdirt_edge"
	shoefootstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	mediumxenofootstep = FOOTSTEP_SAND
	smoothing_groups = list(SMOOTH_GROUP_JUNGLE_FLOOR)

/turf/open/floor/plating/ground/dirtgrassborder/corner
	icon_state = "grassdirt_corner"

/turf/open/floor/plating/ground/dirtgrassborder/corner2
	icon_state = "grassdirt_corner2"

/turf/open/floor/plating/ground/dirt2
	name = "dirt"
	icon_state = "dirt"

/turf/open/floor/plating/ground/dirtgrassborder2
	name = "grass"
	icon_state = "grassdirt2_edge"
	shoefootstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	mediumxenofootstep = FOOTSTEP_SAND
	smoothing_groups = list(SMOOTH_GROUP_JUNGLE_FLOOR)

/turf/open/floor/plating/ground/dirtgrassborder2/corner
	icon_state = "grassdirt2_corner"

/turf/open/floor/plating/ground/dirtgrassborder2/corner2
	icon_state = "grassdirt2_corner2"

/turf/open/floor/plating/ground/dirtgrassborder/autosmooth
	icon = 'icons/turf/floors/jungle-border.dmi'
	icon_state = "jungle-border-icon"
	base_icon_state = "jungle-border"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_JUNGLE_FLOOR)
	canSmoothWith = list(
		SMOOTH_GROUP_JUNGLE_FLOOR,
		SMOOTH_GROUP_ASTEROID_WARNING,
		SMOOTH_GROUP_SURVIVAL_TITANIUM_WALLS,
		SMOOTH_GROUP_MINERAL_STRUCTURES,
		SMOOTH_GROUP_WINDOW_FULLTILE,
		SMOOTH_GROUP_FLORA,
		SMOOTH_GROUP_WINDOW_FRAME,
	)

/turf/open/floor/plating/ground/dirtgrassborder/autosmooth/buildable

/turf/open/ground/grass
	name = "grass"
	icon_state = "grass1"
	shoefootstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	mediumxenofootstep = FOOTSTEP_GRASS
	smoothing_groups = list(SMOOTH_GROUP_JUNGLE_FLOOR)

/turf/open/ground/grass/weedable
	name = "soft grass"

/turf/open/ground/grasspatch
	name = "grass"
	icon = 'icons/turf/floors.dmi'
	icon_state = "grass1"
	shoefootstep = FOOTSTEP_GRASS
	barefootstep = FOOTSTEP_GRASS
	mediumxenofootstep = FOOTSTEP_GRASS

/turf/open/ground/grasspatch/grassyellow
	color = "#ffb682"

/turf/open/ground/grass/grass2
	icon_state = "grass2"

/turf/open/ground/grass/grass3
	icon_state = "grass3"

/turf/open/ground/grass/grassalt
	icon_state = "dgrass0"

/turf/open/ground/grass/grassalt/Initialize(mapload)
	. = ..()
	icon_state = "dgrass[pick("0","1","2","3","4")]"

/turf/open/ground/grass/grassalt/tall
	icon_state = "fullgrass0"

/turf/open/ground/grass/grassalt/tall/Initialize(mapload)
	. = ..()
	icon_state = "fullgrass[pick("0","1","2","3","4")]"

// Big Red

/turf/open/floor/plating/ground/mars
	icon = 'icons/turf/bigred.dmi'
	icon_state = "mars_sand"
	mediumxenofootstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	shoefootstep = FOOTSTEP_SAND
	minimap_color = MINIMAP_MARS_DIRT

/turf/open/floor/plating/ground/mars/random/cave
	name = "cave"
	icon_state = "mars_cave"

/turf/open/floor/plating/ground/mars/random/cave/darker
	color = "#948a7c"

/turf/open/floor/plating/ground/mars/random/cave/rock
	name = "cave"
	icon_state = "mars_cave_rock"

/turf/open/floor/plating/ground/mars/random/dirt
	name = "dirt"
	icon_state = "mars_dirt"
	smoothing_groups = list(SMOOTH_GROUP_RED_DIRT, SMOOTH_GROUP_OPEN_FLOOR)

/turf/open/floor/plating/ground/mars/random/sand
	name = "sand"
	icon_state = "mars_sand"

/turf/open/floor/plating/ground/mars/random/Initialize(mapload)
	. = ..()
	dir = pick(GLOB.alldirs)

/turf/open/floor/plating/ground/mars/dirttosand
	name = "sand"
	icon_state = "mars_dirt_to_sand"
	smoothing_groups = list(SMOOTH_GROUP_RED_DIRT, SMOOTH_GROUP_OPEN_FLOOR)

/turf/open/floor/plating/ground/mars/cavetodirt
	name = "cave"
	icon_state = "mars_cave_to_dirt"
	smoothing_groups = list(SMOOTH_GROUP_RED_DIRT)

/turf/open/floor/plating/ground/mars/dirttosand/autosmooth
	icon = 'icons/turf/floors/red-dirt.dmi'
	icon_state = "red-dirt-icon"
	base_icon_state = "red-dirt"
	smoothing_flags = SMOOTH_BITMASK
	smoothing_groups = list(SMOOTH_GROUP_RED_DIRT)
	canSmoothWith = list(
		SMOOTH_GROUP_RED_DIRT,
		SMOOTH_GROUP_ASTEROID_WARNING,
		SMOOTH_GROUP_SURVIVAL_TITANIUM_WALLS,
		SMOOTH_GROUP_MINERAL_STRUCTURES,
		SMOOTH_GROUP_WINDOW_FULLTILE,
		SMOOTH_GROUP_WINDOW_FRAME,
		SMOOTH_GROUP_ASPHALT,
	)

/turf/open/floor/plating/ground/mars/alt
	icon = 'icons/turf/floors.dmi'
	icon_state = "mars1"

/turf/open/floor/plating/ground/mars/alt/Initialize(mapload)
	. = ..()
	icon_state = "mars[pick("1","2","3","4","5")]"

//Ice Colony grounds

//Ice Floor
/turf/open/floor/plating/ground/ice
	name = "ice floor"
	icon = 'icons/turf/ice.dmi'
	icon_state = "ice_floor"
	shoefootstep = FOOTSTEP_ICE
	barefootstep = FOOTSTEP_ICE
	mediumxenofootstep = FOOTSTEP_ICE
	minimap_color = MINIMAP_ICE

//Randomize ice floor sprite
/turf/open/floor/plating/ground/ice/Initialize(mapload)
	. = ..()
	setDir(pick(NORTH,SOUTH,EAST,WEST,NORTHEAST,NORTHWEST,SOUTHEAST,SOUTHWEST))

// Colony tiles
/turf/open/floor/plating/ground/concrete
	name = "concrete"
	icon = 'icons/turf/concrete.dmi'
	icon_state = "concrete0"
	mediumxenofootstep = FOOTSTEP_CONCRETE
	barefootstep = FOOTSTEP_CONCRETE
	shoefootstep = FOOTSTEP_CONCRETE
	minimap_color = MINIMAP_AREA_COLONY

/turf/open/floor/plating/ground/concrete/lines
	icon_state = "concrete_lines"

/turf/open/floor/plating/ground/concrete/edge
	icon_state = "concrete_edge"

//Desert Map

/turf/open/floor/plating/ground/desertdam //Basic groundmap turf parent
	name = "desert"
	icon = 'icons/turf/desertdam_map.dmi'
	icon_state = "desert0"

/turf/open/floor/plating/ground/desertdam/grate //for spanning river
	name = "grate"
	icon = 'icons/turf/catwalks.dmi'
	icon_state = "catwalk-159"

/turf/open/floor/plating/ground/desertdam/grate/alternate
	icon_state = "catwalk-255"

//desert floor
/turf/open/floor/plating/ground/desertdam/desert
	name = "desert"
	icon_state = "desert0"
	mediumxenofootstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	shoefootstep = FOOTSTEP_SAND

/turf/open/floor/plating/ground/desertdam/desert/Initialize(mapload)
	. = ..()
	icon_state = "desert[pick("0","1","2","3","4","5","6","7")]"


//asphalt road
/turf/open/floor/plating/ground/desertdam/asphalt
	name = "asphalt"
	icon = 'icons/turf/asphalt.dmi'
	icon_state = "sunbleached_asphalt"
	shoefootstep = FOOTSTEP_CONCRETE
	barefootstep = FOOTSTEP_CONCRETE
	mediumxenofootstep = FOOTSTEP_CONCRETE
	smoothing_groups = list(SMOOTH_GROUP_ASPHALT)

/turf/open/floor/plating/ground/desertdam/asphalt/cement
	name = "concrete"
	icon_state = "cement5"

/turf/open/floor/plating/ground/desertdam/asphalt/cement_sunbleached
	name = "concrete"
	icon_state = "cement_sunbleached5"

/turf/open/floor/plating/ground/desertdam/asphalt/twoside
	name = "asphalt"
	icon_state = "cement_sunbleached_twoside"

/turf/open/floor/plating/ground/desertdam/asphalt/threeside
	name = "asphalt"
	icon_state = "cement_sunbleached_threeside"

/turf/open/floor/plating/ground/desertdam/asphalt/edge
	name = "asphalt"
	icon_state = "cement_sunbleached_edge"

/turf/open/floor/plating/ground/desertdam/asphalt/open
	name = "asphalt"
	icon_state = "cement_sunbleached_open"

/turf/open/floor/plating/ground/desertdam/asphalt/tile
	name = "asphalt"
	icon_state = "tile"

/turf/open/floor/plating/ground/desertdam/asphalt/edge/regular
	name = "asphalt"
	icon_state = "cement_edge"

/turf/open/floor/plating/ground/desertdam/asphalt/twoside/regular
	name = "asphalt"
	icon_state = "cement_twoside"

/turf/open/floor/plating/ground/desertdam/asphalt/threeside/regular
	name = "asphalt"
	icon_state = "cement_threeside"


//CAVE
/turf/open/floor/plating/ground/desertdam/cave
	name = "cave"
	icon_state = "outer_cave_floor"
	shoefootstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	mediumxenofootstep = FOOTSTEP_SAND

//desert floor to outer cave floor transition
/turf/open/floor/plating/ground/desertdam/cave/desert_into_outer_cave_floor
	icon_state = "outer_cave_transition"

//outer cave floor
/turf/open/floor/plating/ground/desertdam/cave/outer_cave_floor
	icon_state = "outer_cave_floor"

//outer to inner cave floor transition
/turf/open/floor/plating/ground/desertdam/cave/outer_cave_to_inner_cave
	icon_state = "outer_cave_to_inner"

/turf/open/floor/plating/ground/desertdam/cave/outer_cave_to_inner_cave/alt
	icon_state = "outer_cave_to_inner2"

//inner cave floor
/turf/open/floor/plating/ground/desertdam/cave/inner_cave_floor
	name = "cave"
	icon_state = "inner_cave_full0"

/turf/open/floor/plating/ground/desertdam/cave/inner_cave_floor/Initialize(mapload)
	. = ..()
	icon_state = "inner_cave_full[pick("0","1")]"

/turf/open/floor/plating/ground/desertdam/cave/inner_cave/corners
	name = "cave"
	icon_state = "inner_cavecorners"

/turf/open/floor/plating/ground/desertdam/cave/inner_cave/sides
	name = "cave"
	icon_state = "inner_cavesides"

/turf/open/floor/plating/ground/drought
	name = "desert"
	icon = 'icons/turf/desert.dmi'
	icon_state = "desert"
	mediumxenofootstep = FOOTSTEP_SAND
	barefootstep = FOOTSTEP_SAND
	shoefootstep = FOOTSTEP_SAND
	minimap_color = MINIMAP_DIRT
	var/icon_variants = 3

/turf/open/floor/plating/ground/drought/Initialize(mapload)
	. = ..()
	icon_state = "[initial(icon_state)]_[pick(1, icon_variants)]"

/turf/open/floor/plating/ground/drought/alt
	icon_state = "desert_alt"

/turf/open/floor/plating/ground/drought/cave
	name = "cave"
	icon = 'icons/turf/cave_drought.dmi'
	icon_state = "cave"
	mediumxenofootstep = FOOTSTEP_GRAVEL
	barefootstep = FOOTSTEP_GRAVEL
	shoefootstep = FOOTSTEP_GRAVEL
	icon_variants = 8

/turf/open/floor/plating/ground/drought/cave/deep
	icon = 'icons/turf/cave.dmi'
	icon_variants = 7
	mediumxenofootstep = FOOTSTEP_CONCRETE
	barefootstep = FOOTSTEP_CONCRETE
	shoefootstep = FOOTSTEP_CONCRETE
