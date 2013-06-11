
/client/verb/who()
	set name = "Who"
	set category = "OOC"

	var/msg = "<b>Current Players:</b>\n"

	var/list/Lines = list()

	if(holder)
		for(var/client/C in clients)
			var/entry = "\t[C.key]"
			if(C.holder && C.holder.fakekey)
				entry += " <i>(as [C.holder.fakekey])</i>"
			entry += " - Playing as [C.mob.real_name]"
			switch(C.mob.stat)
				if(UNCONSCIOUS)
					entry += " - <font color='darkgray'><b>Unconscious</b></font>"
				if(DEAD)
					if(isobserver(C.mob))
						var/mob/dead/observer/O = C.mob
						if(O.started_as_observer)
							entry += " - <font color='gray'>Observing</font>"
						else
							entry += " - <font color='black'><b>DEAD</b></font>"
					else
						entry += " - <font color='black'><b>DEAD</b></font>"
			if(is_special_character(C.mob))
				entry += " - <b><font color='red'>Antagonist</font></b>"
			entry += " (<A HREF='?_src_=holder;adminmoreinfo=\ref[C.mob]'>?</A>)"
			Lines += entry
	else
		for(var/client/C in clients)
			if(C.holder && C.holder.fakekey)
				Lines += C.holder.fakekey
			else
				Lines += C.key

	for(var/line in sortList(Lines))
		msg += "[line]\n"

	msg += "<b>Total Players: [length(Lines)]</b>"
	src << msg

/client/verb/adminwho() //I think this works much better --Numbers
	set category = "Admin"
	set name = "Adminwho"

//	var/msg = "<b>Current Admins:</b>\n"
	var/num_admins_online = 0
	var/num_mods_online = 0
	var/num_misc_online = 0

	var/misc = "<b>Current Miscellaneous Ranks Online:</b>\n"
	var/mod = "<b>Current Moderators Online:</b>\n"
	var/admin = "<b>Current Admins Online:</b>\n"

	var/admin_ranks = list("GameAdmin","GameMaster","Badmin","TrialAdmin","TempAdmin","Host")
	var/mod_ranks = list("Moderator")

	for(var/client/C in admins)
		if(C.holder.rank in mod_ranks)
			mod += "\t[C] is a [C.holder.rank]"

			if( (C.holder.fakekey) && (holder) )
				mod += " <i>(as [C.holder.fakekey])</i>"

			if( (isobserver(C.mob)) && (holder) )
				mod += " - Observing"
			else if( (istype(C.mob,/mob/new_player)) && (holder))
				mod += " - Lobby"
			else if(holder)
				mod += " - Playing"

			if( (C.is_afk()) && (holder))
				mod += " (AFK)"
			mod += "\n"
			num_mods_online++
		else if(C.holder.rank in admin_ranks)
			admin += "\t[C] is a [C.holder.rank]"

			if( (C.holder.fakekey) && (holder) )
				admin += " <i>(as [C.holder.fakekey])</i>"

			if( (isobserver(C.mob)) && (holder) )
				admin += " - Observing"
			else if( (istype(C.mob,/mob/new_player)) && (holder) )
				admin += " - Lobby"
			else if(holder)
				admin += " - Playing"

			if( (C.is_afk()) && (holder) )
				admin += " (AFK)"
			admin += "\n"
			num_admins_online++
		else
			misc += "\t[C] is a [C.holder.rank]"

			if( (C.holder.fakekey) && (holder) )
				misc += " <i>(as [C.holder.fakekey])</i>"

			if( (isobserver(C.mob)) && (holder) )
				misc += " - Observing"
			else if( (istype(C.mob,/mob/new_player)) && (holder) )
				misc += " - Lobby"
			else if(holder)
				misc += " - Playing"

			if( (C.is_afk()) && (holder) )
				misc += " (AFK)"
			misc += "\n"
			num_misc_online++

	admin += "<b>There are [num_admins_online] administrators online.</b>\n"
	mod += "\n<b>There are [num_mods_online] moderators online.</b>\n"
	misc += "\n<b>There are [num_misc_online] miscellaneous ranks online.</b>\n"

	src << admin + "<BR>" + mod + "<BR>" + misc + "<BR>"

/* This is stupid
/client/verb/modwho()
	set category = "Admin"
	set name = "Modwho"

	var/msg = "<b>Current Moderators:</b>\n"
	var/num_mods_online = 0
	if(holder)
		for(var/client/C in admins)
			if(C.holder.rank == "Moderator")
				msg += "\t[C] is a [C.holder.rank]"

				if(isobserver(C.mob))
					msg += " - Observing"
				else if(istype(C.mob,/mob/new_player))
					msg += " - Lobby"
				else
					msg += " - Playing"

				if(C.is_afk())
					msg += " (AFK)"
				msg += "\n"
				num_mods_online++
	else
		for(var/client/C in admins)
			if(C.holder.rank == "Moderator")
				msg += "\t[C] is a [C.holder.rank]\n"
				num_mods_online++

	msg += "<b>There are [num_mods_online] moderators online</b>\n"
	src << msg
*/