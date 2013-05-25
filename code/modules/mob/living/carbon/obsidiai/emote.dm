/mob/living/carbon/rock/obsidiai/emote(var/act)
	//var/param  //Wha...?
	if (findtext(act, "-", 1, null))
		var/t1 = findtext(act, "-", 1, null)
//		param = copytext(act, t1 + 1, length(act) + 1) //Wha...?
		act = copytext(act, 1, t1)

	if(findtext(act,"s",-1) && !findtext(act,"_",-2))//Removes ending s's unless they are prefixed with a '_'
		act = copytext(act,1,length(act))

	var/m_type = 1
	var/message

	switch(act)
		if("scratch")
			message = "<B>[src.name]</B> rubs its rock-hands against itself.  It looks like its trying to scratch itself."
			m_type = 1
		if("whimper")
			message = "<B>[src.name]</B> whimpers."
			m_type = 2
		if("roar")
			message = "<B>[src.name]</B> roars."
			for(var/mob/O in viewers(world.view, src))
				O << "<B><FONT COLOR=RED>You tremble in your place...</FONT></B>"
			m_type = 2
		if("shiver")
			message = "<B>[src.name]</B> shakes violently."
			m_type = 2
		if("hand")
			message = "<B>[src.name]</B> flails \\his rock-hands."
			m_type = 1
		if("choke")
			message = "<B>[src.name]</B> chokes."
			m_type = 2
		if("moan")
			message = "<B>[src.name]</B> moans!"
			m_type = 2
		if("nod")
			message = "<B>[src.name]</B> nods \his head."
			m_type = 1
		if("sit")
			message = "<B>[src.name]</B> sits down."
			m_type = 1
		if("sway")
			message = "<B>[src.name]</B> sways around dizzily."
			m_type = 1
		if("sulk")
			message = "<B>[src.name]</B> sulks down sadly."
			m_type = 1
		if("twitch")
			message = "<B>[src.name]</B> twitches violently."
			m_type = 1
		if("dance")
			message = "<B>[src.name]</B> dances around happily."
			m_type = 1
		if("roll")
			message = "<B>[src.name]</B> rolls."
			m_type = 1
		if("shake")
			message = "<B>[src.name]</B> shakes \his head."
			m_type = 1
		if("gnarl")
			message = "<B>[src.name]</B> gnarls and shows \his obsidian teeth..."
			m_type = 2
		if("jump")
			message = "<B>[src.name]</B> jumps!"
			m_type = 1
		if("collapse")
			Paralyse(2)
			message = text("<B>[]</B> collapses!", src)
			m_type = 2
		if("help")
			src << "choke, collapse, dance, drool, gasp, shiver, gnarl, jump, paw, moan, nod, roar, roll, scratch, shake, sign-#, sit, sulk, sway, twitch, whimper"
		else
			if(src.client)
				log_emote("[name]/[key] : [message]")
			if (m_type & 1)
				for(var/mob/O in viewers(src, null))
					O.show_message(message, m_type)
					//Foreach goto(703)
			else
				for(var/mob/O in hearers(src, null))
					O.show_message(message, m_type)
					//Foreach goto(746)
			return
	if ((message && src.stat == 0))
		if(src.client)
			log_emote("[name]/[key] : [message]")
		if (m_type & 1)
			for(var/mob/O in viewers(src, null))
				O.show_message(message, m_type)
				//Foreach goto(703)
		else
			for(var/mob/O in hearers(src, null))
				O.show_message(message, m_type)
				//Foreach goto(746)
	return