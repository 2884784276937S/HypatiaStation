/obj/machinery/vidcom
	name = null
	icon = 'icons/obj/device.dm'
	var/link_id

/obj/machinery/vidcom/intercom
	name = "\improper Video Intercom" //Not a proper noun
	icon_state = "vidcom"
	desc = "It's a video-enable intercom, with lots of buttons... fancy."
	link_id = 1

/obj/machinery/vidcom/buzzer
	name = "\improper Buzzer" //not a proper noun
	icon_state = "int_buzzer"
	desc = "It just begs you to push it..."
	link_id = 1

/obj/machinery/vidcom/intercom/conflict_resolve()
	var/new_id = 1
	for(var/obj/machinery/vidcom/A in world)
		if(A == src) continue
		new_id += 1
	link_id = new_id
	return

/obj/machinery/vidcom/conflict_check()
	var/conflict = 0 //because I'm not sure of ..() syntax
	for(var/obj/machinery/vidcom/V in world)
		if(src.type != V.type)
			continue
		if(src.link_id == V.link_id)
			conflict = 1
	if(conflict)
		return 1
	else
		return 0

/obj/machinery/vidcom/intercom/New()
	if(!link_id)
		link_id = 1
	if( conflict_check() )
		conflict_resolve()
	//Some more stuff might be needed
	return

/obj/machinery/vidcom/buzzer/New()
	if(!link_id)
		link_id = 1
	return



















































