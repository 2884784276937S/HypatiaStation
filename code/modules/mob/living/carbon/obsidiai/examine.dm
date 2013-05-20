/mob/living/carbon/rock/obsidiai/examine()
	set src in oview()

	if(!usr || !src)	return
	if( (usr.sdisabilities & BLIND || usr.blinded || usr.stat) && !istype(usr,/mob/dead/observer) )
		usr << "<span class='notice'>Something is there but you can't see it.</span>"
		return

	var/msg = "<span class='info'>*---------*\nThis is \icon[src] \a <EM>[src]</EM>!\n"

	if (src.wear_mask)
		msg += "It has \icon[src.wear_mask] \a [src.wear_mask] on its head.\n"
	if (src.l_hand)
		msg += "It has \icon[src.l_hand] \a [src.l_hand] in its left hand.\n"
	if (src.r_hand)
		msg += "It has \icon[src.r_hand] \a [src.r_hand] in its right hand.\n"
	if (src.back)
		msg += "It has \icon[src.back] \a [src.back] on its back.\n"
	if (src.stat == DEAD)
		msg += "<span class='deadsay'>It is motionless and unresponsive.  It's just rock...</span>\n"
	else
		msg += "<span class='warning'>"
		if (src.getBruteLoss())
			if (src.getBruteLoss() < 30)
				msg += "There are some minor dents on its rocks.\n"
			else
				msg += "<B>Pieces of its rocks are missing!</B>\n"
		if (src.stat == UNCONSCIOUS)
			msg += "It isn't responding to anything around it; it seems to be asleep.\n"
		msg += "</span>"


	msg += "*---------*</span>"

	usr << msg
	return