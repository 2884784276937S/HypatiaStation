/client/proc/cinematic(var/cinematic as anything in list("Nuke",null))
	set name = "Show Global Cinematic"
	set category = "Event"
	set desc = "Shows a cinematic."	// Intended for testing but I thought it might be nice for events on the rare occasion Feel free to comment it out if it's not wanted.
	set hidden = 0
	if(!ticker)	return
	message_admins("<FONT COLOR=RED>WARNING:</FONT> [src.ckey]/([src.mob.name]) is about to show a cinematic.")
	switch(cinematic)
		if("Nuke")
			var/parameter = input(src,"station_missed = ?","Enter Parameter",0) as num
			var/override
			switch(parameter)
				if(1)
					override = input(src,"mode = ?","Enter Parameter",null) as anything in list("nuclear emergency","no override")
				if(0)
					override = input(src,"mode = ?","Enter Parameter",null) as anything in list("blob","nuclear emergency","AI malfunction","no override")
			ticker.station_explosion_cinematic(parameter,override)
	return