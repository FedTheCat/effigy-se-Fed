/world/proc/update_status()

	var/features
	var/new_status = "<a href=\"https://socialdistrict.effigy.se\"><b>Effigy Station</b> \[Whitelist] \[Discord]</a> &#8212; [GLOB.tagline]]<br/><b>\[18+] \[Anthro RP/light antag action on custom /tg/station code]</b><br/>"
	var/round_real_time = REALTIMEOFDAY - SSticker.round_start_real_time

	if(SSmapping.config)
		features += "\[[SSmapping.config.map_name] - [SSsecurity_level.get_current_level_as_text()] alert [SSticker.HasRoundStarted() ? "- [time2text(round_real_time, "hh:mm", 0)]" : ""]"

	if (features)
		new_status += features

	status = new_status
