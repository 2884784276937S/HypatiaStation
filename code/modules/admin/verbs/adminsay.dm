/client/proc/cmd_admin_colour_set(newColour as color)
	set name = "Change ASAY Colour"
	set category = "Fun"
	src.prefs.asaycolor = newColour

/client/proc/cmd_admin_say(msg as text)
	set category = "Special Verbs"
	set name = "Asay" //Gave this shit a shorter name so you only have to time out "asay" rather than "admin say" to use it --NeoFite
	set hidden = 1
//	if(!check_rights(R_ADMIN|R_DONOR))	return

	if(!holder)	return

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	if(!msg)	return

	log_admin("[key_name(src)] : [msg]")
	var/title
	var/color = src.prefs.asaycolor
	switch(src.holder.rank)
		if("TrialAdmin")
	//		color = " style='color: #386aff'"
			title = "TRIAL"
		if("TempAdmin")
	//		color = " class='adminmod'"
			title = "TEMP"
		if("Donor")
	//		color = " style='color: #0099CC"
			title = "DONOR"
		if("Moderator")
	//		color = " style='color: #735638'"
			title = "MOD"
		if("Badmin")
	//		color = " style='color: #38F2FF'"
			title = "BADMIN"
		if("GameMaster")
	//		color = " style='color: #B338FF'"
			title = "GMASTER"
		if("GameAdmin")
	//		color = " style='color: #B338FF'"
			title = "GADMIN"
		if("Host")
	//		color = " style='color: #AA0000'"
			title = "HOST"
		if("Moderator")
			title = "MOD"
		else
	//		color = " style='color: #386aff'"
	//		title = "ADMIN"
			title = uppertext(src.holder.rank)

	if(!asay_colours)
		title = "ADMIN"
		color = "#386aff"

	if(check_rights(R_ADMIN|R_DONOR,0))
		msg = "<span class='admin' style='color: [color]'><span class='prefix'>[title]:</span> <EM>[key_name(usr, 1)]</EM> (<a href='?_src_=holder;adminplayerobservejump=\ref[mob]'>JMP</A>): <span class='message'>[msg]</span></span>"
		for(var/client/C in admins)
			if(R_ADMIN||R_DONOR|R_MOD|R_DEBUG & C.holder.rights)
				C << msg

	feedback_add_details("admin_verb","M") //If you are copy-pasting this, ensure the 2nd parameter is unique to the new proc!

/client/proc/cmd_mod_say(msg as text)
	set category = "Special Verbs"
	set name = "Msay"
	set hidden = 1
//	return cmd_admin_say(msg)
	if(asay_colours)
	//	cmd_admin_say(msg)
		return cmd_admin_say(msg)

	if(!check_rights(R_ADMIN|R_MOD|R_DONOR))	return

	msg = copytext(sanitize(msg), 1, MAX_MESSAGE_LEN)
	log_admin("MOD: [key_name(src)] : [msg]")

	if (!msg)
		return
	var/color = "mod"
	if (check_rights(R_ADMIN|R_DONOR,0))
		color = "adminmod"
	for(var/client/C in admins)
		if((R_ADMIN|R_MOD|R_DONOR|R_DEBUG) & C.holder.rights)
			C << "<span class='[color]'><span class='prefix'>MOD:</span> <EM>[key_name(src,1)]</EM> (<A HREF='?src=\ref[C.holder];adminplayerobservejump=\ref[mob]'>JMP</A>): <span class='message'>[msg]</span></span>"
