//////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////TORTURE//////////////////////////////////////////
///////////////////////////////////////S & M FOREVER//////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
/client/proc/rules_for_everyone() //--Numbers because Numbers can
	set name = "Display Rules for Everyone"
	set category = "Torture"
	if(!holder)
		src << "\red Sorry, you're part of the problem."
		return
	if(!(check_rights(R_ADMIN|R_MOD|R_FUN)))
		src << "\red You're not horrible enough to use this command."
		return
	var/who = alert("Who should see the rules?",,"Players","Players + Donors","Everyone", "Cancel")
	var/time = input("Time unitl window can be closed","Seconds:",15) as num|null
	if(!time)
		if(alert("Are you sure you want [who] to be able to close it immediatly?",,"Yes","No")=="No")
			return
	if(time > 60)
		src << "That's too long, reducing to 60 seconds.<BR>"
		time = 60
	time = time * 10
	if(who != "Cancel")
		src << "\blue <B>Displaying rules window to [who].<BR>It will not be able to be closed for [time / 10] seconds.</B><BR>"
	switch(who)
		if("Cancel")
			src << "<FONT SIZE=2 COLOR=RED>You<BR>are<BR>no<BR>fun</FONT>"
			return
		if("Everyone")
			world << browse('config/rules.html',"window=wrules;can_close=0;size=920x820;can_resize=0")
			sleep(time)//15s
		//	world << browse(null, "window=wrules")
			world << browse('config/rules.html',"window=wrules;can_close=1;size=920x820")
			return
		if("Players")
			var/list/players = list()
			for(var/client/C in clients)
				if(C in admins) continue
				players += C
			for(var/client/D in players)
				D << browse('config/rules.html',"window=wrules;can_close=0;size=920x820;can_resize=0")
				sleep(time)//15s
			//	D << browse(null, "window=wrules")
				D << browse('config/rules.html',"window=wrules;can_close=1;size=920x820")
			return
		if("Players + Donors")
			var/list/players = list()
			for(var/client/C in clients)
				if((C in admins) && (C.holder.rank != "Donor"))
					continue
				players += C
			for(var/client/D in players)
				D << browse('config/rules.html',"window=wrules;can_close=0;size=920x820;can_resize=0")
				sleep(time)//15s
			//	D << browse(null, "window=wrules")
				D << browse('config/rules.html',"window=wrules;can_close=1;size=920x820")
			return
		else
			src << "How did this happen exactly?  Contact a Coder, but its not too much of a big deal."
			return
	message_admins("[src.ckey] has made a rules windows appear for [who] (unclosable for [time] seconds)!")
	log_admin("[src.ckey] has made a rules window that cannot be closed for [time] seconds appear for [who]!")
	return
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/client/proc/cmd_admin_torture_announce()
	set category = "Torture"
	set name = "Tortorous Announcement"

	if(!holder)
		src << "Sorry, we're not going to let you corrupt yourself with this filth... it might be too late for us, but it's not too late for us!"
		return
	var/torture_msg
	var/input = input(usr, "Enter the text you wish to announce:", "Annoucement", torture_msg) as message|null
	if((!input) || (input == null))
		return

	log_admin("[usr.key] has used torture announce.")
	message_admins("[key_name_admin(usr)] has used torture announce.")

	torture_msg = input

	world << "<h1 class='alert'>Admin Announcement</h1>"
	world << "<h2 class='alert'>\An [src.holder.rank]([src.ckey]) wants you to listen to something, listen:</h2>"
	world << "<span class='alert'>[html_encode(torture_msg)]</span>"
	world << "<br>"
/////////////////////////////////////////////////////////////////