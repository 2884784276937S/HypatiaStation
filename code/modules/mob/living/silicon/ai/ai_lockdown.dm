var/list/locked_down_areas = list()

var/list/lockdownlocs = list()

/mob/living/silicon/ai/proc/get_locs()
	lockdownlocs = list()
	for(var/area/AR in return_sorted_areas())
		if(lockdownlocs.Find(AR.name)) continue
		if(locked_down_areas.Find(AR)) continue
		if(locked_down_areas.Find(AR.name)) continue
		var/turf/picked = pick(get_area_turfs(AR.type))
		if (picked.z == 1)
			lockdownlocs += AR.name
			lockdownlocs[AR.name] = AR //The hell is this..?

/mob/living/silicon/ai/proc/lockdown()
	set category = "AI Commands"
	set name = "Lockdown"

	if(usr.stat == 2)
		usr <<"You cannot initiate lockdown because you are dead!"
		return
	if(src.z != 1)
		usr << "<FONT COLOR=RED><B>ERROR:</B> Unable to establish connection to station, you are too far away!</FONT>"
		return // :P
	var/area
	get_locs()
//	var/areas = lockdownlocs

/*	for(var/area/A in areas)
		if(A in locked_down_areas)
			areas -= A */

	if(alert("Would you like to lock down a specific area, or the entire station?",,"Entire Station","Area")=="Entire Station")
		area = world
	else
		area = input("Please select an area to lockdown!", "Selective Lockdown", null, null) as null|area in lockdownlocs

	if(area in locked_down_areas)
		src << "<FONT COLOR=RED><B>ERROR:</B> Area already locked down.</FONT>"
		return

	var/bolt = alert("Would you like to bolt doors in selected area?",,"Yes","No")
	if(bolt == "Yes")
		bolt = 1
	else
		bolt = 0

	message_admins("[src.ckey]/([src.name] has initiated a lockdown for [area in lockdownlocs ? area : "station-wide"]!")
	log_admin("[src.ckey]/([src.name] has initiated a lockdown for [area in lockdownlocs ? area : "station-wide"]!")

	for(var/obj/machinery/firealarm/FA in area) //activate firealarms
		spawn( 0 )
			if(FA.lockdownbyai == 0)
				FA.lockdownbyai = 1
				FA.alarm()
	for(var/obj/machinery/door/airlock/AL in area) //close airlocks
		spawn( 0 )
			if(AL.canAIControl() && AL.lockdownbyai == 0) //&& AL.icon_state == "door0"
				AL.close()
				AL.lockdownbyai = 1
				if(bolt)
					AL.locked = 1
					AL.update_icon()
	for(var/obj/machinery/door/poddoor/AL in area) //lockdown blast doors
		spawn( 0 )
			if(AL.density == 0 && AL.lockdownbyai == 0)
				AL.close()
				AL.lockdownbyai = 1

	var/obj/machinery/computer/communications/C = locate() in world
	if(C)
		C.post_status("alert", "lockdown")

	if(!(area in return_sorted_areas()))
		area = "station-wide"
	captain_announce("[src.name]/(Station AI) has initiated \an [area] lockdown.")

	if( (area in lockdownlocs) || (area == "station-wide") )
		locked_down_areas += area

//	src.verbs -= /mob/living/silicon/ai/proc/lockdown
//	src.verbs += /mob/living/silicon/ai/proc/disablelockdown
//	usr << "\red Disable lockdown command enabled!"
	winshow(usr,"rpane",1)


/mob/living/silicon/ai/proc/disablelockdown()
	set category = "AI Commands"
	set name = "Release Lockdown"

	if(usr.stat == 2)
		usr <<"You cannot disable lockdown because you are dead!"
		return

	var/area

//	if(alert("Would you like to relase the lockdown of a specific area, or the entire station?",,"Entire Station","Area")=="Entire Station")
//		area = world
//	else
	area = input("Please select an area to release lockdown!", "Selective Lockdown", null, null) as null|area in locked_down_areas
	if(!locked_down_areas)
		src << "<FONT COLOR=RED><B>ERROR:</B> No locked down areas to release lock-down.</FONT>"
	if(!(area in return_sorted_areas()))
		area = world

	message_admins("[src.ckey]/([src.name] has released a lockdown for [area ? area : "station-wide"]!")
	log_admin("[src.ckey]/([src.name] has released a lockdown for [area ? area : "station-wide"]!")

	for(var/obj/machinery/firealarm/FA in area) //deactivate firealarms
		spawn( 0 )
			if(FA.lockdownbyai == 1)
				FA.lockdownbyai = 0
				FA.reset()
	for(var/obj/machinery/door/airlock/AL in area) //open airlocks
		spawn ( 0 )
			if(AL.canAIControl() && AL.lockdownbyai == 1)
				AL.open()
				AL.lockdownbyai = 0
				AL.locked = 0
				AL.update_icon()
	for(var/obj/machinery/door/poddoor/AL in area) //lockdown blast doors
		spawn( 0 )
			if(AL.density == 1 && AL.lockdownbyai == 1)
				AL.open()
				AL.lockdownbyai = 0

	if(alert("Would you like to announce the relase of lockdown to the crew?",,"Yes","No")=="Yes")
		if(!(area in return_sorted_areas()))
			area = "station-wide"
		captain_announce("[src.name]/(Station AI) has released \an [area] lockdown.")

	locked_down_areas -= area

//	src.verbs -= /mob/living/silicon/ai/proc/disablelockdown
//	src.verbs += /mob/living/silicon/ai/proc/lockdown
//	usr << "\red Disable lockdown command removed until lockdown initiated again!"
	winshow(usr,"rpane",1)
