
/obj/machinery/computer/dropship_picker
	name = "dropship picker"
	desc = "A computer that lets you choose the model of the tadpole.."
	density = TRUE
	icon = 'icons/obj/machines/computer.dmi'
	icon_state = "computer_generic"
	circuit = null
	resistance_flags = RESIST_ALL
	interaction_flags = INTERACT_MACHINE_TGUI
	req_access = list(ACCESS_MARINE_DROPSHIP)
	var/dock_id = SHUTTLE_TADPOLE
	///if true lock console
	var/dropship_selected = FALSE
	var/datum/map_template/shuttle/current_template_ref

/obj/machinery/computer/dropship_picker/attack_hand(mob/user)
	if(dropship_selected)
		balloon_alert(user, "model has already been chosen!")
		return FALSE
	return ..()

/obj/machinery/computer/dropship_picker/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)

	if(!ui)
		ui = new(user, src, "DropshipPicker", name)
		ui.open()

/obj/machinery/computer/dropship_picker/ui_static_data(mob/user)
	var/data = list()
	var/list/shuttles = list()
	for (var/datum/map_template/shuttle/minidropship/shuttle_template in SSmapping.minidropship_templates)
		shuttles += list(list(
			"name" = shuttle_template.display_name,
			"description" = shuttle_template.description,
			"ref" = REF(shuttle_template),
		))
	data["shuttles"] = shuttles
	
	return data

/obj/machinery/computer/dropship_picker/ui_data(mob/user)
	. = list()
	.["dropship_selected"] = dropship_selected
	.["current_ref"] = current_template_ref
	var/datum/map_template/shuttle/minidropship/temp = locate(current_template_ref) in SSmapping.minidropship_templates
	.["current_image"] = temp ? temp.image_url : ""
	if(temp)
		.["desc"] = temp.description
		.["name"] = temp.display_name
	return .
	
/obj/machinery/computer/dropship_picker/ui_act(action, list/params)
	. = ..()
	if(.)
		return
	
	if(dropship_selected)
		return FALSE

	switch(action)
		if("pickship")
			current_template_ref = params["ref"]
		if("confirm")
			if(!current_template_ref)
				return FALSE
			var/datum/map_template/shuttle/template = locate(current_template_ref) in SSmapping.minidropship_templates
			var/obj/docking_port/mobile/shuttle = SSshuttle.action_load(template)
			SSshuttle.loading_shuttle = FALSE
			SSshuttle.moveShuttleQuickToDock(template.shuttle_id, dock_id)
			shuttle.setTimer(0)
			dropship_selected = TRUE
			to_chat(usr, span_notice("Shuttle selected, console locking."))
	return TRUE

