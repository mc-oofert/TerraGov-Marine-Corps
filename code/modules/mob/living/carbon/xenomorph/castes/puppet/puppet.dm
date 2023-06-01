#define WITHER_RANGE 15

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
	flags_pass = PASSXENO
	///pheromone list we arent allowed to receive
	var/list/illegal_pheromones = list(AURA_XENO_RECOVERY, AURA_XENO_WARDING, AURA_XENO_FRENZY)
	///our master
	var/mob/living/carbon/xenomorph/master

/mob/living/carbon/xenomorph/puppet/handle_special_state() //prevent us from using different run/walk sprites
	icon_state = "[xeno_caste.caste_name] Running"
	return TRUE

/mob/living/carbon/xenomorph/puppet/Initialize(mapload, mob/living/carbon/xenomorph/puppeteer)
	. = ..()
	master = puppeteer
	AddComponent(/datum/component/ai_controller, /datum/ai_behavior/puppet, puppeteer)

/mob/living/carbon/xenomorph/puppet/Life()
	. = ..()
	if(get_dist(src, master) > WITHER_RANGE)
		adjustBruteLoss(15)
	else
		adjustBruteLoss(-5)

/mob/living/carbon/xenomorph/puppet/receive_aura(aura_type, strength)
	if(aura_type in illegal_pheromones)
		return
	var/static/list/puppet_phero_to_normal_phero = list(
	AURA_XENO_PUPPETFURY = AURA_XENO_PUPPETFURY,
	AURA_XENO_PUPPETWARDING = AURA_XENO_WARDING,
	AURA_XENO_PUPPETFRENZY = AURA_XENO_FRENZY,
	)
	aura_type = puppet_phero_to_normal_phero[aura_type]
	return ..()

/mob/living/carbon/xenomorph/puppet/finish_aura_cycle()
	var/fury = received_auras[AURA_XENO_PUPPETFURY] || 0
	if(fury)
		xeno_melee_damage_modifier = 1 + ((fury - 1) * 0.05)

	..()

//widow code again hooray
/datum/ai_behavior/puppet
	target_distance = 7
	base_action = IDLE
	identifier = IDENTIFIER_XENO
	///should we go back to escorting the puppeteer if we stray too far
	var/too_far_escort = TRUE
	var/datum/weakref/master_ref


/datum/ai_behavior/puppet/New(loc, parent_to_assign, escorted_atom)
	. = ..()
	master_ref = WEAKREF(escorted_atom)
	RegisterSignal(escorted_atom, COMSIG_MOB_DEATH, PROC_REF(fucking_die))
	RegisterSignal(escorted_atom, COMSIG_PUPPET_CHANGE_ALL_ORDER, PROC_REF(change_order))
	RegisterSignal(mob_parent, COMSIG_PUPPET_CHANGE_ORDER, PROC_REF(change_order))
	change_order(null, PUPPET_RECALL)

/datum/ai_behavior/puppet/proc/fucking_die(mob/living/source)
	SIGNAL_HANDLER
	if(!QDELETED(mob_parent))
		mob_parent.death() //die

///Signal handler to try to attack our target (widow code my beloved (fuck tgmc AI))
/datum/ai_behavior/puppet/proc/attack_target(datum/source)
	SIGNAL_HANDLER
	if(world.time < mob_parent.next_move)
		return
	if(Adjacent(atom_to_walk_to))
		return
	if(isliving(atom_to_walk_to))
		var/mob/living/victim = atom_to_walk_to
		if(victim.stat == DEAD)
			late_initialize()
			return
	mob_parent.face_atom(atom_to_walk_to)
	mob_parent.UnarmedAttack(atom_to_walk_to, mob_parent)

//xeno code go
/datum/ai_behavior/puppet/look_for_new_state()
	switch(current_action)
		if(MOVING_TO_NODE, FOLLOWING_PATH)
			if(get_dist(mob_parent, escorted_atom) > WITHER_RANGE && too_far_escort)
				change_order(null, PUPPET_RECALL)
				return
			if(!change_order(null, PUPPET_SEEK_CLOSEST))
				change_action(MOVING_TO_NODE)
				return
		if(IDLE)
			if(!change_order(null, PUPPET_SEEK_CLOSEST))
				return
		if(ESCORTING_ATOM)
			if(!escorted_atom && master_ref)
				escorted_atom = master_ref.resolve()
		if(MOVING_TO_ATOM)
			if(!atom_to_walk_to) //edge case
				late_initialize()
	return ..()

/datum/ai_behavior/puppet/register_action_signals(action_type)
	if(action_type == MOVING_TO_ATOM)
		RegisterSignal(mob_parent, COMSIG_STATE_MAINTAINED_DISTANCE, PROC_REF(attack_target))
		if(!isobj(atom_to_walk_to))
			RegisterSignal(atom_to_walk_to, list(COMSIG_MOB_DEATH, COMSIG_PARENT_QDELETING), PROC_REF(look_for_new_state))
	return ..()

/datum/ai_behavior/puppet/unregister_action_signals(action_type)
	if(action_type == MOVING_TO_ATOM)
		UnregisterSignal(mob_parent, COMSIG_STATE_MAINTAINED_DISTANCE)
		if(!isnull(atom_to_walk_to))
			UnregisterSignal(atom_to_walk_to, list(COMSIG_MOB_DEATH, COMSIG_PARENT_QDELETING))
	return ..()

/datum/ai_behavior/puppet/proc/seek_and_attack_closest(mob/living/source)
	var/victim = get_nearest_target(mob_parent, target_distance, TARGET_HUMAN, mob_parent.faction)
	if(!victim)
		return FALSE
	change_action(MOVING_TO_ATOM, victim)
	return TRUE

/datum/ai_behavior/puppet/proc/seek_and_attack()
	var/list/mob/living/carbon/human/possible_victims = list()
	for(var/mob/living/carbon/human/victim in cheap_get_humans_near(mob_parent, 9))
		if(victim.stat == DEAD)
			continue
		possible_victims += victim
	if(!length(possible_victims))
		return FALSE

	change_action(MOVING_TO_ATOM, pick(possible_victims))
	return TRUE

/datum/ai_behavior/puppet/proc/change_order(mob/living/source, order, atom/target)
	SIGNAL_HANDLER
	if(!order)
		stack_trace("puppet AI was somehow passed a null order")
		return FALSE
	switch(order)
		if(PUPPET_SEEK_CLOSEST)
			return seek_and_attack_closest()
		if(PUPPET_RECALL)
			escorted_atom = master_ref?.resolve()
			base_action = ESCORTING_ATOM
			change_action(ESCORTING_ATOM, escorted_atom)
			too_far_escort = TRUE
			return TRUE
		if(PUPPET_ATTACK)
			too_far_escort = TRUE
			if(target)
				change_action(MOVING_TO_ATOM, target)
				return TRUE
			else
				return seek_and_attack()
		if(PUPPET_SCOUT)
			too_far_escort = FALSE
			base_action = MOVING_TO_NODE
			change_action(MOVING_TO_NODE)
			return TRUE

//stripped down xeno AI (basicmobs when?)
/datum/ai_behavior/puppet/deal_with_obstacle(datum/source, direction)
	var/turf/obstacle_turf = get_step(mob_parent, direction)
	if(obstacle_turf.flags_atom & AI_BLOCKED)
		return
	for(var/thing in obstacle_turf.contents)
		if(istype(thing, /obj/structure/window_frame))
			LAZYINCREMENT(mob_parent.do_actions, obstacle_turf)
			addtimer(CALLBACK(src, PROC_REF(climb_window_frame), obstacle_turf), 2 SECONDS)
			return COMSIG_OBSTACLE_DEALT_WITH
		if(isobj(thing)) //WE BASH EVERYTHING OORAH
			var/obj/obstacle = thing
			if(obstacle.resistance_flags & XENO_DAMAGEABLE)
				INVOKE_ASYNC(src, PROC_REF(attack_target), null, obstacle)
				return COMSIG_OBSTACLE_DEALT_WITH
	if(ISDIAGONALDIR(direction) && ((deal_with_obstacle(null, turn(direction, -45)) & COMSIG_OBSTACLE_DEALT_WITH) || (deal_with_obstacle(null, turn(direction, 45)) & COMSIG_OBSTACLE_DEALT_WITH)))
		return COMSIG_OBSTACLE_DEALT_WITH

/datum/ai_behavior/puppet/proc/climb_window_frame(turf/window_turf)
	mob_parent.loc = window_turf
	mob_parent.last_move_time = world.time
	LAZYDECREMENT(mob_parent.do_actions, window_turf)

#undef WITHER_RANGE
