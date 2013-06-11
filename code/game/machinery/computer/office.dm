/obj/machinery/computer/office
	name = "Office Computer"
	desc = "An office computer, it seems to have a variety of applications installed, and a built in printer!"
	var/num
	var/screen = 0
	//Stuff

/obj/machinery/computer/office/New()
	num = rand(1,10000)
/obj/machinery/computer/office/attack_ai()
	return attack_hand
/obj/machinery/computer/office/attack_hand(mob/user as mob)        //ioijoijwfwkepokovkwv is what I think
	if(!src.ispowered || src.isbroken)
		return
	if(istype(user, /mob/living/carbon/human) || istype(user,/mob/living/silicon) )
		var/mob/living/human_or_robot_user = user
		var/dat
		dat = text("<HEAD><TITLE>NanoTrasen OS</TITLE></HEAD><H3>[config.station_name] Office Computer #[src.num]</H3>")

//		src.scan_user(human_or_robot_user) //Newscaster scans you

		switch(screen)
			if(0)
				dat += "Welcome to NanoTrasen Office OS.<BR> Interface & Applications."
				dat += "<BR><FONT SIZE=1>Property of NanoTransen Inc.</FONT>"
				dat += "<HR><BR><A href='?src=\ref[src];word=1'>NanoTrasen Word</A>"
				dat += "<BR><A href='?src=\ref[src];settings=1'>Settings</A>"
				dat += "<BR><BR><A href='?src=\ref[human_or_robot_user];close=1'>Exit</A>"
			if(1)
				dat += "<HR><BR>NOT COMPLETE<BR><HR>"
			if(2)
				dat += "<HR><BR>NOT COMPLETE<BR><HR>"

		human_or_robot_user << browse(dat, "window=office_suicide;size=400x600")
		onclose(human_or_robot_user, "office_suicide")

/obj/machinery/computer/office/Topic(href, href_list)
	if(..())
		return
	if ((usr.contents.Find(src) || ((get_dist(src, usr) <= 1) && istype(src.loc, /turf))) || (istype(usr, /mob/living/silicon)))
		usr.set_machine(src)
		if(href_list["word"])
			screen = 1
			src.updateUsrDialog()
		else if(href_list["settings"])
			screen = 2
			src.updateUsrDialog()