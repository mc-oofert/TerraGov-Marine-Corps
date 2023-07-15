// THIS SHOULD NEVER BE IN PLAYER CONTROL (like actually having a client)
/mob/living/carbon/xenomorph/puppet
	caste_base_type = /mob/living/carbon/xenomorph/puppet
	name = "Puppet"
	desc = "A reanimated body, crudely pieced together and held in place by an ominous energy tethered to some unknown force."
	icon = 'icons/Xeno/1x1_Xenos.dmi'
	icon_state = "Puppet Running"
	health = 150
	maxHealth = 150
	plasma_stored = 0
	pixel_x = 0
	old_x = 0
	tier = XENO_TIER_MINION
	upgrade = XENO_UPGRADE_BASETYPE
	pull_speed = -1
	allow_pass_flags = PASS_XENO
	///pheromone list we arent allowed to receive
	var/list/illegal_pheromones = list(AURA_XENO_RECOVERY, AURA_XENO_WARDING, AURA_XENO_FRENZY)
	///our masters weakref
	var/datum/weakref/weak_master

/mob/living/carbon/xenomorph/puppet/handle_special_state() //prevent us from using different run/walk sprites
	icon_state = "[xeno_caste.caste_name] Running"
	return TRUE

/mob/living/carbon/xenomorph/puppet/Initialize(mapload, mob/living/carbon/xenomorph/puppeteer)
	. = ..()
	weak_master = WEAKREF(puppeteer)
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/puppet, puppeteer)

/mob/living/carbon/xenomorph/puppet/Life()
	. = ..()
	var/atom/movable/master = weak_master?.resolve()
	if(!master)
		return
	if(get_dist(src, master) > PUPPET_WITHER_RANGE)
		adjustBruteLoss(15)
	else
		adjustBruteLoss(-5)

/mob/living/carbon/xenomorph/puppet/can_receive_aura(aura_type, atom/source, datum/aura_bearer/bearer)
	. = ..()
	var/atom/movable/master = weak_master?.resolve()
	if(!master)
		return
	if(source != master) //puppeteer phero only
		return FALSE

/mob/living/carbon/xenomorph/puppet/finish_aura_cycle()
	var/fury = received_auras[AURA_XENO_FURY] || 0
	if(fury)
		xeno_melee_damage_modifier = 1 + ((fury - 1) * 0.05)
	return ..()
