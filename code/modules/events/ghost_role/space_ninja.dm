/datum/round_event_control/space_ninja
	name = "Spawn Space Ninja"
	typepath = /datum/round_event/ghost_role/space_ninja
	max_occurrences = 1
	weight = 10
	earliest_start = 20 MINUTES
	min_players = 20
	dynamic_should_hijack = TRUE
	category = EVENT_CATEGORY_INVASION
	description = "A space ninja infiltrates the station."

/datum/round_event/ghost_role/space_ninja
	minimum_required = 1
	role_name = "Space Ninja"

/datum/round_event/ghost_role/space_ninja/spawn_role()
	var/spawn_location = find_space_spawn()
	if(isnull(spawn_location))
		return MAP_ERROR

	//selecting a candidate player
	var/list/candidates = get_candidates(ROLE_NINJA, ROLE_NINJA)
	if(!candidates.len)
		return NOT_ENOUGH_PLAYERS

	var/mob/dead/selected_candidate = pick(candidates)
	var/key = selected_candidate.key

	//spawn the ninja and assign the candidate
	var/mob/living/carbon/human/ninja = create_space_ninja(spawn_location)
	ninja.key = key
	ninja.mind.add_antag_datum(/datum/antagonist/ninja)
	spawned_mobs += ninja

	// EffigyEdit Add -  (Character slot)
	var/loadme = tgui_input_list(ninja, "Do you wish to load your character slot?", "Load Character?", list("Yes!", "No, I want to be random!"), default = "No, I want to be random!", timeout = 60 SECONDS)
	var/codename
	if(loadme == "Yes!")
		ninja.client?.prefs?.safe_transfer_prefs_to(ninja)
		codename = tgui_input_text(ninja.client, "What should your codename be?", "Agent Name", "[pick("Master", "Legendary", "Agent", "Shinobi", "Ninja")] [ninja.dna.species.name]", 42, FALSE, TRUE, 300 SECONDS)
		codename ? codename : (codename = "[pick("Master", "Legendary", "Agent", "Shinobi", "Ninja")] [ninja.dna.species.name]")
		ninja.name = codename
		ninja.real_name = codename
		ninja.dna.update_dna_identity()
	else
		ninja.randomize_human_appearance(~(RANDOMIZE_NAME|RANDOMIZE_SPECIES))
		ninja.dna.update_dna_identity()
	// EffigyEdit Add End (Character slot)

	message_admins("[ADMIN_LOOKUPFLW(ninja)] has been made into a space ninja by an event.")
	ninja.log_message("was spawned as a ninja by an event.", LOG_GAME)

	return SUCCESSFUL_SPAWN


//=======//NINJA CREATION PROCS//=======//

/proc/create_space_ninja(spawn_loc)
	var/mob/living/carbon/human/new_ninja = new(spawn_loc)
	// new_ninja.randomize_human_appearance(~(RANDOMIZE_NAME|RANDOMIZE_SPECIES)) // EffigyEdit Remove (Character slot)
	var/new_name = "[pick(GLOB.ninja_titles)] [pick(GLOB.ninja_names)]"
	new_ninja.name = new_name
	new_ninja.real_name = new_name
	// new_ninja.dna.update_dna_identity() // EffigyEdit Remove (Character slot)
	return new_ninja
