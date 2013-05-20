/mob/living/carbon/rock/obsidiai
	name = "obsidiai"
	voice_name = "obsidiai"
	voice_message = "chimpers"
	say_message = "chimpers"
	icon = 'icons/mob/obsidiai.dmi'
	icon_state = "body_m"
	gender = NEUTER
	pass_flags = PASSTABLE
	update_icon = 0		///no need to call regenerate_icon

	var/obj/item/weapon/card/id/wear_id = null // Fix for station bounced radios -- Skie

/mob/living/carbon/rock/obsidiai/Stat()
	..()
	statpanel("Status")
	stat("<B><FONT SIZE=2 COLOR=RED>This mob is currently unfinished.  This currently exists for debug-purposes only.  Playing this mob is not advised.</FONT></B>")

	stat(null, "Intent: [a_intent]")
	if(ticker && ticker.mode && ticker.mode.name == "AI malfunction")
		if(ticker.mode:malf_mode_declared)
			stat(null, "Time left: [max(ticker.mode:AI_win_timeleft/(ticker.mode:apcs/3), 0)]")
	if(emergency_shuttle)
		if(emergency_shuttle.online && emergency_shuttle.location < 2)
			var/timeleft = emergency_shuttle.timeleft()
			if (timeleft)
				stat(null, "ETA-[(timeleft / 60) % 60]:[add_zero(num2text(timeleft % 60), 2)]")

	if (client.statpanel == "Status")
		/* if (internal)
			if (!internal.air_contents)
				del(internal)
			else
				stat("Internal Atmosphere Info", internal.name)
				stat("Tank Pressure", internal.air_contents.return_pressure())
				stat("Distribution Pressure", internal.distribute_pressure) */ //Obsidiai don't breathe, right?
		/* switch(mind)
			else */ //If we do have anything, like Obsidiai traitors, etc.
		stat("Plasma: [plasmaStat]"

/mob/living/carbon/rock/obsidiai/attack_slime(mob/living/carbon/slime/M as mob) //Obsidiai need their own attack_slime proc.
	if(M.Victim) return // can't attack while eating!

	for(var/mob/O in viewers(src, null))
		if ((O.client && !( O.blinded )))
			O.show_message(text("\red <B>The [M.name] attempts to glomp [], however this has no effect on rock!</B>", src), 1)

	return

/mob/living/carbon/rock/obsidiai/proc/get_assignment(var/if_no_id = "No id", var/if_no_job = "No job") //Yes,  I know this needs to be changed.
	var/obj/item/device/pda/pda = wear_id
	var/obj/item/weapon/card/id/id = wear_id
	if (istype(pda))
		if (pda.id && istype(pda.id, /obj/item/weapon/card/id))
			. = pda.id.assignment
		else
			. = pda.ownjob
	else if (istype(id))
		. = id.assignment
	else
		return if_no_id
	if (!.)
		. = if_no_job
	return
/mob/living/carbon/rock/obsidiai/restrained()
	var/ret = 0
	if (handcuffed)
		ret += 1
	if (istype(wear_suit, /obj/item/clothing/suit/straight_jacket))
		ret += 2
	if (ret >= 1)
		src << "\blue <B>An error has occured.  Please adminhelp the following error code: \n <FONT COLOR=RED>ERROR OB-RES-[ret]</FONT>"
	return 0

/mob/living/carbon/rock/obsidiai/IsAdvancedToolUser()
	return 1//Maybe change?

/mob/living/carbon/rock/obsidai/get_species()
	return "Obsidiai"

/mob/living/carbon/rock/obsidiai/proc/get_visible_gender()
	if(wear_suit && wear_suit.flags_inv & HIDEJUMPSUIT && ((head && head.flags_inv & HIDEMASK) || wear_mask))
		return NEUTER
	return gender