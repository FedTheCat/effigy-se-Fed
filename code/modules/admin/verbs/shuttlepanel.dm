/datum/admins/proc/open_shuttlepanel()
	set category = "Admin.Events"
	set name = "Shuttle Manipulator"
	set desc = "Opens the shuttle manipulator UI."

	if(!check_rights(R_ADMIN))
		return

	SSshuttle.ui_interact(usr)


/obj/docking_port/mobile/proc/admin_fly_shuttle(mob/user)
	var/list/options = list()
	options += ">>> VALID DOCKS:" // EffigyEdit Add
	for(var/port in SSshuttle.stationary_docking_ports)
		if (istype(port, /obj/docking_port/stationary/transit))
			continue  // please don't do this
		var/obj/docking_port/stationary/S = port
		if (canDock(S) == SHUTTLE_CAN_DOCK)
			options[S.name || S.shuttle_id] = S
	// EffigyEdit Add -
	options += ">>> INVALID DOCKS:" //I WILL CRASH THIS SHIP WITH NO SURVIVORS!
	for(var/port in SSshuttle.stationary_docking_ports)
		if (istype(port, /obj/docking_port/stationary/transit))
			continue  // please don't do this
		var/obj/docking_port/stationary/S = port
		if(!(canDock(S) == SHUTTLE_CAN_DOCK))
			options[S.name || S.shuttle_id] = S
	// EffigyEdit Add End

	options += "--------"
	options += "Infinite Transit"
	options += "Delete Shuttle"
	options += "Into The Sunset (delete & greentext 'escape')"

	var/selection = tgui_input_list(user, "Select where to fly [name || shuttle_id]:", "Fly Shuttle", options)
	if(isnull(selection))
		return

	switch(selection)
		if("Infinite Transit")
			destination = null
			mode = SHUTTLE_IGNITING
			setTimer(ignitionTime)

		if("Delete Shuttle")
			if(tgui_alert(user, "Really delete [name || shuttle_id]?", "Delete Shuttle", list("Cancel", "Really!")) != "Really!")
				return
			jumpToNullSpace()

		if("Into The Sunset (delete & greentext 'escape')")
			if(tgui_alert(user, "Really delete [name || shuttle_id] and greentext escape objectives?", "Delete Shuttle", list("Cancel", "Really!")) != "Really!")
				return
			intoTheSunset()

		else
			if(options[selection])
				request(options[selection], TRUE) // EffigyEdit Change
				message_admins("[user.ckey] has admin FORCED [name || shuttle_id] to dock at [options[selection]], this is ignoring all safety measures.") // EffigyEdit Add

/obj/docking_port/mobile/emergency/admin_fly_shuttle(mob/user)
	return  // use the existing verbs for this

/obj/docking_port/mobile/arrivals/admin_fly_shuttle(mob/user)
	switch(tgui_alert(user, "Would you like to fly the arrivals shuttle once or change its destination?", "Fly Shuttle", list("Fly", "Retarget", "Cancel")))
		if("Cancel")
			return
		if("Fly")
			return ..()

	var/list/options = list()

	for(var/port in SSshuttle.stationary_docking_ports)
		if (istype(port, /obj/docking_port/stationary/transit))
			continue  // please don't do this
		var/obj/docking_port/stationary/S = port
		if (canDock(S) == SHUTTLE_CAN_DOCK)
			options[S.name || S.shuttle_id] = S

	var/selection = tgui_input_list(user, "New arrivals destination", "Fly Shuttle", options)
	if(isnull(selection))
		return
	target_dock = options[selection]
	if(!QDELETED(target_dock))
		destination = target_dock

