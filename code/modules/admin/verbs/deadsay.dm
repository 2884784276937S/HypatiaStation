/client/proc/dsay(msg as text)
	set category = "Special Verbs"
	set name = "Dsay" //Gave this shit a shorter name so you only have to time out "dsay" rather than "dead say" to use it --NeoFite
	set hidden = 1
	if(!src.holder)
		src << "Only administrators may use this command."
		return
	if(!src.mob)
		return
	if(prefs.muted & MUTE_DEADCHAT)
		src << "\red You cannot send DSAY messages (muted)."
		return

	if (src.handle_spam_prevention(msg,MUTE_DEADCHAT))
		return

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	log_admin("[key_name(src)] : [msg]")

	if (!msg)
		return

	var/rendered
	var/d_rank
	if(length(src.holder.rank) <= 11)
		d_rank = uppertext(src.holder.rank)
	else
		if(!config.admin_legacy_system) //INDENT LEVEL 1
			switch(src.holder.rank) //INDENT LEVEL 2
				if(null) //INDENT LEVEL 3
					return
				if("Head Administrator")
					d_rank = "HEADADMIN"
				//Because screw double pipes
				if("HeadAdministrator")
					d_rank = "HEADADMIN"
				else
					d_rank = "ADMIN"
		else d_rank = "ADMIN" //INDENT LEVLEL 1 (SORRY, THIS HURT MY EYES)

	//if(config.admin_legacy_system)


	rendered = "<span class='game deadsay'><span class='prefix'>DEAD:</span> <span class='name'>[d_rank]([src.holder.fakekey ? pick("BADMIN", "hornigranny", "TLF", "scaredforshadows", "KSI", "Silnazi", "HerpEs", "BJ69", "SpoofedEdd", "Uhangay", "Wario90900", "Regarity", "MissPhareon", "LastFish", "unMportant", "Deurpyn", "Fatbeaver") : src.key])</span> says, <span class='message'>\"[msg]\"</span></span>"


	for (var/mob/M in player_list)
		if (istype(M, /mob/new_player))
			continue
		if (M.stat == DEAD || (M.client && M.client.holder && (M.client.prefs.toggles & CHAT_DEAD))) //admins can toggle deadchat on and off. This is a proc in admin.dm and is only give to Administrators and above
			M.show_message(rendered, 2)

	feedback_add_details("admin_verb","D") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!