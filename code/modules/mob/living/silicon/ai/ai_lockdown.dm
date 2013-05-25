/mob/living/silicon/ai/proc/lockdown()
	set category = "AI Commands"
	set name = "Lockdown"


	if(usr.stat == 2)
		usr <<"You cannot initiate lockdown because you are dead!"
		return

	message_admins("[src.ckey]/([src.name] has initiated a lockdown!")
	log_admin("[src.ckey]/([src.name] has initiated a lockdown!")

	for(var/obj/machinery/firealarm/FA in world) //activate firealarms
		spawn( 0 )
			if(FA.lockdownbyai == 0)
				FA.lockdownbyai = 1
				FA.alarm()
	for(var/obj/machinery/door/airlock/AL in world) //close airlocks
		spawn( 0 )
			if(AL.canAIControl() && AL.icon_state == "door0" && AL.lockdownbyai == 0)
				AL.close()
				AL.lockdownbyai = 1
	for(var/obj/machinery/door/poddoor/AL in world) //lockdown blast doors
		spawn( 0 )
			if(AL.density == 0 && AL.lockdownbyai == 0)
				AL.close()
				AL.lockdownbyai = 1

	var/obj/machinery/computer/communications/C = locate() in world
	if(C)
		C.post_status("alert", "lockdown")


	src.verbs -= /mob/living/silicon/ai/proc/lockdown
	src.verbs += /mob/living/silicon/ai/proc/disablelockdown
	usr << "\red Disable lockdown command enabled!"
	winshow(usr,"rpane",1)


/mob/living/silicon/ai/proc/disablelockdown()
	set category = "AI Commands"
	set name = "Disable Lockdown"

	if(usr.stat == 2)
		usr <<"You cannot disable lockdown because you are dead!"
		return

	message_admins("[src.ckey]/([src.name] has released a lockdown!")
	log_admin("[src.ckey]/([src.name] has released a lockdown!")

	for(var/obj/machinery/firealarm/FA in world) //deactivate firealarms
		spawn( 0 )
			if(FA.lockdownbyai == 1)
				FA.lockdownbyai = 0
				FA.reset()
	for(var/obj/machinery/door/airlock/AL in world) //open airlocks
		spawn ( 0 )
			if(AL.canAIControl() && AL.lockdownbyai == 1)
				AL.open()
				AL.lockdownbyai = 0
	for(var/obj/machinery/door/poddoor/AL in world) //lockdown blast doors
		spawn( 0 )
			if(AL.density == 1 && AL.lockdownbyai == 1)
				AL.open()
				AL.lockdownbyai = 0

	src.verbs -= /mob/living/silicon/ai/proc/disablelockdown
	src.verbs += /mob/living/silicon/ai/proc/lockdown
	usr << "\red Disable lockdown command removed until lockdown initiated again!"
	winshow(usr,"rpane",1)
