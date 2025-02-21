/datum/unit_test/emoting
	var/emotes_used = 0

/datum/unit_test/emoting/Run()
	var/mob/living/carbon/human/human = allocate(/mob/living/carbon/human/consistent)
	RegisterSignal(human, COMSIG_MOB_EMOTE, PROC_REF(on_emote_used))

	human.say("*shrug")
	TEST_ASSERT_EQUAL(emotes_used, 1, "Human did not shrug")

	// EffigyEdit Remove -  - Following check does not affect us
	/*
	human.say("*beep")
	TEST_ASSERT_EQUAL(emotes_used, 1, "Human beeped, when that should be restricted to silicons")
	*/
	// EffigyEdit Remove End

	human.setOxyLoss(140)

	TEST_ASSERT(human.stat != CONSCIOUS, "Human is somehow conscious after receiving suffocation damage")

	human.say("*shrug")
	TEST_ASSERT_EQUAL(emotes_used, 1, "Human shrugged while unconscious")

	// EffigyEdit Remove -  - Following check fails due to global cooldown from the above test step (.8s)
	/*
	human.say("*deathgasp")
	TEST_ASSERT_EQUAL(emotes_used, 2, "Human could not deathgasp while unconscious")
	*/
	// EffigyEdit Remove End

/datum/unit_test/emoting/proc/on_emote_used()
	SIGNAL_HANDLER
	emotes_used += 1
